function [PK, t_services] = compute_t_service_recursive(max_k, taus, my_gamma, my_lambda, fault_stacking)

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

% Compute PK for K in k = 0:max_k using f() which is recursive
for k = 0:max_k
   prefix = exp(-sum(betas(1:k+1)));
   PK(k+1) = prefix * compute_f(k,0,betas,1e-12);
end

% Compute the event handler latency for each value of K in 0:max_k
t_services = NaN(max_k+1,1);
for i=0:max_k
    t_services(i+1) = my_gamma + sum(taus(1:i));
end

end
