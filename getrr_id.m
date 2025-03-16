function [recognition_rate] = getrr_id(id_test,mfcc_test_data,id_train,codebook)
% Algorithm for training the and testing the speaker recognition on the datasets.
    % Inputs:
    % - id_test
    % - mfcc_test_data
    % - id_train
    % - codebook
    % Output:
    % - recognition_rate
    % Usage: Clustering L training vectors into M codebook vectors

speech = ' ';
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

    
   % Execute only if test 10a is happening 
   if length(codebook) > 30 
        if (predicted_speaker > 100) && (test_id > 100) % if the predicted and test ids are coorelated to 12 
            speech = '12';
        elseif ((predicted_speaker < 100) && (test_id < 100)) % if the predicted and test ids are coorelated to 0
            speech = '0';
        else
            speech = ''; % Else leave blank
        end
   end


   
    
   


     % Check if prediction is correct
     
            if predicted_speaker == test_id
                correct = correct + 1;
            end
fprintf('%10d %10d %10d %10s\n', test_id, predicted_speaker, correct, speech);
end

recognition_rate = (correct / length(id_test)) * 100;
fprintf('Speaker Recognition Rate: %.2f%%\n', recognition_rate);

end