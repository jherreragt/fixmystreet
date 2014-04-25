package FixMyStreet::Cobrand::PorMiBarrio;
use base 'FixMyStreet::Cobrand::Default';

use strict;
use warnings;
use mySociety::MaPit;

sub process_extras {
	my $self = shift;
    my $c = shift;
    my $body = shift;
    my $extra = shift;

    push @$extra, { name => 'document', value => '1234' };
    push @$extra, { name => 'category', value => 'NuevaLatLong' };
}

1;
