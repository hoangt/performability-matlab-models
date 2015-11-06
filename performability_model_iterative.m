function [PK, t_lats] = performability_model_iterative(max_k, taus, my_gamma, my_lambda)

% Compute beta_i for i in 0:max_k
betas = NaN(max_k+1,1);
betas(1) = my_lambda * my_gamma; % Special case for beta_0
betas(2:max_k+1) = my_lambda * taus(1:max_k);

% Initialize PK
PK = NaN(max_k+1,1);

% Compute all f(x,y) values that can be used to find all PK values
f_matrix = compute_f_matrix(max_k, betas);

t_lats = NaN(max_k+1,1);
parfor k = 0:max_k
    % Find all PK values
    prefix = exp(-sum(betas(1:k+1)));
    PK(k+1) = prefix * f_matrix(k+1,1);
    
    % Compute the event handler latency for each value of K in 0:max_k
    t_lats(k+1) = my_gamma + sum(taus(1:k));
end

end

