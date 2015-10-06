#!/usr/bin/perl

%data = ('John' => 54, 'Lisa' => 30, 'Kumar' => 40);

if ( exists($data{'Lisa'} ) ) {
	print "Lisa is $data{'Lisa'} years old\n";
}
else {
	print "I dont know age of Lisa\n";
}

=begin comment
output is:
Lisa is 30 years old
=cut
