function E = calc_exact_E(files, N, r)

Rd = 0.2;
eps_0 = 8.854187e-12;
rho = 1e-6*4/3*pi*Rd^3; %charge density

vecR = linspace(0,1,N);

E = zeros(N,1);
I = vecR <= Rd;
E(I) = (rho*vecR(I))/(4*pi*eps_0*Rd^3);
E(~I) = rho./(4*pi*eps_0*vecR(~I).^2);

end