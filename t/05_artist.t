use strict;
use Test::More 0.98;
use WebService::MusixMatch;


my $musixmatch = new WebService::MusixMatch;

my $data = $musixmatch->artist_get(artist_id => 64);
ok $data;
my $data = $musixmatch->artist_search(q_artist => 'Metallica');
ok $data;
my $data = $musixmatch->artist_albums_get(artist_id => 64);
ok $data;
my $data = $musixmatch->artist_related_get(artist_id => 64);
ok $data;


done_testing;

