#!/bin/bash
#

arrow_head="path 'M 212,14  l -15,-5  +5,+5  -5,+5  +15,-5 z'"
convert -size 450x57 \
	xc:transparent \
	-strokewidth 6 \
	-stroke red \
	-draw 'line 4,28 395,28' \
	-draw "stroke red fill red scale 2,2 $arrow_head" \
	arrow.png

convert arrow.png \
	-bordercolor none -border 20 \
	\( -clone 0 -fill white -colorize 100 \) \
	\( -clone 0 -alpha extract -write mpr:alpha -morphology edgeout disk:1 \) \
	-alpha off -compose over -composite \
	\( mpr:alpha -morphology dilate disk:1 \) \
	-alpha off -compose copy_opacity -composite \
	arrow-white-border.png

convert arrow-white-border.png \
	-bordercolor none -border 20 \
	\( -clone 0 -fill black -colorize 100 \) \
	\( -clone 0 -alpha extract -write mpr:alpha -morphology edgeout disk:1 \) \
	-alpha off -compose over -composite \
	\( mpr:alpha -morphology dilate disk:1 \) \
	-alpha off -compose copy_opacity -composite \
	arrow-white-black-border.png

open arrow-white-black-border.png

convert "arrow.png" \
	\( "arrow.png" -alpha extract \) \
	-matte -bordercolor none -border 100x100 \
	-alpha off -compose copy_opacity -composite -compose over \
	\( -clone 0 -background black -shadow 25x4+3+4 \) \
	+swap \
	-background none -layers merge \
	-trim \
	"output.png"

open output.png

#convert -rotate 315 -background 'rgba(0,0,0,0)' arrow.png rotated_arrow.png
#composite -geometry +990+100 rotated_arrow.png docs/img/github-fork.png output.png

## adds the shadow
#convert output.png \( +clone -background black -shadow 100x40+0+16 \) \
#	+swap -background none -layers merge +repage output-2.png
##
## # adds the additional space like MacOSX
#convert output-2.png -bordercolor none -border 32 target.png