function [mfcc] = mfcc(signal_in, fs_in)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% Parameters

window = 256;
overlap = window - (window/3);
nfft = 256;
energyThreshold = 0.0005; % Adjust this threshold for silence detection
k = 20;  % Number of Mel filters
fs = fs_in;
signal = signal_in;

% Generate Mel filter bank
melfilterbank = melfb(k,nfft,fs);

% Silence Removal at the beginning and end using energy threshold
% Calculate the energy of the signal (squared values)
energy = signal.^2;
    
% Define a threshold to consider the signal as non-silent
nonSilentIdx = energy > energyThreshold;
    
% Find the indices of the non-silent portion
speechStart = find(nonSilentIdx, 1, 'first');
speechEnd = find(nonSilentIdx, 1, 'last');
    
% Trim the signal to include only the non-silent portion
trimmedSignal = signal(speechStart:speechEnd);

%normalize trimmed signal 
signal = normalize(trimmedSignal, 'range', [-1,1]); 
    
% Perform STFT
[s, f, ~] = stft(signal, fs, 'Window', hamming(window), 'OverlapLength', round(overlap), 'FFTLength', nfft);
    
% Select only positive frequencies
positiveFreqIdx = f >= 0; 
s_pos = s(positiveFreqIdx, :);

% Apply mel filter bank
melfb_response = melfilterbank * abs(s_pos);

%compute the cepstrum
logMelSpectrogram = log(melfb_response);
mfcc = dct(logMelSpectrogram);
numCoefficients = 20;  

mfcc = mfcc(2:numCoefficients, :);

disp(mfcc);
end