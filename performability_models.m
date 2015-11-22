%% UNIPROCESSOR/BATCH/SMI-CMCI
display 'UNIPROCESSOR/BATCH/SMI-CMCI'

% Parameters
max_k = 200;
taus = 0.125*ones(max_k,1);
my_tau = mean(taus);
my_gamma = 1258;
my_lambda = 1;
k = (0:max_k)';
fault_stacking = 0;

% Performability model
[PK, t_services] = compute_t_services(max_k, taus, my_gamma, my_lambda, fault_stacking);

% Compute stats
t_service_slowdowns_abs = compute_t_service_slowdowns_abs(my_gamma, t_services);
t_service_slowdowns_prct = compute_t_service_slowdowns_prct(my_gamma, t_service_slowdowns_abs);
t_service_avg = compute_t_service_avg(PK, t_services);
t_service_slowdown_abs_avg = compute_t_service_slowdown_abs_avg(my_gamma, t_services);
t_service_slowdown_prct_avg = compute_t_service_slowdown_prct_avg(my_gamma, t_service_slowdown_abs_avg);
N = compute_N(PK);

display 'Part 2...'

my_lambda_array = (0.1:0.1:10)';
my_tau_array = (0.075:0.025:0.2)';
t_service_avg_array = NaN(size(my_lambda_array,1),size(my_tau_array,1));
t_service_slowdown_abs_avg_array = NaN(size(my_lambda_array,1),size(my_tau_array,1));
t_service_slowdown_prct_avg_array = NaN(size(my_lambda_array,1),size(my_tau_array,1));

for t=1:size(my_tau_array,1)
    for i=1:size(my_lambda_array,1)
        t_service_avg_array(i,t) = compute_t_service_avg_const_tau(my_lambda_array(i), my_gamma, my_tau_array(t));
        t_service_slowdown_abs_avg_array(i,t) = compute_t_service_slowdown_abs_avg(my_gamma, t_service_avg_array(i,t));
        t_service_slowdown_prct_avg_array(i,t) = compute_t_service_slowdown_prct_avg(my_gamma, t_service_slowdown_abs_avg_array(i,t));
    end
end

display 'Plotting...'

figure(1);
hold on;
plot(k(2:end),taus);
title('Required Fault Handling Time for Fault Number k');
ylabel('Fault Handling Time (s)');
xlabel('Fault Number (k)');
legend(['mean tau = ' num2str(my_tau) ', gamma = ' num2str(my_gamma) ', lambda = ' num2str(my_lambda)]);
hold off;

figure(2);
hold on;
plot(k,PK);
title('Probability Mass Function (PMF) for k Faults Occurring During Event Handler');
ylabel('Probability');
xlabel('Number of Faults (k)');
legend(['mean tau = ' num2str(my_tau) ', gamma = ' num2str(my_gamma) ', lambda = ' num2str(my_lambda)]);
hold off;

figure(3);
hold on;
plot(t_services,PK);
title('Probability Mass Function (PMF) for Total Event Handling Time with Fault Occurrences');
ylabel('Probability');
xlabel('Total Event Handling Time (s)');
legend(['mean tau = ' num2str(my_tau) ', gamma = ' num2str(my_gamma) ', lambda = ' num2str(my_lambda)]);
hold off;

figure(4);
hold on;
plot(t_service_slowdowns_prct,PK);
title('Probability Mass Function (PMF) for Percent Slowdown with Fault Occurrences');
ylabel('Probability');
xlabel('Percent Slowdown');
legend(['mean tau = ' num2str(my_tau) ', gamma = ' num2str(my_gamma) ', lambda = ' num2str(my_lambda)]);
hold off;

figure(5);
hold on;
for t=1:size(my_tau_array,1)
    plot(my_lambda_array(:), t_service_slowdown_prct_avg_array(:,t));
end
title('Average Percent Slowdown vs. Average Fault Rate');
ylabel('Average Percent Slowdown');
xlabel('Average Fault Rate (faults/sec)');
%legend(['mean tau = ' num2str(my_tau) ', gamma = ' num2str(my_gamma)]);
hold off;

t_service_avg
N

%% UNIPROCESSOR/INTERACTIVE/SMI-CMCI
display 'UNIPROCESSOR/INTERACTIVE/SMI-CMCI'
% Parameters
max_k = 200;
taus = 0.125*ones(max_k,1);
my_tau = mean(taus);
my_gamma = 0.050;
my_lambda = 1;
k = (0:max_k)';
fault_stacking = 0;
my_alphas = (0:0.1:20)';


[PK, t_services] = compute_t_services(max_k, taus, my_gamma, my_lambda, fault_stacking);
uniprocessor_interactive_smi_cmci_t_service_avg_scen1 = compute_t_service_avg(PK, t_services);

for i=1:size(my_alphas,1)
    uniprocessor_interactive_smi_cmci_t_wait_avg_scen1_array(i) = compute_uniprocessor_interactive_smi_cmci_t_wait_avg_scen1(my_alphas(i),PK,t_services,max_k);
    uniprocessor_interactive_smi_cmci_t_lat_avg_scen1_array(i) = uniprocessor_interactive_smi_cmci_t_wait_avg_scen1_array(i) + uniprocessor_interactive_smi_cmci_t_service_avg_scen1;
end

figure(6);
hold on;
plot(my_alphas(:), uniprocessor_interactive_smi_cmci_t_lat_avg_scen1_array(:));
plot(my_alphas(:), uniprocessor_interactive_smi_cmci_t_wait_avg_scen1_array(:));

title('Average Total Query Latency vs. QPS for Uniprocessor/Interactive/SMI-CMCI Scenario 1');
ylabel('Average Total Query Latency (sec)');
xlabel('Average Queries Per Second (queries/sec)');
%legend(['mean tau = ' num2str(my_tau) ', gamma = ' num2str(my_gamma)]);
hold off;

tilefig;