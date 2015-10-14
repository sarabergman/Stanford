
maindir = '/Users/sarabergman/Documents/ELS/KIDMID/';

sublist = {'001','002','003','004', '005', '006', '009', '010', '013', '014','017','020', ...
    '021','022','023','024','025','026','028','030','031','033','034','035','036','037','038', ...
    '040','041','042','045','046','047','048','049','050','054','055','056','058','059','060','061','062',...
    '064','065','067','068','069','070','072','073','074','075','076','077','079','081','083','085', ...
    '087','088','090','093','095'};  %excluding 029

gain_mean = [];
nongain_mean = [];
gain_sd = [];
nongain_sd = [];
gain_mean3 = [];
nongain_mean3 = [];
gain_sd3 = [];
nongain_sd3 = [];


for p = 1:length(sublist)
    subID = sublist{p};
    
    tcdir = fullfile(maindir, 'Analysis', 'Images', subID, 'PS_MELODIC_FLIRT.feat', 'PPI_timecourses');
    cd(tcdir)
    
    load('ROI_peaks.mat')
    
    gain_mean = vertcat(gain_mean, mean(gain_lag2));
    
    gain_sd = vertcat(gain_sd, std(gain_lag2));
    
    nongain_mean = vertcat(nongain_mean, mean(nongain_lag2));
    
    nongain_sd = vertcat(nongain_sd, std(nongain_lag2));
    
    gain_mean3 = vertcat(gain_mean3, mean(gain_lag3));
    
    gain_sd3 = vertcat(gain_sd3, std(gain_lag3));
    
    nongain_mean3 = vertcat(nongain_mean3, mean(nongain_lag3));
    
    nongain_sd3 = vertcat(nongain_sd3, std(nongain_lag3));
    
end
    
cd('/Users/sarabergman/Documents/ELS/KIDMID/Notes/presentations/ASEM2015')
csvwrite(['antgain_peaks_2TRlag' date '.csv'], gain_mean);   
csvwrite(['antgain_peaks_3TRlag' date '.csv'], gain_mean3);
csvwrite(['antnongain_peaks_2TRlag' date '.csv'], nongain_mean);   
csvwrite(['antnongain_peaks_3TRlag' date '.csv'], nongain_mean3);
    
    
