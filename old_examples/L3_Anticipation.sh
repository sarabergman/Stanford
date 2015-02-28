#!/bin/sh

MODEL=$1
COPE=$2

MAINDIR=/Users/sarabergman/Documents/STANFORD/FYP/KIDMID/Analysis
MAINOUTPUT=${MAINDIR}/L3/Anticipation/Model${MODEL}
mkdir -p $MAINOUTPUT


OUTPUT=$MAINOUTPUT/cope${COPE}

if [ $GO -eq 1 ]; then
	rm -rf $OUTPUT.gfeat
fi

# DATA=$MAINDIR/FSL
# SECONDL=Model06_FNIRT/Smooth_${SMOOTH}mm/Level2.gfeat/cope${COPE}.feat/stats/cope1.nii.gz

if [ $COPE -eq 1 ]; then
	CTITLE=ant_certain
elif [ $COPE -eq 2 ]; then
	CTITLE=ant_uncertain
elif [ $COPE -eq 3 ]; then
	CTITLE=anticipation
elif [ $COPE -eq 4 ]; then
	CTITLE=ant_certain_v_ant_uncertain
elif [ $COPE -eq 5 ]; then
	CTITLE=ant_uncertain_v_ant_certain
fi

TEMPLATE=${MAINDIR}/FSL_templates/L3/L3_model06.fsf
dos2unix $TEMPLATE
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@DATA@'$DATA'@g' \
-e 's@SECONDL@'$SECONDL'@g' \
-e 's@COPE@'$COPE'@g' \
-e 's@CTITLE@'$CTITLE'@g' \
<$TEMPLATE> ${MAINDIR}/FSL/FEAT_L3_${COPE}.fsf

if [ -d ${OUTPUT}.gfeat ]; then
	echo "this one is already done"
else
	$FSLDIR/bin/feat ${MAINDIR}/FSL/FEAT_L3_${COPE}.fsf
fi 

for SUBJ in 14084 14096 14105 14115 14121 14131 14133 14142 14151 14162 14164 14177 14185 14187 14191 14200 14220 14221 14229 14235 14262 14266 14276 14290 14291 14295 14297 14300 14301; do

    let N=$N+1
    FILENAME=${DATA}/${SUBJ}/${SECONDL}
    if [ ! -e $FILENAME ];then
	echo "missing lower-level input:$FILENAME"
    fi
    NN=`printf'%03d'$N` 
    eval INPUT${NN}=${FILENAME}
    
done

rm -rf ${OUTPUT}.gfeat/cope*.feat/stats/res4d.nii.gz
rm -rf ${OUTPUT}.gfeat/cope*.feat/filtered_func_data.nii.gz
rm -rf ${OUTPUT}.gfeat/cope*.feat/var_filtered_func_data.nii.gz

OUTDIR=$DATA/Logs
mkdir -p $OUTDIR

# -- END USER SCRIPT -- #

# **********************************************************
# -- BEGIN POST-USER -- 
echo "----JOB [$JOB_NAME.$JOB_ID] STOP [`date`]----" 
OUTDIR=${OUTDIR:-$EXPERIMENT/Analysis}
mv $HOME/$JOB_NAME.$JOB_ID.out $OUTDIR/$JOB_NAME.$JOB_ID.out	 
RETURNCODE=${RETURNCODE:-0}
exit $RETURNCODE
fi
# -- END POST USER-- 
