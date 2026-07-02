% Animacja przyblizonych rozwiazan

lambda = 0.4;
h = 1/40;
k = lambda * h;

t_p = 0;
t_k = 1;

x_p = -1;
x_k = 5;

t = t_p:k:t_k;

n_init = length(t);

x = x_p:h:x_k;

y_p = -5;
y_k = 5;

uL = 1;
uR = 4;

% Predkosci fali uderzeniowej
s = 0.5*(uL + uR);

u = burgers_lax_friedrichs(uL,uR,lambda,h);


figure
p1 = plot(NaN, NaN);
axis([x_p x_k y_p y_k]);

for i = 1:n_init
    pause(0.2)        % Mozna modyfikowac, zeby zmienic szybkosc animacji
    
    set(p1, 'XData', x, 'YData', u(:, i));
    title(['t = ' num2str(t(i))]);
end

% Widzimy ze metoda ta jest monotoniczna dla takich danych
% poczatkowych

