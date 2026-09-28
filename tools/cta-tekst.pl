use strict;
use utf8;
use warnings;
use Encode qw(decode_utf8 encode_utf8);

# De knop onderaan elke pagina zegt nu "Start gratis", maar de zin erboven
# beloofde nog steeds een gesprek van twintig minuten. Dan klikt iemand op
# iets anders dan hij leest.
#
# De zinnen gaan dus mee naar de proefperiode. De meeting blijft bestaan,
# maar die staat nu in de regel eronder en hoeft hier niet nog eens.

binmode(STDOUT, ':encoding(UTF-8)');

sub lees { my ($p)=@_; open my $f,'<:raw',$p or die "$p: $!"; my $t=decode_utf8(do{local $/;<$f>}); close $f; $t }
sub schrijf { my ($p,$t)=@_; open my $o,'>:raw',$p or die "$p: $!"; print $o encode_utf8($t); close $o }

my @PAREN = (
  ['Twintig minuten op je eigen cijfers. We kijken wat er binnenkomt via je site, WhatsApp en mail, en wat ermee gebeurt. Je gaat weg met een eerste werkstroom, of met de reden waarom het bij jou niet past.',
   'Veertien dagen gratis, op je eigen aanvragen. Je zet één werkstroom aan en ziet zelf wat er binnenkomt via je site, WhatsApp en mail, en wat ermee gebeurt.'],

  ['We nemen twintig minuten en lopen jouw week door. Wat er binnenkwam, hoe snel het beantwoord werd en waar het bleef liggen. Daarna weet je of dit iets voor je is.',
   'Zet het veertien dagen aan op je eigen aanvragen. Daarna weet je wat er binnenkwam, hoe snel het beantwoord werd en waar het bleef liggen.'],

  ['Twintig minuten, je eigen cijfers op tafel. Daarna weet je of het past, en wij weten of we je kunnen helpen.',
   'Veertien dagen gratis, je eigen cijfers op tafel. Daarna weet je of het past.'],

  ['Twintig minuten op je eigen cijfers. We laten zien wat deze werkstroom bij jou zou doen, of waarom je beter met een andere kunt beginnen.',
   'Zet deze werkstroom veertien dagen aan op je eigen aanvragen, en zie wat hij bij jou doet.'],

  ['In twintig minuten kijken we naar wat er bij jou binnenkomt en waar het blijft liggen. Daar komt meestal vanzelf uit waar je moet beginnen.',
   'Zet er één aan en kijk veertien dagen wat er binnenkomt en waar het blijft liggen. Daar komt meestal vanzelf uit waar je moet beginnen.'],

  ['Zeg het in het eerste gesprek. We vertellen eerlijk of het vandaag kan, hoe je begint met wat er wel is, en wanneer er meer in zit.',
   'Begin met wat er vandaag wel is. Wat nog gebouwd wordt staat hierboven, met de status erbij.'],

  ['We kijken samen naar wat er bij jou binnenkomt en waar het blijft liggen. Je gaat weg met een eerste werkstroom, of met de reden waarom het bij jou niet past.',
   'Zet één werkstroom aan op je eigen aanvragen en zie waar het bij jou blijft liggen.'],

  ['In twintig minuten kijken we naar wat er bij jou binnenkomt en waar het blijft liggen.',
   'Zet het aan op je eigen aanvragen en zie waar het bij jou blijft liggen.'],

  # Beschrijving die in de zoekresultaten en op gedeelde links staat.
  ['Elke voertuigaanvraag beantwoord, ook \x{2019}s avonds en in het weekend. Een demo van 20 minuten op je eigen cijfers, zonder verplichtingen.',
   'Elke voertuigaanvraag beantwoord, ook \x{2019}s avonds en in het weekend. Veertien dagen gratis proberen op je eigen aanvragen.'],
);

my @BESTANDEN;
for my $map ('.', 'agents', 'koppelingen') {
  opendir(my $d, $map) or next;
  push @BESTANDEN, map { $map eq '.' ? $_ : "$map/$_" } grep { /\.html$/ } readdir $d;
  closedir $d;
}

my %telling;
for my $pad (sort @BESTANDEN) {
  next unless -f $pad;
  my $t = lees($pad);
  my $voor = $t;
  for my $paar (@PAREN) {
    my ($oud, $nieuw) = @$paar;
    while ($t =~ s{\Q$oud\E}{$nieuw}) { $telling{$oud}++ }
  }
  next if $t eq $voor;
  schrijf($pad, $t);
}

print "Aangepast:\n";
for my $paar (@PAREN) {
  my $n = $telling{$paar->[0]} || 0;
  my $kort = substr($paar->[0], 0, 56); $kort =~ s/\s+/ /g;
  printf "  %3d x  %s\n", $n, $kort;
}
