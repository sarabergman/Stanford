#!/bin/sh

for SUBJ in 001	002	003	004	005	006	007	008	009	010	011	012	013	014	015	016	017	018	019	\
020	021	022	023	024	025	026	028	029	030	031	032	033	034	035	036	037	038	039	040	041	042	\
043	045	046	047	048	049	050	051	053	054	055	056	057	058	059	061	062	064	065	067	068	069 \
; do 

    PSDIR=/Users/sarabergman/Documents/ELS/KIDMID/Analysis/Images/${SUBJ}/PS_MELODIC_FLIRT.feat
    behavdir=/Users/sarabergman/Documents/ELS/KIDMID/Analysis/behavior
    evdir=/Users/sarabergman/Documents/ELS/KIDMID/Analysis/EV/${SUBJ}

      if [ ! -e ${PSDIR}/reg ] || [ ! -e ${PSDIR}/MOTIONconfoundevs.txt ] || [ ! -e ${PSDIR}/filtered_func_data.nii.gz ] || [ ! -e ${PSDIR}/reg/example_func2standard.png ] || [ ! -e ${PSDIR}/motion_and_outlier_confounds.txt ];then
      	  echo "$SUBJ PS is not ready for L1"  
      else echo "$SUBJ PS is ready for L1"

      fi
#       grep -i error ${PSDIR}/logs/*
      
      if [ ! -e ${behavdir}/${SUBJ}_behavior_summary.mat ] ; then
      		echo "$SUBJ behavior is not ready for analysis"
	  fi
	  
	  if [ ! -e ${evdir}/${SUBJ}_ant_all.txt ]; then
	  		echo "$SUBJ 3column file not ready for L1.withmissed"
	  fi
	  
	  if [ ! -e ${evdir}/no.missed/${SUBJ}_ant_all.txt ] ; then	
      		echo "$SUBJ 3column file not ready for L1.nomissed"
      fi
      
done    


