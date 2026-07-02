% Animacja przybliżonych rozwiązań

lambda = 0.9;
h = 0.1;
eps = 0.1;

a = 1;

k = lambda * h;

t_p = 0;
t_k = 15;
x_p = -2;
x_k = 2;

t = t_p:k:t_k;

n_init = length(t);

x = x_p:h:x_k;


y_p = -0.2;
y_k = 0.2;

u_1 = leapfrog_zad2(lambda,h,false,0,eps);
u_2 = lax_wendroff_zad2(lambda,h,false,0,eps);


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
    title(['Leapfrog, t = ' num2str(t(i))]);
    
    set(p2, 'XData', x, 'YData', u_2(:, i));
    subplot(2,1,2)
    title(['Lax-Wendroff, t = ' num2str(t(i))]);
    
end

% W przypadku schematu Leapfrog rozwiązanie jest bardzo chaotyczne, wręcz
% "zygzakowate", natomiast schemat Lax_Wendroff "wygasza" rozwiązanie.


