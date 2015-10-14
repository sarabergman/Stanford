#!/bin/sh


ATLAS=/Users/sarabergman/Documents/ELS/KIDMID/Analysis/ROI/HarvardOxfordstructuralatlasprobabilisticmap/2.6.15
ROIDIR=/Users/sarabergman/Documents/ELS/KIDMID/Analysis/ROI
OUTPUTDIR=${ROIDIR}/84N_ELS                                                                                                                                                                                                                                                    

cd ${ROIDIR}

#anticipation ROIs
fslmaths ${OUTPUTDIR}/antlossELS.nii.gz -mul ${ATLAS}/Rins.nii.gz ${OUTPUTDIR}/Rins_antloss
fslmaths ${OUTPUTDIR}/antlossELS.nii.gz -mul ${ATLAS}/Lins.nii.gz ${OUTPUTDIR}/Lins_antloss
fslmaths ${OUTPUTDIR}/antlossELS.nii.gz -mul ${ATLAS}/Rput.nii.gz ${OUTPUTDIR}/Rput_antloss
fslmaths ${OUTPUTDIR}/antlossELS.nii.gz -mul ${ATLAS}/Lput.nii.gz ${OUTPUTDIR}/Lput_antloss
fslmaths ${OUTPUTDIR}/antlossELS.nii.gz -mul ${ATLAS}/Rcaud.nii.gz ${OUTPUTDIR}/Rcaud_antloss
fslmaths ${OUTPUTDIR}/antlossELS.nii.gz -mul ${ATLAS}/Lcaud.nii.gz ${OUTPUTDIR}/Lcaud_antloss
fslmaths ${OUTPUTDIR}/antlossELS.nii.gz -mul ${ATLAS}/Rpall.nii.gz ${OUTPUTDIR}/Rpall_antloss
fslmaths ${OUTPUTDIR}/antlossELS.nii.gz -mul ${ATLAS}/Lpall.nii.gz ${OUTPUTDIR}/Lpall_antloss

#outcome ROIs
fslmaths ${OUTPUTDIR}/outlossELS.nii.gz -mul ${ATLAS}/Lput.nii.gz ${OUTPUTDIR}/Lput_outloss
fslmaths ${OUTPUTDIR}/outlossELS.nii.gz -mul ${ATLAS}/Lcaud.nii.gz ${OUTPUTDIR}/Lcaud_outloss
fslmaths ${OUTPUTDIR}/outlossELS.nii.gz -mul ${ATLAS}/Lins.nii.gz ${OUTPUTDIR}/Lins_outloss
fslmaths ${OUTPUTDIR}/outlossELS.nii.gz -mul ${ATLAS}/Lpall.nii.gz ${OUTPUTDIR}/Lpall_outloss


# fslmaths ${OUTPUTDIR}/anticipationELS.nii.gz -mul ${ATLAS}/Lamy.nii.gz ${OUTPUTDIR}/Lamy_anticipation
# fslmaths ${OUTPUTDIR}/anticipationELS.nii.gz -mul ${ATLAS}/Ramy.nii.gz ${OUTPUTDIR}/Ramy_anticipation
# fslmaths ${OUTPUTDIR}/anticipationELS.nii.gz -mul ${ATLAS}/LHipp.nii.gz ${OUTPUTDIR}/LHipp_anticipation
# fslmaths ${OUTPUTDIR}/anticipationELS.nii.gz -mul ${ATLAS}/RHipp.nii.gz ${OUTPUTDIR}/RHipp_anticipation
# fslmaths ${OUTPUTDIR}/anticipationELS.nii.gz -mul ${ATLAS}/Lput.nii.gz ${OUTPUTDIR}/Lput_anticipation
# fslmaths ${OUTPUTDIR}/anticipationELS.nii.gz -mul ${ATLAS}/Rput.nii.gz ${OUTPUTDIR}/Rput_anticipation
# fslmaths ${OUTPUTDIR}/anticipationELS.nii.gz -mul ${ATLAS}/Lcaud.nii.gz ${OUTPUTDIR}/Lcaud_anticipation
# fslmaths ${OUTPUTDIR}/anticipationELS.nii.gz -mul ${ATLAS}/Rcaud.nii.gz ${OUTPUTDIR}/Rcaud_anticipation
# fslmaths ${OUTPUTDIR}/anticipationELS.nii.gz -mul ${ATLAS}/Rpall.nii.gz ${OUTPUTDIR}/Rpall_anticipation
# fslmaths ${OUTPUTDIR}/anticipationELS.nii.gz -mul ${ATLAS}/Rins.nii.gz ${OUTPUTDIR}/Rins_anticipation
# fslmaths ${OUTPUTDIR}/anticipationELS.nii.gz -mul ${ATLAS}/Lins.nii.gz ${OUTPUTDIR}/Lins_anticipation
# 
# 
# #outcome ROIs
# fslmaths ${OUTPUTDIR}/outcomeELS.nii.gz -mul ${ATLAS}/Lput.nii.gz ${OUTPUTDIR}/Lput_outcome
# fslmaths ${OUTPUTDIR}/outcomeELS.nii.gz -mul ${ATLAS}/Lcaud.nii.gz ${OUTPUTDIR}/Lcaud_outcome
# fslmaths ${OUTPUTDIR}/outcomeELS.nii.gz -mul ${ATLAS}/Lpall.nii.gz ${OUTPUTDIR}/Lpall_outcome
# fslmaths ${OUTPUTDIR}/outcomeELS.nii.gz -mul ${ATLAS}/Lins.nii.gz ${OUTPUTDIR}/Lins_outcome
# 
# 
