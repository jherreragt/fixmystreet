package FixMyStreet::Cobrand::PorMiBarrio;
use base 'FixMyStreet::Cobrand::Default';

use strict;
use warnings;
#use Params::Util qw<_HASH _HASH0 _HASHLIKE>;

sub process_extras {
	my $self = shift;
    my $c = shift;
    my $body = shift;
    my $extra = shift;

    if ($c->user_exists){
    	push @$extra, { name => 'document', value => $c->user->identity_document };
    }
}

=head2 user_check_for_errors

Perform validation for new users. Takes Catalyst context object as an argument

=cut

sub user_check_for_errors {
    my $self = shift;
    my $c = shift;

	my $identity_document = $c->stash->{user}->identity_document;

    my %errors = ();

    if ( $identity_document ) {
		if ( !$self->validate_identity_document( $c, $identity_document ) ) {
			$errors{identity_document} = _('Please enter a valid ID');
		}
	} else {
        $errors{identity_document} = _('Please enter your ID');
    }

    return (
        %{ $c->stash->{field_errors} },
        %{ $c->stash->{user}->check_for_errors },
        %errors,
    );
}

sub validate_identity_document {
	my $self = shift;
	my $c = shift;
	my $identity_document = shift;
	
	if ( $identity_document ) {	
		$identity_document = Utils::trim_text( $identity_document );
		$identity_document =~ s/\.//g;
		
		my @parts = split /-/, $identity_document;
		
		if (scalar @parts eq 2) {
			#1234567-X -> X = [(1x8) + (2x1) + (3x2) + (4x3) + (5x4) + (6x7) + (7x6)] mod 10 -> X = [ 8 +2 +6 +12 +20 +42 +42] mod 10 = 132 mod 10 = 2

			my @magic = (8, 1, 2, 3, 4, 7, 6);
			my @identity_document_array = split("", $identity_document);
			my $result = 0;

			print(scalar $c);
			for ( my $pos = 0; $pos < scalar @magic && $pos < scalar @identity_document_array; $pos++ ) {
					$result += $magic[$pos] * $identity_document_array[$pos];
			}

			my $verification = $result % 10;
			return $verification eq $parts[1];
		}
	}
	
	return 0;
}

=head2 report_check_for_errors

Perform validation for new reports. Takes Catalyst context object as an argument

=cut

sub report_check_for_errors {
    my $self = shift;
    my $c = shift;

	my $identity_document = $c->stash->{report}->user->identity_document;

    my %errors = ();

    if ( $identity_document ) {
		if ( !$self->validate_identity_document( $c, $identity_document ) ) {
			$errors{identity_document} = _('Please enter a valid ID');
		}
	} else {
        $errors{identity_document} = _('Please enter your ID');
    }
    
    return (
        %{ $c->stash->{field_errors} },
        %{ $c->stash->{report}->user->check_for_errors },
        %{ $c->stash->{report}->check_for_errors },
        %errors,
    );
}

=head 2 pin_colour

Returns the colour of pin to be used for a particular report
(so perhaps different depending upon the age of the report).

=cut
sub pin_colour {
    my ( $self, $p, $context, $c, $categories ) = @_;
    #return 'green' if time() - $p->confirmed->epoch < 7 * 24 * 60 * 60;
    
    if ( $context eq 'around' || $context eq 'reports' ) {
		my $category_name = $p->category;
		
		if ( $categories && $categories->{$category_name}) {
			return 'group-'.$categories->{$category_name};
		} else {
			return 'yellow';
		}
	} else {
		return $p->is_fixed ? 'green' : 'red';
	}
}

# let staff and owners hide reports
sub users_can_hide { 1 }

1;
