#!/bin/bash
#

arrow_head="path 'M 210,16  l -15,-5  +5,+5  -5,+5  +15,-5 z'"
convert -size 350x50 \
	xc:transparent \
	\( +clone -background black -shadow 80x3+3+3 \) +swap \
	-stroke red \
	-strokewidth 10 \
	-draw 'line 4,24 315,24' \
	-draw "stroke red fill red scale 1.5,1.5 $arrow_head" \
	arrow_scale.png

convert -rotate 315 -background 'rgba(0,0,0,0)' arrow_scale.png rotated_arrow.png
composite -geometry +990+100 rotated_arrow.png docs/img/github-fork.png output.png

# adds the shadow
convert output.png \( +clone -background black -shadow 100x40+0+16 \) \
	+swap -background none -layers merge +repage output-2.png
#
# # adds the additional space like MacOSX
convert output-2.png -bordercolor none -border 32 target.png
