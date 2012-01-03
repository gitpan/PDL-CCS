
#
# GENERATED WITH PDL::PP! Don't modify!
#
package PDL::CCS::MatrixOps;

@EXPORT_OK  = qw( PDL::PP ccs_matmult2d_sdd PDL::PP ccs_matmult2d_zdd );
%EXPORT_TAGS = (Func=>[@EXPORT_OK]);

use PDL::Core;
use PDL::Exporter;
use DynaLoader;



   $PDL::CCS::MatrixOps::VERSION = 1.17;
   @ISA    = ( 'PDL::Exporter','DynaLoader' );
   push @PDL::Core::PP, __PACKAGE__;
   bootstrap PDL::CCS::MatrixOps $VERSION;





#use PDL::CCS::Version;
use strict;

=pod

=head1 NAME

PDL::CCS::MatrixOps - Low-level matrix operations for compressed storage sparse PDLs

=head1 SYNOPSIS

 use PDL;
 use PDL::CCS::MatrixOps;

 ##---------------------------------------------------------------------
 ## ... stuff happens

=cut







=head1 FUNCTIONS



=cut






=head2 ccs_matmult2d_sdd

=for sig

  Signature: (
    int ixa(NdimsA,NnzA); nza(NnzA); missinga();
    b(O,M);
    zc(O);
    [o]c(O,N)
    )


Two-dimensional matrix multiplication of a sparse index-encoded PDL
$a() with a dense pdl $b(), with output to a dense pdl $c().

The sparse input PDL $a() should be passed here with 0th
dimension "M" and 1st dimension "N", just as for the
built-in PDL::Primitive::matmult().

"Missing" values in $a() are treated as $missinga(), which shouldn't
be BAD or inifinte, but otherwise ought to be handled correctly.
The input pdl $zc() is used to pass the cached contribution of
a $missinga()-row ("M") to an output column ("O"), i.e.

 $zc = ((zeroes($M,1)+$missinga) x $b)->flat;

$SIZE(Ndimsa) is assumed to be 2.


=for bad

ccs_matmult2d_sdd does not process bad values.
It will set the bad-value flag of all output piddles if the flag is set for any of the input piddles.


=cut






*ccs_matmult2d_sdd = \&PDL::ccs_matmult2d_sdd;





=head2 ccs_matmult2d_zdd

=for sig

  Signature: (
    int ixa(Ndimsa,NnzA); nza(NnzA);
    b(O,M);
    [o]c(O,N)
    )


Two-dimensional matrix multiplication of a sparse index-encoded PDL
$a() with a dense pdl $b(), with output to a dense pdl $c().

The sparse input PDL $a() should be passed here with 0th
dimension "M" and 1st dimension "N", just as for the
built-in PDL::Primitive::matmult().

"Missing" values in $a() are treated as zero.
$SIZE(Ndimsa) is assumed to be 2.


=for bad

ccs_matmult2d_zdd does not process bad values.
It will set the bad-value flag of all output piddles if the flag is set for any of the input piddles.


=cut






*ccs_matmult2d_zdd = \&PDL::ccs_matmult2d_zdd;




##---------------------------------------------------------------------
=pod

=head1 ACKNOWLEDGEMENTS

Perl by Larry Wall.

PDL by Karl Glazebrook, Tuomas J. Lukka, Christian Soeller, and others.

=cut

##----------------------------------------------------------------------
=pod

=head1 KNOWN BUGS

We should really implement matrix multiplication in terms of
inner product, and have a good sparse-matrix only implementation
of the former.

=cut


##---------------------------------------------------------------------
=pod

=head1 AUTHOR

Bryan Jurish E<lt>moocow@cpan.orgE<gt>

=head2 Copyright Policy

All other parts Copyright (C) 2009, Bryan Jurish. All rights reserved.

This package is free software, and entirely without warranty.
You may redistribute it and/or modify it under the same terms
as Perl itself.

=head1 SEE ALSO

perl(1), PDL(3perl)

=cut



;



# Exit with OK status

1;

		   