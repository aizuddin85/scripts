#!/usr/bin/perl
#

$a = 10;

if ( $a < 20 ){
	printf "a is less than 20\n";
}

print "value of a is : $a\n";

$a = "";

if  ( $a ){
	printf "a has true value\n";
}

printf "value of a is : $a\n";

=begin comment
a is less than 20
value of a is : 10
value of a is :
=cut
