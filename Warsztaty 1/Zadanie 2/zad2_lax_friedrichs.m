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
        - v(1:end-2,n-1))-k*(1/3)*u(2:end-1,n-1) + 0.5*(u(3:end,n-1)...
        + u(1:end-2,n-1));
    u(end,n) = u(end-1,n);
    
    v(2:end-1,n) = -0.5*lambda*(1/3)*(t(n-1)+1)*(v(3:end,n-1)...
        - v(1:end-2,n-1))-0.5*lambda*(1/3)*(2*t(n-1)-1)*(u(3:end,n-1)...
        - u(1:end-2,n-1))+k*(1/3)*v(2:end-1,n-1) + 0.5*(v(3:end,n-1)...
        + v(1:end-2,n-1));
    v(end,n) = v(end-1,n);
end

% Animacja przybliżonych rozwiązań
y_p = -1;
y_k = 1;

pl = plot(NaN,NaN,NaN,NaN);
axis([x_p x_k y_p y_k]);
for i = 1:n_init
    pause(0.1)
    set(pl(1), 'XData', x, 'YData', u(:, i));
    set(pl(2), 'XData', x, 'YData', v(:, i));
    
    title(['t = ' num2str(t(i))]);
end

% Od t = 1.5 rozwiązanie układu równań zaczyna się stabilizować
% (w tym sensie, że nie pojawiają się znaczącze zmiany kształtu
% rozwiązania) i zaobserwować można, że wówczas rozwiązanie
% "przesuwa się" do przodu.