function [signal_cell, fs_cell, numFiles, id] = loadwav(foldername)
% This function loads all .wav files from the given folder, stores the signal and fs
% into their own cell arrays, and returns an array of extracted numbers from filenames.
%
% Outputs:
%   - signal_cell: Cell array containing audio signals
%   - fs_cell: Cell array containing sampling frequencies
%   - numFiles: Total number of loaded files
%   - id: Numeric values extracted from filenames, ordered correctly

    files = dir(fullfile(foldername, '*.wav'));

    % Extract numeric values from filenames for sorting
    fileNames = {files.name};
    numValues = zeros(length(fileNames), 1);

    for i = 1:length(fileNames)
        numStr = regexp(fileNames{i}, '\d+', 'match'); % Extract numeric part
        if ~isempty(numStr)
            numValues(i) = str2double(numStr{1}); % Convert to number
        else
            numValues(i) = NaN; % Handle cases where no number is found
        end
    end

    % Sort files numerically based on extracted numbers
    [~, sortedIdx] = sort(numValues, 'ascend', 'MissingPlacement', 'last');
    files = files(sortedIdx); % Reorder file structure
    id = numValues(sortedIdx); % Keep sorted file numbers

    % Number of files
    numFiles = length(files);
    signal_cell = cell(1, numFiles);
    fs_cell = cell(1, numFiles);

    for i = 1:numFiles
        % Construct full filename
        filename = fullfile(files(i).folder, files(i).name);
        
        % Read the audio file
        [signal, fs] = audioread(filename);
        
        % Convert stereo to mono if necessary
        if size(signal, 2) == 2
            signal = mean(signal, 2); % Take the average of both channels
        end
        
        signal_cell{i} = signal;
        fs_cell{i} = fs;
    end
end
