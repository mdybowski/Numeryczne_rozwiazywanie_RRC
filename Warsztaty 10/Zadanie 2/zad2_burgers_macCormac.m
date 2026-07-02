% Animacja przyblizonych rozwiazan

lambda = 0.4;
h = 1/40;
k = lambda * h;

t_p = 0;
t_k = 1;

x_p = -4;
x_k = 4;

t = t_p:k:t_k;

n_init = length(t);

x = x_p:h:x_k;

y_p = -5;
y_k = 5;

u = burgers_macCormac(lambda,h);


figure
p1 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p y_k]);

for i = 1:n_init-1
    pause(0.2)        % Mozna modyfikowac, zeby zmienic szybkosc animacji
    
    set(p1(1), 'XData', x, 'YData', (x<t(i)) + ((1-x)/(1-t(i))).*(x>=t(i)).*(x<=1));
    set(p1(2), 'XData', x, 'YData', u(:, i));
    legend('Rozw słabe', 'Rozw przybliżone', 'Location','southwest');
    title(['t = ' num2str(t(i))]);
end

% Rozwiazanie to zachowuje sie lepiej niz rozwiazania uzyskane dla rownania
% z zadania 1. Miejsce w ktorym jest "skok" caly czas dobrze pokrywa sie ze
% slabym rozwiazaniem.
