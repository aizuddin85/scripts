#!/usr/bin/perl

@nums = (1..20);
print "Before - @nums\n";

splice(@nums, 5, 5, 21..25);
print "After - @nums\n";

#Output
#Before - 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
#After - 1 2 3 4 5 21 22 23 24 25 11 12 13 14 15 16 17 18 19 20
