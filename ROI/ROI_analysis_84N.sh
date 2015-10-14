#!/bin/sh

for SUBJ in 001 002	003	004	005	006	009	010	012	013	014	016	017	021	022	023	024	025	026	028	029	030 031	033	034	035	036	037	038	040 \
041	042	045	046 047	048	049	050	054	055	056	058	059	060	061	062	064	065	067	068	069	070	072	073 074 075 076 077 079 081 083 085 \
086 087 088 089 090 091 093 095 097 098 099 100 102 103 106 107 108 112 113 114 116 121; do	

# #removed 020, 030, and 046

	MAINDIR=/Users/sarabergman/Documents/ELS/KIDMID/Analysis
	ROIDIR=${MAINDIR}/ROI/84N_ELS
	MODELDIR=${MAINDIR}/L1/Model5.2/${SUBJ}.feat
	
	#MASK17=${MAINDIR}/ROI/HarvardOxfordstructuralatlasprobabilisticmap/thresh_rightNAcc.nii.gz

	MASK01=${ROIDIR}/Lcaud_antloss.nii.gz 
	MASK02=${ROIDIR}/Lcaud_outloss.nii.gz 
	MASK03=${ROIDIR}/Lins_antloss.nii.gz 
	MASK04=${ROIDIR}/Lins_outloss.nii.gz 
	MASK05=${ROIDIR}/Lpall_antloss.nii.gz 
	MASK06=${ROIDIR}/Lpall_outloss.nii.gz	
	MASK08=${ROIDIR}/Lput_antloss.nii.gz
	MASK09=${ROIDIR}/Lput_outloss.nii.gz
	MASK10=${ROIDIR}/Rcaud_antloss.nii.gz
	MASK11=${ROIDIR}/Rins_antloss.nii.gz
	MASK12=${ROIDIR}/Rpall_antloss.nii.gz
	MASK13=${ROIDIR}/Rput_antloss.nii.gz 
	
	
	cd ${MODELDIR}
	
	#anticipation
	
#     featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_Lcaud_ant -p ${MASK01} 
# 	featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_Lins_ant -p ${MASK03}
# 	featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_Lpall_ant -p ${MASK05}
# 	featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_Lput_ant -p ${MASK08}
#     featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_Rcaud_ant -p ${MASK10}
#     featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_Rins_ant -p ${MASK11}
#     featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_Rpall_ant -p ${MASK12}
#     featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_Rput_ant -p ${MASK13}
    
	#outcome
	featquery 1 ${MODELDIR} 6 stats/pe5 stats/pe6 stats/pe7 stats/pe8 stats/pe9 stats/pe10 featquery_Lcaud_outcome -p ${MASK02}
   	featquery 1 ${MODELDIR} 6 stats/pe5 stats/pe6 stats/pe7 stats/pe8 stats/pe9 stats/pe10 featquery_Lins_outcome -p ${MASK04}
  	featquery 1 ${MODELDIR} 6 stats/pe5 stats/pe6 stats/pe7 stats/pe8 stats/pe9 stats/pe10 featquery_Lpall_outcome -p ${MASK06}
  	featquery 1 ${MODELDIR} 6 stats/pe5 stats/pe6 stats/pe7 stats/pe8 stats/pe9 stats/pe10 featquery_Lput_outcome -p ${MASK09}
	
	
done	