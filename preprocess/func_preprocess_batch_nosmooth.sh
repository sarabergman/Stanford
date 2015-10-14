#!/bin/sh

for subj in 116 121;  
##001 002 003 004 005 006 009 010 012 013 014 016 017 018 020 021 022 023 024 025 026 028 029 030 031 032 033 034 035 036 037 038
##039 040 041 042 045 046 047 048 049 050;
do

MAINDIR=/Users/sarabergman/Documents/ELS/KIDMID
DATADIR=${MAINDIR}/Data/${subj}/functional/ModKMID_3mm_2sec
IMAGEDIR=${MAINDIR}/Analysis/Images/${subj}

#set up log file
OUTPUTDIR=${MAINDIR}/Analysis/Logs/preprocess
NOW=$(date +"%F.%H-%M-%S")
LOGFILE=${OUTPUTDIR}/${subj}_func_preprocess.${NOW}.txt

{
cd ${DATADIR}

MAINOUTPUT=${IMAGEDIR}/PS_MELODIC_FLIRT_NO_SMOOTH.feat

GO=1
SKIP=0

FILE_TO_CHECK=${MAINOUTPUT}/filtered_func_data.nii.gz
if [ $GO -eq 1 ]; then
	rm -rf ${MAINOUTPUT}
fi
if [ ! -e $FILE_TO_CHECK ]; then
	rm -rf ${MAINOUTPUT}
fi


ANAT=${IMAGEDIR}/${subj}_anat_brain.nii.gz #hi res anatomical image to register with functional data
DATA=${IMAGEDIR}/${subj}_reoriented_func.nii.gz #functional data of run 9, outcome run 


NVOLUMES=`fslnvols $DATA` #Determines number of volumes from nifti file
#NDISDAQS=4

TEMPLATEDIR=${MAINDIR}/scripts/FSF
cd ${TEMPLATEDIR}
#dos2unix prestats.fsf
sed -e 's@OUTPUT@'$MAINOUTPUT'@g' \
-e 's@ANAT@'$ANAT'@g' \
-e 's@DATA@'$DATA'@g' \
-e 's@NVOLUMES@'$NVOLUMES'@g' \
<prestats_nosmooth.fsf> ${IMAGEDIR}/FEAT_prestats_nosmooth_${subj}.fsf

cd ${IMAGEDIR}
feat FEAT_prestats_nosmooth_${subj}.fsf


#OUTPUTREAL=${MAINOUTPUT}/run${RUN}.feat

#if [ -d "$OUTPUTREAL" ]; then
	#cd $OUTPUTREAL
cd ${MAINOUTPUT}
fslmeants -i filtered_func_data.nii.gz -o wb_raw.txt -m mask.nii.gz

rm -rf stats
#else
#echo "wtf... this file should be there"
#fi

cp $MAINOUTPUT/mc/prefiltered_func_data_mcf.par $MAINOUTPUT/MOTIONconfoundevs.txt

if [ -e ${MAINOUTPUT}/bad_timepoints.txt ]; then
 	echo "Exists: ${MAINOUTPUT}/bad_timepoints.txt"
else
	#fsl_motion_outliers ${DATA} ${NDISDAQS} bad_timepoints.txt  --old syntax
	cd ${IMAGEDIR}
	fsl_motion_outliers -i ${subj}_reoriented_func.nii.gz -o PS_MELODIC_FLIRT_NO_SMOOTH.feat/bad_timepoints.txt --dummy=4
fi

} > $LOGFILE	
done 	
	