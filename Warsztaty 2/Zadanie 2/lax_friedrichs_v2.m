function u = lax_friedrichs_v2(lambda,h,alpha,rysuj,t_0)
% Zmienne przestrzenne
x_p = -3;
x_k = 3;
% Czas
t_p = 0;
t_k = 2;
% Parametry
k = lambda * h;
% Inicjalizacja macierzy przechowujacej kolejne przyblizenia
x = x_p:h:x_k;
t = t_p:k:t_k;

m_init = length(x);
n_init = length(t);

u = zeros(m_init, n_init);

u(:,1) = ((abs(x) <= 1).*(exp(x.^2))).';  % warunek poczatkowy
% u(1,:) = 0 - warunek brzegowy

% Schemat lax-friedrichs
for n = 2:n_init
    u(2:end-1,n) = -0.5*lambda*(1+alpha*x(2:end-1))'.*(u(3:end,n-1)...
        - u(1:end-2,n-1)) + 0.5*(u(3:end,n-1)...
        + u(1:end-2,n-1));  
    u(end,n) = u(end-1,n);
end

if rysuj

hold on
grid on
% Rozwiazanie przyblizone dla czasu t = t_0
n_0 = sum(t <= t_0);
plot(x, u(:,n_0))

end

end