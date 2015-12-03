%% UNIPROCESSOR/BATCH/SMI-CMCI OR MULTIPROCESSOR/BATCH/SMI
display 'UNIPROCESSOR/BATCH/SMI-CMCI OR MULTIPROCESSOR/BATCH/SMI'

% Parameters
max_k = 200;
taus = 0.135*ones(max_k,1);
my_tau = mean(taus);
my_gamma = 1781;
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

%my_lambda_array = [1; 10; 20; 50; 75; 100; 150; 200; 333; 500; 750; 1000; 1500; 2000];
%my_tau_array = (0.00020:0.00005:0.00040)';
my_lambda_array = (0.1:0.1:10)';
my_tau_array = (0.1:0.025:0.2)';
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
    semilogy(my_lambda_array(:), t_service_slowdown_prct_avg_array(:,t));
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

% Approximation 1: phi >> rho. phi = alpha * gamma, rho = lambda * tau
display 'Approximation 1...'
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
uniprocessor_interactive_smi_cmci_t_service_avg_approx1 = compute_t_service_avg(PK, t_services);

for i=1:size(my_alphas,1)
    uniprocessor_interactive_smi_cmci_t_wait_avg_approx1_array(i) = compute_uniprocessor_interactive_smi_cmci_t_wait_avg_approx1(my_alphas(i),PK,t_services,max_k);
    uniprocessor_interactive_smi_cmci_t_lat_avg_approx1_array(i) = uniprocessor_interactive_smi_cmci_t_wait_avg_approx1_array(i) + uniprocessor_interactive_smi_cmci_t_service_avg_approx1;
end

figure(6);
hold on;
plot(my_alphas(:), uniprocessor_interactive_smi_cmci_t_lat_avg_approx1_array(:));
plot(my_alphas(:), uniprocessor_interactive_smi_cmci_t_wait_avg_approx1_array(:));

title('Average Total Query Latency vs. QPS for Uniprocessor/Interactive/SMI-CMCI Approximation 1');
ylabel('Average Total Query Latency (sec)');
xlabel('Average Queries Per Second (queries/sec)');
%legend(['mean tau = ' num2str(my_tau) ', gamma = ' num2str(my_gamma)]);
hold off;


display 'Approximation 2...'
% Parameters
max_k = 200;
max_c = 140;
my_tau = 0.125;
taus = my_tau * ones(max_k+1,1);
my_gamma = 0.015;
my_lambda = 4;
k = (0:max_k)';
C = (1:1:140)';
fault_stacking = 0;

[PK, t_services] = compute_t_services(max_k, taus, my_gamma, my_lambda, fault_stacking);

D = compute_blocking_delays(C, my_tau);
PC = compute_PC(my_lambda * my_tau, max_c);

uniprocessor_interactive_smi_cmci_t_lat_approx2_matrix = compute_uniprocessor_interactive_smi_cmci_t_lat_approx2(D, t_services);
uniprocessor_interactive_smi_cmci_t_lat_approx2 = matrix_to_vector(uniprocessor_interactive_smi_cmci_t_lat_approx2_matrix);

P_t_lat_uni_approx2_matrix = compute_P_t_lat_uni_approx2(PK, PC);
P_t_lat_uni_approx2 = matrix_to_vector(P_t_lat_uni_approx2_matrix);

result = [uniprocessor_interactive_smi_cmci_t_lat_approx2 P_t_lat_uni_approx2];
result = sortrows(result,1);
uniprocessor_interactive_smi_cmci_t_lat_approx2 = result(:,1);
P_t_lat_uni_approx2 = result(:,2);
clear result;

cdf_t_lat_uni_approx2 = compute_cdf(P_t_lat_uni_approx2);
t_lat_uni_approx2_avg = compute_t_lat_avg(P_t_lat_uni_approx2, uniprocessor_interactive_smi_cmci_t_lat_approx2)
t_lat_uni_approx2_p95 = compute_percentile_latency(cdf_t_lat_uni_approx2, uniprocessor_interactive_smi_cmci_t_lat_approx2, 0.95)
t_lat_uni_approx2_p99 = compute_percentile_latency(cdf_t_lat_uni_approx2, uniprocessor_interactive_smi_cmci_t_lat_approx2, 0.99)


figure(7);
hold on;
surf(t_services, D, uniprocessor_interactive_smi_cmci_t_lat_approx2_matrix');
title('Total Query Latency vs. Blocking Delay and Servicing Time for Uniprocessor/Interactive/SMI-CMCI Approximation 2');
ylabel('Blocking Delay (sec)');
xlabel('Servicing Time (sec)');
zlabel('Query Latency (sec)');
hold off;

figure(8);
hold on;
surf(t_services, D, P_t_lat_uni_approx2_matrix');
title('Joint PMF for Blocking Delay and Servicing Time for Uniprocessor/Interactive/SMI-CMCI Approximation 2');
ylabel('Blocking Delay (sec)');
xlabel('Servicing Time (sec)');
zlabel('Probability');
hold off;

figure(9);
hold on;
plot(uniprocessor_interactive_smi_cmci_t_lat_approx2, P_t_lat_uni_approx2);
title('PMF of Application Event Latency for Uniprocessor/Interactive/SMI-CMCI Approximation 2');
ylabel('Probability');
xlabel('Total Latency (sec)');
hold off;


tilefig;