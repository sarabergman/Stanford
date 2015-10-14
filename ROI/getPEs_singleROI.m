cwd = pwd;
%maindir =  '/Users/sarabergman/Documents/STANFORD/FYP/KIDMID/Analysis/L1/Model4';
maindir = '/Users/sarabergman/Documents/ELS/KIDMID/Analysis/L1/Model5.1';
roidir = '/Users/sarabergman/Documents/ELS/KIDMID/Analysis/ROI/70N_Model5.1';
sublist = {'001','002','003','004','005','006','009','010','012','013','014','016','017', ... 
    '021','022','023','024','025','026','028','029','031','033','034','035','036','037','038','040','041','042', ...
    '045','047','048','049','050','054','055','056','058','059','060','061','062','064','065','067','068','069','070','072', ...
    '073','074','075','076','077','079','081','083','085','086','087','088','089','090','093','095','097','099','100'}; %n=70
B = [];

for s = 1:length(sublist)
    %sub = num2str(sublist(s));
    sub = sublist{s};
    
    %datadir = fullfile(maindir, [sub '.feat'], 'featquery_vmPFC.a.lnl.subjels');
    %cd (maindir)
    
    PEfile = fullfile(maindir,[sub '.feat'],'featquery_vmPFC_anticipation','report.txt');
    A = importdata(PEfile);
    
    PEs = A.data(:,4);
    %imports the first 2 elements as textdata, e.g., textdata: {'1'  'stats/pe26'}
    %imports the other elements as data, e.g, data: [128 -2.2560 -0.6702 -0.2925 -0.2394 0.2140 0.5081 0.4547 45 40 18 35.9000 -0.3000 -1.6000]
    %the 4th element is the mean 
    %stdevs = A.data(:,8);  maybe use this another time ...
    
    B = [B PEs];
    C = B';
    %D = [sublist' B'];
    
    
end

cd(fullfile(roidir))
dlmwrite(['Model5.1_vmpfc' date '.csv'],C,'delimiter','\t','newline','unix', 'precision', 7);
cd(cwd)
% need to adjust text-to-columns after dlmwrite    
    