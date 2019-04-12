function I = int_tri_K_as(A, k, abc, fun, r, z, i, j) %A, k, abc, f_K, xe, ye, i, j

g_data = [0.333333333333333, 0.333333333333333, 0.1125
         0.470142064105115, 0.470142064000000, 0.066197076394253
         0.059715871789770, 0.470142064000000, 0.066197076394253
         0.470142064105115, 0.059715872000000, 0.066197076394253
         0.101286507323456, 0.101286507000000, 0.062969590272414
         0.797426985353087, 0.797426985000000, 0.066197076394253
         0.101286507323456, 0.101286507000000, 0.066197076394253];
n_p = size(g_data, 1);
%det_J = calc_detJ(x,y);
b = [abc(2,i),abc(2,j)];
c = [abc(3,i),abc(3,j)];

I = 0;
for i_p = 1:n_p
    rv = r(1)*(1-g_data(i_p,1)-g_data(i_p,2))+r(2)*g_data(i_p,1)+r(3)*g_data(i_p,2);
    zv = z(1)*(1-g_data(i_p,1)-g_data(i_p,2))+z(2)*g_data(i_p,1)+z(3)*g_data(i_p,2);
    I = I + fun(A, abc(:,[i j]), rv, zv, k)*g_data(i_p,3); %r([i,j]), z([i,j]), k), (A, k, b, c, rv)
end

I = I * A * 2;