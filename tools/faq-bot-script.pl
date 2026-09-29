use strict;
use utf8;
use warnings;
use Encode qw(decode_utf8 encode_utf8);

# Zet de scripttag van de FAQ-assistent op elke Nederlandse bronpagina, direct
# na main.js. De diepte wordt overgenomen van main.js zelf, want agents/ en
# koppelingen/ staan een niveau lager.
#
# Alleen de bron: de taalmappen worden gebouwd, dus die krijgen hem vanzelf.

binmode(STDOUT, ':encoding(UTF-8)');

sub lees { my ($p)=@_; open my $f,'<:raw',$p or die "$p: $!"; my $t=decode_utf8(do{local $/;<$f>}); close $f; $t }
sub schrijf { my ($p,$t)=@_; open my $o,'>:raw',$p or die "$p: $!"; print $o encode_utf8($t); close $o }

my @BESTANDEN;
for my $map ('.', 'agents', 'koppelingen') {
  opendir(my $d, $map) or next;
  push @BESTANDEN, map { $map eq '.' ? $_ : "$map/$_" } grep { /\.html$/ } readdir $d;
  closedir $d;
}

my ($gezet, $al) = (0, 0);
for my $pad (sort @BESTANDEN) {
  next unless -f $pad;
  my $t = lees($pad);
  if ($t =~ /js\/faq-bot\.js/) { $al++; next; }

  my $E = ($t =~ /\r\n/) ? "\r\n" : "\n";
  # main.js staat op elke pagina; zijn voorvoegsel is de juiste diepte.
  unless ($t =~ s{(<script src="((?:\.\./)*)js/main\.js\?v=\d+"></script>)}
                 {$1$E  <script src="$2js/faq-bot.js?v=1" defer></script>}) {
    warn "  !! $pad: main.js niet gevonden\n";
    next;
  }
  schrijf($pad, $t);
  $gezet++;
}

print "  $gezet pagina's kregen de scripttag, $al hadden hem al\n";
