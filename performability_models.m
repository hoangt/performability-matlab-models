display 'Part 1...'

max_k = 200;
taus = 0.125*ones(max_k,1);
my_gamma = 10;
my_lambda = 0.2;
k = (0:max_k)';
[PK, t_lats] = performability_model_iterative(max_k, taus, my_gamma, my_lambda);
[abs_slowdowns, percent_slowdowns, t_lat_avg, abs_slowdown_avg, percent_slowdown_avg] = compute_performability_stats(PK, t_lats, my_gamma, 1e-4);

display 'Part 2...'

my_lambda_array = 0.1*(1:100)';
percent_slowdown_avg_array = NaN(size(my_lambda_array,1),1);
for i=1:size(my_lambda_array,1)
    [PK_tmp, t_lats_tmp] = performability_model_iterative(max_k, taus, my_gamma, my_lambda_array(i));
    [abs_slowdowns_tmp, percent_slowdowns_tmp, t_lat_avg_tmp, abs_slowdown_avg_tmp, percent_slowdown_avg_tmp] = compute_performability_stats(PK_tmp, t_lats_tmp, my_gamma, 1e-4);
    percent_slowdown_avg_array(i) = percent_slowdown_avg_tmp;
end

display 'Plotting...'

figure(1);
hold on;
plot(k(2:end),taus);
title('Required Fault Handling Time for Fault Number k');
ylabel('Fault Handling Time (s)');
xlabel('Fault Number (k)');
legend(['mean tau = ' num2str(mean(taus)) ', gamma = ' num2str(my_gamma) ', lambda = ' num2str(my_lambda)]);
hold off;

figure(2);
hold on;
plot(k,PK);
title('Probability Mass Function (PMF) for k Faults Occurring During Event Handler');
ylabel('Probability');
xlabel('Number of Faults (k)');
legend(['mean tau = ' num2str(mean(taus)) ', gamma = ' num2str(my_gamma) ', lambda = ' num2str(my_lambda)]);
hold off;

figure(3);
hold on;
plot(t_lats,PK);
title('Probability Mass Function (PMF) for Total Event Handling Time with Fault Occurrences');
ylabel('Probability');
xlabel('Total Event Handling Time (s)');
legend(['mean tau = ' num2str(mean(taus)) ', gamma = ' num2str(my_gamma) ', lambda = ' num2str(my_lambda)]);
hold off;

figure(4);
hold on;
plot(percent_slowdowns,PK);
title('Probability Mass Function (PMF) for Percent Slowdown with Fault Occurrences');
ylabel('Probability');
xlabel('Percent Slowdown');
legend(['mean tau = ' num2str(mean(taus)) ', gamma = ' num2str(my_gamma) ', lambda = ' num2str(my_lambda)]);
hold off;

figure(5);
hold on;
plot(my_lambda_array,percent_slowdown_avg_array);
title('Average Percent Slowdown vs. Average Fault Rate');
ylabel('Average Percent Slowdown');
xlabel('Average Fault Rate (faults/sec)');
legend(['mean tau = ' num2str(mean(taus)) ', gamma = ' num2str(my_gamma)]);
hold off;

tilefig;