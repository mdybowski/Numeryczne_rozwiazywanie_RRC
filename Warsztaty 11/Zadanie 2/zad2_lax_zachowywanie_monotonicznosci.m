% Animacja przyblizonych rozwiazan

lambda = 0.4;
h = 1/40;
k = lambda * h;

t_p = 0;
t_k = 1;

x_p = -3;
x_k = 3;

t = t_p:k:t_k;

n_init = length(t);

x = x_p:h:x_k;

y_p = -5;
y_k = 5;
s = 0.5*(uL + uR);
uL = 1;
uR = 4;
war_pocz = (uL*(x <= 0) + uR*(x > 0)).';
war_brzeg_lewy = uL*(x_p < s*t) + uR*(x_p > s*t);
war_brzeg_prawy = uL*(x_k < s*t) + uR*(x_k > s*t);
u = burgers_lax_friedrichs(war_pocz,war_brzeg_lewy,...
    war_brzeg_prawy,lambda,h);


figure
p1 = plot(NaN, NaN);
axis([x_p x_k y_p y_k]);

for i = 1:n_init
    pause(0.2)        % Mozna modyfikowac, zeby zmienic szybkosc animacji
    
    set(p1, 'XData', x, 'YData', u(:, i));
    title(['t = ' num2str(t(i))]);
end

% Widzimy ze metoda ta zachowuje monotonicznosc dla takich danych
% poczatkowych

