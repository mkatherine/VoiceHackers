function [recognition_rate] = getrr_id(id_test,mfcc_test_data,id_train,codebook)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

correct = 0;
for i = 1:length(id_test) %test data
    test_mfcc = mfcc_test_data{i}; % MFCCs of current test speaker
    test_id = id_test(i);
    min_dist = inf;
    predicted_speaker = -1;

    for j = 1:length(id_train) %train data
        train_codebook = codebook{j};  % Codebook of  j
        train_id = id_train(j);
        
        % Compute average minimum distance to codebook
        dist = sum(min(pdist2(test_mfcc', train_codebook, 'euclidean'), [], 2)) / size(test_mfcc, 1);

        if dist < min_dist
            min_dist = dist;
            predicted_speaker = train_id;
        end
    end

    % Check if prediction is correct
    if predicted_speaker == test_id
        correct = correct + 1;
    end
    disp([test_id, predicted_speaker, correct]);
end

recognition_rate = (correct / length(id_test)) * 100;
fprintf('Speaker Recognition Rate: %.2f%%\n', recognition_rate);

end