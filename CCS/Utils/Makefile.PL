use PDL::Core::Dev;
use ExtUtils::MakeMaker;
PDL::Core::Dev->import();
require "../../pdlmaker.plm";

$package = ["ccsutils.pd", 'Utils', 'PDL::CCS::Utils'];
%hash = pdlmaker_init($package);

$hash{AUTHOR} = 'Bryan Jurish';
$hash{ABSTRACT} = 'Low-level utilities for compressed storage sparse PDLs';
$hash{VERSION_FROM} = '../Version.pm';
$hash{PREREQ_PM}{PDL} = $hash{CONFIGURE_REQUIRES}{PDL} = 0;
push(@{$hash{LIBS}}, '-lm');
$hash{DIR} = [];
#$hash{INC} .= '';
#$hash{OBJECT} .= '';
$hash{realclean}{FILES} .= '*~ *.tmp README.txt';

#my $pmfile = $package[0];
#$pmfile =~ s/\.pd$/\.pm/;
#$hash{PM}{$pmfile} = "\$(INST_LIBDIR)/CCS/$pmfile";

WriteMakefile(%hash);

