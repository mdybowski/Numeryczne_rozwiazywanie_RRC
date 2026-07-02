function u = leapfrog_Neumann(x_p, x_k, t_k, b, mu,...
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


% Schemat forward-time central-space dla n=2 (druga chwila czasowa)

    
u(2:end-1,2) = b*mu*(u(3:end,1)...
        + u(1:end-2,1)) + (1-2*b*mu)*u(2:end-1,1) + k*f(2:end-1,1);

% Warunek brzegowy typu Neumanna
    u(1,2) = (-1/3)*(u(3,2) - 4*u(2,2));
    u(end,2) = -3*u(end-2,2) + 4*u(end-1,2);

% Schemat leapfrog
for n = 3:n_init
    
    u(2:end-1, n) = 2*b*mu*(u(3:end, n-1) - 2*u(2:end-1, n-1)...
        + u(1:end-2, n-1)) + u(2:end-1, n-2) + 2*k*f(2:end-1, n);
    
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