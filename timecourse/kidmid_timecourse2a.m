%timecourse data for all cue conditions across '-2','0','+2','+4','+6','+8', where 0 is the TR
%coinciding with the cue presentation


clear all

maindir = '/Users/sarabergman/Documents/ELS/KIDMID/';

%sublist = {'046'};
sublist = {'006','009','012', '013','014','016','017','024','025','026','028','033','039','040','041','042', ...
    '045','046','047','048','049','050','054','055','056','058','060','061','062','064','065','067','068','069', ...
    '070','072','073','074','075','076','077','079','081','083','085','086','087','088','089','090','093','095','097','099','100'};

%problem with 034 native timecourse

all_antgain = [];
all_antloss = [];
all_antnongain = [];
all_antnonloss = [];

antgain4 = [];
antgain6 = [];
antgain8 = [];

antloss4 = [];
antloss6 = [];
antloss8 = [];


for p = 1:length(sublist)
    subID = sublist{p};
    
    tcdir = fullfile(maindir, 'Analysis', 'Images', subID, 'PS_MELODIC_FLIRT.feat', 'PPI_timecourses');
    cd(tcdir)
    
    load('tNacc_mni.mat')
    
    signal = tNacc(:,1); %signal is the first column, all 246 timepoints
    m = mean(signal); %calculate mean signal 
    sc = (signal - m) / 100; % % calculate signal change 
    
    tNacc = [tNacc sc]; %append sc to tNacc

%     antgain = [];
%     antgainlag = struct;
    j = 1;
    k = 1;
    l = 1;
    m = 1;
    for i = 1:length(tNacc) %loop thru volumes
%    ant = struct;
   
        if tNacc(i,2) == 1.1
            ant(j).gain = [tNacc(i-1,3), tNacc(i,3), tNacc(i+1,3), tNacc(i+2,3), tNacc(i+3,3), tNacc(i+4,3)];   
            %insert tar and out structures
            j = j + 1;
        elseif tNacc(i,2) == 1.2
            ant(k).loss = [tNacc(i-1,3), tNacc(i,3), tNacc(i+1,3), tNacc(i+2,3), tNacc(i+3,3), tNacc(i+4,3)];    
            k = k + 1;
        elseif tNacc(i,2) == 1.3
            ant(l).nongain = [tNacc(i-1,3), tNacc(i,3), tNacc(i+1,3), tNacc(i+2,3), tNacc(i+3,3), tNacc(i+4,3)];
            l = l + 1;
        elseif tNacc(i,2) == 1.4 
            ant(m).nonloss = [tNacc(i-1,3), tNacc(i,3), tNacc(i+1,3), tNacc(i+2,3), tNacc(i+3,3), tNacc(i+4,3)];
            m = m + 1;
        end   
    end
    
    antgain = [];
    antloss = [];
    antnongain = [];
    antnonloss = [];
    for a = 1:length(ant)
        antgain = vertcat(antgain,ant(a).gain);
        antloss = vertcat(antloss,ant(a).loss);
        antnongain = vertcat(antnongain,ant(a).nongain);
        antnonloss = vertcat(antnonloss,ant(a).nonloss);
    end
    
    %save('tNacc_ant.mat', 'antgain','antloss','antnongain','antnonloss') 
    

    antgain4 = [antgain4 mean(antgain(:,4))];
    antgain6 = [antgain6 mean(antgain(:,5))];
    antgain8 = [antgain8 mean(antgain(:,6))];
    
    antloss4 = [antloss4 mean(antloss(:,4))];
    antloss6 = [antloss6 mean(antloss(:,5))];
    antloss8 = [antloss8 mean(antloss(:,6))];
  
    
    all_antgain = vertcat(all_antgain,antgain);
    all_antnongain = vertcat(all_antnongain,antnongain);
    all_antnonloss = vertcat(all_antnonloss,antnonloss);
    all_antloss = vertcat(all_antloss,antloss);

    
end

antgain4 = antgain4';
antgain6 = antgain6';
antgain8 = antgain8';
antloss4 = antloss4';
antloss6 = antloss6';
antloss8 = antloss8';

%header = {'-2','0','+2','+4','+6','+8'};
%get mean, sd, standard error for every condition at each time point    
% antgain_mean = [];
% antgain_sd = [];
% antgain_sem = [];
% 
% antloss_mean = [];
% antloss_sd = [];
% antloss_sem = [];
% 
% antnongain_mean = [];
% antnongain_sd = [];
% antnongain_sem = [];
% 
% antnonloss_mean = [];
% antnonloss_sd = [];
% antnonloss_sem = [];
% 
% for w = 1:size(all_antgain,2) %for every column
%     antgain_mean = [antgain_mean mean(all_antgain(:,w))];
%     antgain_sd = [antgain_sd std(all_antgain(:,w))];
% end
% 
% for w = 1:size(all_antloss,2) %for every column
%     antloss_mean = [antloss_mean mean(all_antloss(:,w))];
%     antloss_sd = [antloss_sd std(all_antloss(:,w))];
% end
%         
% for w = 1:size(all_antnongain,2) %for every column
%     antnongain_mean = [antnongain_mean mean(all_antnongain(:,w))];
%     antnongain_sd = [antnongain_sd std(all_antnongain(:,w))];
% end
% 
% for w = 1:size(all_antnonloss,2) %for every column
%     antnonloss_mean = [antnonloss_mean mean(all_antnonloss(:,w))];
%     antnonloss_sd = [antnonloss_sd std(all_antnonloss(:,w))];
% end        
% 
% antgain_sem = antgain_sd/sqrt(length(all_antgain)); %compute standard error of the mean
% antloss_sem = antloss_sd/sqrt(length(all_antloss));
% antnongain_sem = antnongain_sd/sqrt(length(all_antnongain));
% antnonloss_sem = antnonloss_sd/sqrt(length(all_antnonloss));
% 
% ant = vertcat(antgain_mean,antloss_mean,antnongain_mean,antnonloss_mean);
% ant_sem = vertcat(antgain_sem,antloss_sem,antnongain_sem,antnonloss_sem);
% 
% % statsdir = fullfile(maindir, 'scripts','timecourse');
% % cd(statsdir)
% % csvwrite(['timecourse_native_NAcc_ant_all' date '.csv'], ant);
% % csvwrite(['timecourse_native_NAcc_ant_sem' date '.csv'], ant_sem);
% 
% % csvwrite(['timecourse_native_NAcc_antgain' date '.csv'], all_antgain);
% % csvwrite(['timecourse_native_NAcc_antloss' date '.csv'], all_antloss);
% % csvwrite(['timecourse_native_NAcc_antnongain' date '.csv'], all_antnongain);
% % csvwrite(['timecourse_native_NAcc_antnonloss' date '.csv'], all_antnonloss);    

