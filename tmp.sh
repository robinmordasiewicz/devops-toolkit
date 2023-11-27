#!/bin/bash
#

convert -size 386x72 \
	xc:white \
	-strokewidth 0 \
	-stroke red \
	-fill red \
	-draw "ellipse 14,36 9,9 0,360" \
	-draw "polygon 382,36 285,4 300,27 10,27 10,45 300,45 285,68" \
	arrow.png

convert -rotate 315 -background 'rgba(0,0,0,0)' arrow.png 315-arrow.png
convert -rotate 225 -background 'rgba(0,0,0,0)' arrow.png 225-arrow.png
mv 315-arrow.png arrow.png

width=10
wfact=$((1000 * width))
depth=40
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
mv arrow-bevel.png arrow.png

convert arrow.png \
	-bordercolor none -border 20 \
	\( -clone 0 -fill white -colorize 100 \) \
	\( -clone 0 -alpha extract -write mpr:alpha -morphology edgeout disk:2 \) \
	-alpha off -compose over -composite \
	\( mpr:alpha -morphology dilate disk:2 \) \
	-alpha off -compose copy_opacity -composite \
	arrow-white-border.png
mv arrow-white-border.png arrow.png

convert arrow.png \
	-bordercolor none -border 20 \
	\( -clone 0 -fill black -colorize 100 \) \
	\( -clone 0 -alpha extract -write mpr:alpha -morphology edgeout disk:1 \) \
	-alpha off -compose over -composite \
	\( mpr:alpha -morphology dilate disk:1 \) \
	-alpha off -compose copy_opacity -composite \
	arrow-white-black-border.png
mv arrow-white-black-border.png arrow.png

convert arrow.png \( +clone -background black -shadow 50x10+10+10 \) +swap -background none -layers merge +repage output.png
composite -geometry +915+140 output.png docs/img/github-fork.png output2.png
rm output.png
open output2.png

#convert -rotate 315 -background 'rgba(0,0,0,0)' arrow.png rotated_arrow.png
#composite -geometry +990+100 rotated_arrow.png docs/img/github-fork.png output.png

## adds the shadow
#convert output.png \( +clone -background black -shadow 100x40+0+16 \) \
#	+swap -background none -layers merge +repage output-2.png
##
## # adds the additional space like MacOSX
#convert output-2.png -bordercolor none -border 32 target.png
