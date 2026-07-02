function u = lax_wendroff_zad1(lambda,h,rysuj,t_0)
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

% Schemat Laxa-Wendroffa
for n = 2:n_init
    u(1,n) = 0.5*(a^2)*(lambda^2)*(u(2, n-1) -...
        2*u(1, n-1) + u(end, n-1)) - ...
        0.5*a*lambda*(u(2, n-1) - u(end, n-1)) + u(1, n-1);
    
    u(2:end-1,n) = 0.5*(a^2)*(lambda^2)*(u(3:end, n-1) -...
        2*u(2:end-1, n-1) + u(1:end-2, n-1)) - ...
        0.5*a*lambda*(u(3:end, n-1) - u(1:end-2, n-1)) + u(2:end-1, n-1);
    
    u(end,n) = 0.5*(a^2)*(lambda^2)*(u(1, n-1) -...
        2*u(end, n-1) + u(end-1, n-1)) - ...
        0.5*a*lambda*(u(1, n-1) - u(end-1, n-1)) + u(end, n-1); 
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