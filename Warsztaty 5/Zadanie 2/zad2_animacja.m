% Animacja przybliżonych rozwiązań

mu = 10;
lambda = 1;

h1 = 1/10;
h2 = 1/20;
h3 = 1/40;

b = 0.5;

k1_lambda = lambda * h1;
k1_mu = mu*h1*h1;

k2_lambda = lambda * h2;
k2_mu = mu*h2*h2;

k3_lambda = lambda * h3;
k3_mu = mu*h3*h3;

t_k = 0.5;
x_p = -1;
x_k = 1;

t1_mu = 0:k1_mu:t_k;
t2_mu = 0:k2_mu:t_k;
t3_mu = 0:k3_mu:t_k;
t1_lambda = 0:k1_lambda:t_k;
t2_lambda = 0:k2_lambda:t_k;
t3_lambda = 0:k3_lambda:t_k;

n_init_t1_mu = length(t1_mu);
n_init_t2_mu = length(t2_mu);
n_init_t3_mu = length(t3_mu);
n_init_t1_lambda = length(t1_lambda);
n_init_t2_lambda = length(t2_lambda);
n_init_t3_lambda = length(t3_lambda);

x1 = x_p:h1:x_k;
x2 = x_p:h2:x_k;
x3 = x_p:h3:x_k;

m_init_1 = length(x1);
m_init_2 = length(x2);
m_init_3 = length(x3);

u1_0 = (abs(x1) < 0.5) + (abs(x1) == 0.5).*0.5;
u2_0 = (abs(x2) < 0.5) + (abs(x2) == 0.5).*0.5;
u3_0 = (abs(x3) < 0.5) + (abs(x3) == 0.5).*0.5;

f1_mu = zeros(m_init_1, n_init_t1_mu);
f2_mu = zeros(m_init_2, n_init_t2_mu);
f3_mu = zeros(m_init_3, n_init_t3_mu);
f1_lambda = zeros(m_init_1, n_init_t1_lambda);
f2_lambda = zeros(m_init_2, n_init_t2_lambda);
f3_lambda = zeros(m_init_3, n_init_t3_lambda);


y_p = -1;
y_k = 1;

u_1_mu = crank_nicolson_zad2(x_p, x_k, t_k, b, mu,...
    f1_mu, u1_0, h1,false,0);
u_2_mu = crank_nicolson_zad2(x_p, x_k, t_k, b, mu,...
    f2_mu, u2_0, h2,false,0);
u_3_mu = crank_nicolson_zad2(x_p, x_k, t_k, b, mu,...
    f3_mu, u3_0, h3,false,0);

u_1_lambda = crank_nicolson_zad2(x_p, x_k, t_k, b, lambda/h1,...
    f1_lambda, u1_0, h1,false,0);
u_2_lambda = crank_nicolson_zad2(x_p, x_k, t_k, b, lambda/h2,...
    f2_lambda, u2_0, h2,false,0);
u_3_lambda = crank_nicolson_zad2(x_p, x_k, t_k, b, lambda/h3,...
    f3_lambda, u3_0, h3,false,0);


figure
subplot(6,1,1)
p1 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p y_k]);
subplot(6,1,2)
p2 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p y_k]);
subplot(6,1,3)
p3 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p y_k]);
subplot(6,1,4)
p4 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p y_k]);
subplot(6,1,5)
p5 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p y_k]);
subplot(6,1,6)
p6 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p y_k]);

u_dokl_1_lambda = rozw_dokladne_zad2(x1, t1_lambda);
u_dokl_2_lambda = rozw_dokladne_zad2(x2, t2_lambda);
u_dokl_3_lambda = rozw_dokladne_zad2(x3, t3_lambda);
u_dokl_1_mu = rozw_dokladne_zad2(x1, t1_mu);
u_dokl_2_mu = rozw_dokladne_zad2(x2, t2_mu);
u_dokl_3_mu = rozw_dokladne_zad2(x3, t3_mu);

for i = 1:n_init_t3_mu
    pause(0.1)        % Można modyfikować, żeby zmienić szybkość animacji
    
    if i <= n_init_t1_lambda
    set(p1(1), 'XData', x1, 'YData', u_dokl_1_lambda(:, i));
    set(p1(2), 'XData', x1, 'YData', u_1_lambda(:, i));
    subplot(6,1,1)
    title(['h=1/10, lambda=1, t = ' num2str(t1_lambda(i))]);
    end
    
    if i <= n_init_t2_lambda
    set(p2(1), 'XData', x2, 'YData', u_dokl_2_lambda(:, i));
    set(p2(2), 'XData', x2, 'YData', u_2_lambda(:, i));
    subplot(6,1,2)
    title(['h=1/20, lambda=1, t = ' num2str(t2_lambda(i))]);
    end
    
    if i <= n_init_t3_lambda
    set(p3(1), 'XData', x3, 'YData', u_dokl_3_lambda(:, i));
    set(p3(2), 'XData', x3, 'YData', u_3_lambda(:, i));
    subplot(6,1,3)
    title(['h=1/40, lambda=1, t = ' num2str(t3_lambda(i))]);
    end
    
    if i <= n_init_t1_mu
    set(p4(1), 'XData', x1, 'YData', u_dokl_1_mu(:, i));
    set(p4(2), 'XData', x1, 'YData', u_1_mu(:, i));
    subplot(6,1,4)
    title(['h=1/10, mu=10, t = ' num2str(t1_mu(i))]);
    end
    
    if i <= n_init_t2_mu
    set(p5(1), 'XData', x2, 'YData', u_dokl_2_mu(:, i));
    set(p5(2), 'XData', x2, 'YData', u_2_mu(:, i));
    subplot(6,1,5)
    title(['h=1/20, mu=10, t = ' num2str(t2_mu(i))]);
    end
    
    if i <= n_init_t3_mu
    set(p6(1), 'XData', x3, 'YData', u_dokl_3_mu(:, i));
    set(p6(2), 'XData', x3, 'YData', u_3_mu(:, i));
    subplot(6,1,6)
    title(['h=1/40, mu=10, t = ' num2str(t3_mu(i))]);
    end
       
end


errL2_1 = blad_L2(u_1_lambda, u_dokl_1_lambda, h1);
errL2_2 = blad_L2(u_2_lambda, u_dokl_2_lambda, h2);
errL2_3 = blad_L2(u_3_lambda, u_dokl_3_lambda, h3);

errsupr_1 = blad_supremum(u_1_lambda, u_dokl_1_lambda);
errsupr_2 = blad_supremum(u_2_lambda, u_dokl_2_lambda);
errsupr_3 = blad_supremum(u_3_lambda, u_dokl_3_lambda);

disp(['errL2_1 = ' num2str(errL2_1)]);
disp(['errL2_2 = ' num2str(errL2_2)]);
disp(['errL2_3 = ' num2str(errL2_3)]);

disp(['errsupr_1 = ' num2str(errsupr_1)]);
disp(['errsupr_2 = ' num2str(errsupr_2)]);
disp(['errsupr_3 = ' num2str(errsupr_3)]);

% Metoda Cranka-Nicolsona jest efektywna dla wszystkich 6 wykresow i daje
% calkiem dobre przyblizenie rozwiazania analitycznego. Ponadto
% widac ze blad w normie L2 zmniejsza sie wraz z czasem, ale blad w normie
% supremum tez zmniejsza sie(?).

