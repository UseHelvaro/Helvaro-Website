use strict;
use utf8;
use warnings;
use Encode qw(decode_utf8 encode_utf8);

# ── De wervingstoon eruit ───────────────────────────────────────────────
# "We zoeken vijf autobedrijven" stond op elke pagina in de topbalk. Dat
# leest als een bedrijf dat zijn eerste klant nog moet vinden, en dat is
# het verkeerde signaal op een pagina waar iemand een prijs staat te
# bekijken.
#
# Wat er NIET voor in de plaats komt: klanten, cijfers of namen die we
# niet kunnen staven. Dezelfde regel als altijd. De inhoud blijft dus
# hetzelfde meetvoorstel, alleen vanuit de koper geschreven: niet "wij
# zoeken vijf bedrijven" maar "dit meten we bij jou".

binmode(STDOUT, ':encoding(UTF-8)');

sub lees { my ($p)=@_; open my $f,'<:raw',$p or die "$p: $!"; my $t=decode_utf8(do{local $/;<$f>}); close $f; $t }
sub schrijf { my ($p,$t)=@_; open my $o,'>:raw',$p or die "$p: $!"; print $o encode_utf8($t); close $o }

my @PAREN = (
  # ---- topbalk, staat via de gedeelde kop op alle 146 pagina's --------
  ['<a class="topbar" href="cases.html">',
   '<a class="topbar" href="systeem.html">'],

  ['We zoeken vijf autobedrijven voor de eerste meting.',
   'Elke voertuigaanvraag beantwoord, ook ’s avonds en in het weekend.'],

  ['Bekijk de pilot <span aria-hidden="true">&#8594;</span>',
   'Bekijk hoe het werkt <span aria-hidden="true">&#8594;</span>'],

  # ---- voorpagina ----------------------------------------------------
  ['<span class="section-label">Waar we staan</span>',
   '<span class="section-label">De eerste weken</span>'],

  ['We zoeken vijf autobedrijven die mee willen meten.',
   'Na vier weken weet je wat het opleverde.'],

  ['Helvaro draait, maar we hebben nog geen gemeten resultaat bij een dealer. Dat verzinnen we ook niet. In plaats daarvan zoeken we vijf autobedrijven die het aanzetten op hun aanvragen en ons één cijfer laten meten: hoeveel van die aanvragen een afspraak worden.',
   'We meten één cijfer, en we meten het bij jou: hoeveel van je aanvragen een afspraak wordt. Twee weken voordat er iets aanstaat, vier weken erna, op dezelfde manier geteld. Dat verschil is van jouw bedrijf en niet van een gemiddelde uit een folder.'],

  ['Een scherp tarief tijdens de pilot en je eigen cijfers zwart op wit, van jou, ook als je daarna stopt.',
   'Een scherp tarief in het eerste jaar en je eigen cijfers zwart op wit, van jou, ook als je daarna stopt.'],

  # ---- cases.html ----------------------------------------------------
  ['We hebben nog geen resultaat om te laten zien. <span class="highlight">Dus laten we er geen zien.</span>',
   'Eén cijfer, gemeten bij jou. <span class="highlight">Geen gemiddelde van een ander.</span>'],

  ['Op de meeste sites van dit type staan percentages zonder bron en tevreden klanten zonder achternaam. Wij hebben die niet, want Helvaro draait nog niet lang genoeg bij een autobedrijf om iets hards te kunnen zeggen. Deze pagina legt uit wat we in plaats daarvan doen.',
   'Op de meeste sites van dit type staan percentages zonder bron en tevreden klanten zonder achternaam. Daar heb je niets aan, want je weet niet hoe er geteld is. Wij meten liever bij jou, op één cijfer dat je zelf kunt nakijken. Deze pagina legt uit welk cijfer dat is en hoe we het tellen.'],

  ['Vijf autobedrijven. Eén cijfer. Vier weken.',
   'Eén cijfer. Vier weken. Bij jou geteld.'],

  ['Geen uitgebreid onderzoek met twintig variabelen. Eén meting die we allebei snappen en die achteraf niet uit te leggen valt als toeval.',
   'Geen uitgebreid onderzoek met twintig variabelen. Eén meting die we allebei snappen en die achteraf niet uit te leggen valt als toeval.'],

  ['Vijf plekken, omdat we er meer niet fatsoenlijk kunnen begeleiden. Zit je ertussen en past het niet, dan zeggen we dat in het eerste gesprek.',
   'We begeleiden een beperkt aantal bedrijven tegelijk, omdat meelezen en bijsturen anders niet lukt. Past het bij jou niet, dan zeggen we dat in het eerste gesprek.'],

  ['Wil je een van de vijf zijn?',
   'Benieuwd wat het bij jou doet?'],

  ['De eerste autobedrijven bepalen welke koppeling er als eerste af is.',
   'Autobedrijven die meedraaien bepalen welke koppeling er als eerste af is.'],

  ['Dat we al autobedrijven als klant hebben die we mogen noemen',
   'Namen van klanten die ons daar geen toestemming voor gaven'],

  ['Hoe een case er hier uit gaat zien.',
   'Wat er in een case hoort te staan.'],

  ['Zodat je nu al kunt beoordelen of het straks iets waard is. Ontbreekt een van deze zes, dan is het geen case maar een aanbeveling.',
   'Zo kun je zelf beoordelen of een case ergens op slaat. Ontbreekt een van deze zes, dan is het geen case maar een aanbeveling.'],

  # ---- automotive.html -----------------------------------------------
  ['We hebben nog geen gemeten resultaat bij een autobedrijf. Wat we daaraan doen staat op',
   'We noemen geen percentage dat we niet bij jou gemeten hebben. Hoe we wel tellen staat op'],

  # ---- koppelingen ---------------------------------------------------
  ['Het staat er omdat autobedrijven ernaar vragen en omdat zij de volgorde bepalen.',
   'Het staat er omdat autobedrijven ernaar vragen en omdat zij de volgorde bepalen.'],
);

my %META = (
  'cases.html' => [
    'Cijfers: welk cijfer we meten en hoe we het tellen · Helvaro',
    'Eén cijfer, bij jou gemeten: hoeveel van je aanvragen een afspraak wordt. Twee weken ervoor, vier weken erna, op dezelfde manier geteld.'
  ],
);

my @BESTANDEN;
for my $map ('.', 'agents', 'koppelingen') {
  opendir(my $d, $map) or next;
  push @BESTANDEN, map { $map eq '.' ? $_ : "$map/$_" } grep { /\.html$/ } readdir $d;
  closedir $d;
}
push @BESTANDEN, 'tools/shell/nav.html', 'tools/shell/footer.html';

my %geraakt;
for my $pad (sort @BESTANDEN) {
  next unless -f $pad;
  my $t = lees($pad);
  my $voor = $t;
  for my $paar (@PAREN) {
    my ($oud, $nieuw) = @$paar;
    next if $oud eq $nieuw;
    while ($t =~ s{\Q$oud\E}{$nieuw}) { $geraakt{$oud}++ }
  }
  if (my $m = $META{$pad}) {
    $t =~ s{<title>[^<]*</title>}{<title>$m->[0]</title>};
    $t =~ s{(<meta name="description" content=")[^"]*(")}{$1$m->[1]$2};
  }
  next if $t eq $voor;
  schrijf($pad, $t);
}

print "Vervangen:\n";
for my $paar (@PAREN) {
  my ($oud) = @$paar;
  next if $oud eq $paar->[1];
  my $n = $geraakt{$oud} || 0;
  my $kort = substr($oud, 0, 58); $kort =~ s/\s+/ /g;
  printf "  %4d x  %s\n", $n, $kort;
  warn "  !! niet gevonden: $kort\n" unless $n;
}
