#!/bin/bash
#

outputfolder="docs/img/overlays"
if [[ ! -d "$outputfolder" ]]
then
  mkdir -p "$outputfolder"
fi

convert -size 72x384 \
	xc:transparent \
	-strokewidth 0 \
	-stroke red \
	-fill red \
	-draw "polygon 36,4 4,76 27,65 27,380 45,380 45,65 68,76" \
	${outputfolder}/pointer.png

width=10
wfact=$((1000 * width))
depth=40
icontr=$(convert xc: -format "%[fx:(0.5*$depth-100)]" info:)

for entry in 0 45 90 135 180 225 270 315
do
  # Rotate the pointer
  convert -rotate ${entry} -background 'rgba(0,0,0,0)' ${outputfolder}/pointer.png ${outputfolder}/pointer-${entry}.png

  # Add the bezel
  convert ${outputfolder}/pointer-${entry}.png -bordercolor none -border 10x10 -write mpr:img \
  	-alpha extract -write mpr:alpha \
  	+level 0,1000 -white-threshold 999 \
  	-morphology Distance:-1 Euclidean:$width,1000 -level 0,"$wfact" \
  	-shade 120x45 -auto-level -brightness-contrast 0,"$icontr" \
  	\( +clone -fill "gray(50%)" -colorize 100% \) +swap \( mpr:alpha -threshold 0 \) \
	  -compose over -composite \
	  \( mpr:img -alpha off \) +swap -compose hardlight -composite \
	  mpr:alpha -alpha off -compose copy_opacity -composite \
	  -shave 10x10 \
	  tmp.png
  mv tmp.png ${outputfolder}/pointer-${entry}.png

  # Add a white border
  convert ${outputfolder}/pointer-${entry}.png \
  	-bordercolor none -border 20 \
  	\( -clone 0 -fill white -colorize 100 \) \
  	\( -clone 0 -alpha extract -write mpr:alpha -morphology edgeout disk:2 \) \
  	-alpha off -compose over -composite \
  	\( mpr:alpha -morphology dilate disk:2 \) \
  	-alpha off -compose copy_opacity -composite \
  	tmp.png
  mv tmp.png ${outputfolder}/pointer-${entry}.png

  # Add a black border
  convert ${outputfolder}/pointer.png \
  	-bordercolor none -border 20 \
  	\( -clone 0 -fill black -colorize 100 \) \
  	\( -clone 0 -alpha extract -write mpr:alpha -morphology edgeout disk:1 \) \
  	-alpha off -compose over -composite \
  	\( mpr:alpha -morphology dilate disk:1 \) \
  	-alpha off -compose copy_opacity -composite \
  	tmp.png
  mv tmp.png ${outputfolder}/pointer-${entry}.png

  # Add the drop shadow
  convert ${outputfolder}/pointer-${entry}.png \
    \( +clone -background black -shadow 50x10+10+10 \) \
    +swap \
    -background none \
    -layers merge \
    +repage \
    tmp.png
  mv tmp.png ${outputfolder}/pointer-${entry}.png
done
