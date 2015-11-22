function [ret] = compute_t_service_avg_const_tau(my_lambda, my_gamma, my_tau)

if my_lambda*my_tau < 1
    ret = my_gamma / (1-my_lambda*my_tau);
else
   ret = Inf; 
end

end

