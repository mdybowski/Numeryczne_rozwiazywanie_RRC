function u = forward_time_central_space(lambda,h,rysuj,t_0)
% Zmienne przestrzenne
x_p = -1;
x_k = 3;
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
% u(1,:) = 0 - warunek brzegowy

% Schemat forward-time central-space
for n = 2:n_init
    u(2:end-1,n) = -0.5*lambda*a*(u(3:end,n-1)...
        - u(1:end-2,n-1)) + u(2:end-1,n-1);   
    u(end,n) = u(end-1,n);
end

if rysuj

hold on
grid on
% Rozwiązanie przybliżone dla czasu t = t_0
n_0 = sum(t <= t_0);
plot(x, u(:,n_0))
% Rozwiązanie analityczne równania transportu dla t = t_0
plot(x, (abs(x-t_0) <= 0.5).*cos(pi*(x - t_0)).*cos(pi*(x - t_0)))

end

end