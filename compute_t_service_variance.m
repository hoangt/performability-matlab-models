function [t_service_variance] = compute_t_service_variance(PK, t_services)

t_service_avg = compute_t_service_avg(PK, t_services);

for i=1:size(PK,1)
   terms(i) = PK(i)*(t_services(i)-t_service_avg)^2; 
end

t_service_variance = sum(terms);

end

