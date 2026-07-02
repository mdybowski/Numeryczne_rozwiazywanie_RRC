function u = burgers_lax_friedrichs(lambda,h,uL,uR)
% Zmienne przestrzenne
x_p = -4;
x_k = 4;
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

s = (2/3)*(uR^3 - uL^3)/(uR^2 - uL^2);

u = zeros(m_init, n_init);

% warunek poczatkowy
    u(:,1) = (uL*(x <= 0) + uR*(x > 0)).';
% warunek brzegowy
    u(1,:) = uL*(x_p < s*t) + uR*(x_p > s*t);

% Schemat Laxa-Friedrichsa dla rownania Burgersa
for n = 2:n_init
    u(2:end-1,n) = 0.5*(u(1:end-2,n-1) + u(3:end,n-1)) - ...
        0.25*lambda*(u(3:end,n-1).*u(3:end,n-1)...
        - u(1:end-2,n-1).*u(1:end-2,n-1));
end

end