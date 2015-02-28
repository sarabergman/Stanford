%subID = '001';
maindir = '/Users/sarabergman/Documents/ELS/KIDMID/';

%sublist = {'001','002','003','004', '005', '006', '008', '009', '010', '011', '012', '013', '014', '015','016', '017', '018', '021'};
 sublist = {'021'};

RT_all = [];
accuracy_all = [];

for s = 1:length(sublist)
    subID = sublist{s};
    
    rtdir = fullfile(maindir, 'Analysis', 'RT');
    if ~exist (rtdir)
        mkdir (rtdir)
    end
    
    %cd ~
    %cd(maindir)
    datadir = fullfile(maindir, 'Data', subID, 'behavioral');
    cd(datadir)
    
    [num,txt,raw] = xlsread(['kidmid_behavior_' subID '.xlsx']);  %load in data;
    %%% this loads 3 diff variables in the workspace named 'num', 'txt',
    %%% and 'raw' which each represent the data file in a different format.
    %%% We're going to use 'raw', which looks closest to the Excel file.
    
    gain_rt = []; %rt for all potential gain trials
    loss_rt = [];
    nongain_rt = [];
    nonloss_rt = [];
    
    gain_succ = []; %for counting accuracy rates
    loss_succ = [];
    nongain_succ = [];
    nonloss_succ = [];
    missed = []; %for missed trials 
    
%     s_counter = s_counter + 1;
    
    if strcmp(subID,'002')
        trigtime = raw{2,41};
        range = 3:74;
    elseif strcmp(subID, '021') || strcmp(subID,'029')
        range = 4:73;  %only 70 trials
        trigtime = raw{3,41};
    else
        trigtime = raw{3,41};  %trigtime  raw{3,41}; raw{2,41} for 002
        range = 4:75; %columns
    end
    
    for i = range
        if (raw{i,65}) + (raw{i,51}) == 0
           missed = [missed i];
        end
        
        if strcmp(raw{i,62},'dist_resized/cir2.bmp')  %if cir2,  %if condition is potential win
            if raw{i,64} == 1  %if button press before target offset (Tgt.RESP)
                gain_rt = [gain_rt raw{i,65}];  %{'Tgt.RT';}
                gain_succ = [gain_succ i]; %record trial number of accurate trials
            elseif raw{i,50} == 1  %if button press after target offset
                gain_rt = [gain_rt raw{i,66}+raw{i,51}];  %{'TgtDur[Trial]';} + {'Dly2.RT';}
            end
        elseif strcmp(raw{i,62},'dist_resized/sqr2.bmp') %if sqr2,  %if condition is potential loss
            if raw{i,64} == 1  %if button press before target offset (Tgt.RESP)
                loss_rt = [loss_rt raw{i,65}];
                loss_succ = [loss_succ i];
            elseif raw{i,50} == 1 %if button press after target offset
                loss_rt = [loss_rt raw{i,66}+raw{i,51}];
            end
        elseif strcmp(raw{i,62},'dist_resized/sqr.bmp') %if potential nonloss
            if raw{i,64} == 1  %if button press before target offset (Tgt.RESP)
                nonloss_rt = [nonloss_rt raw{i,65}];  %{'Tgt.RT';}
                nonloss_succ = [nonloss_succ i];
            elseif raw{i,50} == 1 %if button press after target offset
                nonloss_rt = [nonloss_rt raw{i,66}+raw{i,51}];
            end
        elseif strcmp(raw{i,62},'dist_resized/cir.bmp') %if potential nongain
            if raw{i,64} == 1  %if button press before target offset (Tgt.RESP)
                nongain_rt = [nongain_rt raw{i,65}];  %{'Tgt.RT';}
                nongain_succ = [nongain_succ i];
            elseif raw{i,50} == 1 %if button press after target offset
                nongain_rt = [nongain_rt raw{i,66}+raw{i,51}];
            end
        end
        
    end
    
%     rt_header = {'gainRT', 'lossRT', 'nongainRT', 'nonlossRT'};
%     responsetime = zeros(18,4);
%     responsetime(1:length(gain_rt),1) = gain_rt;
%     responsetime(1:length(loss_rt),2) = loss_rt;
%     responsetime(1:length(nongain_rt),3) = nongain_rt;
%     responsetime(1:length(nonloss_rt),4) = nonloss_rt;
%     responsetime = dataset({responsetime,rt_header{:}});
%     
%     missed_check = sum(~responsetime.gainRT) + sum(~responsetime.lossRT) + sum(~responsetime.nongainRT) + sum(~responsetime.nonlossRT);
%     
%     acc_header = {'gain_succ', 'loss_succ', 'nongain_succ' 'nonloss_succ', 'missed', 'missed_check'};
%     accuracy = [length(gain_succ) length(loss_succ) length(nongain_succ) length(nonloss_succ), length(missed), missed_check];
%     accuracy = dataset({accuracy,acc_header{:}});
%     
%     cd(rtdir)
% 
%     behavior_sub = cell(1,2);
%     behavior_sub{1} = responsetime;
%     behavior_sub{2} = accuracy;
%     
%     RT_all = [RT_all; behavior_sub{1}];
%     accuracy_all = [accuracy_all; behavior_sub{2}];
%     
% 
%     output1 = fullfile(rtdir, [subID '_behavior_summary.mat']);
%     save(output1, 'behavior_sub')
%     
%     
%      
end

% behavior_all 

% output2 = fullfile(rtdir, 'all_RT_summary.mat');
% save(output2, 'RT_all')
% 
% output3 = fullfile(rtdir, 'all_accuracy_summary.mat');
% save(output3, 'accuracy_all')
% 
% csvwrite(['RT_' num2str(length(sublist)) 'subjects' date '.csv'], RT_all,0,1);
% csvwrite(['accuracy_' num2str(length(sublist)) 'subjects' date '.csv'], accuracy_all,0,1);
