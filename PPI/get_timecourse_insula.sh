#!/bin/sh


#get timecourses for posterior and mid ventral insula


for SUBJ in 001	002	003	004	005	006	009	010	013	014	017	020	021	022	023	024	025	026	028	029	030	031	033	034	035	036	037	038	040	041	042	045	046	047	048	049	050	054	055	056	058	059	060	061	062	064	065	067	068	069	070	072	073	074	075	076	077	079	081	083	085	087	088	090	093	095; do

MAINDIR=/Users/sarabergman/Documents/ELS/KIDMID/Analysis

ROIDIR=${MAINDIR}/ROI/PPI/RightNAcc.Model5/insula_mask_ASEM

PRESTATSDIR=${MAINDIR}/Images/${SUBJ}/PS_MELODIC_FLIRT.feat

PRESTATSREGDIR=$PRESTATSDIR/reg

DATA=${PRESTATSDIR}/filtered_func_data.nii.gz

TIMECOURSEFILES=${PRESTATSDIR}/PPI_timecourses 

NativeSpaceROIs=${PRESTATSDIR}/PPI_ROIs

flirt -in ${ROIDIR}/posterior_ins_sphere_3mm.nii.gz -applyxfm -init ${PRESTATSDIR}/reg/standard2example_func.mat -out ${NativeSpaceROIs}/posterior_insula_transformed.nii.gz -ref ${PRESTATSDIR}/example_func
flirt -in ${ROIDIR}/mid_ventral_ins_sphere_3mm.nii.gz -applyxfm -init ${PRESTATSDIR}/reg/standard2example_func.mat -out ${NativeSpaceROIs}/mid_ventral_insula_transformed.nii.gz -ref ${PRESTATSDIR}/example_func

#re-binarize the mask after transformation
fslmaths ${NativeSpaceROIs}/posterior_insula_transformed.nii.gz -bin ${NativeSpaceROIs}/posterior_insula_transformed.nii.gz
fslmaths ${NativeSpaceROIs}/mid_ventral_insula_transformed.nii.gz -bin ${NativeSpaceROIs}/mid_ventral_insula_transformed.nii.gz

#fslmeants -i filtered_func.nii.gz -o my_timecourse.txt -m your_roi_mask.nii.gz
fslmeants -i $DATA -o ${TIMECOURSEFILES}/right_posterior_insula.txt -m ${NativeSpaceROIs}/posterior_insula_transformed.nii.gz
fslmeants -i $DATA -o ${TIMECOURSEFILES}/right_mid_ventral_insula.txt -m ${NativeSpaceROIs}/mid_ventral_insula_transformed.nii.gz


done
