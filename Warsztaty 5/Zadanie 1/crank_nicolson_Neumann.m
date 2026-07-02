function u = crank_nicolson_Neumann(x_p, x_k, t_k, b, mu,...
    f, u_0, h,rysuj,t_0)
% Parametry
k = mu*h*h;
% Inicjalizacja macierzy przechowującej kolejne przybliżenia
x = x_p:h:x_k;
t = 0:k:t_k;

m_init = length(x);
n_init = length(t);

u = zeros(m_init, n_init);

% Warunek poczatkowy
u(:,1) = u_0;

% Schemat Cranka-Nicolsona
for n = 2:n_init
    
    a_thomas = zeros(1, m_init-2) - b*mu/2;
    b_thomas = zeros(1, m_init-2) + 1 + b*mu;
    c_thomas = zeros(1, m_init-2) - b*mu/2;
    d_thomas = (b*mu*0.5*(u(3:end,n-1) + u(1:end-2,n-1)) +...
        (1-b*mu)*u(2:end-1,n-1) + 0.5*(f(1:end-2, n-1) + f(1:end-2, n)))';
    u(2:end-1,n) = algorytm_thomasa(a_thomas, b_thomas,...
        c_thomas, d_thomas, u(1, n-1), u(end,n-1))';
    
    % Warunek brzegowy typu Neumanna
    u(1,n) = (-1/3)*(u(3,n) - 4*u(2,n));
    u(end,n) = -3*u(end-2,n) + 4*u(end-1,n);
end

if rysuj

hold on
grid on
% Rozwiązanie przybliżone dla czasu t = t_0
n_0 = sum(t <= t_0);
plot(x, u(:,n_0))

end

end