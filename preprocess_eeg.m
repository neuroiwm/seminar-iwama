function signal_out = preprocess_eeg(signal_in,Fs)
%% config_preproc;
range_band = [3 70];
freq_notch = 50;
[bpb,bpa] = butter(3,range_band/(Fs/2),'bandpass');
[ncb,nca] = butter(3,[freq_notch-1 freq_notch+1]/(Fs/2),'stop');
%% filtering
signal_out = filtfilt(ncb,nca,filtfilt(bpb,bpa,signal_in));
end