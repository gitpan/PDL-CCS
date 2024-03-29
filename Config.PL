## File: PDL-CCS/Config.PL
## Description: user variables for PDL::CCS package

##-- load cached values?
if (0 && -e "./CCS/Config.pm") {
  require "./CCS/Config.pm";
  if ($@) {
    warn("$0: could not load cache data from './CCS/Config.pm': $@");
  }
  %cconfig = %PDL::CCS::Config::ccsConfig;
}

##--
## $val = cprompt($key, $message)
## $val = cprompt($key, $message, $default)
##   + sets $cconfig{$key}
sub cprompt {
  my ($key, $msg, $default)=@_;
  return $cconfig{$key} if (defined($cconfig{$key}));
  $default = '' if (!defined($default));
  my $answer = ExtUtils::MakeMaker::prompt("<Config.PL> $msg [$default] ? ");
  chomp($answer);
  return $cconfig{$key} = ($answer eq '' ? $default : $answer);
}

## $USE_PDL_INDX : whether to use built-in PDL_Indx type (PDL >= v2.007)
require PDL::Core;
if (defined(&PDL::indx)) {
  cprompt('USE_PDL_INDX', "use 64-bit indices via PDL_Indx if available (PDL >= v2.007)", "y");
  $cconfig{USE_PDL_INDX} = ($cconfig{USE_PDL_INDX} && $cconfig{USE_PDL_INDX} !~ /^[n0]/i);
} else {
  print STDERR "Info: 64-bit indices via PDL_Indx disabled for PDL < v2.007\n";
  $cconfig{USE_PDL_INDX} = '';
}

if ($cconfig{USE_PDL_INDX}) {
  $cconfig{INDX_CTYPE} = "PDL_Indx";
  $cconfig{INDX_SIG}   = "indx";
  $cconfig{INDX_FUNC}  = "indx";
} else {
  $cconfig{INDX_CTYPE} = "PDL_Long";
  $cconfig{INDX_SIG}   = "int";
  $cconfig{INDX_FUNC}  = "long";
}
$cconfig{INDX_TYPEDEF} = "typedef $cconfig{INDX_CTYPE} CCS_Indx;  /**< typedef for CCS indices */\n";
$cconfig{INDX_FUNCDEF} = "*ccs_indx = \\&PDL::$cconfig{INDX_FUNC}; ##-- typecasting for CCS indices\n";

require PDL::Types;
$cconfig{INT_TYPE_KEYS} = [sort grep {$PDL::Types::typehash{$_}{ppsym} =~ /^(?:[BSULQN]|LL|US)$/} keys %PDL::Types::typehash];
$cconfig{INT_TYPE_CHRS} = [sort map {$_->{ppsym}} @PDL::Types::typehash{ @{$cconfig{INT_TYPE_KEYS}} }];

##-- save cache file
open(CONFIGPM,">./CCS/Config.pm")
  or die("$0: failed to open ./CCS/Config.pm for writing: $!");
print CONFIGPM <<'EOF';
## Automatically generated, remove to re-configure!

package PDL::CCS::Config;
use PDL qw();
our @ISA = qw(Exporter);
our (%ccsConfig);
our @EXPORT      = qw(ccs_indx);
our @EXPORT_OK   = ('%ccsConfig', 'ccs_indx');
our %EXPORT_TAGS = (config=>['%ccsConfig'], Func=>\@Export, default=>\@EXPORT, all=>\@EXPORT_OK);

EOF

##-- config hash
use Data::Dumper;
print CONFIGPM Data::Dumper->Dump([\%cconfig],['*ccsConfig']), "\n";

##-- type conversion sub
print CONFIGPM << "EOF";
\*PDL::ccs_indx = $cconfig{INDX_FUNCDEF}

1; ##-- be happy
EOF
close CONFIGPM;

1; ##-- return nicely
