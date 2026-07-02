% Animacja przybliżonych rozwiązań

lambda = 0.8;
h_1 = 1/10;
h_2 = 1/20;
h_3 = 1/40;

k_1 = lambda * h_1;
k_2 = lambda * h_2;
k_3 = lambda * h_3;

t_p = 0;
t_k = 2.4;
x_p = -1;
x_k = 3;

t_1 = t_p:k_1:t_k;
t_2 = t_p:k_2:t_k;
t_3 = t_p:k_3:t_k;

n_init_1 = length(t_1);
n_init_2 = length(t_2);
n_init_3 = length(t_3);

x_1 = x_p:h_1:x_k;
x_2 = x_p:h_2:x_k;
x_3 = x_p:h_3:x_k;


y_p_1 = -30;
y_k_1 = 40;

y_p_2 = -5000;
y_k_2 = 5000;

y_p_3 = -2.5*10^9;
y_k_3 = 2.5*10^9;

u_1 = forward_time_central_space(lambda,h_1,false,0);
u_2 = forward_time_central_space(lambda,h_2,false,0);
u_3 = forward_time_central_space(lambda,h_3,false,0);


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

for i = 1:n_init_3
    pause(0.1)        % Można modyfikować, żeby zmienić szybkość animacji
    
    if i <= n_init_1
    set(p1(1), 'XData', x_1, 'YData', (abs(x_1-t_1(i))...
        <= 0.5).*cos(pi*(x_1 - t_1(i))).*cos(pi*(x_1...
        - t_1(i))));
    set(p1(2), 'XData', x_1, 'YData', u_1(:, i));
    subplot(3,1,1)
    title(['t = ' num2str(t_1(i))]);
    end
    
    if i <= n_init_2
    set(p2(1), 'XData', x_2, 'YData', (abs(x_2-t_2(i))...
        <= 0.5).*cos(pi*(x_2 - t_2(i))).*cos(pi*(x_2...
        - t_2(i))));
    set(p2(2), 'XData', x_2, 'YData', u_2(:, i));
    subplot(3,1,2)
    title(['t = ' num2str(t_2(i))]);
    end
    
    set(p3(1), 'XData', x_3, 'YData', (abs(x_3-t_3(i))...
        <= 0.5).*cos(pi*(x_3 - t_3(i))).*cos(pi*(x_3...
        - t_3(i))));
    set(p3(2), 'XData', x_3, 'YData', u_3(:, i));
    subplot(3,1,3)
    title(['t = ' num2str(t_3(i))]);
end

% Można zaobserwować na podstawie powyższej animacji, że rozwiązania nie
% "wybuchają" od razu, lecz np. dla h=1/40 dopiero około t=2, a dla
% h=1/20 około t=1.6. Pozwala to wysnuć hipotezę, iż dla malejących
% wymiarów siatki, czas, w którym rozwiązanie wybucha jest późniejszy, ale
% za to "wybuch" jest większy. Dla h=1/20 funkcja w wybuchu osiąga 
% wartości bliskie 5000, a dla h=1/40 wartości bliskie 2.5*10^9.

% Dodatkowo dla małych rozmiarów siatki widać, że wybuch posiada pewną 
% powtarzającą się zależność. Mianowicie dla h=1/40 można zaobserwować,
% iż wybuch rośnie od x=-1 do x=-0.5 by potem maleć od x=-0.5 do x=0. 
% Na przedziale [0,1] wybuch wygląda jak kopia wybuchu
% z przedziału [-1,0]. Podobną sytuację można zaobserwować już dla h=1/20,
% jednakże nie jawi się ona tak wyraźnie i dokładnie jak dla h=1/40.

