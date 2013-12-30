package Mail::Chimp2;

use 5.012;
use Mouse;

# ABSTRACT: Mailchimp V2 API

# VERSION

with 'Web::API';
use Data::Dump;

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Some::Module;
    use Data::Dump 'dump';

=head1 ATTRIBUTES

=head2 attr

=cut

has 'dc' => (
    is      => 'rw',
    isa     => 'Str',
    default => sub { 'us1' },
);

has 'commands' => (
    is      => 'rw',
    default => sub {
        {
            # campaign handling
            campaigns_list => { path => 'campaigns/list' },

            # list handling
            lists_list    => { path => 'lists/list' },
            lists_members => {
                path      => 'lists/members',
                mandatory => ['id']
            },
            lists_batch_subscribe => {
                path      => 'lists/batch-subscribe',
                mandatory => [ 'id', 'batch' ]
            },
            lists_subscribe => {
                path      => 'lists/subscribe',
                mandatory => [ 'id', 'email' ]
            },
            lists_unsubscribe => {
                path      => 'lists/unsubscribe',
                mandatory => [ 'id', 'email' ]
            },

        };
    });

=head1 INTERNALS

=cut

sub commands {
    my ($self) = @_;
    return $self->commands;
}

=head2 BUILD

basic configuration for the client API happens usually in the BUILD method when using Web::API

=cut

sub BUILD {
    my ($self) = @_;

    (my $_key, $self->dc) = split(/-/, $self->api_key);
    $self->user_agent(__PACKAGE__ . ' ' . $Mail::Chimp2::VERSION);
    $self->strict_ssl(1);
    $self->content_type('application/json');
    $self->default_method('POST');
    $self->extension('json');
    $self->base_url('https://' . $self->dc . '.api.mailchimp.com/2.0');
    $self->auth_type('hash_key');
    $self->api_key_field('apikey');

    return $self;
}

=head1 BUGS

Please report any bugs or feature requests on GitHub's issue tracker L<https://github.com/norbu09/Mail::Chimp2/issues>.
Pull requests welcome.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Mail::Chimp2


You can also look for information at:

=over 4

=item * GitHub repository

L<https://github.com/norbu09/Mail::Chimp2>

=item * MetaCPAN

L<https://metacpan.org/module/Mail::Chimp2>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Mail::Chimp2>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Mail::Chimp2>

=back


=head1 ACKNOWLEDGEMENTS

=over 4

=back

=cut

__PACKAGE__->meta->make_immutable();    # End of Mail::Chimp2
