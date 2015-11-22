function [ret] = compute_t_service_avg(PK, t_services)

ret = sum(PK .* t_services);

end

