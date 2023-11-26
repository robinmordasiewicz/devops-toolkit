#!/bin/bash
#

convert -size 486x96 \
	xc:transparent \
	-strokewidth 0 \
	-stroke red \
	-fill red \
	-draw "ellipse 14,47 11,11 0,360" \
	-draw "polygon 482,47 385,4 400,36 10,36 10,58 400,58 385,92" \
	arrow.png

width=8
wfact=$((1000 * width))
depth=80
icontr=$(convert xc: -format "%[fx:(0.5*$depth-100)]" info:)

convert arrow.png -bordercolor none -border 10x10 -write mpr:img \
	-alpha extract -write mpr:alpha \
	+level 0,1000 -white-threshold 999 \
	-morphology Distance:-1 Euclidean:$width,1000 -level 0,"$wfact" \
	-shade 120x45 -auto-level -brightness-contrast 0,"$icontr" \
	\( +clone -fill "gray(50%)" -colorize 100% \) +swap \( mpr:alpha -threshold 0 \) \
	-compose over -composite \
	\( mpr:img -alpha off \) +swap -compose hardlight -composite \
	mpr:alpha -alpha off -compose copy_opacity -composite \
	-shave 10x10 \
	arrow-bevel.png

convert arrow-bevel.png \
	-bordercolor none -border 20 \
	\( -clone 0 -fill white -colorize 100 \) \
	\( -clone 0 -alpha extract -write mpr:alpha -morphology edgeout disk:2 \) \
	-alpha off -compose over -composite \
	\( mpr:alpha -morphology dilate disk:2 \) \
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
