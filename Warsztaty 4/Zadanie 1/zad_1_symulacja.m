% Animacja przybliżonych rozwiązań

lambda = 0.9;
h = 0.1;

a = 1;

k = lambda * h;

t_p = 0;
t_k = 2.4;
x_p = -1;
x_k = 7;

t = t_p:k:t_k;

n_init = length(t);

x = x_p:h:x_k;


y_p = -1;
y_k = 1;

u_1 = leapfrog_zad1(lambda,h,false,0);
u_2 = lax_wendroff_zad1(lambda,h,false,0);


figure
subplot(2,1,1)
p1 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p y_k]);
subplot(2,1,2)
p2 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p y_k]);

for i = 1:n_init
    pause(0.3)        % Można modyfikować, żeby zmienić szybkość animacji
    
    set(p1(1), 'XData', x, 'YData', ...
        ((abs(x-a*t(i)) <= 0.5).*cos(pi*(x-a*t(i))).*cos(pi*(x-a*t(i)))));
    set(p1(2), 'XData', x, 'YData', u_1(:, i));
    subplot(2,1,1)
    title(['Leapfrog, t = ' num2str(t(i))]);
    
    set(p2(1), 'XData', x, 'YData', ...
        ((abs(x-a*t(i)) <= 0.5).*cos(pi*(x-a*t(i))).*cos(pi*(x-a*t(i)))));
    set(p2(2), 'XData', x, 'YData', u_2(:, i));
    subplot(2,1,2)
    title(['Lax-Wendroff, t = ' num2str(t(i))]);
    
end

% W przypadku schematu Leapfrog widać wyraźne oscylacje, natomiast
% przy schemacie Lax-Wendroff oscylacji nie ma. 

