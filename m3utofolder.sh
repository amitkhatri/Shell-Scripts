#!/bin/bash
echo "Enter Playlist: $1"
echo "Output Directory: $2"


mpd          # Start mpd (if not already)
mpc clear    # Clear current playlist
mpc load $1  # Load selected playlist
mpc play     # Play selected playlist

#AUXPATH="$(mpc -f %file% | head -n1)"    # Grab auxillary path of track
PPATH="/home/amit/.mpd/playlists/$1.m3u" # Grab playlist path

while read line; do
	AUXPATH=$(mpc -f %file% | head -n1)   # Grab auxillary path of track
	FILENAME=${AUXPATH##*/}               # Parse auxillary path to get file name
	TRUEPATH=$(find -iname "$FILENAME")   # Find the file & get the "true" path
	echo $TRUEPATH
	cp "$TRUEPATH" $2                     # Copy file to destination
	mpc next                              # Play next song
done < $PPATH
