% Animacja przybliżonych rozwiązań

a = 4;
b = 0.02;
h = 1/20;
k = 1/300;


t_k = 0.5;
x_p = -1;
x_k = 1;

t = 0:k:t_k;

n_init = length(t);
x = x_p:h:x_k;
m_init = length(x);

u_0 = (abs(x) < 0.5) + (abs(x) == 0.5).*0.5;

y_p = -1;
y_k = 1;

u_1 = forward_time_central_space_zad3(x_p, x_k, t_k, b, a, k,...
    u_0, h,false,0);
u_2 = forward_time_central_space_zad3_pod_wiatr(x_p, x_k, t_k,...
    b, a, k, u_0, h,false,0);


figure
subplot(2,1,1)
p1 = plot(NaN, NaN);
axis([x_p x_k y_p y_k]);
subplot(2,1,2)
p2 = plot(NaN, NaN);
axis([x_p x_k y_p y_k]);

for i = 1:n_init
    pause(0.1)        % Można modyfikować, żeby zmienić szybkość animacji
    
    set(p1, 'XData', x, 'YData', u_1(:, i));
    subplot(2,1,1)
    title(['bez modyfikacji, t = ' num2str(t(i))]);
    
    set(p2, 'XData', x, 'YData', u_2(:, i));
    subplot(2,1,2)
    title(['pod wiatr, t = ' num2str(t(i))]);
       
end

