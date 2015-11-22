function [PK, t_services] = compute_t_services(max_k, taus, my_gamma, my_lambda, fault_stacking)

% Compute beta_i for i in 0:max_k
betas = NaN(max_k+1,1);
betas(1) = my_lambda * my_gamma; % Special case for beta_0

if fault_stacking == 1
    betas(2:max_k+1) = my_lambda * taus(1:max_k);
else
    betas(2:max_k+1) = 0;
end

% Initialize PK
PK = NaN(max_k+1,1);

% Compute all f(x,y) values that can be used to find all PK values
f_matrix = compute_f_matrix(max_k, betas);

t_services = NaN(max_k+1,1);
parfor k = 0:max_k
    % Find all PK values
    prefix = exp(-sum(betas(1:k+1)));
    PK(k+1) = prefix * f_matrix(k+1,1);
    
    % Compute the event handler latency for each value of K in 0:max_k
    t_services(k+1) = my_gamma + sum(taus(1:k));
end

end

