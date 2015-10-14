maindir = pwd;

% sublist = {'001','002','003','004', '005', '006', '009', '010', '011', '012', '013', '014', '015','016', '017', '018','019','020', ...
%     '021','022','023','024','025','026','028','029','030','031','032','033','034','035','036','037','038','039','040','041','042', ...
%     '043','045','046','047','048','049','050','051','053','054','055','056','057','058','059','060','061','062','064','065','067','068','069', ...
%     '070','072','074','075','076','077','079','081','083','085','086','087','088','089','090','092','093','095','097','098','099','100', ...
%     '101','102','103','104','107'};  
sublist = {'091','106','108','112','113','114','116','121'};   % '073'
for s = 1:length(sublist)
    subID = sublist{s};
    
    
    imagedir = '/Users/sarabergman/Documents/ELS/KIDMID/Analysis/Images';
    %imagedir = '/Volumes/ELS/KIDMID/Analysis/Images';
    datadir = fullfile(imagedir, num2str(subID),'PS_MELODIC_FLIRT.feat');
    cd(datadir)
    badtimepoints = fullfile(datadir,'bad_timepoints.txt');
    MOTIONconfoundevs = fullfile(datadir,'MOTIONconfoundevs.txt');
    
    a = textread(badtimepoints);  %with textread, a column of 0s gets appended to the last column.
    size1 = size(a);
    cols = size1(2); %number of columns
    Badtime = a(:, 1:(cols-1)); %delete the last column
    
    b = textread(MOTIONconfoundevs);
    
    b1 = b(:,1);
    b2 = b(:,2);
    b3 = b(:,3);
    b4 = b(:,4);
    b5 = b(:,5);
    b6 = b(:,6);
    
    finalconfoundfile = [Badtime b1 b2 b3 b4 b5 b6];
    dlmwrite('new_motion_and_outlier_confounds.txt', finalconfoundfile, 'delimiter','\t','newline','unix','precision', 7);
end
cd(maindir)