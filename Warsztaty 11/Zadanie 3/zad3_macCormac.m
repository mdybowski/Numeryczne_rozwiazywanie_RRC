% Animacja przyblizonych rozwiazan

lambda = 0.4;
h1 = 1/20;
h2 = 1/40;
h3 = 1/80;
k1 = lambda * h1;
k2 = lambda * h2;
k3 = lambda * h3;

t_p = 0;
t_k = 0.5;

x_p = -4;
x_k = 4;

t1 = t_p:k1:t_k;
t2 = t_p:k2:t_k;
t3 = t_p:k3:t_k;

n_init_1 = length(t1);
n_init_2 = length(t2);
n_init_3 = length(t3);

x1 = x_p:h1:x_k;
x2 = x_p:h2:x_k;
x3 = x_p:h3:x_k;

m_init_1 = length(x1);
m_init_2 = length(x2);
m_init_3 = length(x3);


y_p = -5;
y_k = 5;

u1 = burgers_macCormac(lambda,h1);
u2 = burgers_macCormac(lambda,h2);
u3 = burgers_macCormac(lambda,h3);

figure
p1 = plot(NaN, NaN);
axis([x_p x_k y_p y_k]);

for i = 1:n_init_3-1
    pause(0.2)        % Mozna modyfikowac, zeby zmienic szybkosc animacji
    
    set(p1, 'XData', x3, 'YData', u3(:, i));
    title(['t = ' num2str(t3(i))]);
end

% Wyznaczenie rzedu dokladnosci
err_1 = zeros(1,n_init_1);
err_2 = zeros(1,n_init_2);
err_3 = zeros(1,n_init_3);
u_1_dokladne = zeros(m_init_1,n_init_1);
u_2_dokladne = zeros(m_init_2,n_init_2);
u_3_dokladne = zeros(m_init_3,n_init_3);

for i = 1:n_init_1
u_1_dokladne(:,i) = (x1<t1(i)) + ((1-x1)/(1-t1(i))).*(x1>=t1(i)).*(x1<=1);
end
for i = 1:n_init_2
u_2_dokladne(:,i) = (x2<t2(i)) + ((1-x2)/(1-t2(i))).*(x2>=t2(i)).*(x2<=1);
end
for i = 1:n_init_3
u_3_dokladne(:,i) = (x3<t3(i)) + ((1-x3)/(1-t3(i))).*(x3>=t3(i)).*(x3<=1);
end

r = zeros(1, n_init_1);

for i = 1:n_init_3
    
if i <= n_init_1
err_1(1,i) = blad_schematu(u1, u_1_dokladne, h1, i);
end

if i <= n_init_2
err_2(1,i) = blad_schematu(u2, u_2_dokladne, h2, i);
end

err_3(1,i) = blad_schematu(u3, u_3_dokladne, h3, i);

end

for i =1:n_init_1
r(1,i) = log2(abs((err_1(1,i) - err_2(1,2*i-1))/(err_2(1,2*i-1)...
    - err_3(1,4*i-3))));
end

disp(['W przyblizeniu r = ' num2str(round(nanmean(r)))]);

% Metoda monotoniczna ma co najwyzej pierwszy rzad dokladnosci
