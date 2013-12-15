use strict;
use warnings;

use Test::More tests => 1;
BEGIN { use_ok('Keybinder') };

use Keybinder;

my $cb = sub { };
my $key = "<Ctrl>A";

bind_key($key, $cb);
unbind_key($key, $cb);
