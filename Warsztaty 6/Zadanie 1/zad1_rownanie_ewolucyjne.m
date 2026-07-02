function u = zad1_rownanie_ewolucyjne(x_p, x_k, t_k, c, a, h, lambda,rysuj,t_0)
% Parametry
k = lambda*h;
% Inicjalizacja macierzy przechowujacej kolejne przyblizenia
x = x_p:h:x_k;
t = 0:k:t_k;

m_init = length(x);
n_init = length(t);

u = zeros(m_init, n_init);

% Warunek poczatkowy
u(:,1) = cos(pi*x).';
u(:,2) = u(:,1) + h*c*pi*sin(pi*x).';

% Warunek brzegowy 
eta_minus = c - sqrt(a*a + c*c);
eta_plus = c + sqrt(a*a + c*c);
u(1,:) = 0.5*(cos(pi*(x_p - eta_plus*t)) + cos(pi*(x_p - eta_minus*t)));
u(end,:) = 0.5*(cos(pi*(x_k - eta_plus*t)) + cos(pi*(x_k - eta_minus*t)));

% Schemat z zadania
for n = 3:n_init
    a_thomas = zeros(1, m_init-2) - c/(2*k*h);
    b_thomas = zeros(1, m_init-2) + 1/(k*k);
    c_thomas = zeros(1, m_init-2) + c/(2*k*h);
    d_thomas = ((-1/(k*k))*u(2:end-1,n-2) + (c/(2*k*h))*u(3:end,n-2)...
        - (c/(2*k*h))*u(1:end-2,n-2) + ((a*a)/(h*h))*u(3:end,n-1)...
        + ((a*a)/(h*h))*u(1:end-2,n-1) + ((2/(k*k))...
        - ((2*a*a)/(h*h)))*u(2:end-1,n-1))';
    u(2:end-1,n) = algorytm_thomasa(a_thomas, b_thomas,...
        c_thomas, d_thomas, u(1, n), u(end,n))';
end

if rysuj

hold on
grid on
% Rozwiazanie przyblizone dla czasu t = t_0
n_0 = sum(t <= t_0);
plot(x, u(:,n_0))

end

end