czas = 1:K;
figure
subplot(2,1,1)
plot(czas, psi_SOR_iter);
title('Wykres liczby iteracji SOR dla strumienia');
subplot(2,1,2)
plot(czas, omega_SOR_iter);
title('Wykres liczby iteracji SOR dla wirowosci');