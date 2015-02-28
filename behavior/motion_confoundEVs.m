function motion_confoundEVs(subID)
maindir = pwd;

%% old script, used at Duke
%
% for r = firstrun:endrun
%     
%     maindir = '/Users/sarabergman/Documents/STANFORD/FYP/KIDMID/Analysis/Images';
%     datadir = fullfile(maindir, num2str(subID),'PS_MELODIC_FLIRT.feat');
%     cd(datadir)
%     badtimepoints = fullfile(datadir,'bad_timepoints.txt');
%     MOTIONconfoundevs = fullfile(datadir,'MOTIONconfoundevs.txt');
%     
%     a = textread(badtimepoints);
%     b = textread(MOTIONconfoundevs);
%     
%     b1 = b(:,1);
%     b2 = b(:,2);
%     b3 = b(:,3);
%     b4 = b(:,4);
%     b5 = b(:,5);
%     b6 = b(:,6);
%     
%     c1 = [];
%     c2 = [];
%     c3 = [];
%     c4 = [];
%     c5 = [];
%     c6 = [];
%     
%     for i = 1:length(b1)
%         c1 = [c1 b1(i)^2];
%     end
%     for i = 1:length(b2)
%         c2 = [c2 b2(i)^2];
%     end
%     for i = 1:length(b3)
%         c3 = [c3 b3(i)^2];
%     end
%     for i = 1:length(b4)
%         c4 = [c4 b4(i)^2];
%     end
%     for i = 1:length(b5)
%         c5 = [c5 b5(i)^2];
%     end
%     for i = 1:length(b6)
%         c6 = [c6 b6(i)^2];
%     end
%     
%     c1 = c1';
%     c2 = c2';
%     c3 = c3';
%     c4 = c4';
%     c5 = c5';
%     c6 = c6';
%     
%     finalmotion = [a b1 b2 b3 b4 b5 b6 c1 c2 c3 c4 c5 c6];
%     dlmwrite('badtime12motionevs.txt', finalmotion, 'delimiter','\t','newline','unix','precision', 7);
%     
% end
%%

%%%new script, for FYP

%imagedir = '/Users/sarabergman/Documents/ELS/KIDMID/Analysis/Images';
imagedir = '/Volumes/ELS/KIDMID/Analysis/Images';
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

cd(maindir)