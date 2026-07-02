% Animacja przyblizonych rozwiazan

lambda = 0.5;
ind = 3:200;
k = 1./ind;
h = k/lambda;

t_p = 0;
t_k = 1;

x_p = -5;
x_k = 5;

y_p = -2;
y_k = 2;

uL = -1;
uR = 1;

figure
subplot(3,1,1)
p1 = plot(NaN, NaN);
axis([x_p x_k y_p y_k]);
subplot(3,1,2)
p2 = plot(NaN, NaN);
axis([x_p x_k y_p y_k]);
subplot(3,1,3)
p3 = plot(NaN, NaN);
axis([x_p x_k y_p y_k]);


for i = 1:length(ind)    
    t = t_p:k(i):t_k;
    n_init = length(t);
    x = x_p:h(i):x_k;
    
    u = burgers_pod_wiatr(uL,uR,lambda,h(i));
    
    n1 = floor(n_init/3);
    n2 = floor(2*n_init/3);
    n3 = n_init;
    
    t1 = t(n1);
    t2 = t(n2);
    t3 = t(n3);
    
    
    pause(0.2)   
    
    set(p1, 'XData', x, 'YData', u(:, n1));
    subplot(3,1,1)
    title(['k = ' num2str(k(i)) ', t = ' num2str(t1)]);
    
    set(p2, 'XData', x, 'YData', u(:, n2));
    subplot(3,1,2)
    title(['k = ' num2str(k(i)) ', t = ' num2str(t2)]);

    set(p3, 'XData', x, 'YData', u(:, n3));
    subplot(3,1,3)
    title(['k = ' num2str(k(i)) ', t = ' num2str(t3)]);
    
end

