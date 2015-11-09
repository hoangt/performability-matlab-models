function [f_matrix] = compute_f_matrix(max_k, betas)

% Dynamic programming implementation
f_matrix = NaN(max_k+1, max_k+1);
for x=0:max_k % Sequential execution because rows of f_matrix depend on prior rows.
    curr_beta = betas(x+1);
    if x-1 < 0
        f_input_row = NaN(1,size(f_matrix,2));
    else
        f_input_row = f_matrix((x-1)+1,:);
    end
    f_output_row = NaN(1,size(f_matrix,2));
    
    parfor y=0:max_k-x
        terms = NaN(y+1,1);
        for i=0:y
            tmp1 = curr_beta^i / factorial(i);
            if x-1 < 0 % base cases
                if y+1-i <= -(x-1)
                    tmp2 = 1;
                else % y+1-i > -(x-1)
                    tmp2 = 0;
                end
            else % common case
                tmp2 = f_input_row((y+1-i)+1);
            end
            terms(i+1) = tmp1 * tmp2;
        end
        f_output_row(y+1) = sum(terms);
    end
    f_matrix(x+1,:) = f_output_row;
end

f_matrix;

end

