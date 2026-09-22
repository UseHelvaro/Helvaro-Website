use strict;
use utf8;
use warnings;
use Encode qw(decode_utf8 encode_utf8);

# ── og:title en og:description gelijk houden aan <title> en description ──
#
# Deze vier stonden los van elkaar in elke pagina, dus bij elke herschrijving
# werden er twee bijgewerkt en twee vergeten. Het resultaat zie je pas als
# iemand je link deelt: de pagina gaat over autobedrijven, de kaart eronder
# over werkplaatsen. Daarom leidt de og-kant zich hier af van de gewone kant.
#
# Wil een pagina bewust een andere og-tekst, zet er dan
# <!-- OG:EIGEN --> in de <head>. Dan blijft hij met rust.
#
# Alleen de Nederlandse bron. De taalmappen worden erna opnieuw gebouwd.

binmode(STDOUT, ':encoding(UTF-8)');

sub lees { my ($p)=@_; open my $f,'<:raw',$p or die "$p: $!"; my $t=decode_utf8(do{local $/;<$f>}); close $f; $t }
sub schrijf { my ($p,$t)=@_; open my $o,'>:raw',$p or die "$p: $!"; print $o encode_utf8($t); close $o }

my @paginas;
for my $map ('.', 'agents', 'koppelingen', 'sectoren') {
  opendir(my $d, $map) or next;
  push @paginas, map { $map eq '.' ? $_ : "$map/$_" } grep { /\.html$/ } readdir $d;
  closedir $d;
}

my $aangepast = 0;
for my $pad (sort @paginas) {
  my $t = lees($pad);
  next if $t =~ /<!--\s*OG:EIGEN\s*-->/;

  my ($titel) = $t =~ m{<title>([^<]*)</title>};
  my ($desc)  = $t =~ m{<meta name="description" content="([^"]*)"};
  next unless defined $titel && defined $desc;

  my $n = 0;
  $n++ if $t =~ s{(<meta property="og:title" content=")[^"]*(")}{$1$titel$2};
  $n++ if $t =~ s{(<meta property="og:description" content=")[^"]*(")}{$1$desc$2};

  next unless $n;
  my $voor = lees($pad);
  next if $voor eq $t;
  schrijf($pad, $t);
  $aangepast++;
}

print "$aangepast pagina's: og:title en og:description gelijkgetrokken.\n";
