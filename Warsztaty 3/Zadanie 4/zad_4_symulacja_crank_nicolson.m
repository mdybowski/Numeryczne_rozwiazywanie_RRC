% Animacja przybliżonych rozwiązań

lambda = 0.9;
h = 0.02;

a = 1;

k = lambda * h;

t_p = 0;
t_k = 2;
x_p = 0;
x_k = 1;

t = t_p:k:t_k;

n_init = length(t);

x = x_p:h:x_k;


y_p = -1;
y_k = 1;

u_1 = crank_nicolson_1(lambda,h,false,0);
u_2 = crank_nicolson_2(lambda,h,false,0);
u_3 = crank_nicolson_3(lambda,h,false,0);
u_4 = crank_nicolson_4(lambda,h,false,0);


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
    pause(0.1)        % Można modyfikować, żeby zmienić szybkość animacji
    
    set(p1(1), 'XData', x, 'YData', sin(2*pi*(x-a*t(i))));
    set(p1(2), 'XData', x, 'YData', u_1(:, i));
    subplot(4,1,1)
    title(['t = ' num2str(t(i))]);
    
    set(p2(1), 'XData', x, 'YData', sin(2*pi*(x-a*t(i))));
    set(p2(2), 'XData', x, 'YData', u_2(:, i));
    subplot(4,1,2)
    title(['t = ' num2str(t(i))]);
    
    set(p3(1), 'XData', x, 'YData', sin(2*pi*(x-a*t(i))));
    set(p3(2), 'XData', x, 'YData', u_3(:, i));
    subplot(4,1,3)
    title(['t = ' num2str(t(i))]);
    
    set(p4(1), 'XData', x, 'YData', sin(2*pi*(x-a*t(i))));
    set(p4(2), 'XData', x, 'YData', u_4(:, i));
    subplot(4,1,4)
    title(['t = ' num2str(t(i))]);
    
end



