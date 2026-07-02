subplot(3,1,1);
u_1 = forward_time_central_space(0.8,1/10,true,2.4);
legend('Rozw przybliżone', 'Rozw analityczne');

if sum(abs(u_1) >= 5, 'all') > 0
    disp('Schemat nieużyteczny');
end

subplot(3,1,2);
u_2 = forward_time_central_space(0.8,1/20,true,2.4);
legend('Rozw przybliżone', 'Rozw analityczne');

if sum(abs(u_2) >= 5, 'all') > 0
    disp('Schemat nieużyteczny');
end

subplot(3,1,3);
u_3 = forward_time_central_space(0.8,1/40,true,2.4);
legend('Rozw przybliżone', 'Rozw analityczne');

if sum(abs(u_3) >= 5, 'all') > 0
    disp('Schemat nieużyteczny');
end

% Dla h = 1/10, 1/20, 1/40, lambda = 0.8 schemat jest nieużyteczny.
