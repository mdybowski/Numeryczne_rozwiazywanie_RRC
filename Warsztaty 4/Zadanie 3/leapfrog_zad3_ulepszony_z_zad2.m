function u = leapfrog_zad3_ulepszony_z_zad2(lambda,h,rysuj,t_0,eps)
% Zmienne przestrzenne
x_p = -2;
x_k = 2;
% Czas
t_p = 0;
t_k = 15;
% Parametry
k = lambda * h;
a = 1;
% Inicjalizacja macierzy przechowującej kolejne przybliżenia
x = x_p:h:x_k;
t = t_p:k:t_k;

eps_drugi = 0.5*(1 - (a*lambda)^2);

m_init = length(x);
n_init = length(t);

u = zeros(m_init, n_init);

u(:,1) = ((-2)*mod(0:m_init-1, 2) + 1)*eps;
u(:,2) = (2*mod(0:m_init-1, 2) - 1)*eps; % warunek początkowy

% Schemat leapfrog
for n = 3:n_init    
    u(3:end-2,n) = -lambda*a*(u(4:end-1,n-1)...
        - u(2:end-3,n-1)) + u(3:end-2,n-2)...
        - (eps_drugi/16)*(u(5:end,n-1)...
        - 4*u(4:end-1,n-1) + 6*u(3:end-2, n-1)...
        - 4*u(2:end-3,n-1) + u(1:end-4,n-1));
end

if rysuj

hold on
grid on
% Rozwiązanie przybliżone dla czasu t = t_0
n_0 = sum(t <= t_0);
plot(x, u(:,n_0))

end

end