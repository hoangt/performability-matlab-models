function [f_matrix] = compute_f_matrix(max_k, betas)

% Dynamic programming implementation
f_matrix = NaN(max_k+1, max_k+1);
for x=0:max_k
    for y=0:max_k-x
        % Compute f(x,y) using dynamic programming
        if betas(x+1) > 1e-12; % Check for beta close to 0: if it is, then don't bother computing
            terms = NaN(y+1,1);
            for i=0:y
                tmp1 = betas(x+1)^i / factorial(i);
                if x-1 < 0 % base cases
                    if y+1-i <= -(x-1)
                        tmp2 = 1;
                    else % y+1-i > -(x-1)
                        tmp2 = 0;
                    end
                else % common case
                    tmp2 = f_matrix((x-1)+1, (y+1-i)+1);
                end
                terms(i+1) = tmp1 * tmp2;
            end
            f_matrix(x+1,y+1) = sum(terms);
        else
            f_matrix(x+1,y+1) = 0;
        end
    end
end

end

