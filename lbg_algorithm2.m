function codebook = lbg_algorithm(data, M)
    % LBG Algorithm for Vector Quantization (Row-wise Implementation)
    % Inputs:
    % - data: NxD matrix (N samples, D-dimensional feature vectors)
    % - M: Number of clusters (codebook size)
    % Output:
    % - codebook: Trained cluster centroids (size: M x D)
    
    epsilon = 0.01;  % Small perturbation factor
    codebook = mean(data, 1);  % Start with one centroid (row-wise mean)
    
    while size(codebook, 1) < M
        % Step 1: Split existing codewords
        codebook = [codebook * (1 + epsilon); codebook * (1 - epsilon)];
        
        % Step 2: K-means-like clustering
        prevDistortion = inf;
        while true
            % Assign each vector to the closest centroid
            distances = pdist2(data, codebook);
            [~, labels] = min(distances, [], 2);
            
            % Step 3: Update centroids
            new_codebook = zeros(size(codebook));
            for i = 1:size(codebook, 1)
                assigned_vectors = data(labels == i, :);
                if ~isempty(assigned_vectors)
                    new_codebook(i, :) = mean(assigned_vectors, 1);
                else
                    new_codebook(i, :) = codebook(i, :); % Keep old centroid if no points assigned
                end
            end
            
            % Step 4: Compute distortion
            distortion = sum(sum((data - new_codebook(labels, :)).^2)) / numel(data);
            
            if abs(prevDistortion - distortion) < 1e-5
                break;
            end
            prevDistortion = distortion;
            codebook = new_codebook;
        end
    end
end
