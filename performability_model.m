function [p, t_event_faults, percent_slowdown, t_lat_avg, percent_slowdown_avg] = performability_model(k, my_tau, my_gamma, my_lambda, faults_during_fault_handler)

t_event_faults = NaN(size(k));
for i=1:size(k,1)
    t_event_faults(i) = my_gamma + sum(my_tau(1:i));
end

if (faults_during_fault_handler == 1)
    my_beta = my_lambda.*t_event_faults;
else
    my_beta = my_lambda*my_gamma;
end

p = my_beta.^k.*exp(-my_beta)./factorial(k);
p(isnan(p))=0;

abs_slowdown = t_event_faults - my_gamma;
percent_slowdown = abs_slowdown ./ my_gamma * 100;

t_lat_avg = sum(p .* t_event_faults);
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

