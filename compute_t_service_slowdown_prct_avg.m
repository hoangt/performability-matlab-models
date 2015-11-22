function [ret] = compute_t_service_slowdown_prct_avg(my_gamma, t_service_slowdown_abs_avg)

ret = t_service_slowdown_abs_avg/my_gamma * 100;

end

