%subID = '008';
%maindir = '/Users/sarabergman/Documents/ELS/KIDMID/';
maindir = '/Volumes/ELS/KIDMID';

%sublist = {'001','002','003','004', '005', '006', '008', '009', '010', '011', '012', '013', '014', '015','016', '017', '018','019','020', ...
    %'021','022','023','024','024','025','026','028','029','030','031','032','033','034','035','036','037','038','039','040','041','042', ...
    %'043','045','046','047','048','049','050','051','054','055','056','058','059','061','062','064','065','067','068','069'};  
sublist = {'089'};    
for s = 1:length(sublist)
    subID = sublist{s};
     
    evdir = fullfile(maindir, 'Analysis', 'EV', subID);  %where EV files get dumped
    if ~exist (evdir)  %if doesnt exits
        mkdir (evdir)   %make dir
    end
    misseddir = fullfile(maindir, 'Analysis', 'EV', subID, 'no.missed'); %where EV files get dumped for excluding missed trials
    if ~exist (misseddir)
        mkdir (misseddir)
    end
    %cd ~
    %cd(maindir)
    datadir = fullfile(maindir, 'Data', subID, 'behavioral');  %where E-prime data lives
    %datadir = fullfile(maindir, 'Data', '999');
    cd(datadir) 
    
    [num,txt,raw] = xlsread(['kidmid_behavior_' subID '.xlsx']);  %load in data;
    %[num,txt,raw] = xlsread('SB_999.xlsx');
    %%% this loads 3 diff variables in the workspace named 'num', 'txt',
    %%% and 'raw' which each represent the data file in a different format.
    %%% We're going to use 'raw', which looks closest to the Excel file.
    
    
    if strcmp(subID,'002')
        trigtime = raw{2,41};
        range = 3:74;
    elseif strcmp(subID, '021') || strcmp(subID,'029')
        range = 4:73;  %only 70 trials
        trigtime = raw{3,41};
    else
        trigtime = raw{3,41};  %trigtime  raw{3,41}, raw{2,41} for 002
        range = 4:75;
    end
    disdaqs = 8000;
    adjust = trigtime + disdaqs;  %total time to be subtracted
    
    %%% setting up empty vectors to represent the first 2 colummns in EV files (time
    %%% and duration) for each regressor: gain_ant, loss_ant, neut_ant,
    %%% gain_outcome, loss_outcome, neut_outcome, {no_loss_outcome, no_gain_outcome},
    %%% target, delay2, feedback (collapsed across all conditions),
    %%% anticipation (collapsed across all conditions).
    
    %anticipation regressors (4)
    gain_ant_time = [];  %1. anticipation of potential gain, time colummn
    loss_ant_time = [];  %2. anticipation of potential loss, time column
    neut_ant_time = [];  %3. anticipation of not winning or losing, time column
    antall_time = [];    %4. anticipation for all trials (used in Outcome model), time column
    nongain_ant_time = []; %5. anticipation of nongain, time
    nonloss_ant_time = []; %6. anticipation of nonloss, time
    
    
    gain_ant_dur = [];  %anticipation of potential gain, duration colummn
    loss_ant_dur = [];  %anticipation of potential loss, duration column
    neut_ant_dur = [];  %anticipation of not winning or losing, duration column
    antall_dur = [];       %anticipation for all trials (used in Outcome model), duration column
    nongain_ant_dur = [];
    nonloss_ant_dur = [];
    
    
    %outcome regressors (6)
    gain_outcome_time = [];        %1. winning feedback, time column
    loss_outcome_time = [];        %2. losing feedback, time column
    neut_outcome_time = [];        %3. neither win nor lose, time column
    no_gain_outcome_time = [];     %4. didn't win, time column
    no_loss_outcome_time = [];     %5. avoid losing, time column
    feedback_time = [];            %6. feedback phase (used in Anticipation model), time column
    
    gain_outcome_dur = [];    %winning feedback, duration column
    loss_outcome_dur = [];    %losing feedback, duration column
    neut_outcome_dur = [];    %neither win nor lose, duration column
    no_gain_outcome_dur = []; %didn't win, duration column
    no_loss_outcome_dur = []; %avoid losing, duration column
    feedback_dur = [];   %feedback phase (used in Anticipation model), duration column
    
    %target
    target_time = [];   %target
    target_dur = [];
    
    %Delay2 (period in between target offset and feedback onset)
    delay_time = [];
    delay_dur = [];
    
    %missed trials
    missed_time = [];
    missed_dur = [];
    
    %accuracy and trial-type counts 
    gain_succ = 0;
    gain_count = 0;
    nongain_count = 0;
    nongain_succ = 0;
    nonloss_succ = 0;
    nonloss_count = 0;
    lose_succ = 0;
    lose_count = 0;
    missed_count = 0;
    
    
    
    %%%condition types, identified by target image name:
    %%%1. sqr2 = you CAN lose 5 points
    %%%2. cir2 = you CAN win 5 points
    %%%3. sqr = you don't lose anything
    %%%4. cir = you don't win anything
    
    %looping through each trial
    for i = range  %i is the row, so trials are from row 4-75; 3:74 for 002
        
        if raw{i,65} + raw{i,51} == 0 %if Tg.RT (col BM, 65) = 0 and Dly2.RT (col AY, 51) = 0, i.e., no button-press for trial
            missed_time = [missed_time (raw{i,44} - adjust)/1000]; 
            missed_dur = [missed_dur (raw{i+1,44}-raw{i,44})/1000]; %duration is entire length of trial
            missed_count = missed_count + 1;
        end
        
        %first, fill regressors for which condition is irrelevant (should include all 72 trials, length should be 72)
        antall_time = [antall_time (raw{i,44} - adjust)/1000]; %col 44: {'Cue.OnsetTime';}
        antall_dur = [antall_dur (raw{i,63}-raw{i,44})/1000];  %col 63 - 44: {'Tgt.OnsetTime';} - {'Cue.OnsetTime';}
        feedback_time = [feedback_time (raw{i,54} - adjust)/1000]; %col 54: {'fbk.OnsetTime';}
        feedback_dur = [feedback_dur (raw{i+1,44}-raw{i,54})/1000]; %col 44 for subsequent trial - col 54, then 1.5: {'Cue.OnsetTime';} - {'fbk.OnsetTime';}
        target_time = [target_time (raw{i,63} - adjust)/1000]; %col 63: {'Tgt.OnsetTime';}
        target_dur = [target_dur (raw{i,66})/1000]; %col 66: {'TgtDur[Trial]';}
        delay_time = [delay_time (raw{i,49} - adjust)/1000]; %col 49: {'Dly2.OnsetTime';}
        delay_dur = [delay_dur (raw{i,54}-raw{i,49})/1000]; %col 54 - 49: {'fbk.OnsetTime';} - {'Dly2.OnsetTime';}
        
        %if condition is neutral; column 62 refers to the shape image name
        if strcmp(raw{i,62},'dist_resized/cir.bmp') || strcmp(raw{i,62},'dist_resized/sqr.bmp')  %if cir OR sqr
            neut_ant_time = [neut_ant_time (raw{i,44} - adjust)/1000]; %col 44: {'Cue.OnsetTime';}
            neut_ant_dur = [neut_ant_dur (raw{i,63}-raw{i,44})/1000]; %col 63 - 44: {'Tgt.OnsetTime';} - {'Cue.OnsetTime';
            neut_outcome_time = [neut_outcome_time (raw{i,54} - adjust)/1000]; %col 54: {'fbk.OnsetTime';}
            neut_outcome_dur = [neut_outcome_dur (raw{i+1,44}-raw{i,54})/1000]; %col 44 for subsequent trial - col 54, then 1.5: {'Cue.OnsetTime';} - {'fbk.OnsetTime';}
            if strcmp(raw{i,62},'dist_resized/cir.bmp')  %if cir, no gain (nongain)
                nongain_ant_time = [nongain_ant_time (raw{i,44} - adjust)/1000];
                nongain_ant_dur = [nongain_ant_dur (raw{i,63}-raw{i,44})/1000];
                no_gain_outcome_time = [no_gain_outcome_time (raw{i,54} - adjust)/1000];  %col 54: {'fbk.OnsetTime';}
                no_gain_outcome_dur = [no_gain_outcome_dur (raw{i+1,44}-raw{i,54})/1000];  %col 44 for subsequent trial - col 54, then 1.5: {'Cue.OnsetTime';} - {'fbk.OnsetTime';}
                nongain_count = nongain_count + 1;
                if raw{i,64} == 1 %if trial is successful
                    nongain_succ = nongain_succ + 1;
                end
            else  %sqr, no loss (nonloss) 
                nonloss_ant_time = [nonloss_ant_time (raw{i,44} - adjust)/1000];
                nonloss_ant_dur = [nonloss_ant_dur (raw{i,63}-raw{i,44})/1000];
                no_loss_outcome_time = [no_loss_outcome_time (raw{i,54} - adjust)/1000];
                no_loss_outcome_dur = [no_loss_outcome_dur (raw{i+1,44}-raw{i,54})/1000];
                nonloss_count = nonloss_count + 1;
                if raw{i,64} == 1 %if trial is successful
                    nonloss_succ = nonloss_succ + 1;
                end
            end
            
            %if condition is potential win
        elseif strcmp(raw{i,62},'dist_resized/cir2.bmp')  %if cir2
            gain_ant_time = [gain_ant_time (raw{i,44} - adjust)/1000];
            gain_ant_dur = [gain_ant_dur (raw{i,63}-raw{i,44})/1000];
            if raw{i,64} == 1 %if trial is successful, win 5 points: if {'Tgt.RESP';} == 1; col 64
                gain_outcome_time = [gain_outcome_time (raw{i,54} - adjust)/1000];
                gain_outcome_dur = [gain_outcome_dur (raw{i+1,44}-raw{i,54})/1000];
                gain_succ = gain_succ + 1;
                gain_count = gain_count + 1;
            else   %if trial is unsuccessful, neutral or non-gain
                no_gain_outcome_time = [no_gain_outcome_time (raw{i,54} - adjust)/1000];
                no_gain_outcome_dur = [no_gain_outcome_dur (raw{i+1,44}-raw{i,54})/1000];
                neut_outcome_time = [neut_outcome_time (raw{i,54} - adjust)/1000]; %col 54: {'fbk.OnsetTime';}
                neut_outcome_dur = [neut_outcome_dur (raw{i+1,44}-raw{i,54})/1000];
                nongain_count = nongain_count + 1;
            end
            
            %if condition is potential loss
        elseif strcmp(raw{i,62},'dist_resized/sqr2.bmp')  %if sqr2
            loss_ant_time = [loss_ant_time (raw{i,44} - adjust)/1000];
            loss_ant_dur = [loss_ant_dur (raw{i,63}-raw{i,44})/1000];
            if raw{i,64} == 1  %if trial is successful, neutral or non-loss
                no_loss_outcome_time = [no_loss_outcome_time (raw{i,54} - adjust)/1000];
                no_loss_outcome_dur = [no_loss_outcome_dur (raw{i+1,44}-raw{i,54})/1000];
                neut_outcome_time = [neut_outcome_time (raw{i,54} - adjust)/1000]; %col 54: {'fbk.OnsetTime';}
                neut_outcome_dur = [neut_outcome_dur (raw{i+1,44}-raw{i,54})/1000];
                nonloss_count = nonloss_count + 1;
                lose_succ = lose_succ + 1;
            else  %if trial is unsuccessful, lose 5 points
                loss_outcome_time = [loss_outcome_time (raw{i,54} - adjust)/1000];
                loss_outcome_dur = [loss_outcome_dur (raw{i+1,44}-raw{i,54})/1000];
                lose_count = lose_count + 1;
            end
        end
        
        
        
    end
    
    %change duration of feedback for each trial on all regressors from NA to
    %1.51
    feedback_dur(find(isnan(feedback_dur))) = 1.51;
    neut_outcome_dur(find(isnan(neut_outcome_dur))) = 1.51;
    gain_outcome_dur(find(isnan(gain_outcome_dur))) = 1.51;
    loss_outcome_dur(find(isnan(loss_outcome_dur))) = 1.51;
    no_gain_outcome_dur(find(isnan(no_gain_outcome_dur))) = 1.51;
    no_loss_outcome_dur(find(isnan(no_loss_outcome_dur))) = 1.51;
    missed_dur(find(isnan(no_loss_outcome_dur))) = 1.51;
    
    
    
    %weight column: set up vectors of ones for every regressor based on the length (number of trials) of that regressor.
    gain_weight = ones(1,length(gain_ant_time))'; %row of 1s - for weights, ' makes vertical
    loss_weight = ones(1,length(loss_ant_time))';
    neut_weight = ones(1,length(neut_ant_time))';
    antall_weight = ones(1,length(antall_time))'; %should be 72, should be same for target, delay, and feedback
    gain_outcome_weight = ones(1,length(gain_outcome_time))';
    loss_outcome_weight = ones(1,length(loss_outcome_time))';
    no_gain_outcome_weight = ones(1,length(no_gain_outcome_time))';
    no_loss_outcome_weight = ones(1,length(no_loss_outcome_time))';
    neut_outcome_weight = ones(1,length(neut_outcome_time))';
    nongain_weight = ones(1,length(nongain_ant_time))';
    nonloss_weight = ones(1,length(nonloss_ant_time))';
    missed_weight = ones(1,length(missed_time))';
    
    %if there are not 72 trials - all_weight is a vector of ones for how
    %many trials there are.
    if strcmp(subID, '021') || strcmp(subID,'029')
        all_weight = ones(1,70)';
    else all_weight = ones(1,72)';
    end
    
    %create 3-column arrays - concatenate time, dur, and weight vectors
    ant_all = [antall_time' antall_dur' all_weight]; %anticipation regressor 4 (collapsed across all conditions)
    feedback = [feedback_time' feedback_dur' all_weight];  %feedback/outcome regressor 6 (collapsed across all conditions)
    target = [target_time' target_dur' all_weight]; %target nuissance regressor
    delay = [delay_time' delay_dur' all_weight]; %delay2 nuissance regressor (between target and feedback)
    
    ant_potential_gain = [gain_ant_time' gain_ant_dur' gain_weight]; %anticipation of potential gain regressor 1
    ant_potential_loss = [loss_ant_time' loss_ant_dur' loss_weight]; %anticipation of potential loss regressor 2
    ant_neutral = [neut_ant_time' neut_ant_dur' neut_weight];  %anticipation of not winning or losing regressor 3
    ant_nongain = [nongain_ant_time' nongain_ant_dur' nongain_weight];
    ant_nonloss = [nonloss_ant_time' nonloss_ant_dur' nonloss_weight];
    
    
    gain = [gain_outcome_time' gain_outcome_dur' gain_outcome_weight]; %winning feedback regressor 1
    loss = [loss_outcome_time' loss_outcome_dur' loss_outcome_weight]; %losing feedback regressor 2
    nongain = [no_gain_outcome_time' no_gain_outcome_dur' no_gain_outcome_weight]; %non-gain feedback regressor 4
    nonloss = [no_loss_outcome_time' no_loss_outcome_dur' no_loss_outcome_weight]; %non-loss feedback regressor 5
    neutral = [neut_outcome_time' neut_outcome_dur' neut_outcome_weight];  %neutral feedback regressor 3 
    
    missed = [missed_time' missed_dur' missed_weight];
    
    
    %write out text files into EV folder
    cd(evdir)
    dlmwrite([subID '_ant_all.txt'], ant_all, 'delimiter','\t','newline','unix', 'precision', 7);
    dlmwrite([subID '_outcome_all.txt'], feedback, 'delimiter','\t','newline','unix', 'precision', 7);
    dlmwrite([subID '_target_all.txt'], target, 'delimiter','\t','newline','unix', 'precision', 7);
    dlmwrite([subID '_delay_all.txt'], delay, 'delimiter','\t','newline','unix', 'precision', 7);
    dlmwrite([subID '_ant_gain.txt'], ant_potential_gain, 'delimiter','\t','newline','unix', 'precision', 7);
    dlmwrite([subID '_ant_loss.txt'], ant_potential_loss, 'delimiter','\t','newline','unix', 'precision', 7);
    dlmwrite([subID '_ant_neut.txt'], ant_neutral, 'delimiter','\t','newline','unix', 'precision', 7);
    dlmwrite([subID '_gain.txt'], gain, 'delimiter','\t','newline','unix', 'precision', 7);
    dlmwrite([subID '_loss.txt'], loss, 'delimiter','\t','newline','unix', 'precision', 7);
    dlmwrite([subID '_nongain.txt'], nongain, 'delimiter','\t','newline','unix', 'precision', 7);
    dlmwrite([subID '_nonloss.txt'], nonloss, 'delimiter','\t','newline','unix', 'precision', 7);
    dlmwrite([subID '_outcome_neutral.txt'], neutral, 'delimiter','\t','newline','unix', 'precision', 7);
    dlmwrite([subID '_ant_nongain.txt'], ant_nongain, 'delimiter','\t','newline','unix', 'precision', 7);
    dlmwrite([subID '_ant_nonloss.txt'], ant_nonloss, 'delimiter','\t','newline','unix', 'precision', 7);
    dlmwrite([subID '_missed.txt'], missed, 'delimiter','\t','newline','unix', 'precision', 7);
    
 
end
cd(maindir)
%cd(maindir)


