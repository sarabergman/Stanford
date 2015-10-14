#!/bin/sh

if [ $(hostname) = sbergman.stanford.edu ] ;
then 
	MAINDIR=/Users/sarabergman/Documents/ELS/KIDMID
elif [ $(hostname) = axon.stanford.edu ] ;
then
	MAINDIR=/Volumes/ELS/KIDMID
else
	MAINDIR=/Users/sarabergman/Documents/STANFORD/FYP/KIDMID
fi	





#091 106 108 109 110 
for SUBJ in 112 113 114 115 116 118 121; do

DATADIR=${MAINDIR}/Data/${SUBJ}
ANATDIR=${DATADIR}/anatomical
BEHAVDIR=${DATADIR}/behavioral
FUNCDIR=${DATADIR}/functional/ModKMID_3mm_2sec
DTIDIR=/Users/sarabergman/Documents/ELS/DTI/${SUBJ}/raw

mkdir -p ${DATADIR}
mkdir -p ${ANATDIR}
mkdir -p ${BEHAVDIR}
mkdir -p ${FUNCDIR}


cd /Volumes/group/iang/biac3/gotlib7/data/ELS/ELS-T1/${SUBJ}-T1

cp *.xlsx ${DATADIR}

if [ ! -e anatomics/spgr/T1w_9mm_sag_raw.nii ]; then 
	cp T1w_9mm_sag_raw.nii.gz ${ANATDIR}
else
	cp anatomics/spgr/T1w_9mm_sag_raw.nii ${ANATDIR}
fi
	
if [ -e anatomics/dti ]; then
	mkdir -p ${DTIDIR}
	mv anatomics/dti/*dicoms.tgz ${DTIDIR}/${SUBJ}_dicoms.tgz
	mv anatomics/dti/*bval ${DTIDIR}/${SUBJ}.bval
	mv anatomics/dti/*bvec ${DTIDIR}/${SUBJ}.bvec
	mv anatomics/dti/*.nii ${DTIDIR}/${SUBJ}.nii
fi

cp behavioral/ELS_KIDMID_* ${BEHAVDIR}

cp functional/ModKMID_3mm_2sec ${FUNCDIR}

done 
	






