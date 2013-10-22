package Net::WHMCS::Support;
{
    $Net::WHMCS::Support::VERSION = '0.02';
}

# ABSTRACT: WHMCS API Support

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

Net::WHMCS::Support - WHMCS API Support

=head1 VERSION

version 0.02

=head2 openticket

	$client->openticket({
		clientid => 1,
		deptid => 1,
		subject => 'subject',
		message => 'message'
	});

L<http://docs.whmcs.com/API:Open_Ticket>

=head1 AUTHOR

Fayland Lam <fayland@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Fayland Lam.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
