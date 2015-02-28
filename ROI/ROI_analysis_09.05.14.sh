#!/bin/sh

for SUBJ in 001	002	003	004	005	006	008	009	010	012	013	014	016	017	020	021	022	023	024	025	026	028	029	030	031	033	034	035	036	037	038	039	040 \
041	042	045	046	047	048	049	050	054	055	056	057	058	059	060	061	062	064	065	067	068	069	070	072	075; do	
	MAINDIR=/Users/sarabergman/Documents/ELS/KIDMID/Analysis
	ROIDIR=${MAINDIR}/ROI
	MODELDIR=${MAINDIR}/L1/Model4/${SUBJ}.feat
	
	#MASK1=${ROIDIR}/52N_MSPSS.total/sgACC.cope20zstat2.nii.gz  #ant loss > gain corr with social support total score

	MASK1=${ROIDIR}/58N_maineffect_HOatlas_union/bilateral_NAcc.nii.gz 
	MASK2=${ROIDIR}/58N_maineffect_HOatlas_union/bilateral_putamen.nii.gz 
	MASK3=${ROIDIR}/58N_maineffect_HOatlas_union/bilateral_caudate.nii.gz 
	MASK4=${ROIDIR}/58N_maineffect_HOatlas_union/bilateral_insula.nii.gz 
	MASK5=${ROIDIR}/58N_maineffect_HOatlas_union/mPFC.nii.gz 
	MASK6=${ROIDIR}/58N_maineffect_HOatlas_union/right_NAcc.nii.gz
	MASK7=${ROIDIR}/58N_maineffect_HOatlas_union/left_NAcc.nii.gz
	MASK8=${ROIDIR}/58N_maineffect_HOatlas_union/right_insula.nii.gz
	
	cd ${MODELDIR}
	#rm -rf featquery_sgACC.52mspss.cope20zstat2

	#featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_sgACC.52mspss.cope20zstat2 -p ${MASK1}
	#featquery 1 ${MODELDIR} 8 stats/pe1 stats/pe2 stats/pe3 stats/pe4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_58bilateralNAcc -p ${MASK1}
	#featquery 1 ${MODELDIR} 8 stats/pe1 stats/pe2 stats/pe3 stats/pe4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_58bilateralPutamen -p ${MASK2}
	#featquery 1 ${MODELDIR} 8 stats/pe1 stats/pe2 stats/pe3 stats/pe4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_58bilateralCaudate -p ${MASK3}
	#featquery 1 ${MODELDIR} 8 stats/pe1 stats/pe2 stats/pe3 stats/pe4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_58bilateralInsula -p ${MASK4}
	#featquery 1 ${MODELDIR} 8 stats/pe1 stats/pe2 stats/pe3 stats/pe4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_58mPFC -p ${MASK5}
	#featquery 1 ${MODELDIR} 8 stats/pe1 stats/pe2 stats/pe3 stats/pe4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_58rightNAcc -p ${MASK6}
	#featquery 1 ${MODELDIR} 8 stats/pe1 stats/pe2 stats/pe3 stats/pe4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_58leftNAcc -p ${MASK7}
	featquery 1 ${MODELDIR} 8 stats/pe1 stats/pe2 stats/pe3 stats/pe4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_58rightInsula -p ${MASK8}
	
done	
	

