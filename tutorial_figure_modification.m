%% load test data
clear;
close all
S = load('./TestData.mat');
COI = 36; % C3 (Left sensorimotor cortex)
%% get parameter
Fs = S.EEGSamplingRate;
signal = double(S.testData005mff(COI,:))';
range_time = cell2mat(S.evt_255_DINs(2,:));
%% Preprocessing
signal = preprocess_eeg(signal,Fs);
signal = signal(range_time(1)+1:range_time(2));
%% plain
start = 14;
finish = 15;
range_of_interest = start*Fs+1:finish*Fs;
figure;
plot(signal(range_of_interest))
%% call ModifyFigure
modify_figure = ModifyFigure;
time = modify_figure.get_time(signal,Fs);
time_interest = time(range_of_interest);
%% plot again
modify_figure.figure;
modify_figure.plot(time_interest,signal(range_of_interest));
modify_figure.main();
%% visualize config
modify_figure.get_list_config;
%% change config
modify_figure.set_config('Color','r');
%% plot again (again)
modify_figure.figure;
modify_figure.plot(time_interest,signal(range_of_interest));
modify_figure.main();
%% save figure
save_figure = SaveFigure;
save_figure.save_current_figure();


