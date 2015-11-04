function [PK, t_lats] = performability_model(max_k, taus, my_gamma, my_lambda)
%[p, t_lats, percent_slowdown, t_lat_avg, percent_slowdown_avg]
% Compute the event handler latency for each value of K in 0:max_k
t_lats = NaN(max_k+1,1);
for i=0:max_k
    t_lats(i+1) = my_gamma + sum(taus(1:i));
end

% Compute beta_i for i in 0:max_k
betas = NaN(max_k+1,1);
betas(1) = my_lambda * my_gamma; % Special case for beta_0
PK = NaN(max_k+1,1);

%if (faults_during_fault_handler == 1)
    betas(2:max_k+1) = my_lambda * taus(1:max_k);
    
    % Compute PK for K in k = 0:max_k.
    % We utilize a max_k*max_k matrix to store incremental results and employ
    % dynamic programming to solve the PK recursive formulation.
    for k = 0:max_k
        prefix = exp(-sum(betas(1:k+1)));
        PK(k+1) = prefix * f(k,0,betas,k==0);
    end
%else % Special case
%    betas(2:max_k+1) = 0;
%    for k = 0:max_k
%        PK(k+1) = betas(1)^k * exp(-betas(1)) / factorial(k);
%    end
%end 



%p = betas.^max_k.*exp(-betas)./factorial(max_k);
%p(isnan(p))=0;

%abs_slowdown = t_lats - my_gamma;
%percent_slowdown = abs_slowdown ./ my_gamma * 100;

%t_lat_avg = sum(p .* t_lats);
%percent_slowdown_avg = (t_lat_avg - my_gamma)/my_gamma * 100;
    
% if (sum(my_lambda .* my_tau >= 1) < 1)
%     
%    % t_lat_avg = my_gamma / (1-my_lambda*mean(my_tau));
%   %  perf_avg = 1 - my_lambda * mean(my_tau);
% else
%     t_lat_avg = Inf;
%     percent_slowdown_avg = Inf;
% end

end

