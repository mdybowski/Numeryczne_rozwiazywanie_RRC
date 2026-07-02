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

uL_1 = 1;
uL_2 = 2;
uR_1 = 0;
uR_2 = 4;

% Predkosci fali uderzeniowej
s1 = 0.5*(uL_1 + uR_1);
s2 = 0.5*(uL_1 + uR_2);
s3 = 0.5*(uL_2 + uR_1);
s4 = 0.5*(uL_2 + uR_2);

u_1 = burgers_forward_time_backward_space(uL_1,uR_1,lambda,h);
u_2 = burgers_forward_time_backward_space(uL_1,uR_2,lambda,h);
u_3 = burgers_forward_time_backward_space(uL_2,uR_1,lambda,h);
u_4 = burgers_forward_time_backward_space(uL_2,uR_2,lambda,h);


figure
subplot(4,1,1)
p1 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p y_k]);
subplot(4,1,2)
p2 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p y_k]);
subplot(4,1,3)
p3 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p y_k]);
subplot(4,1,4)
p4 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p y_k]);

for i = 1:n_init
    pause(0.2)        % Mozna modyfikowac, zeby zmienic szybkosc animacji
    
    set(p1(1), 'XData', x, 'YData', uL_1*(x < s1*t(i)) + uR_1*(x>=s1*t(i)));
    set(p1(2), 'XData', x, 'YData', u_1(:, i));
    subplot(4,1,1)
    legend('Rozw słabe', 'Rozw przybliżone', 'Location','southwest');
    title(['t = ' num2str(t(i)) ', uL = 1, uR = 0,' ...
        '  predkosc fali uderzeniowej = ' num2str(s1)]);
    
    set(p2(1), 'XData', x, 'YData', uL_1*(x < s2*t(i)) + uR_2*(x>=s2*t(i)));
    set(p2(2), 'XData', x, 'YData', u_2(:, i));
    subplot(4,1,2)
    legend('Rozw słabe', 'Rozw przybliżone', 'Location','southwest');
    title(['t = ' num2str(t(i)) ', uL = 1, uR = 4,' ...
        '  predkosc fali uderzeniowej = ' num2str(s2)]);
    
    set(p3(1), 'XData', x, 'YData', uL_2*(x < s3*t(i)) + uR_1*(x>=s3*t(i)));
    set(p3(2), 'XData', x, 'YData', u_3(:, i));
    subplot(4,1,3)
    legend('Rozw słabe', 'Rozw przybliżone', 'Location','southwest');
    title(['t = ' num2str(t(i)) ', uL = 2, uR = 0,' ...
        '  predkosc fali uderzeniowej = ' num2str(s3)]);
    
    set(p4(1), 'XData', x, 'YData', uL_2*(x < s4*t(i)) + uR_2*(x>=s4*t(i)));
    set(p4(2), 'XData', x, 'YData', u_4(:, i));
    subplot(4,1,4)
    legend('Rozw słabe', 'Rozw przybliżone', 'Location','southwest');
    title(['t = ' num2str(t(i)) ', uL = 2, uR = 4,' ...
        '  predkosc fali uderzeniowej = ' num2str(s4)]);
end

% 

