#!/bin/sh

for SUBJ in 001 002	003	004	005	006	009	010	012	013	014	016	017	021	022	023	024	025	026	028	029	031	033	034	035	036	037	038	040 \
041	042	045	047	048	049	050	054	055	056	058	059	060	061	062	064	065	067	068	069	070	072	073 074 075 076 077 079 081 083 085 \
086 087 088 089 090 093 095 097 099 100; do	
#removed 020, 030, and 046

#for SUBJ in 001; do
	MAINDIR=/Users/sarabergman/Documents/ELS/KIDMID/Analysis
	ROIDIR=${MAINDIR}/ROI/70N_Model5.1
	MODELDIR=${MAINDIR}/L1/Model5.1/${SUBJ}.feat
	
	#MASK17=${MAINDIR}/ROI/HarvardOxfordstructuralatlasprobabilisticmap/thresh_rightNAcc.nii.gz

	MASK01=${ROIDIR}/Lamy_anticipation.nii.gz 
	MASK02=${ROIDIR}/Ramy_anticipation.nii.gz 
	MASK03=${ROIDIR}/LHipp_anticipation.nii.gz 
	MASK04=${ROIDIR}/RHipp_anticipation.nii.gz 
	MASK05=${ROIDIR}/Lput_anticipation.nii.gz 
	MASK06=${ROIDIR}/Rput_anticipation.nii.gz
	
	MASK08=${ROIDIR}/Lput_outcome.nii.gz
	MASK09=${ROIDIR}/Lcaud_anticipation.nii.gz
	MASK10=${ROIDIR}/Rcaud_anticipation.nii.gz
	MASK11=${ROIDIR}/Lcaud_outcome.nii.gz
	MASK12=${ROIDIR}/Lpall_outcome.nii.gz
	MASK13=${ROIDIR}/Rpall_anticipation.nii.gz 
	MASK14=${ROIDIR}/Lins_anticipation.nii.gz
	MASK15=${ROIDIR}/Lins_outcome.nii.gz
	MASK16=${ROIDIR}/Rins_anticipation.nii.gz
	
	MASK18=${ROIDIR}/vmPFC_anticipation_gainvloss_gender.nii.gz
	
	cd ${MODELDIR}
	
	

	
	#anticipation
	featquery 1 ${MODELDIR} 8 stats/pe1 stats/pe2 stats/pe3 stats/pe4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_vmPFC_anticipation -p ${MASK18}
#   featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_Lamy_anticipation -p ${MASK01} 
# 	featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_Ramy_anticipation -p ${MASK02}
# 	featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_LHipp_anticipation -p ${MASK03}
# 	featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_RHipp_anticipation -p ${MASK04}
#   featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_Lput_anticipation -p ${MASK05}
# 	featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_Rput_anticipation -p ${MASK06}
#  	featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_Lcaud_anticipation -p ${MASK09}
# 	featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_Rcaud_anticipation -p ${MASK10}
#	featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_Rpall_anticipation -p ${MASK13}
# 	featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_Lins_anticipation -p ${MASK14}
#  	featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_Rins_anticipation -p ${MASK16}
#	featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_RNAcc_HO_anticipation -p ${MASK17}
	
	#outcome
#     featquery 1 ${MODELDIR} 4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_Lput_outcome -p ${MASK08}
#  	featquery 1 ${MODELDIR} 4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_Lcaud_outcome -p ${MASK11}
# 	featquery 1 ${MODELDIR} 4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_Lpall_outcome -p ${MASK12}
# 	featquery 1 ${MODELDIR} 4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_Lins_outcome -p ${MASK15}
# 	featquery 1 ${MODELDIR} 4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_RNAcc_HO_outcome -p ${MASK17}
	
	
	
done	