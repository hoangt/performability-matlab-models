function [ret] = compute_f(x,y,betas,beta_cutoff)

if x >= 0 % normal condition
    terms = NaN(y+1,1);
    if betas(x+1) > beta_cutoff; % Check for beta close to 0: if it is, then don't bother recursing
        for i=0:y
            terms(i+1) = betas(x+1)^i / factorial(i) * compute_f(x-1, y+1-i, betas, beta_cutoff);
        end
        ret = sum(terms);
    else
        ret = 0;
    end    
else
    if y <= -x % base case: x < 0 and y <= -x
        ret = 1;
    else % base case: x < 0 and y > -x
        ret = 0;
    end
end

end

