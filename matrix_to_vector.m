function [my_vector] = matrix_to_vector(my_matrix)

for i=1:size(my_matrix,1)
    for j=1:size(my_matrix,2)
        my_vector((i-1)*size(my_matrix,2)+j,1) = my_matrix(i,j);
    end
end

end

