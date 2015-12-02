function [ret] = compute_t_lat_avg(P_t_lat, t_lat)

ret = sum(P_t_lat .* t_lat);

end

