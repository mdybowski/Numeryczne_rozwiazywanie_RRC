% Animacja przyblizonego rozwiazania

lambda = 1;
h = 0.1;
k = lambda * h;

t_p = 0;
t_k = 2;

x_p = -3;
x_k = 3;

t = t_p:k:t_k;

n_init = length(t);

x = x_p:h:x_k;

alpha = -0.5;


y_p_1 = -15;
y_k_1 = 15;

y_p_2 = -60;
y_k_2 = 60;

y_p_3 = -0.5*10^5;
y_k_3 = 0.5*10^5;


u_1 = lax_friedrichs_v1(lambda,h,alpha,false,0);
u_2 = lax_friedrichs_v2(lambda,h,alpha,false,0);
u_3 = lax_friedrichs_v3(lambda,h,alpha,false,0);


figure
subplot(3,1,1)
p1 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p_1 y_k_1]);
subplot(3,1,2)
p2 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p_2 y_k_2]);
subplot(3,1,3)
p3 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p_3 y_k_3]);



for i = 1:n_init
    pause(0.5)        % Mozna modyfikowac, zeby zmienic szybkosc animacji
    
    set(p1, 'XData', x, 'YData', u_1(:, i));
    subplot(3,1,1)
    title(['t = ' num2str(t(i))]);
    
    set(p2, 'XData', x, 'YData', u_2(:, i));
    subplot(3,1,2)
    title(['t = ' num2str(t(i))]);
    
    set(p3, 'XData', x, 'YData', u_3(:, i));
    subplot(3,1,3)
    title(['t = ' num2str(t(i))]);

end

% W naszym przypadku na przedziale (-3, 3) warunek
% |(1+alpha*x_m)lambda| > 1 zachodzi <=> -3 < x < 0. Mozna wowczas
% zaobserwowac, ze rozwiazania sa niestabilne.

