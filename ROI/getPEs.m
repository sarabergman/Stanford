cwd = pwd;
%maindir =  '/Users/sarabergman/Documents/STANFORD/FYP/KIDMID/Analysis/L1/Model4';
maindir = '/Users/sarabergman/Documents/ELS/KIDMID/Analysis/L1/Model5.2';
roidir = '/Users/sarabergman/Documents/ELS/KIDMID/Analysis/ROI/84N_ELS';
sublist = {'001','002','003','004', '005', '006','009','010','012','013','014','016','017', ...
    '021','022','023','024','025','026','028','029','030','031','033','034','035','036','037','038','040','041','042', ...
    '045','046','047','048','049','050','054','055','056','058','059','060','061','062','064','065','067','068','069','070','072', ...
    '073','074','075','076','077','079','081','083','085','086','087','088','089','090','091','093','095','097','098','099','100','102','103', ...
    '106','107','108','112','113','114','116','121'};
table_ant = [];
table_out = [];
d = [];

for s = 1:length(sublist)
    %sub = num2str(sublist(s));
    sub = sublist{s};
    
    B = [];
    cd (maindir)
    
    %PElist_ant = {'Lamy', 'Ramy', 'LHipp', 'RHipp','Lput', 'Rput', 'Lcaud','Rcaud','Rpall','Lins','Rins'}; %11 directories
    %PElist_ant = {'Lput', 'Lcaud','Lins','Lpall','Rput','Rcaud','Rins', 'Rpall'};
    PElist_out = {'Lput', 'Lcaud','Lins','Lpall'};
    
    for f = 1:length(PElist_out)
        fdir = PElist_out{f};
        
        PEhor = [];
        PEfile = fullfile(maindir,[sub '.feat'],['featquery_' fdir '_outcome'],'report.txt');
        A = importdata(PEfile);
        PEs = A.data(:,4);
        PEFlip = PEs';
        PEhor = [PEhor PEFlip];
        B = [B PEhor];
        %imports the first 2 elements as textdata, e_g_, textdata: {'1'  'stats/pe26'}
        %imports the other elements as data, e_g, data: [128 -2_2560 -0_6702 -0_2925 -0_2394 0_2140 0_5081 0_4547 45 40 18 35_9000 -0_3000 -1_6000]
        %the 4th element is the mean
        %stdevs = A_data(:,8);  maybe use this another time ___
    end
    
    table_out = vertcat(table_out,B); 
  
end
cd(fullfile(roidir))
table = vertcat(d,table_out);
csvwrite(['featquery_outcome' date '.csv'],table_out)
%csvwrite(['featquery_anticipation_test' date '.csv'],table)
%export(table,'File',['featquery_anticipation' date '.csv'],'Delimiter',',');
% 

% % header = {'Lamy_gain','Lamy_nongain','Lamy_loss','Lamy_nonloss','Ramy_gain','Ramy_nongain','Ramy_loss','Ramy_nonloss',...
% %     'LHipp_gain','LHipp_nongain','LHipp_loss','LHipp_nonloss','RHipp_gain','RHipp_nongain','RHipp_loss','RHipp_nonloss',...
% %     'Lput_gain','Lput_nongain','Lput_loss','Lput_nonloss','Rput_gain','Rput_nongain','Rput_loss','Rput_nonloss','Lcaud_gain',...
% %     'Lcaud_nongain','Lcaud_loss','Lcaud_nonloss','Rcaud_gain','Rcaud_nongain','Rcaud_loss','Rcaud_nonloss','Rpall_gain',...
% %     'Rpall_nongain','Rpall_loss','Rpall_nonloss','Lins_gain','Lins_nongain','Lins_loss','Lins_nonloss','Rins_gain','Rins_nongain'...
% %     'Rins_loss','Rins_nonloss'};
% header = {'Lput_gain','Lput_nongain','Lput_loss','Lput_nonloss','Lcaud_gain','Lcaud_nongain','Lcaud_loss','Lcaud_nonloss','Lins_gain',...
%     'Lins_nongain','Lins_loss','Lins_nonloss','Rput_gain','Rput_nongain','Rput_loss','Rput_nonloss','Rcaud_gain','Rcaud_nongain','Rcaud_loss','Rcaud_nonloss',...
%     'Rins_gain','Rins_nongain','Rins_loss','Rins_nonloss'};
% anticipation_PE = dataset({table_ant,header{:}});
% 

% 
% for s = 1:length(sublist)
%     %sub = num2str(sublist(s));
%     sub = sublist{s};
%     
%     C = [];
%     PElist_outcome = {'Lput', 'Lcaud'}; %4 directories
%     %
%     for f = 1:length(PElist_outcome)
%         fdir = PElist_outcome{f};
%         
%         PEhor = [];
%         PEfile = fullfile(maindir,[sub '.feat'],['featquery_' fdir '_outcome'],'report.txt');
%         A = importdata(PEfile);
%         PEs = A.data(:,4);
%         PEFlip = PEs';
%         PEhor = [PEhor PEFlip];
%         C = [C PEhor];
%         %imports the first 2 elements as textdata, e_g_, textdata: {'1'  'stats/pe26'}
%         %imports the other elements as data, e_g, data: [128 -2_2560 -0_6702 -0_2925 -0_2394 0_2140 0_5081 0_4547 45 40 18 35_9000 -0_3000 -1_6000]
%         %the 4th element is the mean
%         %stdevs = A_data(:,8);  maybe use this another time
%     end
%     table_out = vertcat(table_out,C);
%     
% end
% % header = {'Lput_gain','Lput_nongain','Lput_loss','Lput_nonloss','Lcaud_gain','Lcaud_nongain','Lcaud_loss','Lcaud_nonloss',...
% %     'Lpall_gain','Lpall_nongain','Lpall_loss','Lpall_nonloss','Lins_gain','Lins_nongain','Lins_loss','Lins_nonloss'};
% 
% header = {'Lput_gain','Lput_nongain','Lput_loss','Lput_nonloss','Lcaud_gain','Lcaud_nongain','Lcaud_loss','Lcaud_nonloss'};
% 
% outcome_PE = dataset({table_out,header{:}});
% 
% cd(fullfile(roidir))
% export(outcome_PE,'File',['featquery_outcome' date '.csv'],'Delimiter',',');

