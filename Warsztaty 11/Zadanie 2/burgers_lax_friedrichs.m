function u = burgers_lax_friedrichs(war_pocz,war_brzeg_lewy,...
    war_brzeg_prawy,lambda,h)
% Zmienne przestrzenne
x_p = -3;
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

% warunek poczatkowy
u(:,1) = war_pocz;

% warunek brzegowy (z warunku Rankine-Hugoniota)
u(1,:) = war_brzeg_lewy;
u(end,:) = war_brzeg_prawy;

% Schemat Laxa-Friedrichsa dla rownania Burgersa
for n = 2:n_init
    u(2:end-1,n) = 0.5*(u(1:end-2,n-1) + u(3:end,n-1)) - ...
        0.25*lambda*(u(3:end,n-1).*u(3:end,n-1)...
        - u(1:end-2,n-1).*u(1:end-2,n-1));
end

end