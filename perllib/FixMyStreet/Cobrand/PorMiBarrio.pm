package FixMyStreet::Cobrand::PorMiBarrio;
use base 'FixMyStreet::Cobrand::Default';

use strict;
use warnings;
use mySociety::MaPit;
use mySociety::VotingArea;

sub process_extras {
	my $self = shift;
    my $c = shift;
    my $body = shift;
    my $extra = shift;

    $extra->{category} = 'Nueva Cat';
    $extra->{document} = '987654';
}

1;
