%timecourse analysis1: pair each TR with an event
%assigns an event to each TR. 246 volumes per run (after removing first 4 volumes).
%TR = 2s; trial length = 6s
%not true = first trial, which is a little bit shorter, is excluded to allow timing to
%catch up to the timing of acquisitions.


maindir = '/Users/sarabergman/Documents/ELS/KIDMID/';

%sublist = {'006'};
sublist = {'006','009','012', '013','014','016','017','024','025','026','028','033','039','040','041','042', ...
    '045','046','047','048','049','050','054','055','056','058','060','061','062','064','065','067','068','069', ...
    '070','072','073','074','075','076','077','079','081','083','085','086','087','088','089','090','093','095','097','099','100'}; 
%problem with 034 native timecourse


for p = 1:length(sublist)
    subID = sublist{p};

    datadir = fullfile(maindir, 'Data', subID, 'behavioral');  %where E-prime data lives
    
    cd(datadir)
    [num,txt,raw] = xlsread(['kidmid_behavior_' subID '.xlsx']);  %load in data;
    
    %number of trials per trialtype(condition)
    antgain_count = 0; %should be 18 or 24
    antloss_count = 0; %should be 18 or 24
    antnongain_count = 0; %should be 18 or 12
    antnonloss_count = 0; %should be 18 or 12

    if strcmp(subID,'002')
        trigtime = raw{2,41};
        range = 3:74;
        start = 2; %to start structure at 1
        b2 = zeros(1,15); %baseline2 = 15 TRs of baseline = 0s
    elseif strcmp(subID, '021') %021 didnt record last 2 trials but has 246 volumes
        range = 4:73;  %only 70 trials
        trigtime = raw{3,41};
        b2 = zeros(1,21); %extra bseline2 time for sub 021
        start = 3;
    elseif strcmp(subID,'029')  %029 has 204 volumes, completed 70 trials
        range = 4:73;  %only 70 trials
        trigtime = raw{3,41};
        b2 = 0;  %no baseline2 time for 029
        start = 3;
    else
        trigtime = raw{3,41};  %trigtime  raw{3,41}, raw{2,41} for 002
        range = 4:75;
        start = 3;
        b2 = zeros(1,15); %baseline2 = 15 TRs of baseline = 0s
    end
    disdaqs = 8000;
    adjust = trigtime + disdaqs;  %total time to be subtracted
    b1 = zeros(1,15); %baseline1 = 15 TRs of baseline = 0s
    
   % t = zeros(1,length(range)*3); %timecourse will include 3*number of trials (trial length = 6s or 3 TRs)

    for i = range  %looping thru trials
       % j = [];
        s = i - start;
        %for j = event
        
        %if no button-response on trial
        %if isnan(raw{i,64}) == 1 && isnan(raw{i,50}) == 1 %if Tg.RESP (col BL, 64) = NaN (return TRUE) and Dly2.RESP (col AX, 50) = NaN, i.e., no button-press for trial
              
        %else
 
        %if cue is ant gain
        if strcmp(raw{i,62},'dist_resized/cir2.bmp')  %if cir2
            j(s).ant = 1.1;
            j(s).tar = 2.1;
            if raw{i,64} == 1 %if trial is successful, win 5 points: if {'Tgt.RESP';} == 1; col 64
                j(s).out = 3.1;
            else   %if trial is unsuccessful (miss on gain trial; unsuccessful gain)
                j(s).out = 3.5;
            end
            
        %if cue is ant loss
        elseif strcmp(raw{i,62},'dist_resized/sqr2.bmp')  %if sqr2
            j(s).ant = 1.2;
            j(s).tar = 2.2;
            if raw{i,64} == 1  %if trial is successful (hit on loss trial; successfully avoid loss)
                j(s).out = 3.6;
            else  %if trial is unsuccessful (lose)
                j(s).out = 3.2;
            end
            
        %if cue is ant nongain    
        elseif strcmp(raw{i,62},'dist_resized/cir.bmp') %if cir
            j(s).ant = 1.3;
            j(s).tar = 2.3;
            j(s).out = 3.3;
            
        %if cue is ant nonloss    
        elseif strcmp(raw{i,62},'dist_resized/sqr.bmp') %if sqr
            j(s).ant = 1.4;
            j(s).tar = 2.4;
            j(s).out = 3.4;
        end
            
    end       

    d = struct2array(j);
    t = [b1 d b2];
    t = t';
    
    
    tcdir = fullfile(maindir, 'Analysis', 'Images', subID, 'PS_MELODIC_FLIRT.feat', 'PPI_timecourses');
    cd(tcdir)
    %nacc = load('RightNAcc_native_timecourse.txt');
    nacc = load('RightNAcc_timecourse.txt');
    tNacc = [nacc t];
    
    %export to csv
    csvwrite('timecourse_MNI_NAcc_events.csv', tNacc)
    %save as matlab double
    save('tNacc_mni.mat', 'tNacc')
    
    clearvars %%%-except sublist maindir

end




