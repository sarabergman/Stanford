% allsubs_behavior.m compiles the behavioral output of from make3column_nomissed.m for every subject.
% The output of this script can be used for behavioral analysis of response
% time, accuracy, and trial counts in R.

%maindir = '/Users/sarabergman/Documents/ELS/KIDMID/';
maindir = '/Volumes/ELS/KIDMID';

behavdir = fullfile(maindir, 'Analysis', 'behavior');

table = [];

sublist = {'001','002','003','004', '005', '006', '008', '009', '010', '011', '012', '013', '014', '015','016', '017', '018','019','020', ...
    '021','022','023','024','025','026','028','029','030','031','032','033','034','035','036','037','038','039','040','041','042', ...
    '043','045','046','047','048','049','050','051','054','055','056','058','059','060','061','062','064','065','067','068','069','070','072', ...
    '074','075','076','077','079','081','083','085','086','087','088','093','095'};  % '057' - check on this subject; included in Model4
                                                                               % '073' - not included, decide whether including

for s = 1:length(sublist)
    subID = sublist{s};

    cd (behavdir)
    load([subID '_behavior_summary.mat']);
    behav = behavior{1,1};


    table = vertcat(table,behav);
end

export(table,'File',['all_behavior_' date '.csv'],'Delimiter',',');
% export(table,'XLSFile',['all_behavior_' date '.xlsx']);

