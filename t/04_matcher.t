use strict;
use utf8;
use Test::More 0.98;
use WebService::MusixMatch;
use Encode;
use Data::Dumper;


my $musixmatch = new WebService::MusixMatch;

my $data = $musixmatch->matcher_lyrics_get(
    q_track => 'One',
    q_artist => 'Metallica',
);
is $data->{message}{header}{status_code}, 200;

my $data = $musixmatch->matcher_track_get(
    q_track => 'One',
    q_album => 'Master of Puppets',
    q_artist => 'Metallica',
);
is $data->{message}{header}{status_code}, 200;

=pod
my $data = $musixmatch->matcher_subtitle_get(
    q_track => 'One',
    q_artist => 'Metallica',
);
is $data->{message}{header}{status_code}, 200;
warn Dumper $data;
=cut

done_testing;

