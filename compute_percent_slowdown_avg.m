function [ret] = compute_percent_slowdown_avg(my_gamma, abs_slowdown_avg)

ret = abs_slowdown_avg/my_gamma * 100;

end

