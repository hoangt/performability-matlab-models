function [ret] = compute_N(PK)

k = (0:size(PK,1)-1)';
ret = sum(PK .* k);

end

