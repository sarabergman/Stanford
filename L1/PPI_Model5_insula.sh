#!/bin/sh

##PPI - extracts the time course of the seed ROI and runs L1 in FEAT with the physiological regressor

## same as Model 4 with the following changes:
##	--CONFOUNDEVSFILE points to new_motion_and_outlier_confounds.txt, which gets rid of the all-zero regressor
##	--TEMPLATE points to model5.fsf, which contains a nuisance regressor for missed trials and 2 additional outcome
##		regressors: 1. unsuccessful gain (formerly grouped with nongain) and 2. successfully avoid loss (formerly
##		grouped with nonloss). Trials for which there was no button-press are moved to the 'missed' regressor.

#sub list includes all subs that have no empty EVS (excludes 012, 016, 086, and 089) and excludes 039 and 057
#for SUBJ in 001 002 003 004 005 006 009 010 013 014 017 020 021 022 023 024 025 026 028 029 030 031 033 034 035 036 037 038 040 041 042 045 046 047 048 049 050 054 055 056 058 059 060 061 062 064 065 067 068 069 070 072 073 074 075 076 077 079 081 083 085 087 088 090 093 095; do
for SUBJ in 090 097 099; do 
#SUBJ=$1
SMOOTH=5
GO=1

if [ $(hostname) = sbergman.stanford.edu ];
then 
	MAINDIR=/Users/sarabergman/Documents/ELS/KIDMID/Analysis
else
	MAINDIR=/Users/sarabergman/Documents/STANFORD/FYP/KIDMID/Analysis
fi	

PRESTATSDIR=${MAINDIR}/Images/${SUBJ}/PS_MELODIC_FLIRT.feat

TIMECOURSEFILES=${PRESTATSDIR}/PPI_timecourses 
mkdir -p ${TIMECOURSEFILES}

NativeSpaceROIs=${PRESTATSDIR}/PPI_ROIs
mkdir -p ${NativeSpaceROIs}

PRESTATSREGDIR=$PRESTATSDIR/reg

DATA=${PRESTATSDIR}/filtered_func_data.nii.gz

MAINOUTPUT=${MAINDIR}/L1/PPI/RightIns.antgain
mkdir -p ${MAINOUTPUT}
#fi


OUTPUT=${MAINOUTPUT}/${SUBJ}
#CONFOUNDEVSFILE=${PRESTATSDIR}/MOTIONconfoundevs.txt
CONFOUNDEVSFILE=${PRESTATSDIR}/new_motion_and_outlier_confounds.txt

VOLUMES=`fslnvols $DATA`
if [ $GO -eq 1 ]; then
	rm -rf $OUTPUT.feat
fi
# 
if [ -e $OUTPUT.feat/cluster_mask_zstat1.nii.gz ]; then
	echo "previous analysis worked..."
else
	rm -rf $OUTPUT.feat
fi

ROIDIR=${MAINDIR}/ROI/PPI/RightNacc.Model5  #this insula cluster is the output from the PPI analysis with rNAcc as seed 

#flirt -in S02brain_BET_5_pve_0_thr -ref example_func -init  
#highres2example_func.mat -applyxfm -out S02brain_BET_5_pve_0_thr_func
   #fslmaths S02brain_BET_5_pve_0_thr_func -thr 0.9 -bin  
#S02brain_BET_5_pve_0_thr_func

#transform the standard-space ROI to individual space using FLIRT
flirt -in ${ROIDIR}/right_insula.nii.gz -applyxfm -init ${PRESTATSDIR}/reg/standard2example_func.mat -out ${NativeSpaceROIs}/thresh_right_insula_tranformed.nii.gz -ref ${PRESTATSDIR}/example_func

#re-binarize the mask after transformation
fslmaths ${NativeSpaceROIs}/thresh_right_insula_tranformed.nii.gz -bin ${NativeSpaceROIs}/thresh_right_insula_tranformed.nii.gz


#fslmeants -i filtered_func.nii.gz -o my_timecourse.txt -m your_roi_mask.nii.gz
fslmeants -i $DATA -o ${TIMECOURSEFILES}/RightIns_timecourse.txt -m ${NativeSpaceROIs}/thresh_right_insula_tranformed.nii.gz
#fslmeants -i $DATA -o ${TIMECOURSEFILES}/LeftNAcc_timecourse.txt -m ${ROIDIR}/left_accumbens.nii.gz


EVFILES=${MAINDIR}/EV/${SUBJ}/PPI.antgain

# OR
#EVFILES=${MAINDIR}/EV/no.missed/${SUBJ}

ev1=${EVFILES}/${SUBJ}_ant_gain_V_nongain.txt
ev2=${EVFILES}/${SUBJ}_ant_gain_and_nongain.txt
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
ev013=${TIMECOURSEFILES}/RightIns_timecourse.txt


TEMPLATE=/Users/sarabergman/Documents/ELS/KIDMID/scripts/FSF/PPI/Model5_antgain_negPPI.fsf


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
-e 's@VOLUMES@'$VOLUMES'@g' \
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

CHECKREG=${OUTPUT}.feat/reg/example_func2standard.png
if [ -e $CHECKREG ]; then
	echo "registration is complete..."
else
	rm -rf ${OUTPUT}.feat/reg
	cp -r ${PRESTATSREGDIR} ${OUTPUT}.feat/reg
fi


done
