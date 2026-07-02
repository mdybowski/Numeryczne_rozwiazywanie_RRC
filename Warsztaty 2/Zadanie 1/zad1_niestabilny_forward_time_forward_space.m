% Animacja przyblizonych rozwiazan

lambda = 0.8;
h = 0.1;
k = lambda * h;


t_p = 0;
t_k = 1;

x_p = -1;
x_k = 3;

t = t_p:k:t_k;

n_init = length(t);

x = x_p:h:x_k;

% Bierzemy a takie, aby nie zostal spelniony warunek -1 <= a*lambda <= 0,
% czyli np.

a_1 = -2/lambda;
a_2 = -3/lambda;
a_3 = 1;
a_4 = 2;


y_p_1 = -8000;
y_k_1 = 8000;

y_p_2 = -0.5*10^7;
y_k_2 = 0.5*10^7;

y_p_3 = -2000;
y_k_3 = 2000;

y_p_4 = -0.5*10^6;
y_k_4 = 0.5*10^6;

u_1 = forward_time_forward_space(lambda,h,a_1,false,0);
u_2 = forward_time_forward_space(lambda,h,a_2,false,0);
u_3 = forward_time_forward_space(lambda,h,a_3,false,0);
u_4 = forward_time_forward_space(lambda,h,a_4,false,0);


figure
subplot(4,1,1)
p1 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p_1 y_k_1]);
subplot(4,1,2)
p2 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p_2 y_k_2]);
subplot(4,1,3)
p3 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p_3 y_k_3]);
subplot(4,1,4)
p4 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p_4 y_k_4]);

for i = 1:n_init
    pause(0.5)        % Mozna modyfikowac, zeby zmienic szybkosc animacji
    
    set(p1(1), 'XData', x, 'YData', (abs(x-a_1*t(i)) <= 1).*(1 - abs(x-a_1*t(i))));
    set(p1(2), 'XData', x, 'YData', u_1(:, i));
    subplot(4,1,1)
    legend('Rozw analityczne', 'Rozw przybliżone');
    title(['t = ' num2str(t(i)) ', a = ' num2str(a_1)]);
    
    set(p2(1), 'XData', x, 'YData', (abs(x-a_2*t(i)) <= 1).*(1 - abs(x-a_2*t(i))));
    set(p2(2), 'XData', x, 'YData', u_2(:, i));
    subplot(4,1,2)
    legend('Rozw analityczne', 'Rozw przybliżone');
    title(['t = ' num2str(t(i)) ', a = ' num2str(a_2)]);
    
    set(p3(1), 'XData', x, 'YData', (abs(x-a_3*t(i)) <= 1).*(1 - abs(x-a_3*t(i))));
    set(p3(2), 'XData', x, 'YData', u_3(:, i));
    subplot(4,1,3)
    legend('Rozw analityczne', 'Rozw przybliżone');
    title(['t = ' num2str(t(i)) ', a = ' num2str(a_3)]);
    
    set(p4(1), 'XData', x, 'YData', (abs(x-a_4*t(i)) <= 1).*(1 - abs(x-a_4*t(i))));
    set(p4(2), 'XData', x, 'YData', u_4(:, i));
    subplot(4,1,4)
    legend('Rozw analityczne', 'Rozw przybliżone');
    title(['t = ' num2str(t(i)) ', a = ' num2str(a_4)]);
end

% Zauwazmy, ze im bardziej oddalamy sie od spelnienia warunku
% -1 <= a*lambda <= 0, tym szybciej rozwiazanie wybucha, widac to na 
% przykladach a_1, a_2 oraz a_3, a_4.

