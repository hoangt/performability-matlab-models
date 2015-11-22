function [ ret ] = compute_t_service_slowdowns_prct(my_gamma, t_services_slowdowns_abs)

ret = t_services_slowdowns_abs ./ my_gamma * 100;

end

