function [abs_slowdowns, percent_slowdowns, t_lat_avg, abs_slowdown_avg, percent_slowdown_avg] = compute_performability_stats(PK, t_lats, my_gamma)

% Check for validity of PK. It should sum to 1 to be complete prob.
% distribution. If it is less than 1, we don't have enough terms or there
% was loss of numerical precision. When this happens, we assume that
% E[t_lats] over PMF of PK is undefined and saturate it to infinity.
numerical_issue = sum(PK(~isnan(PK))) < 1;
if numerical_issue == 1
   display(['Numerical issue. Sum of PK, excluding NaN, is: ' num2str(sum(PK(~isnan(PK)))) '. Setting all NaN PK entries to 0.']); 
   PK(isnan(PK)) = 0;
end

abs_slowdowns = t_lats - my_gamma;
percent_slowdowns = abs_slowdowns ./ my_gamma * 100;

t_lat_avg = sum(PK .* t_lats);
abs_slowdown_avg = t_lat_avg - my_gamma;
percent_slowdown_avg = abs_slowdown_avg/my_gamma * 100;
    
% if (sum(my_lambda .* my_tau >= 1) < 1)
%     
%    % t_lat_avg = my_gamma / (1-my_lambda*mean(my_tau));
%   %  perf_avg = 1 - my_lambda * mean(my_tau);
% else
%     t_lat_avg = Inf;
%     percent_slowdown_avg = Inf;
% end

end

