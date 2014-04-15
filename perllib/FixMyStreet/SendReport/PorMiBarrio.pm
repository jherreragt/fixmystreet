package FixMyStreet::SendReport::PorMiBarrio;

use Moose;
use namespace::autoclean;

BEGIN { extends 'FixMyStreet::SendReport'; }

use FixMyStreet::App;
use mySociety::Config;
use DateTime::Format::W3CDTF;
use Open311;
use Readonly;

Readonly::Scalar my $COUNCIL_ID_OXFORDSHIRE => 2237;

sub send {
    my $self = shift;
    my ( $row, $h ) = @_;

    my $result = -1;
    #Agregado
    use Data::Dumper;
    open (MYFILE, '>>open311.log');
    print MYFILE "ROW:\n";
    print MYFILE Dumper($row);
    close (MYFILE);

    #foreach(@columns)
    #{
    #    print "$_\r\n";
    #}
    foreach my $body ( @{ $self->bodies } ) {
        my $conf = $self->body_config->{ $body->id };

        my $always_send_latlong = 1;
        my $send_notpinpointed  = 0;
        my $use_service_as_deviceid = 0;

        my $extended_desc = 1;

        # To rollback temporary changes made by this function
        my $revert = 0;

        # FIXME: we've already looked this up before
        my $contact = FixMyStreet::App->model("DB::Contact")->find( {
            deleted => 0,
            body_id => $body->id,
            category => $row->category
        } );

        my %open311_params = (
            jurisdiction            => $conf->jurisdiction,
            endpoint                => $conf->endpoint,
            api_key                 => $conf->api_key,
            always_send_latlong     => $always_send_latlong,
            send_notpinpointed      => $send_notpinpointed,
            use_service_as_deviceid => $use_service_as_deviceid,
            extended_description    => $extended_desc,
        );
        if (FixMyStreet->test_mode) {
            my $test_res = HTTP::Response->new();
            $test_res->code(200);
            $test_res->message('OK');
            $test_res->content('<?xml version="1.0" encoding="utf-8"?><service_requests><request><service_request_id>248</service_request_id></request></service_requests>');
            $open311_params{test_mode} = 1;
            $open311_params{test_get_returns} = { 'requests.xml' => $test_res };
        }

        my $open311 = Open311->new( %open311_params );

        my $resp = $open311->send_service_request( $row, $h, $contact->email );

        # make sure we don't save user changes from above
        $row->discard_changes() if $revert;

        if ( $resp ) {
            $row->external_id( $resp );
            $row->send_method_used('Open311');
            $result *= 0;
            $self->success( 1 );
        } else {
            $result *= 1;
        }
    }

    $self->error( 'Failed to send over Open311' ) unless $self->success;

    return $result;
}

1;