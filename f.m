function [ret] = f(x,y,betas)

if x >= 0 % normal condition
    terms = NaN(y+1,1);
    if betas(x+1) > 1e-12; % Check for beta close to 0: if it is, then don't bother recursing
        for i=0:y
            terms(i+1) = betas(x+1)^i / factorial(i) * f(x-1, y+1-i, betas);
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

