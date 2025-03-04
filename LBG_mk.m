function codebook = LBG_mk(trainingData, M, epsilon)
    % LBG Algorithm for Vector Quantization
    % trainingData: NxD matrix (N samples, D-dimensional feature vectors)
    % M: Desired number of centroids (codebook size)
    % epsilon: Splitting parameter (typically 0.01)
    
    %input is mffc_data for a single speaker which is 19x72
    % Step 1: Initialize with a single centroid (global mean)
    centroid = mean(trainingData, 1); %mean of first row
    codebook = centroid;
    
    % Iteratively double the codebook size until reaching M
    while size(codebook, 1) < M
        % Step 2: Split each centroid using the splitting parameter
        codebook = [codebook * (1 + epsilon); codebook * (1 - epsilon)];
        
        % Step 3 & 4: Perform K-means clustering
        prevDistortion = inf;
        while true
            % Nearest Neighbor Search: Assign each point to the closest centroid
            [idx, ~] = knnsearch(codebook, trainingData);
            
            % Update centroids
            newCodebook = zeros(size(codebook));
            for i = 1:size(codebook, 1)
                assignedPoints = trainingData(idx == i, :);
                if ~isempty(assignedPoints)
                    newCodebook(i, :) = mean(assignedPoints, 1);
                else
                    newCodebook(i, :) = codebook(i, :); % Keep old centroid if no points assigned
                end
            end
            
            % Compute distortion (average distance to nearest centroid)
            distortion = mean(vecnorm(trainingData - newCodebook(idx, :), 2, 2));
            
            % Convergence check
            if abs(prevDistortion - distortion) < 1e-6
                break;
            end
            
            prevDistortion = distortion;
            codebook = newCodebook;
        end
    end
end
