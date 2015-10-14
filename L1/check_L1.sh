#!/bin/sh

for SUBJ in 001	002	003	004	005	006	009	010	012	013	014	016	017	021	022	023	024	025	026	028	029	030	031	033	034	035	036	037	038	040	041	042	045	046	047	048	049	050	054	055	056	058	059	060	061	062	064	065	067	068	069	070	072	073	074	075	076	077	079	081	083	085	086	087	088	089	090	091	093	095	097	098	099	100	102	103	106	107	108	112	113	114	116	121; do
#for SUBJ in 001	002	004 006	009	010	012	013	014	016	017 022	023	024	025	026	028	029	030	 032 033 034 036 037 038 039	040	041	042	045	046	047	048	049	050	054	055	056	058	059	060	061	062	064	065	067	068	069	070	072	073	074	075	076	077	079	081	083	085	086	087	088	089	090	093	095	097	099	100; do

    L1DIR=/Users/sarabergman/Documents/ELS/KIDMID/Analysis/L1/Model5.2/${SUBJ}.feat
    #IMAGEDIR=/Users/sarabergman/Documents/ELS/KIDMID/Analysis/Images/${SUBJ}/PS_MELODIC_FLIRT_NO_SMOOTH.feat
	#L1DIR=/Users/sarabergman/Documents/ELS/KIDMID/Analysis/L1/PPI/RightNAcc.Model5.1.Nat_nongain/${SUBJ}.feat
	#EVDIR=/Users/sarabergman/Documents/ELS/KIDMID/Analysis/EV/${SUBJ}/PPI.antgain

       if [ ! -e ${L1DIR}/reg ] || [ ! -e ${L1DIR}/cluster_mask_zstat3.nii.gz ] && [ ! -e ${L1DIR}/reg/highres2standard.nii.gz ] && [ ! -e ${L1DIR}/reg/standard.nii.gz ] && [ ! -e ${L1DIR}/reg/example_func2standard.nii.gz ] && [ ! -e ${L1DIR}/reg/standard2example_func.mat ] && [ ! -e ${L1DIR}/reg/standard2highres.mat ]; then
       #if [ ! -e ${L1DIR}/reg_standard/reg/highres.nii.gz ] || [ ! -e ${L1DIR}/reg_standard/mask.nii.gz ] || [ ! -e ${L1DIR}/cluster_mask_zstat3.nii.gz ]; then
       	  echo "$SUBJ L1 not ready for L3"  
       else echo "$SUBJ L1 okay"
 
       fi
#       
# 	if [ ! -e ${EVDIR}/${SUBJ}_ant_gain_and_nongain.txt ]; then
#        echo "$SUBJ PS no smooth not ready "
#        else echo "$SUBJ PS okay"
# 	fi		
       
#       grep -i error ${PSDIR}/logs/*
      
#       if [ ! -e ${behavdir}/${SUBJ}_behavior_summary.mat ] ; then
#       		echo "$SUBJ behavior is not ready for analysis"
# 	  fi
# 	  
# 	  if [ ! -e ${evdir}/${SUBJ}_ant_all.txt ]; then
# 	  		echo "$SUBJ 3column file not ready for L1.withmissed"
# 	  fi
# 	  
# 	  if [ ! -e ${evdir}/no.missed/${SUBJ}_ant_all.txt ] ; then	
#       		echo "$SUBJ 3column file not ready for L1.nomissed"
#       fi
      
done