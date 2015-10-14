#!/bin/sh


#for SUBJ in 002 003 004 005 006 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 028 029 030 031 032 034 035 036 037 038 039; do 
#for SUBJ in 006 009 012 013 014 016 017 024 025 026 028 033 034 039 040 041 042 045 046 047 048 049 050 054 055 056 057 058 059 060 061 062 064 065 067 068 069 070 072 073 074 075 076 077 079 081 083 085 086 087 088 089 090 093 095 097 099 100; do  #DTI list
#for SUBJ in 001 002 003 004 005 006 009 010 012 013 014 016 017 018 020 021 022 023 024 025 026 028 029 030 031 032 033 034 035 036 037 038 039 040 041 042 045 046 047 048 049 050 054 055 056 057 058 059 060 061 062 064 065 067 068 069 070 072 073 074 075 076 077 079 081 083 085 086 087 088 089 090 093 095 097 099 100; do
for SUBJ in 001	002	004 006	009	010	012	013	014	016	017 022	023	024	025	026	028	029	030 032	033	034	036	037	038	039	040	041	042	045	046	047	048	049	050	054	055	056	058	059	060	061	062	064	065	067	068	069	070	072	073	074	075	076	077	079	081	083	085	086	087	088	089	090	093	095	097	099	100; do

	MAINDIR=/Users/sarabergman/Documents/ELS/KIDMID/Analysis
	ROIDIR=${MAINDIR}/ROI/PPI/interaction_check
	MODELDIR=${MAINDIR}/L1/PPI/RightNAcc.Model5.1.Nat/${SUBJ}.feat
	#MAINMODEL=${MAINDIR}/L1/Model5/${SUBJ}.feat
	
	MASK1=${ROIDIR}/insula_mask.nii.gz
	#MASK2=${ROIDIR}/
	
	cd ${MODELDIR}

	featquery 1 ${MODELDIR} 1 stats/pe26 featquery_insulaPE.int ${MASK1}  #parameter estimates from the R posterior insula for the interaction term
	#featquery 1 ${MODELDIR} 1 stats/pe26 featquery_PPI_Linsula.01.28 -p ${MASK2}
	
	
	#featquery 1 ${MODELDIR} 1 stats/pe26 featquery_PPI_Rinsula.01.27 -p ${MODELDIR}/reg/standard.nii.gz -mm 38 -14 14   #parameter estimates from the right insula subcluster coordinate for the interaction term
	#featquery 1 ${MODELDIR} 1 stats/pe26 featquery_PPI_Linsula.01.27 -p ${MODELDIR}/reg/standard.nii.gz -mm -38 -2 -10  #parameter estimates from the left insula subcluster coordinate for the interaction term
	#featquery 1 ${MODELDIR} 1 stats/pe1 featquery_antgainVnongain_insula -p ${MASK1} #parameter estimates from the insula for the ant gain > nongain term
	#featquery 1 ${MODELDIR} 1 stats/pe1 featquery_antgainVnongain_rNAcc -p ${MASK2} #parameter estimates from the NAcc for the ant gain > nongain term
	
	# cd ${MAINMODEL}  ## Model 5 GLM L1
# 	rm -rf featquery_antgain
# 	featquery 1 ${MAINMODEL} 2 stats/pe1 stats/pe2 featquery_antgainAnongain_insula -p ${MASK1} #parameter estimates from the insula for the ant gain > baseline, ant nongain > baseline terms
# 	featquery 1 ${MAINMODEL} 2 stats/pe1 stats/pe2 featquery_antgainAnongain_rNAcc -p ${MASK2} #parameter estimates from the NAcc for the ant gain > baseline, ant nongain > baseline terms
	

done