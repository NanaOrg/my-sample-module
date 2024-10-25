# bin/script.pl
#!/usr/bin/perl
use strict;
use warnings;
use lib "../lib";    # Add lib to the module path
use MyProject::Module;

my $module = MyProject::Module->new();
print $module->greet() . "\n";
