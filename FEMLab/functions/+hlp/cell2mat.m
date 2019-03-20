function res_mat = cell2mat(cell_mat)
[n, n_elem] = hlp.max_vec_len(cell_mat);
res_mat = zeros(n_elem, n);
for i_node = 1:n_elem
    res_mat(i_node, :) = hlp.cell2vec(strsplit(cell_mat{i_node}, ' '), n);
end
end
