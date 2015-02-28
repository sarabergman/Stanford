#!/bin/sh

for SUBJ in 002 003 004 005 006 009 010 011 012 013 014 015 016; do 
#SUBJ=$1
SMOOTH=5
GO=1

MAINDIR=/Users/sarabergman/Documents/STANFORD/FYP/KIDMID/Analysis
PRESTATSDIR=${MAINDIR}/Images/${SUBJ}/PS_MELODIC_FLIRT.feat
PRESTATSREGDIR=$PRESTATSDIR/reg
DATA=${PRESTATSDIR}/filtered_func_data.nii.gz
MAINOUTPUT=${MAINDIR}/L1/Model2
mkdir -p ${MAINOUTPUT}
#fi


OUTPUT=${MAINOUTPUT}/${SUBJ}
CONFOUNDEVSFILE=${PRESTATSDIR}/MOTIONconfoundevs.txt
if [ -e $CONFOUNDEVSFILE ]; then
	USECONFOUNDEVS=1
	#USECONFOUNDEVS=0
else
	USECONFOUNDEVS=0
fi


if [ $GO -eq 1 ]; then
	rm -rf $OUTPUT.feat
fi

if [ -e $OUTPUT.feat/cluster_mask_zstat1.nii.gz ]; then
	echo "previous analysis worked..."
else
	rm -rf $OUTPUT.feat
fi


# 
# if [ -e ${OUTPUT}.feat/mean_func.nii.gz ]; then
# 	echo "exists: ${OUTPUT}.feat/mean_func.nii.gz"
# 	XX=`fslstats ${OUTPUT}.feat/mean_func.nii.gz -m`
# 	if [ $XX == "nan" ]; then
# 		echo "found $XX in the mean func file. deleting and starting over..."
# 		rm -rf ${OUTPUT}.feat
# 	fi
# fi

#numbers below reflect original minus disdaqs
# if [ $SUBJ -eq 13282 -a $RUN -eq 1 ]; then
# 	NVOLUMES=476
# elif [ $SUBJ -eq 13282 -a $RUN -eq 2 ]; then
# 	NVOLUMES=480
# elif [ $RUN -eq 5 ]; then
# 	NVOLUMES=234
# else
# 	NVOLUMES=484
# fi
#VOLUMES=`fslnvols $DATA`

EVFILES=${MAINDIR}/EV/${SUBJ}

ev1=${EVFILES}/${SUBJ}_ant_gain.txt
ev2=${EVFILES}/${SUBJ}_ant_nongain.txt
ev3=${EVFILES}/${SUBJ}_ant_loss.txt
ev4=${EVFILES}/${SUBJ}_ant_nonloss.txt
ev5=${EVFILES}/${SUBJ}_gain.txt
ev6=${EVFILES}/${SUBJ}_nongain.txt
ev7=${EVFILES}/${SUBJ}_loss.txt
ev8=${EVFILES}/${SUBJ}_nonloss.txt

TEMPLATE=/Users/sarabergman/Documents/STANFORD/FYP/KIDMID/scripts/FSF/L1/model2.fsf
#dos2unix $TEMPLATE
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@DATA@'$DATA'@g' \
-e 's@ev1@'$ev1'@g' \
-e 's@ev2@'$ev2'@g' \
-e 's@ev3@'$ev3'@g' \
-e 's@ev4@'$ev4'@g' \
-e 's@ev5@'$ev5'@g' \
-e 's@ev6@'$ev6'@g' \
-e 's@ev7@'$ev7'@g' \
-e 's@ev8@'$ev8'@g' \
-e 's@CONFOUNDEVSFILE@'$CONFOUNDEVSFILE'@g' \
-e 's@USECONFOUNDEVS@'$USECONFOUNDEVS'@g' \
<$TEMPLATE> ${MAINOUTPUT}/FEAT_${SUBJ}.fsf

if [ -d ${OUTPUT}.feat ]; then
	echo "this one is already done"
else
	feat ${MAINOUTPUT}/FEAT_${SUBJ}.fsf
fi

rm -rf ${OUTPUT}.feat/stats/res4d.nii.gz
rm -rf ${OUTPUT}.feat/stats/corrections.nii.gz
rm -rf ${OUTPUT}.feat/filtered_func_data.nii.gz

CHECKREG=${OUTPUT}.feat/reg/example_func2standard.png
if [ -e $CHECKREG ]; then
	echo "registration is complete..."
else
	rm -rf ${OUTPUT}.feat/reg
	cp -r ${PRESTATSREGDIR} ${OUTPUT}.feat/reg
fi
done