function [recognition_rate] = getrr(numTestSpeakers,numTrainSpeakers,codebook,mfcc_test_data)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

correct = 0;
for i = 1:numTestSpeakers
    test_mfcc = mfcc_test_data{i}; % MFCCs of current test speaker
    min_dist = inf;
    predicted_speaker = -1;

    for j = 1:numTrainSpeakers
        train_codebook = codebook{j};  % Codebook of speaker j

        % Compute average minimum distance to codebook
        dist = sum(min(pdist2(test_mfcc', train_codebook, 'euclidean'), [], 2)) / size(test_mfcc, 1);

        if dist < min_dist
            min_dist = dist;
            predicted_speaker = j;
        end
    end

    % Check if prediction is correct
    if predicted_speaker == i
        correct = correct + 1;
    end
end

recognition_rate = (correct / numTestSpeakers) * 100;
fprintf('Speaker Recognition Rate: %.2f%%\n', recognition_rate);

end