function [t_service_avg] = compute_multiprocessor_batch_cmci_t_service(my_gamma, my_lambda, my_tau_avg, U, M, S, cmci_scheduling_policy)
% Ensure 0 <= U <= 1.
% Ensure 1 <= M <= S.
% Ensure 1 <= S.

t_service_avg = NaN;
if strcmp(cmci_scheduling_policy,'random') == 1 % random CMCI issue to cores
    I = U * M * my_lambda * my_tau_avg / S;
else
    if strcmp(cmci_scheduling_policy,'idle-first') == 1 % CMCIs are issued first to cores w/ spare utilization
        if my_lambda * my_tau_avg <= S - U*M
            I = 0;
        else
            I = U*M*(my_lambda * my_tau_avg - (S - U*M));
        end
    else
        display('This should not have happened!');
        I = NaN;
    end
end

t_service_avg = my_gamma * ((U*M)/(U*M-I));

end

