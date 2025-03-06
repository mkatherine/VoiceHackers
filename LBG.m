function codebook = LBG(data, M,e)
    % LBG Algorithm for Vector Quantization (Row-wise Implementation)
    % Inputs:
    % - Data: (size: D(19)-dimension training vectors x L samples)
    % - M: Num of clusters (codebook size)
    % Output:
    % - codebook: Trained cluster centroids (size: M x D)
    % Usage: Clustering L training vectors into M codebook vectors
    
    e = 0.01;  % Splitting parameter
 
    %% a. Initialize with a single-vector codebook; this is the centroid of all training vectors
    codebook = mean(data, 1);  % row vector containing the mean of each column (mean val across all frames for each mfcc)

    while size(codebook, 1) < M % repeat steps 2, 3 and 4 until a codebook size of M is designed

        %% b. Double the size of the codebook by splitting each current codebook
        codebook = [codebook * (1 + e); codebook * (1 - e)];
        
        prevDist = inf; % initialize previous distortion
        while true
            %% c. Assign each vector to the closest codeword
            distances = pdist2(data, codebook); % now training vectors are rows and centroids are the cols
            [~, labels] = min(distances, [], 2); % stores col index of min centriod along each row, aka closest centroid to each training vector
            
            %% d. Centroid Update
            new_codebook = zeros(size(codebook)); % create array of zeros to store new

            for i = 1:size(codebook, 1)
                assigned_vectors = data(labels == i, :); % Extract all training vectors assigned to centroid i

                if ~isempty(assigned_vectors)
                    new_codebook(i, :) = mean(assigned_vectors, 1); % Gives a new centroid
                else
                    new_codebook(i, :) = codebook(i, :); % Keep old centroid if no training vectors were assigned to it
                end
            end
            
            % Repeat steps c and d until the average distance falls below a preset threshold
            distortion = sum(sum((data - new_codebook(labels, :)).^2)) / numel(data);
            
            if abs(prevDist - distortion) < 1e-5
                break;
            end

            prevDist = distortion;

            codebook = new_codebook;
        end
    end
end
