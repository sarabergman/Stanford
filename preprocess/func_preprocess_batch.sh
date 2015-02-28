#!/bin/sh

for subj in 098;
do
#subj=$1

if [ $(hostname) = sbergman.stanford.edu ];
then 
	MAINDIR=/Users/sarabergman/Documents/ELS/KIDMID
else
	MAINDIR=/Users/sarabergman/Documents/STANFORD/FYP/KIDMID
fi
DATADIR=${MAINDIR}/Data/${subj}/functional/ModKMID_3mm_2sec
IMAGEDIR=${MAINDIR}/Analysis/Images/${subj}

#set up log file
OUTPUTDIR=${MAINDIR}/Analysis/Logs/preprocess
NOW=$(date +"%F.%H-%M-%S")
LOGFILE=${OUTPUTDIR}/${subj}_func_preprocess.${NOW}.txt

{
cd ${DATADIR}
rm -rf ${subj}_kidmid.nii* #remove any previous image of this name
if [ ! -e kidmid_raw.nii ]; then
	cp kidmid_raw.nii.gz ${subj}_kidmid.nii.gz
else
	cp kidmid_raw.nii ${subj}_kidmid.nii #copy func, rename
fi	
rm -rf ${IMAGEDIR}/reorient_${subj}_func.nii*  #remove any previous images
fslreorient2std ${subj}_kidmid ${IMAGEDIR}/${subj}_reoriented_func.nii  #reorient anat, rename and put in IMAGE folder
#in fslview, right is left and left is right. in MRIcron, right is right and left is left.

MAINOUTPUT=${IMAGEDIR}/PS_MELODIC_FLIRT.feat

GO=1
SKIP=0

# if [ $SKIP -eq 1 ]; then
# 	echo "not making dirs for exceptions..."
# else
#mkdir -p ${MAINOUTPUT}
# fi

#OUTPUTREAL=${MAINOUTPUT}/run${RUN}.feat
#OUTPUTREAL=${MAINOUTPUT}
FILE_TO_CHECK=${MAINOUTPUT}/filtered_func_data.nii.gz
if [ $GO -eq 1 ]; then
	rm -rf ${MAINOUTPUT}
fi
if [ ! -e $FILE_TO_CHECK ]; then
	rm -rf ${MAINOUTPUT}
fi

#mkdir -p ${MAINOUTPUT}

ANAT=${IMAGEDIR}/${subj}_anat_brain.nii.gz #hi res anatomical image to register with functional data
DATA=${IMAGEDIR}/${subj}_reoriented_func.nii.gz #functional data of run 9, outcome run 
#OUTPUT=${MAINOUTPUT}
#SO_FILE=${SUBJDIR}/so_run${RUN}.txt

NVOLUMES=`fslnvols $DATA` #Determines number of volumes from nifti file
#NDISDAQS=4

TEMPLATEDIR=${MAINDIR}/scripts/FSF
cd ${TEMPLATEDIR}
#dos2unix prestats.fsf
sed -e 's@OUTPUT@'$MAINOUTPUT'@g' \
-e 's@ANAT@'$ANAT'@g' \
-e 's@DATA@'$DATA'@g' \
-e 's@NVOLUMES@'$NVOLUMES'@g' \
<prestats.fsf> ${IMAGEDIR}/FEAT_prestats_${subj}.fsf

cd ${IMAGEDIR}
feat FEAT_prestats_${subj}.fsf
# if [ -d "$MAINOUTPUT" ]; then
# 	echo "That one is already done!"
# else
# 	feat FEAT_prestats_${subj}.fsf
# fi 

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
	fsl_motion_outliers -i ${subj}_reoriented_func.nii.gz -o PS_MELODIC_FLIRT.feat/bad_timepoints.txt --dummy=4
fi

} > $LOGFILE	
done 	
	