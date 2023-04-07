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
%%
modify_figure = ModifyFigure;
time = modify_figure.get_time(signal,Fs);
time_interest = time(range_of_interest);
%%
modify_figure.figure;
modify_figure.plot(time_interest,signal(range_of_interest));
modify_figure.main()
%%
modify_figure.get_list_config;
%%
modify_figure.set_config('Color','r');

