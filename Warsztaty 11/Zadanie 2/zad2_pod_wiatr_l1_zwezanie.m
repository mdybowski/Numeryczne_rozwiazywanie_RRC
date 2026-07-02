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

norma_L1 = @(x,y) sum(abs(x-y));


uL = 1;
uR = 2;
s = 0.5*(uL + uR);
war_pocz = (uL*(x <= 0) + uR*(x > 0)).';
war_brzeg_lewy = uL*(x_p < s*t) + uR*(x_p > s*t);
war_brzeg_prawy = uL*(x_k < s*t) + uR*(x_k > s*t);
u1 = burgers_forward_time_backward_space(war_pocz,war_brzeg_lewy,...
    war_brzeg_prawy,lambda,h);

uL = 0;
uR = 1;
s = 0.5*(uL + uR);
war_pocz = (uL*(x <= 0) + uR*(x > 0)).';
war_brzeg_lewy = uL*(x_p < s*t) + uR*(x_p > s*t);
war_brzeg_prawy = uL*(x_k < s*t) + uR*(x_k > s*t);
u2 = burgers_forward_time_backward_space(war_pocz,war_brzeg_lewy,...
    war_brzeg_prawy,lambda,h);

figure
subplot(3,1,1)
p1 = plot(NaN, NaN);
axis([x_p x_k y_p y_k]);
subplot(3,1,2)
p2 = plot(NaN, NaN);
axis([x_p x_k y_p y_k]);
subplot(3,1,3)
p3 = plot(NaN, NaN);
set(p3, 'XData', 1:n_init, 'YData', norma_L1(u1,u2));
title('l1-zwezanie');

for i = 1:n_init
    pause(0.2)        % Mozna modyfikowac, zeby zmienic szybkosc animacji
    
    set(p1, 'XData', x, 'YData', u1(:, i));
    subplot(3,1,1)
    title(['t = ' num2str(t(i))]);
    
    set(p2, 'XData', x, 'YData', u2(:, i));
    subplot(3,1,2)
    title(['t = ' num2str(t(i))]);
end


