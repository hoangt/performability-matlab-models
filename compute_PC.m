function [PC] = compute_PC(rho, max_c)

parfor c=1:max_c
    PC(c,1) = (exp(-rho * c) * (rho * c)^(c-1))/factorial(c);
end

