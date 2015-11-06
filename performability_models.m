display 'Part 1...'

% Parameters
max_k = 200;
taus = 0.125*ones(max_k,1);
taus(3:end) = 0;
taus(2) = 5;
my_tau = mean(taus);
my_gamma = 10;
my_lambda = 0.2;
k = (0:max_k)';

% Performability model
[PK, t_lats] = performability_model_iterative(max_k, taus, my_gamma, my_lambda);

% Compute stats
abs_slowdowns = compute_abs_slowdowns(my_gamma, t_lats);
percent_slowdowns = compute_percent_slowdowns(my_gamma, abs_slowdowns);
t_lat_avg = compute_t_lat_avg(PK, t_lats);
abs_slowdown_avg = compute_abs_slowdown_avg(my_gamma, t_lats);
percent_slowdown_avg = compute_percent_slowdown_avg(my_gamma, abs_slowdown_avg);
N = compute_N(PK);

display 'Part 2...'

my_lambda_array = (0.1:0.1:10)';
my_tau_array = (0.075:0.025:0.2)';
t_lat_avg_array = NaN(size(my_lambda_array,1),size(my_tau_array,1));
abs_slowdown_avg_array = NaN(size(my_lambda_array,1),size(my_tau_array,1));
percent_slowdown_avg_array = NaN(size(my_lambda_array,1),size(my_tau_array,1));

for t=1:size(my_tau_array,1)
    for i=1:size(my_lambda_array,1)
        t_lat_avg_array(i,t) = compute_t_lat_avg_const_tau(my_lambda_array(i), my_gamma, my_tau_array(t));
        abs_slowdown_avg_array(i,t) = compute_abs_slowdown_avg(my_gamma, t_lat_avg_array(i,t));
        percent_slowdown_avg_array(i,t) = compute_percent_slowdown_avg(my_gamma, abs_slowdown_avg_array(i,t));
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
plot(t_lats,PK);
title('Probability Mass Function (PMF) for Total Event Handling Time with Fault Occurrences');
ylabel('Probability');
xlabel('Total Event Handling Time (s)');
legend(['mean tau = ' num2str(my_tau) ', gamma = ' num2str(my_gamma) ', lambda = ' num2str(my_lambda)]);
hold off;

figure(4);
hold on;
plot(percent_slowdowns,PK);
title('Probability Mass Function (PMF) for Percent Slowdown with Fault Occurrences');
ylabel('Probability');
xlabel('Percent Slowdown');
legend(['mean tau = ' num2str(my_tau) ', gamma = ' num2str(my_gamma) ', lambda = ' num2str(my_lambda)]);
hold off;

figure(5);
hold on;
for t=1:size(my_tau_array,1)
    plot(my_lambda_array(:), percent_slowdown_avg_array(:,t));
end
title('Average Percent Slowdown vs. Average Fault Rate');
ylabel('Average Percent Slowdown');
xlabel('Average Fault Rate (faults/sec)');
%legend(['mean tau = ' num2str(my_tau) ', gamma = ' num2str(my_gamma)]);
hold off;

t_lat_avg
N

tilefig;