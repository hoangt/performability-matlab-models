function [ret] = compute_t_lat_avg(PK, t_lats)

ret = sum(PK .* t_lats);

end

