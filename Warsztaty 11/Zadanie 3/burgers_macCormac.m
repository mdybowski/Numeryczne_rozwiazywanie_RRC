function u = burgers_macCormac(lambda,h)
% Zmienne przestrzenne
x_p = -4;
x_k = 4;
% Czas
t_p = 0;
t_k = 0.5;
% Parametry
k = lambda * h;
% Inicjalizacja macierzy przechowujacej kolejne przyblizenia
x = x_p:h:x_k;
t = t_p:k:t_k;

m_init = length(x);
n_init = length(t);

u = zeros(m_init, n_init);
u_gwiazdka = zeros(m_init, 1);

% warunek poczatkowy
u(:,1) = ((x<=0) + (1-x).*(0<x).*(x<=1)).';
% warunek brzegowy
u(1,:) = (x_p<t) + ((1-x_p)./(1-t)).*(x_p>=t).*(x_p<1);

% Schemat MacCormac dla rownania Burgersa
for n = 2:n_init
    u_gwiazdka(1:end-1, 1) = u(1:end-1, n-1) - 0.5*lambda*...
        (u(2:end,n-1).*u(2:end,n-1) - u(1:end-1,n-1).*u(1:end-1,n-1));
    u(2:end-1,n) = 0.5*(u(2:end-1,n-1) + u_gwiazdka(2:end-1, 1))...
        -0.25*lambda*(u_gwiazdka(2:end-1, 1).*u_gwiazdka(2:end-1, 1)...
        - u_gwiazdka(1:end-2, 1).*u_gwiazdka(1:end-2, 1));
end

end