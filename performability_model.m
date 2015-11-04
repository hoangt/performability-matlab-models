function [p, t_lats, percent_slowdown, t_lat_avg, percent_slowdown_avg] = performability_model(max_k, taus, my_gamma, my_lambda, faults_during_fault_handler)

% Compute the event handler latency for each value of K in 1:max_k
t_lats = NaN(size(max_k));
for i=1:size(max_k)
    t_lats(i) = my_gamma + sum(taus(1:i));
end

% Compute beta_i for i in 1:max_k+1
betas = NaN(size(max_k)+1);
betas(1) = my_lambda * my_gamma; % Special case for beta_0

if (faults_during_fault_handler == 1)
    betas(2:max_k) = my_lambda * taus(1:max_k);
else
    betas(2:max_k) = 0;
end 

% Compute PK for K in 0:max_k
PK = NaN(size(max_k)+1);
for k = 0:max_k
    prefix = exp(-sum(betas(1:k+1)));
    for j = 0:k-1
       upper = k-j-sum(
       for i_j = 0:k-j-su 
    end
end

p = betas.^max_k.*exp(-betas)./factorial(max_k);
p(isnan(p))=0;

abs_slowdown = t_lats - my_gamma;
percent_slowdown = abs_slowdown ./ my_gamma * 100;

t_lat_avg = sum(p .* t_lats);
percent_slowdown_avg = (t_lat_avg - my_gamma)/my_gamma * 100;
    
% if (sum(my_lambda .* my_tau >= 1) < 1)
%     
%    % t_lat_avg = my_gamma / (1-my_lambda*mean(my_tau));
%   %  perf_avg = 1 - my_lambda * mean(my_tau);
% else
%     t_lat_avg = Inf;
%     percent_slowdown_avg = Inf;
% end

end

