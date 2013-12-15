#!/usr/bin/env perl

use strict;
use warnings;

use Gtk2 -init;
use Keybinder;

my $key = '<Ctrl>A';
my $window = Gtk2::Window->new('toplevel');
my $button = Gtk2::Button->new("press $key to quit app globally");
my $exit; $exit = sub {
    print "Exiting..\n";
    unbind_key($key, $exit);
    Gtk2->main_quit;
};
$button->signal_connect (clicked => $exit);
$window->add ($button);
$window->show_all;

bind_key($key => $exit) or die("can't bind $key");

Gtk2->main;
