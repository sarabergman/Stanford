#!/bin/sh


for SUBJ in ; do
#003 005 018 020

# 	if [ ! -e /Users/sarabergman/Documents/ELS/KIDMID/Analysis/segment/${SUBJ} ]; then 
# 		rm -rf /Users/sarabergman/Documents/ELS/KIDMID/Analysis/segment/${SUBJ}
# 	fi 
	
recon-all -all -notal-check -3T -s ${SUBJ} -i /Users/sarabergman/Documents/ELS/KIDMID/Data/${SUBJ}/anatomical/T1w_9mm_sag_raw.nii

done
