use strict;
use warnings;

use Test::More;

use_ok('Keybinder');

my $cb = sub { };
my $key = "<Ctrl>A";

#ok !bind_key("<Ctrlll>A", sub{}), "Wrong key hasn't been binded";
ok bind_key($key, $cb), "$key binded successfully to coderef";
unbind_key($key, $cb);

done_testing;
