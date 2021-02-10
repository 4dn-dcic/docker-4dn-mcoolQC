#!/bin/bash
# Creates qc for mcool files

INPUT=$1
OUTDIR=$2

FILE_BASE=$(basename $INPUT)
FILE_NAME=${FILE_BASE%.*}

if [ ! -d "$OUTDIR" ]
then
	mkdir $OUTDIR
fi

cooler attrs $INPUT > $OUTDIR/cooler_attrs.txt

python3 /usr/local/bin/get_mcoolqc.py $OUTDIR/cooler_attrs.txt $OUTDIR $FILE_NAME
