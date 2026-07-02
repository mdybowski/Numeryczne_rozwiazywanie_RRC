% Animacja przybliżonych rozwiązań

mu = 1;
h = 1/20;
b = 0.2;

k = mu*h*h;

t_k = 0.5;
x_p = -1;
x_k = 1;

t = 0:k:t_k;

n_init = length(t);
x = x_p:h:x_k;
m_init = length(x);


u_0 = (abs(x) < 0.5) + (abs(x) == 0.5).*0.5;


f = zeros(m_init, n_init);


y_p = -2;
y_k = 2;

u = crank_nicolson_Dirichlet(x_p, x_k, t_k, b, mu,...
    f, u_0, h,false,0);
u2 = crank_nicolson_Neumann(x_p, x_k, t_k, b, mu,...
    f, u_0, h,false,0);


figure
subplot(2,1,1)
p1 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p y_k]);
subplot(2,1,2)
p2 = plot(NaN, NaN, NaN, NaN);
axis([x_p x_k y_p y_k]);

for i = 1:n_init
    pause(0.1)        % Można modyfikować, żeby zmienić szybkość animacji
    
    set(p1(1), 'XData', x, 'YData', u(:, i));
    set(p1(2), 'XData', x, 'YData', u_0);
    subplot(2,1,1)
    title(['Dirichlet, t = ' num2str(t(i))]);  
    
    set(p2(1), 'XData', x, 'YData', u2(:, i));
    set(p2(2), 'XData', x, 'YData', u_0);
    subplot(2,1,2)
    title(['Neumann, t = ' num2str(t(i))]); 
    
end

