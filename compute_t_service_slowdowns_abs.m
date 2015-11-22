function [ret] = compute_t_service_slowdowns_abs(my_gamma, t_services)

ret = t_services - my_gamma;

end

