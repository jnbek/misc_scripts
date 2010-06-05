#!/usr/bin/perl
#
# Converts FLAC to MP3 preserving tags
# License: GPLv2
# Home: http://www.GuruLabs.com/downloads.html
# Edited by jnbek for use strict, configurable LAME opts.
# http://github.com/jnbek
# Note: Only use on flac files that you trust. A
# malicious ID3v1 tag could hose you.
# Requires FLAC, LAME and Audio::FLAC::Header
#
use strict;
use warnings;

use Audio::FLAC::Header;
my $lame_options = q{ -v -b 224 -B 320 };    # man lame
foreach my $file (@ARGV) {
    my ($year, $artist, $comment, $album, $title, $genre, $tracknum) = '';
    if (!($file =~ m/\.flac$/i)) {
        print "Skipping $file\n";
        next;
    }
    my $flac = Audio::FLAC::Header->new($file);
    if (my $tag = $flac->tags()) {
        $year     = $tag->{'DATE'};
        $artist   = $tag->{'ARTIST'};
        $comment  = $tag->{'COMMENT'};
        $album    = $tag->{'ALBUM'};
        $title    = $tag->{'TITLE'};
        $genre    = $tag->{'GENRE'};
        $tracknum = $tag->{'TRACKNUMBER'};
        chomp($year, $artist, $comment, $album, $title, $genre, $tracknum);
        $tracknum = sprintf("%2.2d", $tracknum);
    }
    else {
        print "Couldn't get id3v1 tag for $file.\n";
    }
    if (($artist) || ($title) || ($tracknum)) {
        my $outfile = $artist . "_-_" . $album . "_-_" . $tracknum . "_-_" . $title . ".mp3";
        `flac -c -d "$file" | lame $lame_options --ty $year --ta "$artist" --tc "$comment" --tl "$album" --tt "$title" --tg "$genre" --tn $tracknum - "$outfile"`;
    }
    else {
        my $outfile = $file;
        $outfile =~ s/\.flac$/.mp3/;
        `flac -c -d "$file" | lame $lame_options - "$outfile"`;
    }
}
