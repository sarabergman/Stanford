#!/bin/sh


# for SUBJ in 001 002 003 004 005 006 008 009 010 011 012 013 014 015 016 017 018; do
# for SUBJ in 002; do
DATA=/Users/sarabergman/Documents/STANFORD/FYP/KIDMID/Analysis/L1/Model3/002.feat

cd ${DATA}


# 	for cope in {1..18} ; do
	for cope in 1; do
	
		echo "	<p>COPE${cope} - zstat1 &nbsp;&nbsp;-&nbsp;&nbsp; C${cope} <br>
			<a href=cluster_zstat${cope}_std.html><IMG BORDER=0 SRC=rendered_thresh_zstat${cope}.png></a> "
	done
 >> /Users/sarabergman/Documents/STANFORD/FYP/KIDMID/Analysis/L1/Model3/L1_summary.html


