% Animacja przybliżonych rozwiązań

lambda = 0.9;
h = 0.1;
eps = 0.1;

a = 1;

k = lambda * h;

t_p_1 = 0;
t_k_1 = 2.4;
x_p_1 = -1;
x_k_1 = 7;

t_p_2 = 0;
t_k_2 = 15;
x_p_2 = -2;
x_k_2 = 2;

t_1 = t_p_1:k:t_k_1;
t_2 = t_p_2:k:t_k_2;

n_init_1 = length(t_1);
n_init_2 = length(t_2);

x_1 = x_p_1:h:x_k_1;
x_2 = x_p_2:h:x_k_2;


y_p = -1;
y_k = 1;

u_1 = leapfrog_zad3_ulepszony_z_zad1(lambda,h,false,0);
u_2 = leapfrog_zad3_ulepszony_z_zad2(lambda,h,false,0,eps);

v_1 = leapfrog_zad1(lambda,h,false,0);
v_2 = leapfrog_zad2(lambda,h,false,0,eps);


figure
subplot(2,1,1)
p1 = plot(NaN, NaN, NaN, NaN);
axis([x_p_1 x_k_1 y_p y_k]);
subplot(2,1,2)
p2 = plot(NaN, NaN, NaN, NaN);
axis([x_p_2 x_k_2 y_p y_k]);

for i = 1:n_init_2
    pause(0.3)        % Można modyfikować, żeby zmienić szybkość animacji
    
    if i <= n_init_1
    
    set(p1(1), 'XData', x_1, 'YData', v_1(:, i));
    set(p1(2), 'XData', x_1, 'YData', u_1(:, i));
    subplot(2,1,1)
    title(['Leapfrog zad1, t = ' num2str(t_1(i))]);
    legend('Rozw podstawowy leapfrog', 'Rozw zmodyfikowany leapfrog','Location','northeast');
    
    end
    
    set(p2(1), 'XData', x_2, 'YData', v_2(:, i));
    set(p2(2), 'XData', x_2, 'YData', u_2(:, i));
    subplot(2,1,2)
    title(['Leapfrog zad2, t = ' num2str(t_2(i))]);
    legend('Rozw podstawowy leapfrog', 'Rozw zmodyfikowany leapfrog','Location','northwest');
    
end

% Zmodyfikowany leapfrog lepiej nieco sobie radzi z przykładem z zadania 1,
% natomiast w przykładzie z zadania 2 lepiej
% sobie radzi niezmodyfikowany leapfrog - oscylacje w zmodyfikowanym są
% bardzo duże.


