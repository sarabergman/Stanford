%function count_trials(subID)
dir = pwd;

%fix this.
subID = '021';

maindir = '/Users/sarabergman/Documents/ELS/KIDMID/';

%sublist = {'001','002','003','004', '005', '006', '007', '009', '010', '011', '012', '013', '014', '015','016'};

% for s = 1:length(sublist)
%     subID = sublist{s};

subID = num2str(subID);

evdir = fullfile(maindir, 'Analysis', 'EV', subID);

cd(evdir)

ant_all_ev = load([subID '_ant_all.txt']);
ant_gain_ev = load([subID '_ant_gain.txt']);
ant_loss_ev = load([subID '_ant_loss.txt']);
ant_neut_ev = load([subID '_ant_neut.txt']);
delay_ev = load([subID '_delay_all.txt']);
gain_outcome_ev = load([subID '_gain.txt']);
loss_outcome_ev = load([subID '_loss.txt']);
nongain_ev = load([subID '_nongain.txt']);
nonloss_ev = load([subID '_nonloss.txt']);
outcome_all_ev = load([subID '_outcome_all.txt']);
neutral_outcome_ev = load([subID '_outcome_neutral.txt']);
target_ev = load([subID '_target_all.txt']);


%evcount = cell(length(sublist),11);

gain = length(gain_outcome_ev);
loss = length(loss_outcome_ev);
neutral = length(neutral_outcome_ev);
nongain = length(nongain_ev);
nonloss = length(nonloss_ev);
ant_gain = length(ant_gain_ev);
ant_loss = length(ant_loss_ev);
ant_neutral = length(ant_neut_ev);
target = length(target_ev);
delay = length(delay_ev);
ant_all = length(ant_all_ev);
outcome_all = length(outcome_all_ev);

row = [gain loss neutral nongain nonloss ant_gain ant_loss ant_neutral target delay ant_all outcome_all]
%     row
%     evcount = vertcat(evcount,row);

cd(dir)





