package Net::WHMCS::Support;
{
    $Net::WHMCS::Support::VERSION = '0.01';
}

# ABSTRACT: WHMCS API Clients

use Moo;
with 'Net::WHMCS::Base';

sub openticket {
    my ( $self, $params ) = @_;
    $params->{action} = 'openticket';
    return $self->build_request($params);
}

1;

__END__

=pod

=head1 NAME

Net::WHMCS::Support - WHMCS API Clients

=head1 VERSION

version 0.01

=head3 openticket

	$client->openticket({
		clientid => 1,
		deptid => 1,
		subject => 'subject',
		message => 'message'
	});

http://docs.whmcs.com/API:Open_Ticket

=head1 AUTHOR

Fayland Lam <fayland@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Fayland Lam.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
