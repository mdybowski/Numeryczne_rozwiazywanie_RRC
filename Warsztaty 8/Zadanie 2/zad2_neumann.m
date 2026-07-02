options = struct;
options.gType = "function";
options.fType = "function";
options.boundary = "Neumann";
options.error = 10^-7;
options.additionalPoint = [0.5,0.5,-2*cos(0.5)*sin(0.5)];

Omega = [1 1];

% Skomplikowany zapis ze wzgledu na obsluzenie sytuacji gdy g jest na
% rogach kwadratu
g = @(x,y) -sin(x).*sin(y).*((x==0)*(-1) + (x==Omega(1))).*(0 < y & y < Omega(2)) +...
    cos(x).*cos(y).*((y==0)*(-1) + (y==Omega(2))).*...
    (0 < x & x < Omega(1)) -cos(x).*cos(y).*(x==0 & y==0)...
    -cos(x).*cos(y).*(x==Omega(1) & y==0) + cos(x).*cos(y).*...
    (x==0 & y==Omega(2))+ cos(x).*cos(y).*(x==Omega(1) & y==Omega(2));

f = @(x,y) -2*cos(x)*sin(y);

options.h = 0.1;
options.omega = 2/(1+pi*options.h);
[u1, X1, Y1, M1, N1] = PoissonEquationSOR(f, g, Omega, options);

options.h = 0.05;
options.omega = 2/(1+pi*options.h);
[u2, X2, Y2, M2, N2] = PoissonEquationSOR(f, g, Omega, options);

options.h = 0.025;
options.omega = 2/(1+pi*options.h);
[u3, X3, Y3, M3, N3] = PoissonEquationSOR(f, g, Omega, options);

u_analityczne = cos(X3)'*sin(Y3);

subplot(1,4,1);
surf(X1,Y1,u1);
title('h=0.1');
subplot(1,4,2);
surf(X2,Y2,u2);
title('h=0.05');
subplot(1,4,3);
surf(X3,Y3,u3);
title('h=0.025');
subplot(1,4,4);
surf(X3,Y3,u_analityczne);
title('Dokladne, h =0.025');


