#!/bin/sh

for subj in 118; do  #no commas, use 0xx, separated by space
#subj=021

if [ $(hostname) = sbergman.stanford.edu ] ;
then 
	MAINDIR=/Users/sarabergman/Documents/ELS/KIDMID
elif [ $(hostname) = axon.stanford.edu ] ;
then
	MAINDIR=/Volumes/ELS/KIDMID
else
	MAINDIR=/Users/sarabergman/Documents/STANFORD/FYP/KIDMID
fi	
DATADIR=${MAINDIR}/Data/${subj}
ANATDIR=${DATADIR}/anatomical
IMAGEDIR=${MAINDIR}/Analysis/Images/${subj}

#set up log file
OUTPUTDIR=${MAINDIR}/Analysis/Logs/preprocess
NOW=$(date +"%F.%H-%M-%S")
LOGFILE=${OUTPUTDIR}/${subj}_anat_preprocess.${NOW}.txt
#anat_preprocess &> $LOGFILE
#anat_preprocess.sh 2>&1 | tee $LOGFILE

mkdir -p ${IMAGEDIR}

### ANAT preprocess includes reorient (fslreorient2std) and brain extraction (bet)  ###
{
cd ${ANATDIR}
rm -rf ${subj}_anat.nii #remove any previous image of this name

if [ ! -e T1w_9mm_sag_raw.nii ]; then 
	cp T1w_9mm_sag_raw.nii.gz ${subj}_anat.nii.gz
else
	cp T1w_9mm_sag_raw.nii ${subj}_anat.nii.gz #copy anat, rename
fi

#cp T1w_9mm_sag_raw.nii.gz ${subj}_anat.nii
#rm -rf ${IMAGEDIR}/${subj}*.nii*  #remove any previous images
fslreorient2std ${subj}_anat ${IMAGEDIR}/${subj}_reoriented_anat.nii  #reorient anat, rename and put in IMAGE folder
#in fslview, right is left and left is right. in MRIcron, right is right and left is left.

cd ${IMAGEDIR}
bet ${subj}_reoriented_anat ${subj}_anat_brain.nii  #skull strip, rename
#default fractional intensity is .5. used diff values on a case-by-case basis
} > $LOGFILE

## to manually run bet: 
#bet ${subj}_reoriented_anat ${subj}_anat_bet_.4 -f .4  (changes fractional intensity)
## bet ${subj}_reoriented_anat ${subj}_anat_bet_.4 -f -B .4  (changes fractional intensity and runs -B (cleans up neck))

#rename to subj_anat_brain.nii.gz
#cp ${subj}_anat_bet_.4.nii.gz  ${subj}_anat_brain.nii.gz

done