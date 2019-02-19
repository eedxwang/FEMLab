function assemble(file_name)
disp('-Assembling solution matrix and calculating solution ...')
tic
respth = ['.\results\', file_name];
load(respth)

K = sparse(n_nodes, n_nodes);
R = zeros(n_nodes,1);

i_elem = 1;
while(elements(i_elem).type == 1)
    i_elem = i_elem + 1;
end

for i_el=i_elem:n_elements
    
    i_n = elements(i_el).n;
    i_N = elements(i_el).nodes(i_n);
    
    K(i_N, i_N) = K(i_N, i_N) + elements(i_el).K(i_n, i_n);
    R(i_N) = R(i_N) + elements(i_el).R(i_n);
    
end

U = zeros(n_nodes, 1);

I = any(K,2);
u_unknown = I;
u_known = ~I;
K = K(I,:);
R = R(I);
I = any(K,1);
K = K(:,I);

U_known = get_known_U(u_known, regparams);
U_unknown = K\R;
U(u_unknown) = U_unknown;
U(u_known) = U_known;

figure;surface(1:size(K,1),size(K,1):-1:1,K,K);colormap(bluewhitered);shading flat 
eigenvals = eigs(K);
condition_number = max(abs(eigenvals))/min(abs(eigenvals));
disp(['Condition Number: ',num2str(condition_number)]);

save(respth, 'U', 'K', 'R','condition_number', '-append'); 

disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])
end