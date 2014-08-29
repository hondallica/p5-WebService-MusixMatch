use strict;
use utf8;
use Test::More 0.98;
use WebService::MusixMatch;
use Encode;
use Data::Dumper;


my $musixmatch = new WebService::MusixMatch;

my $data = $musixmatch->chart_artists_get(
    country => 'JP',
);
is $data->{message}{header}{status_code}, 200;


my $data = $musixmatch->chart_tracks_get(
    country => 'JP',
    'page_size' => 1,
);
is $data->{message}{header}{status_code}, 200;

for my $track (@{$data->{message}{body}{track_list}}){
    ok exists $track->{track}{artist_name};
    ok exists $track->{track}{track_name};
}


done_testing;

