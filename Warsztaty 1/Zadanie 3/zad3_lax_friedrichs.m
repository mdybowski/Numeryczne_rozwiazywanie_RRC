% Zmienne przestrzenne
x_p = -3;
x_k = 3;
% Czas
t_p = 0;
t_k = 2;
% Parametry
lambda = 0.5;
h = 1/20;
k = lambda * h;
% Inicjalizacja macierzy przechowującej kolejne przybliżenia
x = x_p:h:x_k;
t = t_p:k:t_k;

m_init = length(x);
n_init = length(t);

u = zeros(m_init, n_init);
v = zeros(m_init, n_init);

u(:,1) = max(0, 1 - abs(x)).';  % warunek początkowy
% u(1,:) = 0 - warunek brzegowy

v(:,1) = max(0, 1 - 2*abs(x)).';  % warunek początkowy
% v(1,:) = 0 - warunek brzegowy

% Schemat lax-friedrichs
for n = 2:n_init
    u(2:end-1,n) = -0.5*lambda*(1/3)*(t(n-1)-2)*(u(3:end,n-1)...
        - u(1:end-2,n-1))-0.5*lambda*(2/3)*(t(n-1)+1)*(v(3:end,n-1)...
        - v(1:end-2,n-1)) + 0.5*(u(3:end,n-1)...
        + u(1:end-2,n-1)); 
    u(end,n) = u(end-1,n);
    
    v(2:end-1,n) = -0.5*lambda*(1/3)*(t(n-1)+1)*(v(3:end,n-1)...
        - v(1:end-2,n-1))-0.5*lambda*(1/3)*(2*t(n-1)-1)*(u(3:end,n-1)...
        - u(1:end-2,n-1)) + 0.5*(v(3:end,n-1)...
        + v(1:end-2,n-1));
    v(end,n) = v(end-1,n);
end

% Animacja przybliżonych rozwiązań
y_p = -1;
y_k = 3;
pl = plot(NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN);
axis([x_p x_k y_p y_k]);
legend('Rozw przybliżone u', 'Rozw przybliżone v',...
    'Rozw analityczne u', 'Rozw analityczne v', 'Location','northwest');

% Skrótowe rozwiązanie układu równań:
% Wartości własne : -1, t
% P = [[-1 1];[1 2]]
% w = P*[u;v]
% w_1 = -u(x+t,0) + v(x+t,0)
% w_2 = u(x - 0.5*t^2, 0) + 2*v(x - 0.5*t^2, 0)
% u = (1/3)*(w_2 - 2*w_1);
% v = (1/3)*(w_1 + w_2);

w_1 = -max(0,1-abs(x'+t)) + max(0, 1-2*abs(x'+t));
w_2 = max(0, 1-abs(x' - 0.5*t.^2)) + 2*max(0, 1-2*abs(x' - 0.5*t.^2));
u_analityczne = (1/3)*(w_2 - 2*w_1);
v_analityczne = (1/3)*(w_1 + w_2);
    
for i = 1:n_init
    
    pause(0.1)
    set(pl(1), 'XData', x, 'YData', u(:, i));
    set(pl(2), 'XData', x, 'YData', v(:, i));
    set(pl(3), 'XData', x, 'YData', u_analityczne(:, i));
    set(pl(4), 'XData', x, 'YData', v_analityczne(:, i));
    
    title(['t = ' num2str(t(i))]);
end

% Rozwiązanie otrzymane numerycznie nienajgorzej przybliża rozwiązanie
% analityczne. Widać, że rozwiązanie numeryczne dąży w jakiś sposób
% do rozwiązania analitycznego. Najciekawsze fragmenty rozwiązania to
% skrajnie prawa i lewa część. Można zaobserwować, iż rozwiązanie
% numeryczne porusza się odpowiednio w lewo bądź prawo zgodnie z
% zachowaniem rozwiązania analitycznego, natomiast nie zbliża się zbyt
% dobrze z wartościami do tego rozwiązania,
% co najlepiej widać w prawej części wykresu.
