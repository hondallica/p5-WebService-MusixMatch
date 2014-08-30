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
        return $http;
    },
);


my @methods = (
    'chart.artists.get',
    'chart.tracks.get',
    'track.search',
    'track.get',
    'track.subtitle.get',
    'track.lyrics.get',
    'track.snippet.get',
    'track.lyrics.post',
    'track.lyrics.feedback.post',
    'matcher.lyrics.get',
    'matcher.track.get',
    'matcher.subtitle.get',
    'artist.get',
    'artist.search',
    'artist.albums.get',
    'artist.related.get',
    'album.get',
    'album.tracks.get',
    'tracking.url.get',
    'catalogue.dump.get',
);


for my $method (@methods) {
    my $code = sub {
        my ($self, %query_param) = @_;
        return $self->request($method, \%query_param);
    };
    no strict 'refs';
    my $method_name = $method;
    $method_name =~ s|\.|_|g;
    *{$method_name} = $code; 
}


sub request {
    my ( $self, $path, $query_param ) = @_;

    my $query = URI->new;
    $query->query_param( 'apikey', $self->api_key );
    $query->query_param( 'format', 'json' );
    map { $query->query_param( $_, $query_param->{$_} ) } keys %$query_param;

    my ($minor_version, $status_code, $message, $headers, $content) = 
        $self->http->request(
            scheme => 'http',
            host => 'api.musixmatch.com',
            path_query => "ws/1.1/$path$query",
            method => 'GET',
        );

    my $data = decode_json( $content );
    if ( $data->{message}{header}{status_code} != 200 ) {
        confess $data->{message}{header}{status_code};
    } else {
        return $data;
    }
}


1;
__END__

=encoding utf-8

=head1 NAME

WebService::MusixMatch - A simple and fast interface to the Musixmatch API

=head1 SYNOPSIS

    use WebService::MusixMatch;

=head1 DESCRIPTION

The module provides a simple interface to the Bandcamp.com API. To use this module, you must first sign up at https://developer.musixmatch.com to receive an API key.

=head1 METHODS

=head2 chart.artists.get
=head2 chart.tracks.get
=head2 track.search
=head2 track.get
=head2 track.subtitle.get
=head2 track.lyrics.get
=head2 track.snippet.get
=head2 track.lyrics.post
=head2 track.lyrics.feedback.post
=head2 matcher.lyrics.get
=head2 matcher.track.get
=head2 matcher.subtitle.get
=head2 artist.get
=head2 artist.search
=head2 artist.albums.get
=head2 artist.related.get
=head2 album.get
=head2 album.tracks.get
=head2 tracking.url.get
=head2 catalogue.dump.get




=head1 SEE ALSO

https://developer.musixmatch.com

=head1 LICENSE

Copyright (C) Hondallica.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Hondallica E<lt>hondallica@gmail.comE<gt>

=cut

