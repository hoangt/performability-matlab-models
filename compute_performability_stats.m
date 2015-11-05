function [abs_slowdowns, percent_slowdowns, t_lat_avg, abs_slowdown_avg, percent_slowdown_avg] = compute_performability_stats(PK, t_lats, my_gamma)

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

