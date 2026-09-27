use strict;
use utf8;
use warnings;
use Encode qw(decode_utf8 encode_utf8);

# Restant van de wervingstoon: de menulabels en de zin die Faro erbij zegt.
# Faro sprak namens ons over "nog geen gemeten resultaat", wat hetzelfde
# signaal afgeeft als de topbalk. Hij zegt nu wat er gemeten wordt.

binmode(STDOUT, ':encoding(UTF-8)');

sub lees { my ($p)=@_; open my $f,'<:raw',$p or die "$p: $!"; my $t=decode_utf8(do{local $/;<$f>}); close $f; $t }
sub schrijf { my ($p,$t)=@_; open my $o,'>:raw',$p or die "$p: $!"; print $o encode_utf8($t); close $o }

my %BESTAND = (
  'tools/shell/nav.html' => [
    ['<span class="ndi-title">Pilot en cijfers</span>', '<span class="ndi-title">Cijfers</span>'],
  ],
  'tools/shell/footer.html' => [
    ['>Pilot en cijfers</a>', '>Cijfers</a>'],
  ],
  'js/main.js' => [
    ["nl: 'We hebben nog geen gemeten resultaat, en we verzinnen er ook geen. Daarom deze pilot.'",
     "nl: 'Wat het bij jou doet, tellen we bij jou. Twee weken ervoor, vier weken erna.'"],
    ["en: 'We do not have a measured result yet, and we are not inventing one. That is what this pilot is for.'",
     "en: 'What it does at your business, we count at your business. Two weeks before, four weeks after.'"],
    ["fr: 'Nous n’avons pas encore de résultat mesuré, et nous n’en inventons pas. C’est à ça que sert ce pilote.'",
     "fr: 'Ce que cela donne chez vous, nous le comptons chez vous. Deux semaines avant, quatre semaines après.'"],
    ["de: 'Wir haben noch kein gemessenes Ergebnis, und wir erfinden auch keines. Genau dafür ist dieser Pilot da.'",
     "de: 'Was es bei Ihnen bringt, zählen wir bei Ihnen. Zwei Wochen davor, vier Wochen danach.'"],
    ["es: 'Todavía no tenemos un resultado medido, y tampoco nos lo inventamos. Para eso está este piloto.'",
     "es: 'Lo que hace en tu caso lo contamos en tu caso. Dos semanas antes, cuatro semanas después.'"],
  ],
);

for my $pad (sort keys %BESTAND) {
  my $t = lees($pad);
  my $n = 0;
  for my $paar (@{ $BESTAND{$pad} }) {
    my ($oud, $nieuw) = @$paar;
    my $raak = 0;
    while ($t =~ s{\Q$oud\E}{$nieuw}) { $raak++; $n++ }
    unless ($raak) {
      my $kort = substr($oud, 0, 50); $kort =~ s/\s+/ /g;
      warn "  !! $pad: niet gevonden: $kort\n";
    }
  }
  schrijf($pad, $t);
  printf "  %-26s %d vervangingen\n", $pad, $n;
}
