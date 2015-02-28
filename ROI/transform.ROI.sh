#!/bin/sh

for SUBJ in 013; do

MAINDIR=/Users/sarabergman/Documents/ELS/KIDMID/Analysis
PRESTATSDIR=${MAINDIR}/Images/${SUBJ}/PS_MELODIC_FLIRT.feat
ROIDIR=${MAINDIR}/ROI/PPI/tractography
OUTPUT=${ROIDIR}/2.24.15

cd ${ROIDIR}

#transform the ACPC ROI to individual space using FLIRT

#binarize ROI
fslmaths rh_antshortins_fd.nii.gz -bin ${OUTPUT}/rh_antshortins_fd_bin.nii.gz

#generate a transformation matrix - from acpc to native space.
#flirt -in example_func -ref highres -out example_func2highres -omat example_func2highres.mat -cost corratio -dof 6 -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -interp trilinear 
#example_func to T1_ACPC
#flirt -in 013_highres -ref els013_t1_acpc -out ${OUTPUT}/013_t1_native2acpc -omat ${OUTPUT}/013_t1_native2acpc.mat -cost corratio -dof 6 -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -interp trilinear 
flirt -in els013_t1_acpc -ref 013_reoriented_anat -omat ${OUTPUT}/013_acpc2native.mat

flirt -in ${OUTPUT}/rh_antshortins_fd_bin.nii.gz -ref 013_reoriented_anat -applyxfm -init ${OUTPUT}/013_acpc2native.mat -out ${OUTPUT}/motherfucking_mask.nii.gz 

fslmaths ${OUTPUT}/motherfucking_mask.nii.gz -thr 0.9 -bin ${OUTPUT}/motherfucking_mask.nii.gz

#convert_xfm -omat ${OUTPUT}/013_t1_acpc2native.mat -inverse ${OUTPUT}/013_t1_native2acpc.mat

#example from http://wikis.la.utexas.edu/imagelab/book/convert-rois-native-space
#flirt -in $dir/resting_fmri/post_cing.nii.gz -applyxfm -init $featdir/reg/standard2example_func.mat -out $featdir/roi/post_cing_ntv.nii.gz -paddingsize 0.0 -interp nearestneighbour -ref $featdir/stats/res4d.nii.gz

#flirt -in ${OUTPUT}/rh_antshortins_fd_bin.nii.gz -applyxfm -init ${OUTPUT}/013_t1_acpc2native.mat -out ${OUTPUT}/right_insula_transformed2native.nii.gz -ref 013_highres   # -paddingsize 0.0 -interp nearestneighbour



#flirt -in rh_antshortins_fd.nii.gz -ref example_func -applyxfm -init acpc_highres2func_013_example.mat -out acpc_rh_insula_tranformed_native.nii.gz 

#micah
#flirt -init acpc_highres2func_013_example.mat -applyxfm -in rh_antshortins_fd.nii.gz -ref 013_example_func -out ROI_in_nativefunc.nii.gz -interp nearestneighbour

#flirt -in ${ROIDIR}/rh_antshortins_fd.nii.gz -ref ${PRESTATSDIR}/example_func -applyxfm -init 013_acpc2example_func.mat -out ${ROIDIR}/transform.test/acpc_rh_insula_tranformed_native.nii.gz 





#applywarp --ref=${PRESTATSDIR}/example_func --in=${ROIDIR}/rh_antshortins_fd.nii.gz --postmat=013_acpc2example_func.mat --out=${ROIDIR}/transform.test/acpc_rh_insula_tranformed_native_2.nii.gz 

# re-binarize the mask after transformation
# fslmaths ${ROIDIR}/transform.test/acpc_rh_insula_tranformed_native.nii.gz -bin ${ROIDIR}/transform.test/acpc_rh_insula_tranformed_native.nii.gz


# fslmeants -i filtered_func.nii.gz -o my_timecourse.txt -m your_roi_mask.nii.gz
# fslmeants -i $DATA -o ${TIMECOURSEFILES}/RightIns_timecourse.txt -m ${NativeSpaceROIs}/thresh_right_insula_tranformed.nii.gz
# fslmeants -i $DATA -o ${TIMECOURSEFILES}/LeftNAcc_timecourse.txt -m ${ROIDIR}/left_accumbens.nii.gz
# 
# 
# /usr/local/fsl/bin/flirt -in /Users/sarabergman/Documents/ELS/KIDMID/Analysis/ROI/PPI/tractography/els013_t1_acpc.nii.gz -ref /Users/sarabergman/Documents/ELS/KIDMID/Analysis/ROI/PPI/tractography/013_highres.nii.gz -out /Users/sarabergman/Documents/ELS/KIDMID/Analysis/ROI/PPI/tractography/013_acpc2nativeT1 -omat /Users/sarabergman/Documents/ELS/KIDMID/Analysis/ROI/PPI/tractography/013_acpc2nativeT1.mat -bins 256 -cost corratio -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 12  -interp trilinear
# 
# 
# /usr/local/fsl/bin/flirt -in /Users/sarabergman/Documents/ELS/KIDMID/Analysis/ROI/PPI/tractography/rh_antshortins_fd.nii.gz -ref /Users/sarabergman/Documents/ELS/KIDMID/Analysis/ROI/PPI/tractography/013_highres.nii.gz -out /Users/sarabergman/Documents/ELS/KIDMID/Analysis/ROI/PPI/tractography/013_acpc2nativeT1_shadowreg_rh_antshortins_fd.nii -applyxfm -init /Users/sarabergman/Documents/ELS/KIDMID/Analysis/ROI/PPI/tractography/013_acpc2nativeT1.mat -interp trilinear


done