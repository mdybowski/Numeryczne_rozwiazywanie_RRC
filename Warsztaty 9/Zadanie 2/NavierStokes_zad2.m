options = struct;
options.error = 10^-4;
options.h = 1/128;
options.theta = 2/(1 + sin(pi*options.h));
options.sigma = 2/(1 + sin(pi*options.h));
options.delta_t = 10^-4;
options.nu = 0.1;
options.u_falka = 4;

T = 1;

% Przykladowe warunki poczatkowe
u0 = @(x,y) sin(x)*cos(y);
v0 = @(x,y) -cos(x)*sin(y);

[u,v,X,M,N,K,psi,omega,psi_SOR_iter, omega_SOR_iter]...
    = NavierStokesSquare(T, u0, v0, options);

przykladowy_punkt = [64,64]; % we wspolrzednych siatki
trajektoria_x = zeros(1,K);
trajektoria_y = zeros(1,K);
trajektoria_x(1) = przykladowy_punkt(1)*options.h;
trajektoria_y(1) = przykladowy_punkt(2)*options.h;

% Wyznaczanie trajektorii przykladowego punktu
for i=1:K
    trajektoria_x(i+1) = trajektoria_x(i) + options.delta_t*...
        u(floor(trajektoria_x(i)/options.h),...
        floor(trajektoria_y(i)/options.h),i);
    trajektoria_y(i+1) = trajektoria_y(i) + options.delta_t*...
        v(floor(trajektoria_x(i)/options.h),...
        floor(trajektoria_y(i)/options.h),i);
end
