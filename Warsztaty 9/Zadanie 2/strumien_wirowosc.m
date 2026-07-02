figure
subplot(2,1,1)
mesh(psi(:,:,K));
title('Wykres strumienia');
subplot(2,1,2)
mesh(omega(:,:,K));
title('Wykres wirowosci');