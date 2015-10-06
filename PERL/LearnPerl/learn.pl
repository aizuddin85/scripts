#!/usr/bin/perl
use strict;
use warnings;

my $filename = 'systems.db';
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
print $fh "hostname\n";
print $fh "managed=yes\n";
close $fh;
print "done\n";

