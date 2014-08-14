package WebService::MusixMatch;
use JSON::XS;
use Cache::LRU;
use Net::DNS::Lite;
use Furl;
use URI;
use URI::QueryParam;
use Carp;
use Moo;
use namespace::clean;
our $VERSION = "0.01";


$Net::DNS::Lite::CACHE = Cache::LRU->new( size => 512 );

has 'api_key' => (
    is => 'rw',
    isa => sub { $_[0] },
    required => 1,
    default => $ENV{MUSIXMATCH_API_KEY},
);

has 'http' => (
    is => 'rw',
    required => 1,
    default  => sub {
        my $http = Furl::HTTP->new(
            inet_aton => \&Net::DNS::Lite::inet_aton,
            agent => 'WebService::MusixMatch' . $VERSION,
            headers => [ 'Accept-Encoding' => 'gzip',],
        );
        $http->env_proxy;
        return $http;
    },
);


1;
__END__

=encoding utf-8

=head1 NAME

WebService::MusixMatch - A simple and fast interface to the Musixmatch API

=head1 SYNOPSIS

    use WebService::MusixMatch;

=head1 DESCRIPTION

The module provides a simple interface to the Bandcamp.com API. To use this module, you must first sign up at https://developer.musixmatch.com to receive an API key.

=head1 SEE ALSO

https://developer.musixmatch.com

=head1 LICENSE

Copyright (C) Hondallica.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Hondallica E<lt>hondallica@gmail.comE<gt>

=cut

