function [t_lat_matrix] = compute_uniprocessor_interactive_smi_cmci_t_lat_approx2(D, t_services)

for i=1:size(t_services,1)
    for j=1:size(D,1)
        t_lat_matrix(i,j) = D(j) + t_services(i);
    end 
end

end

