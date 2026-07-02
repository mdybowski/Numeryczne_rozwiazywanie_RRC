function u = forward_time_central_space_zad3_pod_wiatr(x_p, x_k, t_k,...
    b,a, k, u_0, h,rysuj,t_0)
% Parametry
mu = k/(h*h);
alpha= h*a/(2*b);
% Inicjalizacja macierzy przechowującej kolejne przybliżenia
x = x_p:h:x_k;
t = 0:k:t_k;

m_init = length(x);
n_init = length(t);

u = zeros(m_init, n_init);

% Warunek poczatkowy
u(:,1) = u_0;

% Schemat forward-time central-space (zag. konwekcji-dyfuzji)
for n = 2:n_init
    u(2:end-1,n) = (1-2*b*mu*(1+alpha))*u(2:end-1,n-1) +...
        b*mu*u(3:end,n-1) + b*mu*(1+2*alpha)*u(1:end-2,n-1);   
end

if rysuj

hold on
grid on
% Rozwiązanie przybliżone dla czasu t = t_0
n_0 = sum(t <= t_0);
plot(x, u(:,n_0))

end

end