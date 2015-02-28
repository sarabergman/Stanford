#! /bin/sh

### These are notes for transferring data from BIAC to local computer at the command line ###

#copying data from BIAC server on echelon to for_sara_tmp in BIAC
#enter in shell after ssh'ing into echelon --> BIAC
#/biac4/gotlib/biac3/gotlib7/data/ELS

#copying anatomical data
[echelon:gotlib7/data/ELS]foreach x ( 001 002 003 004 005 006 007 009 010 011 012 013 014 015 )
foreach? mkdir -p for_sara_tmp/$x
foreach? cp ELS-T1/${x}-T1/anatomics/spgr/*.nii* for_sara_tmp/$x/anatomical
foreach? end

#copying behavioral data
foreach x ( 001 002 003 004 005 006 007 009 010 011 012 013 014 015 )
foreach? cp ELS-T1/${x}-T1/behavioral/ELS_KIDMID* for_sara_tmp/$x/behavioral
foreach? end

#copying functional data
foreach x ( 001 002 003 004 005 006 007 009 010 011 012 013 014 015 )
foreach? cp -r ELS-T1/${x}-T1/functional/kidmid/*ModKMID* for_sara_tmp/$x/functional
foreach? end

#copying notes
foreach x ( 001 002 003 004 005 006 007 009 010 011 012 013 014 015 )
foreach? cp ELS-T1/${x}-T1/*.xlsx for_sara_tmp/$x
foreach? end

#copying all files at once
foreach x ( 001 002 003 004 005 006 007 009 010 011 012 013 014 015 )
foreach? mkdir -p for_sara_tmp/$x
foreach? cp -r ELS-T1/${x}-T1/anatomics/spgr/*.nii* for_sara_tmp/$x/anatomical
foreach? cp ELS-T1/${x}-T1/*.xlsx for_sara_tmp/$x
foreach? cp -r ELS-T1/${x}-T1/functional/kidmid/*ModKMID* for_sara_tmp/$x/functional
foreach? cp ELS-T1/${x}-T1/behavioral/ELS_KIDMID* for_sara_tmp/$x/behavioral
foreach? end

#in another terminal
scp -r echelon@echelon.stanford.edu:/biac4/gotlib/biac3/gotlib7/data/ELS/for_sara_tmp /Users/sarabergman/Documents/STANFORD/FYP/KIDMID/Data
#prompted for echelon's password