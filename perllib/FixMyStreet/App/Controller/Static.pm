package FixMyStreet::App::Controller::Static;
use Moose;
use namespace::autoclean;
use Data::Dumper;
use FixMyStreet::App;
use JSON;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

FixMyStreet::App::Controller::Static - Catalyst Controller

=head1 DESCRIPTION

Static pages Catalyst Controller. FAQ does some smarts to choose the correct
template depending on language, will need extending at some point.

=head1 METHODS

=cut

sub about : Global : Args(0) {
    my ( $self, $c ) = @_;

    my $lang_code = $c->stash->{lang_code};
    my $template  = "static/about-$lang_code.html";
    $c->stash->{template} = $template;
}

sub privacy : Global : Args(0) {
    my ( $self, $c ) = @_;
}

sub faq : Global : Args(0) {
    my ( $self, $c ) = @_;

    # There should be a faq template for each language in a cobrand or default.
    # This is because putting the FAQ translations into the PO files is
    # overkill.
    
    # We rely on the list of languages for the site being restricted so that there
    # will be a faq template for that language/cobrand combo.
        
    my $lang_code = $c->stash->{lang_code};
    my $template  = "faq/faq-$lang_code.html";
    $c->stash->{template} = $template;
}

sub fun : Global : Args(0) {
    my ( $self, $c ) = @_;
    # don't need to do anything here - should just pass through.
}

sub posters : Global : Args(0) {
    my ( $self, $c ) = @_;
}

sub iphone : Global : Args(0) {
    my ( $self, $c ) = @_;
}

sub stats : Global : Args(0) {
    my ( $self, $c ) = @_;
    my @problems;

    if ( $c->req->param('getcounts') ) {

        my ( $start_date, $end_date, @errors );
        my $parser = DateTime::Format::Strptime->new( pattern => '%d/%m/%Y' );

        $start_date = $parser-> parse_datetime ( $c->req->param('start_date') );

        push @errors, _('Invalid start date') unless defined $start_date;

        $end_date = $parser-> parse_datetime ( $c->req->param('end_date') ) ;

        push @errors, _('Invalid end date') unless defined $end_date;

        $c->stash->{errors} = \@errors;
        $c->stash->{start_date} = $start_date;
        $c->stash->{end_date} = $end_date;

        return 1 if @errors;

        #Cache Groups if not in memcached

        #Get contact and groups for render properly
        my @contacts                #
          = $c                      #
          ->model('DB::Contact')    #
          ->not_deleted             #
          ->search(
                {
                    -AND => [
                    'deleted' => { '=', 'f'},
                    'non_public' => { '=', 'f' },
                    ]
                },
                {select => ['category', 'group_id']}
            )
          ->all;
        @contacts = map { { $_->get_columns } } @contacts;
        my @contacts_group                #
          = $c                            #
          ->model('DB::ContactsGroup')    #
          ->search()
          ->all;
        @contacts_group = map { { $_->get_columns } } @contacts_group;
        my $problem_by_group = {};
        for my $contact (@contacts){
            for my $contact_group (@contacts_group){
                if ( exists $contact->{group_id} and $contact->{group_id} eq $contact_group->{group_id} ){
                    unless (exists $problem_by_group->{$contact->{group_id}}) {
                        $problem_by_group->{$contact->{group_id}}{name} = $contact_group->{group_name};
                        $problem_by_group->{$contact->{group_id}}{total} = 0;
                        $problem_by_group->{$contact->{group_id}}{fixed} = 0;
                        $problem_by_group->{$contact->{group_id}}{in_progress} = 0;
                        $problem_by_group->{$contact->{group_id}}{confirmed} = 0;
                    }
                    $problem_by_group->{$contact->{group_id}}{$contact->{category}}{name} = $contact->{category};
                    $problem_by_group->{$contact->{group_id}}{$contact->{category}}{total} = 0;
                    $problem_by_group->{$contact->{group_id}}{$contact->{category}}{fixed} = 0;
                    $problem_by_group->{$contact->{group_id}}{$contact->{category}}{in_progress} = 0;
                    $problem_by_group->{$contact->{group_id}}{$contact->{category}}{confirmed} = 0;
                }
            }
        }
        $c->log->debug('%PROBLEM_BY_GROUP');
        $c->log->debug(Dumper($problem_by_group));

        my $one_day = DateTime::Duration->new( days => 1 );

        my %select = (
                state => [ FixMyStreet::DB::Result::Problem->visible_states() ],
                select => [ 
                    'id', 'latitude', 'longitude', 'category', 'external_id', 
                    'created', 'confirmed', 'state', 'whensent', 'lastupdate' ],
                order_by => [ 'confirmed, state' ],
        );

        my @problems = $c->model('DB::Problem')->search(
            {
                -AND => [
                    'confirmed' => { '>=', $start_date},
                    'confirmed' => { '<=', $end_date + $one_day },
                ],
            },
            \%select
        );
        @problems = map { { $_->get_columns } } @problems;
        $c->log->debug('PROBLEMS:');
        my $problem_csv = '"id","latitude","longitude","category","external_id","created","confirmed","whensent","lastupdate","state"\r\n';
        for my $problem (@problems){
            foreach my $group_id (keys $problem_by_group){
                if ( exists $problem_by_group->{$group_id}->{$problem->{category}} ){
                    $problem_by_group->{$group_id}->{$problem->{category}}{total}++;
                    $problem_by_group->{$group_id}{total}++;
                    if ( $problem->{state} =~ /fixed/ ){
                        $problem_by_group->{$group_id}{fixed}++;
                        $problem_by_group->{$group_id}->{$problem->{category}}{fixed}++;
                    }
                    elsif ($problem->{state} eq 'in progress'){
                        $problem_by_group->{$group_id}{in_progress}++;
                        $problem_by_group->{$group_id}->{$problem->{category}}{in_progress}++;
                    }
                    else{
                        $problem_by_group->{$group_id}{confirmed}++;
                        $problem_by_group->{$group_id}->{$problem->{category}}{confirmed}++;
                    }
                    last;
                }
            }
            $problem_csv .= $problem->{id}.',"'.
                $problem->{latitude}.'","'.
                $problem->{longitude}.'","'.
                $problem->{category}.'","'.
                $problem->{external_id}.'","'.
                $problem->{created}.'","'.
                $problem->{confirmed}.'","'.
                $problem->{whensent}.'","'.
                $problem->{lastupdate}.'","'.
                $problem->{state}.'"\r\n';
        }
        $c->log->debug(Dumper($problem_by_group));
        my $problem_json = encode_json($problem_by_group);
        $c->log->debug(Dumper($problem_json));
        $c->stash->{statics_json} = $problem_json;
        $c->stash->{problem_csv} = "'".$problem_csv."'";
    }

    return 1;
}

__PACKAGE__->meta->make_immutable;

1;

