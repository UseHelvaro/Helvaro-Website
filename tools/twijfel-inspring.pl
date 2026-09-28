use strict;
use utf8;
use warnings;
use Encode qw(decode_utf8 encode_utf8);

# De twijfelregel kreeg in de cta-band de inspringing van de regel ERNA
# mee in plaats van die van de knop ervoor. Puur cosmetisch, maar deze
# bestanden worden ook door mensen gelezen.
#
# Hier wordt de regel uitgelijnd op de knop die er direct boven staat.

binmode(STDOUT, ':encoding(UTF-8)');

sub lees { my ($p)=@_; open my $f,'<:raw',$p or die "$p: $!"; my $t=decode_utf8(do{local $/;<$f>}); close $f; $t }
sub schrijf { my ($p,$t)=@_; open my $o,'>:raw',$p or die "$p: $!"; print $o encode_utf8($t); close $o }

my $n = 0;
for my $pad (@ARGV) {
  next unless -f $pad;
  my $t = lees($pad);
  my $voor = $t;

  # knopregel, regeleinde, verkeerde inspringing, twijfelregel
  $t =~ s{
      ^([ \t]*)(<a\ href="[^"]*aanmelden\.html"[^>]*>.*?</a>)(\r?\n)
      [ \t]*(<p\ class="cta-twijfel">)
    }{$1$2$3$1$4}gmx and $n++;

  next if $t eq $voor;
  schrijf($pad, $t);
}
print "  uitgelijnd in $n bestanden\n";
