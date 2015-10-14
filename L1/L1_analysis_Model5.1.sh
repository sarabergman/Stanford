#!/bin/sh

## same as Model 5 with the following changes:
##	--delay regressor models the pre-feedback, post-target delay period to mop any pre-feedback anticipatory signal that was previously being allocated to the baseline.


#for SUBJ in 001 002 003 004 005 006 009 010 012 013 014 016 017 020 021 022 023 024 025 026 028 029 030 031 033 034 035 036 037 038 040 041 042 045 046 047 048 049 050 054 055 056 058 059 060 061 062 064 065 067 068 069 070 072 073 074 075 076 077 079 081 083 085 087 088 090 093 095 097 099 100; do
SUBJ=$1
SMOOTH=5
GO=1

if [ $(hostname) = sbergman.stanford.edu ];
then 
	MAINDIR=/Users/sarabergman/Documents/ELS/KIDMID/Analysis
else
	MAINDIR=/Users/sarabergman/Documents/STANFORD/FYP/KIDMID/Analysis
fi	

PRESTATSDIR=${MAINDIR}/Images/${SUBJ}/PS_MELODIC_FLIRT.feat
PRESTATSREGDIR=$PRESTATSDIR/reg
DATA=${PRESTATSDIR}/filtered_func_data.nii.gz
MAINOUTPUT=${MAINDIR}/L1/Model5.1
mkdir -p ${MAINOUTPUT}
#fi


OUTPUT=${MAINOUTPUT}/${SUBJ}
#CONFOUNDEVSFILE=${PRESTATSDIR}/MOTIONconfoundevs.txt
CONFOUNDEVSFILE=${PRESTATSDIR}/new_motion_and_outlier_confounds.txt
# if [ -e $CONFOUNDEVSFILE ]; then
# 	USECONFOUNDEVS=1
# 	#USECONFOUNDEVS=0
# else
# 	USECONFOUNDEVS=0
# fi


# if [ $GO -eq 1 ]; then
# 	rm -rf $OUTPUT.feat
# fi
# 
# if [ -e $OUTPUT.feat/cluster_mask_zstat1.nii.gz ]; then
# 	echo "previous analysis worked..."
# else
# 	rm -rf $OUTPUT.feat
# fi


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


EVFILES=${MAINDIR}/EV/${SUBJ}/model5
# OR
#EVFILES=${MAINDIR}/EV/no.missed/${SUBJ}

ev1=${EVFILES}/${SUBJ}_ant_gain.txt
ev2=${EVFILES}/${SUBJ}_ant_nongain.txt
ev3=${EVFILES}/${SUBJ}_ant_loss.txt
ev4=${EVFILES}/${SUBJ}_ant_nonloss.txt
ev5=${EVFILES}/${SUBJ}_gain.txt
ev6=${EVFILES}/${SUBJ}_nongain.txt
ev7=${EVFILES}/${SUBJ}_loss.txt
ev8=${EVFILES}/${SUBJ}_nonloss.txt
ev9=${EVFILES}/${SUBJ}_unsucc_gain.txt
ev010=${EVFILES}/${SUBJ}_succ_avoid_loss.txt
ev011=${EVFILES}/${SUBJ}_target_all.txt
ev012=${EVFILES}/${SUBJ}_missed.txt
ev013=${EVFILES}/${SUBJ}_delay_all.txt

if [ $(hostname) = sbergman.stanford.edu ];
then 
	TEMPLATE=/Users/sarabergman/Documents/ELS/KIDMID/scripts/FSF/L1/model5.1.fsf
else
	TEMPLATE=/Users/sarabergman/Documents/STANFORD/FYP/KIDMID/scripts/FSF/L1/model5.1.fsf
fi	

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
-e 's@ev9@'$ev9'@g' \
-e 's@ev010@'$ev010'@g' \
-e 's@ev011@'$ev011'@g' \
-e 's@ev012@'$ev012'@g' \
-e 's@ev013@'$ev013'@g' \
-e 's@CONFOUNDEVSFILE@'$CONFOUNDEVSFILE'@g' \
<$TEMPLATE> ${MAINOUTPUT}/FEAT_${SUBJ}.fsf

#-e 's@USECONFOUNDEVS@'$USECONFOUNDEVS'@g' \


if [ -d ${OUTPUT}.feat ]; then
	echo "this one is already done"
else
	feat ${MAINOUTPUT}/FEAT_${SUBJ}.fsf
fi

# 
# rm -rf ${OUTPUT}.feat/stats/res4d.nii.gz
# rm -rf ${OUTPUT}.feat/stats/corrections.nii.gz
# rm -rf ${OUTPUT}.feat/filtered_func_data.nii.gz

# 
CHECKREG=${OUTPUT}.feat/reg/example_func2standard.png
if [ -e $CHECKREG ]; then
	echo "registration is complete..."
else
	rm -rf ${OUTPUT}.feat/reg
	cp -r ${PRESTATSREGDIR} ${OUTPUT}.feat/reg
fi


done
