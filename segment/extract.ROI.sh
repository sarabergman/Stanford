#!/bin/sh


for SUBJ in 003 005 018 020 031 035; do


NACCDIR=/Users/sarabergman/Documents/ELS/KIDMID/Analysis/FRUNCTURE_ROI
SEGDIR=/Users/sarabergman/Documents/ELS/KIDMID/Analysis/segment/${SUBJ}/mri

#freesurfer to native space:
cd $SEGDIR
mri_convert -rl rawavg.mgz -rt nearest -odt int aparc.a2009s+aseg.mgz a2009seg2nat.nii.gz
#(these files are inside the <subject>/mri/ folder)

#extract ROIs from freesurfer segmentation:
fslmaths a2009seg2nat.nii.gz -uthr 58 -thr 58 -bin -fillh ${NACCDIR}/els${SUBJ}_rh_nacc_aseg2nat.nii.gz
fslmaths a2009seg2nat.nii.gz -uthr 26 -thr 26 -bin -fillh ${NACCDIR}/els${SUBJ}_lh_nacc_aseg2nat.nii.gz

done