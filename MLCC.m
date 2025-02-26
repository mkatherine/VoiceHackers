
%filename = "\Training_Data\s1.wav"
%[signal, fs] = audioread(filename);

%plot(signal)

% Get all .wav files in the directory
files = dir(fullfile('Training_Data', '*.wav'))
disp({filedir.name})
%filenames = sort({files.name})
%disp(sort(file))

%sort files by name
numFiles = length(files);

% Define subplot grid size (4x4)
rows = 4; 
cols = 4;
numPlots = min(numFiles, rows * cols); % Ensure we don't exceed available subplots
figure; % Create a new figure

for i = 1:numPlots
    % Construct full filename
    filename = fullfile(files(i).folder, files(i).name);
    % Read the audio file
    [signal, fs] = audioread(filename);
   
    % Create time vector (optional for time-domain analysis)
    %t = (0:length(signal)-1) / fs;
    
    % Select subplot position
    subplot(rows, cols, i);
    plot(signal);
    
    % Formatting each subplot
    title(files(i).name, 'Interpreter', 'none', 'FontSize', 8); % Use small font for readability
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
end

% Adjust figure layout
sgtitle('Waveform Plots of .wav Files'); % Overall title
set(gcf, 'Position', [100, 100, 1200, 800]); % Resize figure window

