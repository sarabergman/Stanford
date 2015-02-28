#!/bin/sh

#echo This is a test

#subj = ( 001 002 003 004 005 006 007 009 010 011 012 013 014 015 )
subj=$1

MAINDIR=/Users/sarabergman/Documents/STANFORD/FYP/KIDMID
DATADIR=${MAINDIR}/Data/${subj}
ANATDIR=${DATADIR}/anatomical
IMAGEDIR=${MAINDIR}/Analysis/Images/${subj}
mkdir -p ${IMAGEDIR}

### ANAT preprocess includes reorient (fslreorient2std) and brain extraction (bet)  ###

cd ${ANATDIR}
rm -rf ${subj}_anat.nii #remove any previous image of this name
cp T1w_9mm_sag_raw.nii ${subj}_anat.nii #copy anat, rename
rm -rf ${IMAGEDIR}/${subj}*.nii*  #remove any previous image of this name 
fslreorient2std ${subj}_anat ${IMAGEDIR}/${subj}_reoriented_anat.nii  #reorient anat, rename and put in IMAGE folder
cd ${IMAGEDIR}
bet ${subj}_reoriented_anat ${subj}_anat_brain.nii  #skull strip, rename


## add an OUTDIR
