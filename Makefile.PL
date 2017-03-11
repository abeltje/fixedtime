#! /usr/bin/perl -w
use v5.10.1;
use strict;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'fixedtime',
    VERSION_FROM  => 'lib/fixedtime.pm',
    ABSTRACT_FROM => 'lib/fixedtime.pm',

    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 6.56,
    },

    BUILD_REQUIRES => {
        'Test::More'       => 0.96,
    },

    MIN_PERL_VERSION => 5.010001,
    META_ADD => {
        'meta-spec' => {
            version => 2,
        },
        'resources' => {
            repository => {
                type => 'git',
                url  => 'git@github.com:abeltje/fixedtime.git',
                web  => 'https://github.com/abeltje/fixedtime',
            },
        },
    },
);
