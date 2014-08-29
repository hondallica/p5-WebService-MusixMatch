use strict;
use Test::More 0.98;
use WebService::MusixMatch;
use Data::Dumper;


my $musixmatch = new WebService::MusixMatch;

my $data = $musixmatch->track_search(
    q => 'One',
    f_artist_id => 64,
);
ok $data;

my $data = $musixmatch->track_get(
    'track_id' => 14201829,
);
ok $data;

#my $data = $musixmatch->track_subtitle_get(
#    'track_id' => 14201829,
#);
#ok $data;

my $data = $musixmatch->track_lyrics_get(
    'track_id' => 7327851,
);
ok $data;
like $data->{message}{body}{lyrics}{lyrics_body}, qr/^Thunder and lightning the gods take revenge/;

my $data = $musixmatch->track_snippet_get(
    'track_id' => 7327851,
);
is $data->{message}{header}{status_code}, 200;

my $data = $musixmatch->track_lyrics_post(
    'track_id' => 1471157,
    'lyrics_body' => 'here%20is%20the%20lyrics',
);
is $data->{message}{header}{status_code}, 200;
is $data->{message}{body}, '';


done_testing;

