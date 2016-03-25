function write_matrix_file(fid, labels_rows, labels_cols, data)

% Inputs:
%
% * |labels_cols| = |m x n| cell array of labels, where |m| is the number of
% columns and |n| is the number of labels for each column.
%
% * |labels_row| = |p x q| cell array of labels, where |p| is the number of
% rows and |q| is the number of labels for each row.

str = '\t%.3f';
if isinteger(data)
    str = '\t%d';
end

fprintf('Writing the matrix file\n');

fprintf(fid,'\');

for n = 1 : size(labels_cols,2)
    if n > 1
        fprintf(fid, '\n');
    end
    for m = 1 : size(labels_cols,1)
        if m == 1
            fprintf(fid, repmat('\t', 1, size(labels_rows,2)-1));
        end
        fprintf(fid, '\t%s',labels_cols{m,n});
    end
end

fprintf(['|', blanks(100), '|\n']);
fprintf('|');

y = 0;


for p = 1 : size(labels_rows,1)
    
    % -- Progress bar ---
    x = fix(p * 100 / size(labels_rows,1));
    if x > y
        fprintf('*');
        y = x;
    end
    % -- Progress bar ---
        
    for q = 1 : size(labels_rows,2)
        if q == 1
            fprintf(fid, '\n%s', labels_rows{p,q});
        else
            fprintf(fid, '\t%s', labels_rows{p,q});
        end
    end
    
    for m = 1 : size(labels_cols,1)
        fprintf(fid, str, data(p,m));
    end
end
fprintf('|\n');