function B = calc_exact_B(N, x, y, r_c, type, mshType)

vecR = 0.2;
mu_0 = 1.257e-6;
J = 10e-3;

if(strcmp(type, 'diag'))
    B = zeros(1,N);
    
    if(strcmp(mshType.src, 'circ'))
        r = r_c > vecR; 
    elseif(strcmp(mshType.src, 'rect'))
        r = (x > vecR) & (y > vecR);
    end
    
    B(r) = (mu_0*J*vecR^2)./(2*(sqrt(x(r).^2+y(r).^2)));
    B(~r) = (mu_0*J*(sqrt(x(~r).^2+y(~r).^2)))./2;
    
else
    
    a = 0.3;
    b = 0.5;
    B = zeros(1,N);
    r = linspace(0,2,N);
    
    B_0 = mu_0*J*vecR;
    B(r < a) = B_0;
    I = r >= a & r <= b;
    B(I) = B_0*(r(I) - b)/(a-b);
    
end