function [K,R,U,n] = calc_element_RK(nodes, nodes_prop, element, regparams, sourparams, elem_tag)

kmn = @(k, b, c) k(1)*b(1)*b(2) + k(2)*c(1)*c(2);
rm = @(f,A) f*A/3;

[U, i_k, i_n] = set_known_u([element.nodes], nodes_prop, regparams);

if(elem_tag == 3) %if region is source
    f = sourparams(1); % Stromdichte J
    k1 = regparams(3); % \mu of copper of source
else
    f = 0;
    k1 = regparams(elem_tag);
end
%k1 = 1/k1; % to get reluctance from \mu
k = [k1 k1];

[abc, A] = calc_abc(nodes, [element.nodes]);
K = zeros(3,3);
R_p = rm(f,A)*ones(3,1);

for i=1:3
    for j=1:3
        K(i,j) = kmn(k,[abc(2,i),abc(2,j)], [abc(3,i),abc(3,j)])/(4*A);
    end
end

K_len = max([length(i_k), length(i_n)]);

R_temp = zeros(3,1);
R_temp(i_n) = U(i_k)'*reshape(K(i_n, i_k),[K_len, 1]);
R = R_p - R_temp;
n = i_n;


