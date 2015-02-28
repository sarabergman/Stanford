%%this script writes the 3-column files for a PPI that investigates regions
%%that correlate with a timecourse in a seed region. To model the
%%interaction between the timecourse of region X with activation during the
%%anticipation of loss > nonloss, run this script.

%%this script also follows the parameters of Model5.

maindir = '/Users/sarabergman/Documents/ELS/KIDMID/';
%maindir = '/Users/sarabergman/Documents/STANFORD/FYP/KIDMID/';
%maindir = '/Volumes/TUXEDOSAM/KIDMID/';
%maindir = '/Volumes/ELS/KIDMID';

% sublist = {'001','002','003','004', '005', '006', '008', '009', '010', '011', '012', '013', '014', '015','016', '017', '018','019','020', ...
%     '021','022','023','024','024','025','026','028','029','030','031','032','033','034','035','036','037','038','039','040','041','042', ...
%     '043','045','046','047','048','049','050','051','054','055','056','057','058','059','060','061','062','064','065','067','068','069', ...
%     '070','072','074','075','076','077','079','081','083','085','086','087','088','089','090','093','095'};  
sublist = {'073'};  

for s = 1:length(sublist)
    subID = sublist{s};
     
    evdir = fullfile(maindir, 'Analysis', 'EV', subID);  %where EV files get dumped
    if ~exist (evdir)  %if doesnt exits
        mkdir (evdir)   %make dir
    end
    PPIdir = fullfile(maindir, 'Analysis', 'EV', subID, 'PPI.antloss'); %where EV files get dumped for 
    if ~exist (PPIdir)
        mkdir (PPIdir)
    end

    behavdir = fullfile(maindir, 'Analysis', 'behavior');

    datadir = fullfile(maindir, 'Data', subID, 'behavioral');  %where E-prime data lives
    %datadir = fullfile(maindir, 'behavioral');
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
    lossVnonloss_ant_time = [];     %7. regressor to be used for PPI
    
    
    gain_ant_dur = [];  %anticipation of potential gain, duration colummn
    loss_ant_dur = [];  %anticipation of potential loss, duration column
    neut_ant_dur = [];  %anticipation of not winning or losing, duration column
    antall_dur = [];       %anticipation for all trials (used in Outcome model), duration column
    nongain_ant_dur = [];
    nonloss_ant_dur = [];
    lossVnonloss_ant_dur = []; 
    
    lossVnonloss_ant_weight = [];
    lossandnonloss_ant_weight = [];
    
    %outcome regressors (8; 6 are used in Model5; 4 are used in Model4)
    gain_outcome_time = [];        %1. winning feedback, time column
    loss_outcome_time = [];        %2. losing feedback, time column
    neut_outcome_time = [];        %3. neither win nor lose, time column
    no_gain_outcome_time = [];     %4. nongain feedback during nongain trials, time column
    no_loss_outcome_time = [];     %5. nonloss feedback during nonloss trials, time column
    feedback_time = [];            %6. feedback phase (used in Anticipation model), time column
    unsucc_gain_time = [];         %7. didn't win - unsuccessful on gain trials, time column
    succ_avoid_loss_time = [];     %8. didn't lose - successfully avoided loss on loss trials, time column 
    
    
    gain_outcome_dur = [];    %winning feedback, duration column
    loss_outcome_dur = [];    %losing feedback, duration column
    neut_outcome_dur = [];    %neither win nor lose, duration column
    no_gain_outcome_dur = []; %didn't win, duration column
    no_loss_outcome_dur = []; %avoid losing, duration column
    feedback_dur = [];        %feedback phase (used in Anticipation model), duration column
    unsucc_gain_dur = [];     %didn't win - unsuccessful on gain trials, duration column
    succ_avoid_loss_dur = []; %didn't lose - successfully avoided loss on loss trials, duration column
    
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
    unsucc_gain_count = 0;
    succ_avoid_loss_count = 0;
    
    %rt
    gain_rt = []; %rt for all potential gain trials
    loss_rt = [];
    nongain_rt = [];
    nonloss_rt = [];
    
    %number of trials per trialtype(condition)
    antgain_count = 0; %should be 18 or 24
    antloss_count = 0; %should be 18 or 24
    antnongain_count = 0; %should be 18 or 12
    antnonloss_count = 0; %should be 18 or 12
    
    %%%condition types, identified by target image name:
    %%%1. sqr2 = you CAN lose 5 points
    %%%2. cir2 = you CAN win 5 points
    %%%3. sqr = you don't lose anything
    %%%4. cir = you don't win anything
    
    %looping through each trial
    for i = range  %i is the row, so trials are from row 4-75; 3:74 for 002
        
        if strcmp(raw{i,62},'dist_resized/cir2.bmp')  %if cir2
            antgain_count = antgain_count + 1;
        elseif strcmp(raw{i,62},'dist_resized/sqr2.bmp')  %if sqr2
            antloss_count = antloss_count + 1;
        elseif strcmp(raw{i,62},'dist_resized/cir.bmp')  %if cir
            antnongain_count = antnongain_count + 1;
        elseif strcmp(raw{i,62},'dist_resized/sqr.bmp')  %if sqr
            antnonloss_count = antnonloss_count + 1;
        end
               
        
        if isnan(raw{i,64}) == 1 && isnan(raw{i,50}) == 1 %if Tg.RESP (col BL, 64) = NaN (return TRUE) and Dly2.RESP (col AX, 50) = NaN, i.e., no button-press for trial
            missed_time = [missed_time (raw{i,44} - adjust)/1000]; 
            missed_dur = [missed_dur (raw{i+1,44}-raw{i,44})/1000]; %duration is entire length of trial
            missed_count = missed_count + 1;
            
        else
            
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
                    nongain_rt = [nongain_rt raw{i,65}];  %{'Tgt.RT';}
                else nongain_rt = [nongain_rt raw{i,66}+raw{i,51}];
                end
            else  %sqr, no loss (nonloss) 
                nonloss_ant_time = [nonloss_ant_time (raw{i,44} - adjust)/1000];
                nonloss_ant_dur = [nonloss_ant_dur (raw{i,63}-raw{i,44})/1000];
                no_loss_outcome_time = [no_loss_outcome_time (raw{i,54} - adjust)/1000];
                no_loss_outcome_dur = [no_loss_outcome_dur (raw{i+1,44}-raw{i,54})/1000];
                nonloss_count = nonloss_count + 1;
                lossVnonloss_ant_time = [lossVnonloss_ant_time (raw{i,44} - adjust)/1000]; %time for the PPI (ant nonloss)
                lossVnonloss_ant_dur = [lossVnonloss_ant_dur (raw{i,63}-raw{i,44})/1000]; %duration for the PPI (ant nonloss)
                lossVnonloss_ant_weight = [lossVnonloss_ant_weight -1];   %weight for the PPI (ant nonloss)
                lossandnonloss_ant_weight = [lossandnonloss_ant_weight 1]; 
                if raw{i,64} == 1 %if trial is successful
                    nonloss_succ = nonloss_succ + 1;
                    nonloss_rt = [nonloss_rt raw{i,65}];  %{'Tgt.RT';}
                else nonloss_rt = [nonloss_rt raw{i,66}+raw{i,51}];
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
                gain_rt = [gain_rt raw{i,65}];  %{'Tgt.RT';} 
            else   %if trial is unsuccessful, neutral or unsucc_gain
                unsucc_gain_time = [unsucc_gain_time (raw{i,54} - adjust)/1000];
                unsucc_gain_dur = [unsucc_gain_dur (raw{i+1,44}-raw{i,54})/1000];
                neut_outcome_time = [neut_outcome_time (raw{i,54} - adjust)/1000]; %col 54: {'fbk.OnsetTime';}
                neut_outcome_dur = [neut_outcome_dur (raw{i+1,44}-raw{i,54})/1000];
                unsucc_gain_count = unsucc_gain_count + 1;
                gain_rt = [gain_rt raw{i,66}+raw{i,51}];  %{'TgtDur[Trial]';} + {'Dly2.RT';}
            end
            
            %if condition is potential loss
        elseif strcmp(raw{i,62},'dist_resized/sqr2.bmp')  %if sqr2
            loss_ant_time = [loss_ant_time (raw{i,44} - adjust)/1000];
            loss_ant_dur = [loss_ant_dur (raw{i,63}-raw{i,44})/1000];
            lossVnonloss_ant_time = [lossVnonloss_ant_time (raw{i,44} - adjust)/1000]; %time for the PPI (ant gain)
            lossVnonloss_ant_dur = [lossVnonloss_ant_dur (raw{i,63}-raw{i,44})/1000]; %duration for the PPI (ant gain)
            lossVnonloss_ant_weight = [lossVnonloss_ant_weight 1];   %weight for the PPI (ant gain)
            lossandnonloss_ant_weight = [lossandnonloss_ant_weight 1]; 
            
            if raw{i,64} == 1  %if trial is successful, neutral or succ_avoid_loss outcome
                succ_avoid_loss_time = [succ_avoid_loss_time (raw{i,54} - adjust)/1000];
                succ_avoid_loss_dur = [succ_avoid_loss_dur (raw{i+1,44}-raw{i,54})/1000];
                neut_outcome_time = [neut_outcome_time (raw{i,54} - adjust)/1000]; %col 54: {'fbk.OnsetTime';}
                neut_outcome_dur = [neut_outcome_dur (raw{i+1,44}-raw{i,54})/1000];
                succ_avoid_loss_count = succ_avoid_loss_count + 1;
                lose_succ = lose_succ + 1;
                loss_rt = [loss_rt raw{i,65}];
            else  %if trial is unsuccessful, lose 5 points
                loss_outcome_time = [loss_outcome_time (raw{i,54} - adjust)/1000];
                loss_outcome_dur = [loss_outcome_dur (raw{i+1,44}-raw{i,54})/1000];
                lose_count = lose_count + 1;
                loss_rt = [loss_rt raw{i,66}+raw{i,51}];
            end
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
    missed_dur(find(isnan(missed_dur))) = 6.00;
    unsucc_gain_dur(find(isnan(unsucc_gain_dur))) = 1.51;
    succ_avoid_loss_dur(find(isnan(succ_avoid_loss_dur))) = 1.51;
    
    
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
    unsucc_gain_weight = ones(1,length(unsucc_gain_time))';
    succ_avoid_loss_weight = ones(1,length(succ_avoid_loss_time))'; 
    
    
    %if there are not 72 trials - all_weight is a vector of ones for how
    %many trials there are.
%     if strcmp(subID, '021') || strcmp(subID,'029')
%         all_weight = ones(1,70)';
%     else all_weight = ones(1,72)';
%     end
    
    %create 3-column arrays - concatenate time, dur, and weight vectors
    ant_all = [antall_time' antall_dur' ones(1,length(antall_time))']; %anticipation regressor 4 (collapsed across all conditions)
    feedback = [feedback_time' feedback_dur' ones(1,length(feedback_time))'];  %feedback/outcome regressor 6 (collapsed across all conditions)
    target = [target_time' target_dur' ones(1,length(target_time))']; %target nuissance regressor
    delay = [delay_time' delay_dur' ones(1,length(delay_time))']; %delay2 nuissance regressor (between target and feedback)
    
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
    unsucc_gain = [unsucc_gain_time' unsucc_gain_dur' unsucc_gain_weight]; %unsuccessful gain - didn't win regressor 7
    succ_avoid_loss = [succ_avoid_loss_time' succ_avoid_loss_dur' succ_avoid_loss_weight]; %successfully avoided loss - didn't lose regressor 8
    
    missed = [missed_time' missed_dur' missed_weight]; %nuisance regressor for missed trials 
    
    %PPI regressor for ant loss>nonloss
    ant_lossVnonloss = [lossVnonloss_ant_time' lossVnonloss_ant_dur' lossVnonloss_ant_weight']; 
    ant_loss_nonloss = [lossVnonloss_ant_time' lossVnonloss_ant_dur' lossandnonloss_ant_weight'];
    
    %calculate accuracy
    gain_acc = (gain_succ/antgain_count);
    lose_acc = (lose_succ/antloss_count);
    nongain_acc = (nongain_succ/antnongain_count);
    nonloss_acc = (nonloss_succ/antnonloss_count);
    total_acc = (gain_succ + lose_succ + nongain_succ + nonloss_succ)/(antgain_count + antloss_count + antnongain_count + antnonloss_count);
    missed_percent = missed_count/(antgain_count + antloss_count + antnongain_count + antnonloss_count);
    
    %write out text files into EV folder
    %cd(misseddir)
    cd(PPIdir)
    
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
    dlmwrite([subID '_unsucc_gain.txt'], unsucc_gain, 'delimiter','\t','newline','unix', 'precision', 7);
    dlmwrite([subID '_succ_avoid_loss.txt'], succ_avoid_loss, 'delimiter','\t','newline','unix', 'precision', 7);
    dlmwrite([subID '_ant_loss_V_nonloss.txt'], ant_lossVnonloss, 'delimiter','\t','newline','unix', 'precision', 7);
    dlmwrite([subID '_ant_loss_and_nonloss.txt'], ant_loss_nonloss, 'delimiter','\t','newline','unix', 'precision', 7);
  
    
end
cd(maindir)
