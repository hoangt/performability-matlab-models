function [ret] = compute_percentile_latency(cdf_t_lat, t_lat, percentile)

% find percentile latency
for i=1:size(cdf_t_lat,1)
   if cdf_t_lat(i) < percentile
       curr_prob_index = i;
   end
end

ret = t_lat(curr_prob_index);

end

