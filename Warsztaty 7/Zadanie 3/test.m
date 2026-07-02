options = struct;
options.gType = "function";
options.fType = "function";
Omega = [1 1];
g = @(x,y) cos(x)*sin(y);
f = @(x,y) -2*cos(x)*sin(y);

options.h = 0.1;
[u1, X1, Y1, M1, N1] = PoissonEquationTHOMAS(f, g, Omega, options);
options.h = 0.05;
[u2, X2, Y2, M2, N2] = PoissonEquationTHOMAS(f, g, Omega, options);
options.h = 0.025;
[u3, X3, Y3, M3, N3] = PoissonEquationTHOMAS(f, g, Omega, options);
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


