#!/bin/sh


#for SUBJ in 002 003 004 005 006 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 028 029 030 031 032 034 035 036 037 038 039; do 
for SUBJ in 001 002 003 004 005 006 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 028 029 030 031 032 034 035 036 037 038 039; do	
	MAINDIR=/Users/sarabergman/Documents/STANFORD/FYP/KIDMID/Analysis
	ROIDIR=${MAINDIR}/ROI
	MODELDIR=${MAINDIR}/L1/Model4/${SUBJ}.feat
	
	MASK1=${ROIDIR}/33N_ELS/vSTR_cope6zstat1.nii.gz  #ant loss > nonloss main effect, controlling for ELS... same cluster without controlling, but MainEffects showed 1 contiguous cluster with occipital
	MASK2=${ROIDIR}/33N_ELS/vmPFC_cope6zstat4.nii.gz  #ant loss > nonloss cor subj stress
	MASK3=${ROIDIR}/33N_ELS/medialcluster_cope5zstat6.nii.gz  #ant gain > nongain neg cor total stress
	MASK4=${ROIDIR}/33N_ELS/lateralcluster_cope5zstat6.nii.gz  #ant gain > nongain neg cor total stress
	MASK5=${ROIDIR}/27N_MSPSS/NAcc-vmPFC_cope20zstat2.nii.gz  #ant loss > gain cor social support total
	
	MASK6=${ROIDIR}/33N_ELS/mPFC_cope13zstat1.nii.gz   #outcome gain > nongain main effect
	MASK7=${ROIDIR}/33N_ELS/ACC_cope14zstat1.nii.gz 	#outcome loss > nonloss main effect
	MASK8=${ROIDIR}/33N_ELS/Lins_cope14zstat1.nii.gz 	#outcome loss > nonloss main effect
	MASK9=${ROIDIR}/33N_ELS/Rins_cope14zstat1.nii.gz 	#outcome loss > nonloss main effect
	
	cd ${MODELDIR}
	rm -rf featquery_NAcc-mPFC.a.lg.ss
	rm -rf featquery_NAcc-mPFC.a.lg+.ss
	#anticipation
	# featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_vSTR.a.lnl.me -p ${MASK1}
# 	featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_vmPFC.a.lnl.subjels -p ${MASK2}
# 	featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_medial.a.gng.nels -p ${MASK3}
# 	featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_lateral.a.gng.nels -p ${MASK4}
#   featquery 1 ${MODELDIR} 4 stats/pe1 stats/pe2 stats/pe3 stats/pe4 featquery_NAccvmPFC.a.lg.ss -p ${MASK5}
	featquery 1 ${MODELDIR} 6 stats/cope1 stats/cope3 stats/cope5 stats/cope6 stats/cope19 stats/cope20 featquery_NaccvmPFC.a.lg.ss.copes -p ${MASK5}
	featquery 1 ${MODELDIR} 6 stats/cope1 stats/cope3 stats/cope5 stats/cope6 stats/cope19 stats/cope20 featquery_vSTR.a.lnl.me.copes -p ${MASK1}
	

	#outcome
	# featquery 1 ${MODELDIR} 4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_mPFC.o.gng.me -p ${MASK6}
# 	featquery 1 ${MODELDIR} 4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_ACC.o.lnl.me -p ${MASK7}
# 	featquery 1 ${MODELDIR} 4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_Lins.o.lnl.me -p ${MASK8}
# 	featquery 1 ${MODELDIR} 4 stats/pe5 stats/pe6 stats/pe7 stats/pe8 featquery_Rins.o.lnl.me -p ${MASK9}
# 	
done	
	
	# for SUBJ in 001 002 003 004 005 006 009 010 012 013 014 016 017 021
# do
# 
# 	for cope in 1 2 3 4 5 
# 	do
# 
# 	MAINDIR=/Users/sarabergman/Documents/STANFORD/FYP/KIDMID/Analysis
#  	MODELDIR=${MAINDIR}/L1/Model3/${SUBJ}.feat/Model04_FNIRT/Smooth_5mm_motion_denoised/Level2.gfeat/cope${cope}.feat
# 
# 	ROIDIR=${MAINDIR}/ROI/14N
# 	
#  	MASK1=${ROIDIR}/left_vSTR_5mm.nii.gz
#  	MASK2=${ROIDIR}/right_vSTR_5mm.nii.gz
#  	MASK3=${ROIDIR}/vmPFC_5mm.nii.gz
# 	MASK4=${ROIDIR}/cuneus_5mm.nii.gz
# 
# 	cd $MODELDIR
# 	#cd $ROIDIR
#  	#rm -rf lOFC
#  	featquery 1 ${MODELDIR} 1 stats/pe1 left_vSTR -p ${MASK1}
#  	featquery 1 ${MODELDIR} 1 stats/pe1 right_vSTR -p ${MASK2}
#  	featquery 1 ${MODELDIR} 1 stats/pe1 vmPFC -p ${MASK3}
# 	featquery 1 ${MODELDIR} 1 stats/pe1 cuneus -p ${MASK4}
# done
