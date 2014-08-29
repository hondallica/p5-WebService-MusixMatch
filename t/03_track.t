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

my $data = $musixmatch->track_lyrics_get(
    'track_id' => 7327851,
);
ok $data;
#like $data->{message}{body}{lyrics}{lyrics_body}, /^Thunder and lightning the gods take revenge/;
warn Dumper $data;


done_testing;

