function u = zad2_rownanie_falowe_2(x_p, x_k, t_k, a, h, lambda,rysuj,t_0)
% Parametry
k = lambda*h;
% Inicjalizacja macierzy przechowujacej kolejne przyblizenia
x = x_p:h:x_k;
t = 0:k:t_k;

m_init = length(x);
n_init = length(t);

u = zeros(m_init, n_init);

% Warunek poczatkowy
u(:,1) = 2*cos(x).';
% du(x,t)/dt = sin(x-t) - sin(x+t), wiec du(x,0)/dt = 0
u(:,2) = u(:,1);

% Warunek brzegowy Dirichleta
u(end,:) = cos(x_k+t) + cos(x_k-t);

% Schemat podstawowy
for n = 3:n_init
    
    u(2:end-1,n) = a*a*lambda*lambda*(u(3:end,n-1) - 2*u(2:end-1,n-1)...
        + u(1:end-2,n-1)) + 2*u(2:end-1,n-1) - u(2:end-1,n-2);
    
    % Warunek brzegowy Neumanna    
    u(1,n) = 2*u(1,n-1) - u(1,n-2) - 2*a*a*lambda*lambda*...
        (u(1,n-1) - u(2,n-1));
end

if rysuj

hold on
grid on
% Rozwiazanie przyblizone dla czasu t = t_0
n_0 = sum(t <= t_0);
plot(x, u(:,n_0))

end

end