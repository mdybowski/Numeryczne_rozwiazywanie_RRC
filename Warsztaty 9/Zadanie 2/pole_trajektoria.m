skok = 5;
skok_kroku_czasowego = 10;

figure
hQuiver = quiver(X(1:skok:end), X(1:skok:end),...
    u(1:skok:end,1:skok:end,1)', v(1:skok:end,1:skok:end,1)');
axis([0 1 0 1]);
hold on

for k=1:skok_kroku_czasowego:K
    hQuiver.UData = u(1:skok:end,1:skok:end,k)';
    hQuiver.VData = v(1:skok:end,1:skok:end,k)';
    scatter(trajektoria_x(k), trajektoria_y(k), 10, 'r', 'filled');
    title(['t = ' num2str(k*options.delta_t)]);
    pause(0.01);
end