
maindir = '/Users/sarabergman/Documents/ELS/KIDMID/';

sublist = {'001','002','003','004', '005', '006', '009', '010', '013', '014','017','020', ...
    '021','022','023','024','025','026','028','030','031','033','034','035','036','037','038', ...
    '040','041','042','045','046','047','048','049','050','054','055','056','058','059','060','061','062',...
    '064','065','067','068','069','070','072','073','074','075','076','077','079','081','083','085', ...
    '087','088','090','093','095'};  %excluding 029

%sublist = {'001'};

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
        b2 = zeros(1,21); %extra baseline2 time for sub 021
        start = 3;
    elseif strcmp(subID,'029')  %029 has 204 volumes, completed 70 trials, recorded 63 trials?
        range = 4:73;  %only 6 trials
        trigtime = raw{3,41};
        b2 = 0;  %no baseline2 time for 029 but for this script ok to include 0s
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

    
    for i = range  %looping thru trials
       % j = [];
        s = i - start;
        %for j = event
        
        %if no button-response on trial
        %if isnan(raw{i,64}) == 1 && isnan(raw{i,50}) == 1 %if Tg.RESP (col BL, 64) = NaN (return TRUE) and Dly2.RESP (col AX, 50) = NaN, i.e., no button-press for trial
              
        %else
 
        %if cue is ant gain
        if strcmp(raw{i,62},'dist_resized/cir2.bmp')  %if cir2
            antgain_count = antgain_count + 1;
            j(s).ant = 1.1;
            j(s).tar = 2.1;
            if raw{i,64} == 1 %if trial is successful, win 5 points: if {'Tgt.RESP';} == 1; col 64
                j(s).out = 3.1;
            else   %if trial is unsuccessful (miss on gain trial; unsuccessful gain)
                j(s).out = 3.5;
            end
            
        %if cue is ant loss
        elseif strcmp(raw{i,62},'dist_resized/sqr2.bmp')  %if sqr2
            antloss_count = antloss_count + 1;
            j(s).ant = 1.2;
            j(s).tar = 2.2;
            if raw{i,64} == 1  %if trial is successful (hit on loss trial; successfully avoid loss)
                j(s).out = 3.6;
            else  %if trial is unsuccessful (lose)
                j(s).out = 3.2;
            end
            
        %if cue is ant nongain    
        elseif strcmp(raw{i,62},'dist_resized/cir.bmp') %if cir
            antnongain_count = antnongain_count + 1;
            j(s).ant = 1.3;
            j(s).tar = 2.3;
            j(s).out = 3.3;
            
        %if cue is ant nonloss    
        elseif strcmp(raw{i,62},'dist_resized/sqr.bmp') %if sqr
            antnonloss_count = antnonloss_count + 1;
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
    
    roi1 = load('RightNAcc_timecourse.txt');
    dem_roi1 = roi1 - mean(roi1);

    roi2 = load('right_mid_ventral_insula.txt');
    dem_roi2 = roi2 - mean(roi2);
    
    roi3 = load('right_posterior_insula.txt');
    dem_roi3 = roi3 - mean(roi3);
%     tROI = [roi t];
    
%     signal = tROI(:,1); %signal is the first column, all 246 timepoints
%     m = mean(signal); %calculate mean signal 
%     %sc = (signal - m) / 100; % % calculate signal change 
%     dem = signal - m; %demeaned timeseries
    
    tROI = [dem_roi1 dem_roi2 dem_roi3 t]; %append sc to tROI
    
    antgains = find(tROI(:,4)==1.1);
    antgain_lag2 = antgains + 2;
    antgain_lag3 = antgains + 3;
    
    antnongains = find(tROI(:,4)==1.3);
    antnongain_lag2 = antnongains + 2;
    antnongain_lag3 = antnongains + 3;
    
    gain_lag2 = [];
    gain_lag3 = [];
    
    for i = antgain_lag2(1:length(antgain_lag2))
        gain_lag2 = vertcat(gain_lag2, tROI(i,1:3));
    end
    for i = antgain_lag3(1:length(antgain_lag3))
        gain_lag3 = vertcat(gain_lag3, tROI(i,1:3));    
    end
        
    nongain_lag2 = [];
    nongain_lag3 = [];
    
    for i = antnongain_lag2(1:length(antnongain_lag2))
        nongain_lag2 = vertcat(nongain_lag2, tROI(i,1:3));
    end
    for i = antnongain_lag3(1:length(antnongain_lag3))
        nongain_lag3 = vertcat(nongain_lag3, tROI(i,1:3));   
    end
      
    save('ROI_peaks.mat', 'gain_lag2', 'gain_lag3','nongain_lag2','nongain_lag3')
    
    clearvars -except sublist maindir
end
