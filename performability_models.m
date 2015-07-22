max_k = 100;
k = [1:max_k]';
%my_tau = ones(max_k,1)*0.001;
my_tau = ones(max_k,1).*0.001.*sqrt(k);
my_gamma = 2;
my_lambda = 10;
faults_allowed_during_fault_handler = 1;

[p, t_event_faults, perf, t_lat_avg, perf_avg] = performability_model(k, my_tau, my_gamma, my_lambda, faults_allowed_during_fault_handler);

figure(1);
hold on;
plot(k,my_tau);
title('Required Fault Handling Time for Fault Number k');
ylabel('Fault Handling Time (s)');
xlabel('Fault Number k');
%legend(['mean tau = ' num2str(mean(my_tau)) ', gamma = ' num2str(my_gamma) ', lambda = ' num2str(my_lambda), ', faults allowed during fault handler = ' num2str(faults_allowed_during_fault_handler)]);
hold off;

figure(2);
hold on;
plot(k,p);
title('Probability Mass Function for k Faults Occurring During Event Handler');
ylabel('Probability');
xlabel('Number of Faults k');
%legend(['mean tau = ' num2str(mean(my_tau)) ', gamma = ' num2str(my_gamma) ', lambda = ' num2str(my_lambda), ', faults allowed during fault handler = ' num2str(faults_allowed_during_fault_handler)]);
hold off;

figure(3);
hold on;
plot(t_event_faults,p);
title('Probability Mass Function for Event Handling Time with Fault Occurrences');
ylabel('Probability');
xlabel('Event Handling Time (s)');
%legend(['mean tau = ' num2str(mean(my_tau)) ', gamma = ' num2str(my_gamma) ', lambda = ' num2str(my_lambda), ', faults allowed during fault handler = ' num2str(faults_allowed_during_fault_handler)]);
hold off;

figure(4);
hold on;
plot(perf,p);
title('Probability Mass Function for Performance with Fault Occurrences');
ylabel('Probability');
xlabel('Performance');
%legend(['mean tau = ' num2str(mean(my_tau)) ', gamma = ' num2str(my_gamma) ', lambda = ' num2str(my_lambda), ', faults allowed during fault handler = ' num2str(faults_allowed_during_fault_handler)]);
hold off;

tilefig;

display 'Average latency (s): ';
t_lat_avg
display 'Average performance: ';
perf_avg