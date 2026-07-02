function u = burgers_pod_wiatr(uL,uR,lambda,h)
% Zmienne przestrzenne
x_p = -5;
x_k = 5;
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

% warunek poczatkowy
u(:,1) = (uL*(x < 1) + uR*(x > 1)).';

% warunek brzegowy
u(1,:) = -1;
u(end,:) = 1;

% Schemat pod wiatr dla rownania Burgersa
for n = 2:n_init
    u(2:end-1,n) = u(2:end-1,n-1) - lambda*(F(u(2:end-1,n-1),u(3:end,n-1))...
        - F(u(1:end-2,n-1),u(2:end-1,n-1)));   
end

end