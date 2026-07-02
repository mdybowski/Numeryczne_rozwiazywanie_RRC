function u = forward_time_forward_space(lambda,h,a,rysuj,t_0)
% Zmienne przestrzenne
x_p = -1;
x_k = 3;
% Czas
t_p = 0;
t_k = 1;
% Parametry
k = lambda * h;
% Inicjalizacja macierzy przechowujacej kolejne przyblizenia
x = x_p:h:x_k;
t = t_p:k:t_k;

m_init = length(x);
n_init = length(t);

u = zeros(m_init, n_init);

u(:,1) = ((abs(x) <= 1).*(1- abs(x))).';  % warunek poczatkowy
% u(1,:) = 0 - warunek brzegowy

% Schemat forward-time forward-space
for n = 2:n_init
    u(2:end-1,n) = -lambda*a*(u(3:end,n-1) - u(2:end-1,n-1))...
        + u(2:end-1,n-1);  
    u(end,n) = u(end-1,n);
end

if rysuj

hold on
grid on
% Rozwiazanie przyblizone dla czasu t = t_0
n_0 = sum(t <= t_0);
plot(x, u(:,n_0))
% Rozwiazanie analityczne rownania transportu dla t = t_0
plot(x, (abs(x-a*t_0) <= 1).*(1- abs(x-a*t_0)))

end

end