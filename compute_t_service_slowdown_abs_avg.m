function [ret] = compute_t_service_slowdown_abs_avg(my_gamma, t_service_avg)

ret = t_service_avg - my_gamma;

end

