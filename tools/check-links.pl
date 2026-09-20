#!/usr/bin/perl
# ============================================================================
# check-links.pl — loopt elke interne link na
# ----------------------------------------------------------------------------
# Met dertig pagina's en een navigatie die per map verdiept wordt, is een
# verkeerd aantal ../ zo gemaakt. Dat merk je normaal pas als een bezoeker op
# een 404 belandt.
#
# Dit script leest elke pagina, pakt elke href en src, en kijkt of het bestand
# bestaat. Externe links, mailto:, tel: en #ankers blijven buiten beschouwing.
# Ankers binnen de site worden wel gecontroleerd: bestaat het id op de
# doelpagina.
#
# Gebruik
#   perl tools/check-links.pl            de Nederlandse bron
#   perl tools/check-links.pl --alles    ook /fr/ /en/ /de/ /es/
# ============================================================================
use strict;
use warnings;
use Encode qw(decode_utf8);
use File::Basename qw(dirname);

my $ALLES = grep { $_ eq '--alles' } @ARGV;

sub paginas {
  my @p;
  my @mappen = ('.', 'sectoren', 'agents', 'koppelingen');
  push @mappen, map { my $l = $_; ($l, "$l/sectoren", "$l/agents", "$l/koppelingen") }
                qw(fr en de es) if $ALLES;
  for my $m (@mappen) {
    next unless -d $m;
    opendir my $dh, $m or next;
    for my $f (sort readdir $dh) {
      next unless $f =~ /\.html$/;
      push @p, $m eq '.' ? $f : "$m/$f";
    }
    closedir $dh;
  }
  return @p;
}

# id's per pagina, zodat #ankers na te lopen zijn
my %IDS;
sub ids_van {
  my ($pad) = @_;
  return $IDS{$pad} if exists $IDS{$pad};
  my %ids;
  if (open my $fh, '<:raw', $pad) {
    my $h = decode_utf8(do { local $/; <$fh> });
    close $fh;
    $ids{$1} = 1 while $h =~ /\bid="([^"]+)"/g;
  }
  $IDS{$pad} = \%ids;
  return \%ids;
}

# Pad normaliseren: a/b/../c wordt a/c
sub normaliseer {
  my ($pad) = @_;
  my @uit;
  for my $deel (split m{/}, $pad) {
    next if $deel eq '.' || $deel eq '';
    if ($deel eq '..') { pop @uit; next; }
    push @uit, $deel;
  }
  return join '/', @uit;
}

my @paginas = paginas();
my ($gecontroleerd, @fout) = (0);

for my $pagina (@paginas) {
  open my $fh, '<:raw', $pagina or next;
  my $h = decode_utf8(do { local $/; <$fh> });
  close $fh;

  my $map = dirname($pagina);
  $map = '' if $map eq '.';

  while ($h =~ /\b(?:href|src)="([^"]+)"/g) {
    my $link = $1;
    next if $link =~ m{^(?:https?:|//|mailto:|tel:|data:|javascript:)};
    next if $link eq '' || $link eq '#';

    my ($doel, $anker) = split /#/, $link, 2;
    $doel =~ s/\?.*$// if defined $doel;

    my $volledig;
    if (!defined $doel || $doel eq '') {
      $volledig = $pagina;                      # alleen een #anker
    } elsif ($doel =~ m{^/}) {
      $volledig = normaliseer(substr($doel, 1));
      $volledig = "$volledig/index.html" if -d $volledig;
      $volledig = 'index.html' if $volledig eq '';
    } else {
      $volledig = normaliseer($map eq '' ? $doel : "$map/$doel");
      $volledig = "$volledig/index.html" if -d $volledig;
    }

    $gecontroleerd++;

    unless (-f $volledig) {
      push @fout, "$pagina  ->  $link   (bestand $volledig ontbreekt)";
      next;
    }

    if (defined $anker && $anker ne '' && $volledig =~ /\.html$/) {
      my $ids = ids_van($volledig);
      push @fout, "$pagina  ->  $link   (anker #$anker bestaat niet)"
        unless $ids->{$anker};
    }
  }
}

printf "%d pagina's, %d verwijzingen gecontroleerd.\n", scalar(@paginas), $gecontroleerd;
if (@fout) {
  print "\n", scalar(@fout), " probleem", (@fout == 1 ? '' : 'en'), ":\n";
  print "  $_\n" for @fout;
  exit 1;
}
print "Alles klopt.\n";
