function [ ret ] = compute_percent_slowdowns(my_gamma, abs_slowdowns)

ret = abs_slowdowns ./ my_gamma * 100;

end

