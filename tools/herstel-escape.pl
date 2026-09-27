use strict;
use utf8;
use warnings;
use Encode qw(decode_utf8 encode_utf8);

# In een vorig script stond ’ in een string met ENKELE aanhalings-
# tekens. Perl vertaalt zo'n escape daar niet, dus de vier tekens zijn
# letterlijk op 131 pagina's beland. Dit zet er alsnog een echte
# rechter-apostrof neer.
#
# Via een scriptbestand en niet via perl -e op de opdrachtregel: bash
# haalt de backslashes daar onderuit voordat Perl ze ziet.

binmode(STDOUT, ':encoding(UTF-8)');

my $ZOEK = chr(92) . 'x{2019}';          # letterlijk: ’
my $VERVANG = chr(0x2019);               # het echte teken: ’

sub lees { my ($p)=@_; open my $f,'<:raw',$p or die "$p: $!"; my $t=decode_utf8(do{local $/;<$f>}); close $f; $t }
sub schrijf { my ($p,$t)=@_; open my $o,'>:raw',$p or die "$p: $!"; print $o encode_utf8($t); close $o }

my ($bestanden, $totaal) = (0, 0);
for my $pad (@ARGV) {
  next unless -f $pad;
  my $t = lees($pad);
  my $n = 0;
  $n++ while $t =~ s/\Q$ZOEK\E/$VERVANG/;
  next unless $n;
  schrijf($pad, $t);
  $bestanden++;
  $totaal += $n;
}
print "$totaal escapes hersteld in $bestanden bestanden.\n";
