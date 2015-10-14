

cwd = pwd;
%maindir =  '/Users/sarabergman/Documents/STANFORD/FYP/KIDMID/Analysis/L1/Model4';
maindir = '/Users/sarabergman/Documents/ELS/KIDMID/Analysis/L1/PPI/RightNAcc.Model5.1_Nat';
roidir = '/Users/sarabergman/Documents/ELS/KIDMID/Analysis/ROI/PPI/RightNAcc.Model5.1_Nat';
sublist = {'001','002','004','006','009','010','012','013','014','016','017','022', ...
    '023','024','025','026','028','029','030','032','033','034','036','037','038','039','040','041','042', ...
    '045','046','047','048','049','050','054','055','056','058','059','060','061','062','064','065','067','068','069','070','072', ...
    '073','074','075','076','077','079','081','083','085','086','087','088','089','090','093','095', '097', '099','100'}; %n = 69
% sublist = {'006','009','012','013', '014','016', '017', '024', '025', '026', '028', '033', '034','039','040', '041', '042', '045', '046', '047', '048', '049', '050','054', '055', '056', ...
%     '057','058','059','060','061','062','064', '065', '067', '068', '069', '070', '072', '073', '074','075', '076', '077', '079', '081', '083', '085', '086','087', '088', ...
%     '089','090','093','095','097','099','100'};

B = [];

for s = 1:length(sublist)
    %sub = num2str(sublist(s));
    sub = sublist{s};
    
    %datadir = fullfile(maindir, [sub '.feat'], 'featquery_vmPFC.a.lnl.subjels');
    %cd (maindir)
    
    PEfile = fullfile(maindir,[sub '.feat'],'featquery_insulaPE.int','report.txt');
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
dlmwrite(['interaction_Rinsula_PEs_interactionterm' date '.csv'],C,'delimiter','\t','newline','unix', 'precision', 7);
cd(cwd)
% need to adjust text-to-columns after dlmwrite    
    
