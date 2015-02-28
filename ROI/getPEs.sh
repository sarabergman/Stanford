#!/bin/sh

## ROI 

for SUBJ in 001 002 003 004 005 006 009 010 012 013 014 016 017 021; do

MAINDIR=/Users/sarabergman/Documents/STANFORD/FYP/KIDMID/Analysis
DATADIR=${MAINDIR}/L1/Model4/${SUBJ}.feat

FEATQUERYDIR=${DATADIR}/featquery_dACC_outcome

cd $FEATQUERYDIR

cat report.txt | awk '{print $6 $10}' > 


done