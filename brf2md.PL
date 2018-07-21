use Convert::Braille;
use utf8;

$in = $ARGV[0];
die "usage1: perl brf2md.pl input.brf\nusage2: brf2md.exe input.brf\n" unless $in;

$out = $in . ".md";

open(IN, "< $in");
open(OUT, "> $out");

binmode(OUT, ":utf8");

while ($asciiBraille_line = <IN>){

$asciiBraille_line =~ tr/a-z}|{`~/A-Z]\\[@^/;

$utf8brl_line = brailleAsciiToUnicode ($asciiBraille_line);

$utf8brl_line =~ s/ /\x{2800}/g;

$utf8brl_line =~ s/^\x{2824}\x{2824}\x{2824}\x{2824}/* \x{2824}\x{2824}\x{2824}\x{2824}/;

$utf8brl_line =~ s/^\x{2800}\x{2800}\x{2800}\x{2800}/# /;

print (OUT "$utf8brl_line\n");
}

close(IN);
close(OUT);

exit;
