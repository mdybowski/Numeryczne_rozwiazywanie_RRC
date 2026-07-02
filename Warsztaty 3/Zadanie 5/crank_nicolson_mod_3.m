function u = crank_nicolson_mod_3(lambda,h,rysuj,t_0)

% Zmienne przestrzenne
x_p = 0;
x_k = 1;
% Czas
t_p = 0;
t_k = 2;
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

% Schemat Cranka-Nicolsona
for n = 2:n_init
    a_thomas = zeros(1, m_init-1) - a*lambda/4;
    b_thomas = zeros(1, m_init-1) + 1;
    c_thomas = zeros(1, m_init-1) + a*lambda/4;
    d_thomas = (-(a*lambda/4)*[u(3:end,n-1); u(1,n-1)] + u(2:end,n-1) + (a*lambda/4)*u(1:end-1,n-1))';
    u(2:end-1,n) = algorytm_thomasa_zmodyfikowany(a_thomas, b_thomas, c_thomas, d_thomas)';
    u(1,n) = 2*u(2,n) - u(3,n);
    u(end,n) = u(end-1, n-1);
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