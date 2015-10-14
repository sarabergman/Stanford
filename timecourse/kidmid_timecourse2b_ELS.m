%timecourse data for all cue conditions across '0','+2','+4','+6','+8','+10','+12','+14','+16' where 0 is the TR
%coinciding with the cue presentation, 

clear all

maindir = '/Users/sarabergman/Documents/ELS/KIDMID/';

%sublist = {'046'};
%high ELS
% sublist = {'006','009','014','024','025','040','042', ...
%     '045','046','050','054','060','061','064','065','067','068','069', ...
%     '070','075','077','086','089','090','093','097','099'};

%low ELS
sublist = {'012', '013','016','017','026','028','033','039','041',...
   '047','048','049','055','056','058','062', ...
    '072','073','074','076','079','081','083','085','087','088','095','100'};

%problem with 034 native timecourse

all_antgain = [];
all_antloss = [];
all_antnongain = [];
all_antnonloss = [];


for p = 1:length(sublist)
    subID = sublist{p};
    
    tcdir = fullfile(maindir, 'Analysis', 'Images', subID, 'PS_MELODIC_FLIRT.feat', 'PPI_timecourses');
    cd(tcdir)
    
    load('tNacc.mat')
    
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
            ant(j).gain = [tNacc(i-1,3), tNacc(i,3), tNacc(i+1,3), tNacc(i+2,3), tNacc(i+3,3), tNacc(i+4,3),tNacc(i+5,3), tNacc(i+6,3), tNacc(i+7,3), tNacc(i+8,3)];   
            %insert tar and out structures
            j = j + 1;
        elseif tNacc(i,2) == 1.2
            ant(k).loss = [tNacc(i-1,3), tNacc(i,3), tNacc(i+1,3), tNacc(i+2,3), tNacc(i+3,3), tNacc(i+4,3),tNacc(i+5,3), tNacc(i+6,3), tNacc(i+7,3), tNacc(i+8,3)];     
            k = k + 1;
        elseif tNacc(i,2) == 1.3
            ant(l).nongain = [tNacc(i-1,3), tNacc(i,3), tNacc(i+1,3), tNacc(i+2,3), tNacc(i+3,3), tNacc(i+4,3),tNacc(i+5,3), tNacc(i+6,3), tNacc(i+7,3), tNacc(i+8,3)]; 
            l = l + 1;
        elseif tNacc(i,2) == 1.4 
            ant(m).nonloss = [tNacc(i-1,3), tNacc(i,3), tNacc(i+1,3), tNacc(i+2,3), tNacc(i+3,3), tNacc(i+4,3),tNacc(i+5,3), tNacc(i+6,3), tNacc(i+7,3), tNacc(i+8,3)]; 
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
    
    save('tNacc_ant.mat', 'antgain','antloss','antnongain','antnonloss') 
    
    all_antgain = vertcat(all_antgain,antgain);
    all_antnongain = vertcat(all_antnongain,antnongain);
    all_antnonloss = vertcat(all_antnonloss,antnonloss);
    all_antloss = vertcat(all_antloss,antloss);

end

%header = {'-2','0','+2','+4','+6','+8'};
%get mean, sd, standard error for every condition at each time point    
antgain_mean = [];
antgain_sd = [];
antgain_sem = [];

antloss_mean = [];
antloss_sd = [];
antloss_sem = [];

antnongain_mean = [];
antnongain_sd = [];
antnongain_sem = [];

antnonloss_mean = [];
antnonloss_sd = [];
antnonloss_sem = [];

for w = 1:size(all_antgain,2) %for every column
    antgain_mean = [antgain_mean mean(all_antgain(:,w))];
    antgain_sd = [antgain_sd std(all_antgain(:,w))];
end

for w = 1:size(all_antloss,2) %for every column
    antloss_mean = [antloss_mean mean(all_antloss(:,w))];
    antloss_sd = [antloss_sd std(all_antloss(:,w))];
end
        
for w = 1:size(all_antnongain,2) %for every column
    antnongain_mean = [antnongain_mean mean(all_antnongain(:,w))];
    antnongain_sd = [antnongain_sd std(all_antnongain(:,w))];
end

for w = 1:size(all_antnonloss,2) %for every column
    antnonloss_mean = [antnonloss_mean mean(all_antnonloss(:,w))];
    antnonloss_sd = [antnonloss_sd std(all_antnonloss(:,w))];
end        

antgain_sem = antgain_sd/sqrt(length(all_antgain)); %compute standard error of the mean
antloss_sem = antloss_sd/sqrt(length(all_antloss));
antnongain_sem = antnongain_sd/sqrt(length(all_antnongain));
antnonloss_sem = antnonloss_sd/sqrt(length(all_antnonloss));

ant = vertcat(antgain_mean,antloss_mean,antnongain_mean,antnonloss_mean);
ant_sem = vertcat(antgain_sem,antloss_sem,antnongain_sem,antnonloss_sem);

statsdir = fullfile(maindir, 'scripts','timecourse');
cd(statsdir)
csvwrite(['timecourse_native_NAcc_ant_all_16_loELS' date '.csv'], ant);
csvwrite(['timecourse_native_NAcc_ant_sem_16_loELS' date '.csv'], ant_sem);

% csvwrite(['timecourse_native_NAcc_antgain' date '.csv'], all_antgain);
% csvwrite(['timecourse_native_NAcc_antloss' date '.csv'], all_antloss);
% csvwrite(['timecourse_native_NAcc_antnongain' date '.csv'], all_antnongain);
% csvwrite(['timecourse_native_NAcc_antnonloss' date '.csv'], all_antnonloss);    

