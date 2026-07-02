function u = burgers_forward_time_backward_space(war_pocz,war_brzeg_lewy,...
    war_brzeg_prawy,lambda,h)
% Zmienne przestrzenne
x_p = -1;
x_k = 2;
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

% Schemat forward-time backward-space dla rownania Burgersa
for n = 2:n_init
    u(2:end,n) = u(2:end,n-1) - lambda*u(2:end,n-1).*(u(2:end,n-1)...
        - u(1:end-1, n-1));   
end

end