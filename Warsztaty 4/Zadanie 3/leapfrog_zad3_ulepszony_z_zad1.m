function u = leapfrog_zad3_ulepszony_z_zad1(lambda,h,rysuj,t_0)
% Zmienne przestrzenne
x_p = -1;
x_k = 7;
% Czas
t_p = 0;
t_k = 2.4;
% Parametry
k = lambda * h;
a = 1;
% Inicjalizacja macierzy przechowującej kolejne przybliżenia
x = x_p:h:x_k;
t = t_p:k:t_k;

m_init = length(x);
n_init = length(t);

u = zeros(m_init, n_init);

u(:,1) = ((abs(x) <= 0.5).*cos(pi*x).*cos(pi*x)).';  % warunek początkowy

eps = 0.5*(1 - (a*lambda)^2);

% Schemat forward-time central-space dla n=2 (druga chwila czasowa)
u(1,2) = -0.5*lambda*a*(u(2,1)...
    - u(end,1)) + u(1,1); 

u(2:end-1,2) = -0.5*lambda*a*(u(3:end,1)...
    - u(1:end-2,1)) + u(2:end-1,1); 

u(end,2) = -0.5*lambda*a*(u(1,1)...
    - u(end-1,1)) + u(end,1);
% Schemat leapfrog
for n = 3:n_init
    
    u(1,n) = -lambda*a*(u(2,n-1)...
        - u(end,n-1)) + u(1,n-2)...
        - (eps/16)*(u(3,n-1)...
        - 4*u(2,n-1) + 6*u(1, n-1)...
        - 4*u(end,n-1) + u(end-1,n-1));
    
    u(2,n) = -lambda*a*(u(3,n-1)...
        - u(1,n-1)) + u(2,n-2)...
        - (eps/16)*(u(4,n-1)...
        - 4*u(3,n-1) + 6*u(2, n-1)...
        - 4*u(1,n-1) + u(end,n-1));
    
    u(3:end-2,n) = -lambda*a*(u(4:end-1,n-1)...
        - u(2:end-3,n-1)) + u(3:end-2,n-2)...
        - (eps/16)*(u(5:end,n-1)...
        - 4*u(4:end-1,n-1) + 6*u(3:end-2, n-1)...
        - 4*u(2:end-3,n-1) + u(1:end-4,n-1));
    
    u(end-1,n) = -lambda*a*(u(end,n-1)...
        - u(end-2,n-1)) + u(end-1,n-2)...
        - (eps/16)*(u(1,n-1)...
        - 4*u(end,n-1) + 6*u(end-1, n-1)...
        - 4*u(end-2,n-1) + u(end-3,n-1));
    
    u(end,n) = -lambda*a*(u(1,n-1)...
        - u(end-1,n-1)) + u(end,n-2)...
        - (eps/16)*(u(2,n-1)...
        - 4*u(1,n-1) + 6*u(end, n-1)...
        - 4*u(end-1,n-1) + u(end-2,n-1));
end

if rysuj

hold on
grid on
% Rozwiązanie przybliżone dla czasu t = t_0
n_0 = sum(t <= t_0);
plot(x, u(:,n_0))
% Rozwiązanie analityczne równania transportu dla t = t_0
plot(x, ((abs(x-a*t_0) <= 0.5).*cos(pi*(x-a*t_0)).*cos(pi*(x-a*t_0))))

end

end