function [t_wait_avg] = compute_uniprocessor_interactive_smi_cmci_t_wait_avg_approx1(my_alpha, PK, t_services, max_k)

t_service_avg = compute_t_service_avg(PK, t_services);
t_service_variance = compute_t_service_variance(PK, t_services);

rho = my_alpha * t_service_avg;

t_wait_avg = (rho + (my_alpha/t_service_avg) * t_service_variance) / (2*((1/t_service_avg) - my_alpha));

end

