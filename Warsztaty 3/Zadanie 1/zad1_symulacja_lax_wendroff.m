% Animacja przybliżonych rozwiązań

lambda = 0.8;
h_1 = 1/10;
h_2 = 1/20;
h_3 = 1/40;
h_4 = 1/80;

a = 1;

k_1 = lambda * h_1;
k_2 = lambda * h_2;
k_3 = lambda * h_3;
k_4 = lambda * h_4;

t_p = 0;
t_k = 1.2;
x_p = -1;
x_k = 1;

t_1 = t_p:k_1:t_k;
t_2 = t_p:k_2:t_k;
t_3 = t_p:k_3:t_k;
t_4 = t_p:k_4:t_k;

n_init_1 = length(t_1);
n_init_2 = length(t_2);
n_init_3 = length(t_3);
n_init_4 = length(t_4);

x_1 = x_p:h_1:x_k;
x_2 = x_p:h_2:x_k;
x_3 = x_p:h_3:x_k;
x_4 = x_p:h_4:x_k;


y_p_1 = -1;
y_k_1 = 1;

y_p_2 = -1;
y_k_2 = 1;

y_p_3 = -1;
y_k_3 = 1;

y_p_4 = -1;
y_k_4 = 1;

u_1 = lax_wendroff(lambda,h_1,false,0);
u_2 = lax_wendroff(lambda,h_2,false,0);
u_3 = lax_wendroff(lambda,h_3,false,0);
u_4 = lax_wendroff(lambda,h_4,false,0);


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

for i = 1:n_init_4
    pause(0.1)        % Można modyfikować, żeby zmienić szybkość animacji
    
    if i <= n_init_1
    set(p1(1), 'XData', x_1, 'YData', sin(2*pi*(x_1-a*t_1(i))));
    set(p1(2), 'XData', x_1, 'YData', u_1(:, i));
    subplot(4,1,1)
    title(['t = ' num2str(t_1(i))]);
    end
    
    if i <= n_init_2
    set(p2(1), 'XData', x_2, 'YData', sin(2*pi*(x_2-a*t_2(i))));
    set(p2(2), 'XData', x_2, 'YData', u_2(:, i));
    subplot(4,1,2)
    title(['t = ' num2str(t_2(i))]);
    end
    
    if i <= n_init_3
    set(p3(1), 'XData', x_3, 'YData', sin(2*pi*(x_3-a*t_3(i))));
    set(p3(2), 'XData', x_3, 'YData', u_3(:, i));
    subplot(4,1,3)
    title(['t = ' num2str(t_3(i))]);
    end
    
    set(p4(1), 'XData', x_4, 'YData', sin(2*pi*(x_4-a*t_4(i))));
    set(p4(2), 'XData', x_4, 'YData', u_4(:, i));
    subplot(4,1,4)
    title(['t = ' num2str(t_4(i))]);
    
end


% Wyznaczenie rzedu dokladnosci
err_1 = zeros(1,n_init_1);
err_2 = zeros(1,n_init_2);
err_3 = zeros(1,n_init_3);
err_4 = zeros(1,n_init_4);
u_1_dokladne = sin(2*pi*(x_1'-a*t_1));
u_2_dokladne = sin(2*pi*(x_2'-a*t_2));
u_3_dokladne = sin(2*pi*(x_3'-a*t_3));
u_4_dokladne = sin(2*pi*(x_4'-a*t_4));
r_1 = zeros(1, n_init_1);
r_2 = zeros(1,n_init_2);

for i = 1:n_init_4
if i <= n_init_1
err_1(1,i) = blad_schematu(u_1, u_1_dokladne, h_1, i);
end
if i <= n_init_2
err_2(1,i) = blad_schematu(u_2, u_2_dokladne, h_2, i);
end
if i <= n_init_3
err_3(1,i) = blad_schematu(u_3, u_3_dokladne, h_3, i);
end
err_4(1,i) = blad_schematu(u_4, u_4_dokladne, h_4, i);
end

for i =1:n_init_1 - 1
r_1(1,i) = log2(abs((err_1(1,i) - err_2(1,2*i))/(err_2(1,2*i) - err_3(1,4*i))));
end

for i = 1:n_init_2 - 1
r_2(1,i) = log2(abs((err_2(1,i) - err_3(1,2*i))/(err_3(1,2*i) - err_4(1,4*i))));
end

disp(['W przyblizeniu r = ' num2str(round(mean(r_1)))]);
disp(['W przyblizeniu r = ' num2str(round(mean(r_2)))]);

% Rzad wynosi 1 (?)



