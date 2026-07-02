function u = leapfrog_1(lambda,h,rysuj,t_0)
% Zmienne przestrzenne
x_p = 0;
x_k = 1;
% Czas
t_p = 0;
t_k = 5;
% Parametry
k = lambda * h;
a = 1;
% Inicjalizacja macierzy przechowującej kolejne przybliżenia
x = x_p:h:x_k;
t = t_p:k:t_k;

m_init = length(x);
n_init = length(t);

u = zeros(m_init, n_init);

u(:,1) = (sin(2*pi*x)).';  % warunek początkowy

% Schemat forward-time central-space dla n=2 (druga chwila czasowa)
u(2:end-1,2) = -0.5*lambda*a*(u(3:end,1)...
    - u(1:end-2,1)) + u(2:end-1,1); 
u(end,2) = 2*u(end-1,2) - u(end-2,2);
u(1,2) = u(end,2);
% Schemat leapfrog
for n = 3:n_init
    u(2:end-1,n) = -lambda*a*(u(3:end,n-1)...
        - u(1:end-2,n-1)) + u(2:end-1,n-2);
    u(end,n) = 2*u(end-1,n) - u(end-2,n);
    u(1,n) = u(end,n);
end

if rysuj

hold on
grid on
% Rozwiązanie przybliżone dla czasu t = t_0
n_0 = sum(t <= t_0);
plot(x, u(:,n_0))
% Rozwiązanie analityczne równania transportu dla t = t_0
plot(x, (sin(2*pi*(x - a*t_0))))

end

end