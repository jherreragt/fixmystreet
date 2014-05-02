package FixMyStreet::Cobrand::PorMiBarrio;
use base 'FixMyStreet::Cobrand::Default';

use strict;
use warnings;
use mySociety::MaPit;
use mySociety::VotingArea;
use Params::Util qw<_HASH _HASH0 _HASHLIKE>;

sub process_extras {
	my $self = shift;
    my $c = shift;
    my $body = shift;
    my $extra = shift;

	if ( _HASH0( $extra ) ) {
		$extra->{category} = 'Nueva Cat';
		$extra->{document} = '987654';
	}
}

1;
