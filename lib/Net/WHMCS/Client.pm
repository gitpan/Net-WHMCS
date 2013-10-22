package Net::WHMCS::Client;
{
    $Net::WHMCS::Client::VERSION = '0.02';
}

# ABSTRACT: WHMCS API Clients

use Moo;
with 'Net::WHMCS::Base';

sub getclientsdetails {
    my ( $self, $params ) = @_;
    $params->{action} = 'getclientsdetails';
    return $self->build_request($params);
}

sub addclient {
    my ( $self, $params ) = @_;
    $params->{action} = 'addclient';
    return $self->build_request($params);
}

sub updateclient {
    my ( $self, $params ) = @_;
    $params->{action} = 'updateclient';
    return $self->build_request($params);
}

sub deleteclient {
    my ( $self, $params ) = @_;
    $params->{action} = 'deleteclient';
    return $self->build_request($params);
}

sub getclients {
    my ( $self, $params ) = @_;
    $params ||= {};
    $params->{action} = 'getclients';
    return $self->build_request($params);
}

sub getclientpassword {
    my ( $self, $params ) = @_;
    $params->{action} = 'getclientpassword';
    return $self->build_request($params);
}

sub getclientsproducts {
    my ( $self, $params ) = @_;
    $params ||= {};
    $params->{action} = 'getclientsproducts';
    return $self->build_request($params);
}

sub sendemail {
    my ( $self, $params ) = @_;
    $params ||= {};
    $params->{action} = 'sendemail';
    return $self->build_request($params);
}

1;

__END__

=pod

=head1 NAME

Net::WHMCS::Client - WHMCS API Clients

=head1 VERSION

version 0.02

=head2 getclientsdetails

	$client->getclientsdetails({
		clientid => 1,
		stats => 'true',
	})

L<http://docs.whmcs.com/API:Get_Clients_Details>

=head2 addclient

	$client->addclient({
		firstname => 'first',
		lastname => 'last',
		email => 'blabla@balbla.com',
		...
	})

L<http://docs.whmcs.com/API:Add_Client>

=head2 updateclient

	$client->updateclient({
		clientid => 1,
		firstname => 'first',
		lastname => 'last',
		email => 'blabla@balbla.com',
		...
	})

L<http://docs.whmcs.com/API:Update_Client>

=head2 deleteclient

	$client->deleteclient({
		clientid => 1
	})

L<http://docs.whmcs.com/API:Delete_Client>

=head2 getclients

	$client->getclients()

L<http://docs.whmcs.com/API:Get_Clients>

=head2 getclientpassword

	$client->getclientpassword({
		userid => 1
	})

L<http://docs.whmcs.com/API:Get_Clients_Password>

=head2 getclientsproducts

	$client->getclientsproducts({
		clientid => 1
	})

L<http://docs.whmcs.com/API:Get_Clients_Products>

=head2 sendemail

	$client->sendemail({
		id => 1,
		messagename => 'blabla'
	})

L<http://docs.whmcs.com/API:Send_Email>

=head1 AUTHOR

Fayland Lam <fayland@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Fayland Lam.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
