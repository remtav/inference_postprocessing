# VARIABLES
ifile="$@"
# tfile=$(mktemp /tmp/XXXXXXXXX.gpkg)
tfile1=${ifile%.*}_temp.gpkg
tfile2=${ifile%.*}_raw.gpkg
ofile="${ifile%.*}.gpkg"

# VECTORIZATION
qgis_process run grass7:r.to.vect -- input="$ifile" type=2 output="$tfile1"

# FILTER USEFUL FEATURES
ogr2ogr "$tfile2" "$tfile1" -where "value" > 0

# POST-PROCESS
qgis_process run model:prod_forest forest=./$tfile2 hydrolayername="forest" gpkg_name=./$ofile

rm $tfile1
rm $tfile2

chmod 775 $ofile

echo Successfully vectorized and post-processed to: $ofile
