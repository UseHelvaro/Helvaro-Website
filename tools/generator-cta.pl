use strict;
use utf8;
use warnings;
use Encode qw(decode_utf8 encode_utf8);

# De agent- en koppelingspagina's worden gegenereerd. Mijn pass over de
# HTML veranderde ze wel, maar de eerstvolgende bouwstap zette de oude
# knop er weer in. De sjablonen zelf moeten dus mee, anders komt dit bij
# elke build terug.
#
# Geen s{}{} hier: de sjabloonregels bevatten zelf accolades, en die
# botsen met de begrenzers van de vervangingsoperator. Vandaar een simpele
# stringvervanging met index().

binmode(STDOUT, ':encoding(UTF-8)');

sub lees { my ($p)=@_; open my $f,'<:raw',$p or die "$p: $!"; my $t=decode_utf8(do{local $/;<$f>}); close $f; $t }
sub schrijf { my ($p,$t)=@_; open my $o,'>:raw',$p or die "$p: $!"; print $o encode_utf8($t); close $o }

sub vervang {
  my ($tekst, $oud, $nieuw) = @_;
  my $n = 0;
  while ((my $i = index($tekst, $oud)) >= 0) {
    substr($tekst, $i, length($oud)) = $nieuw;
    $n++;
    last if $n > 50;
  }
  return ($tekst, $n);
}

my $PIJL    = '<span class="btn-arrow" aria-hidden="true">&#8594;</span>';
my $TWIJFEL = '<p class="cta-twijfel">Twijfel je nog? <a href="../meeting.html">Plan een gesprek van 20 minuten met het team</a></p>';

my @PAREN = (
  [ '          <a href="../meeting.html" class="btn btn-lg">Plan een demo ' . $PIJL . '</a>',
    '          <a href="../aanmelden.html" class="btn btn-lg">Start gratis ' . $PIJL . '</a>' ],

  [ '        <a href="../meeting.html" class="btn btn-lg reveal reveal-delay-2">Plan een demo ' . $PIJL . '</a>',
    '        <a href="../aanmelden.html" class="btn btn-lg reveal reveal-delay-2">Start gratis ' . $PIJL . '</a>'
      . '\\n        ' . $TWIJFEL ],
);

for my $pad (qw(tools/build-agents.pl tools/build-koppelingen.pl)) {
  my $t = lees($pad);
  my $totaal = 0;
  for my $paar (@PAREN) {
    my ($nieuw_t, $n) = vervang($t, $paar->[0], $paar->[1]);
    $t = $nieuw_t;
    $totaal += $n;
  }
  schrijf($pad, $t);
  printf "  %-28s %d knoppen omgezet\n", $pad, $totaal;
}
