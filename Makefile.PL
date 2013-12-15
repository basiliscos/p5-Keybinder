use 5.010001;
use ExtUtils::MakeMaker;

our %build_reqs = (
    'glib' => '2.0.0',
    'perl-Glib'           => '1.280'
);

our %PREREQ_PM = (
    'ExtUtils::Depends'   => '0.300',
    'ExtUtils::PkgConfig' => '1.000',
);

eval { "use ExtUtils::PkgConfig" } or do{
    warn $@;
    exit 0;
};

use ExtUtils::PkgConfig;

# may be do  pkg-config --cflags keybinder ?

my %pkgcfg_gtk;
eval {
    %pkgcfg_gtk = ExtUtils::PkgConfig->find("gtk+-2.0"); 1;
} or do {
    warn $@;
    exit 0;
};

WriteMakefile(
    NAME              => 'Keybinder',
    VERSION_FROM      => 'lib/Keybinder.pm',
    PREREQ_PM         => {
        "Gtk2" => "1.247",
    },
    ($] >= 5.005 ?
      (ABSTRACT_FROM  => 'lib/Keybinder.pm',
       AUTHOR         => 'Ivan Baidakou <dmol@(none)>') : ()),
    CCFLAGS           => $pkgcfg_gtk{cflags},
    LIBS              => [ @{ $pkgcfg_gtk{libs} }, '-lkeybinder'],
    # DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    # INC               => '', # e.g., '-I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too
);
