
%%2O MS 

% Get all .wav files in the directory
files = dir(fullfile('Training_Data', '*.wav'));

% Extract numeric values from filenames for correct sorting
fileNames = {files.name}; 
numValues = zeros(length(fileNames), 1); 

for i = 1:length(fileNames)
    numStr = regexp(fileNames{i}, '\d+', 'match'); % Extract numeric part
    numValues(i) = str2double(numStr{1}); % Convert to number
end

% Sort files numerically
[~, sortedIdx] = sort(numValues);
files = files(sortedIdx); % Reorder file structure

% Number of files
numFiles = length(files);

% Define subplot grid size (adjust dynamically)
rows = ceil(sqrt(numFiles));  % Auto-adjust rows
cols = ceil(numFiles / rows); % Auto-adjust columns
numPlots = min(numFiles, rows * cols); % Ensure we don't exceed available subplots

figure; % Create a new figure

for i = 1:numPlots
    % Construct full filename
    filename = fullfile(files(i).folder, files(i).name);
    
    % Read the audio file
    [signal, fs] = audioread(filename);
    
    % Convert stereo to mono (if necessary)
    if size(signal, 2) == 2
        signal = mean(signal, 2); % Take the average of both channels
    end

    % Select subplot position
    subplot(rows, cols, i);
    plot(signal, 'b'); % Force a consistent color (blue)
    
    % Formatting each subplot
    title(files(i).name, 'Interpreter', 'none', 'FontSize', 8); 
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
end

% Adjust figure layout
sgtitle('Waveform Plots of .wav Files', 'FontSize', 14, 'FontWeight', 'bold'); % Overall title
set(gcf, 'Position', [100, 100, 1400, 900]); % Resize figure for better layout

% Ensure tight layout to prevent overlap
tightfig();
