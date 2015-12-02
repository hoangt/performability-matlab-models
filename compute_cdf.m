function [my_cdf] = compute_cdf(my_pmf)

% construct CDF
for i=1:size(my_pmf)
   my_cdf(i,1) = sum(my_pmf(1:i));
end

end

