#!/bin/bash
#

arrow_head="path 'M 220,16  l -15,-5  +5,+5  -5,+5  +15,-5 z'"
convert -size 350x50 \
	xc:transparent \
	-stroke red \
	-strokewidth 6 \
	-draw 'line 4,24 330,24' \
	-draw "stroke red fill red scale 1.5,1.5 $arrow_head" \
	arrow.png

convert -rotate 315 -background 'rgba(0,0,0,0)' arrow.png rotated_arrow.png
composite -geometry +990+100 rotated_arrow.png docs/img/github-fork.png output.png
rm arrow.png rotated_arrow.png

# adds the shadow
convert output.png \( +clone -background black -shadow 100x40+0+16 \) \
	+swap -background none -layers merge +repage output-2.png
#
# # adds the additional space like MacOSX
convert output-2.png -bordercolor none -border 32 target.png

rm output.png output-2.png
