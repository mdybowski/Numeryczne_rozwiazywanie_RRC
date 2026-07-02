% Animacja przyblizonych rozwiazan

lambda = 0.4;
h = 1/40;
k = lambda * h;

t_p = 0;
t_k = 1;

x_p = -1;
x_k = 2;

t = t_p:k:t_k;

n_init = length(t);

x = x_p:h:x_k;

y_p = -5;
y_k = 5;

war_pocz = (exp(-x.^2)).';
u = burgers_forward_time_backward_space(war_pocz,0,0,lambda,h);

% Calkowite wahanie
TV = @(x) sum(abs(diff(x)));

figure
subplot(2,1,1)
p1 = plot(NaN, NaN);
axis([x_p x_k y_p y_k]);
subplot(2,1,2)
p2 = plot(NaN, NaN);
set(p2, 'XData', 1:n_init, 'YData', TV(u));
title('Zanikanie calkowitego wahania');

for i = 1:n_init
    pause(0.2)        % Mozna modyfikowac, zeby zmienic szybkosc animacji
    
    set(p1, 'XData', x, 'YData', u(:, i));
    subplot(2,1,1)
    title(['t = ' num2str(t(i))]);
end


