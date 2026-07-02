% Animacja przyblizonych rozwiazan

lambda = 1;
h_1 = 1/10;
h_2 = 1/20;
h_3 = 1/40;

c = 0.5;
a = 1;
eta_plus = c + sqrt(a*a + c*c);
eta_minus = c - sqrt(a*a + c*c);

k_1 = lambda * h_1;
k_2 = lambda * h_2;
k_3 = lambda * h_3;

t_p = 0;
t_k = 1;
x_p = -1;
x_k = 1;

t_1 = t_p:k_1:t_k;
t_2 = t_p:k_2:t_k;
t_3 = t_p:k_3:t_k;

n_init_1 = length(t_1);
n_init_2 = length(t_2);
n_init_3 = length(t_3);

x_1 = x_p:h_1:x_k;
x_2 = x_p:h_2:x_k;
x_3 = x_p:h_3:x_k;


y_p_1 = -1;
y_k_1 = 1;

y_p_2 = -1;
y_k_2 = 1;

y_p_3 = -1;
y_k_3 = 1;

u_1 = zad1_rownanie_ewolucyjne(x_p, x_k, t_k, c, a, h_1, lambda,false,0);
u_2 = zad1_rownanie_ewolucyjne(x_p, x_k, t_k, c, a, h_2, lambda,false,0);
u_3 = zad1_rownanie_ewolucyjne(x_p, x_k, t_k, c, a, h_3, lambda,false,0);


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
    pause(0.1)         % Mozna modyfikowac, zeby zmienic szybkosc animacji
    
    if i <= n_init_1
    set(p1(1), 'XData', x_1, 'YData', 0.5*(cos(pi*(x_1 -...
        eta_plus*t_1(i))) + cos(pi*(x_1 - eta_minus*t_1(i)))));
    set(p1(2), 'XData', x_1, 'YData', u_1(:, i));
    subplot(3,1,1)
    title(['t = ' num2str(t_1(i))]);
    end
    
    if i <= n_init_2
    set(p2(1), 'XData', x_2, 'YData', 0.5*(cos(pi*(x_2 -...
        eta_plus*t_2(i))) + cos(pi*(x_2 - eta_minus*t_2(i)))));
    set(p2(2), 'XData', x_2, 'YData', u_2(:, i));
    subplot(3,1,2)
    title(['t = ' num2str(t_2(i))]);
    end
    
    set(p3(1), 'XData', x_3, 'YData', 0.5*(cos(pi*(x_3 -...
        eta_plus*t_3(i))) + cos(pi*(x_3 - eta_minus*t_3(i)))));
    set(p3(2), 'XData', x_3, 'YData', u_3(:, i));
    subplot(3,1,3)
    title(['t = ' num2str(t_3(i))]);
end


% Wyznaczenie rzedu dokladnosci
err_1 = zeros(1,n_init_1);
err_2 = zeros(1,n_init_2);
err_3 = zeros(1,n_init_3);
u_1_dokladne = 0.5*(cos(pi*(x_1' - eta_plus*t_1))...
    + cos(pi*(x_1' - eta_minus*t_1)));
u_2_dokladne = 0.5*(cos(pi*(x_2' - eta_plus*t_2))...
    + cos(pi*(x_2' - eta_minus*t_2)));
u_3_dokladne = 0.5*(cos(pi*(x_3' - eta_plus*t_3))...
    + cos(pi*(x_3' - eta_minus*t_3)));
r_1 = zeros(1, n_init_1);

for i = 1:n_init_3
    
if i <= n_init_1
err_1(1,i) = blad_schematu(u_1, u_1_dokladne, h_1, i);
end

if i <= n_init_2
err_2(1,i) = blad_schematu(u_2, u_2_dokladne, h_2, i);
end

err_3(1,i) = blad_schematu(u_3, u_3_dokladne, h_3, i);

end

for i =1:n_init_1
r_1(1,i) = log2(abs((err_1(1,i) - err_2(1,2*i-1))/(err_2(1,2*i-1)...
    - err_3(1,4*i-3))));
end

disp(['W przyblizeniu r = ' num2str(round(nanmean(r_1)))]);





