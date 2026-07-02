subplot(3,1,1);
u_1 = lax_friedrichs(0.8,1/10,true,2.4);
legend('Rozw przybliżone', 'Rozw analityczne','Location','northwest');

if sum(abs(u_1) >= 5, 'all') > 0
    disp('Schemat nieużyteczny');
end

subplot(3,1,2);
u_2 = lax_friedrichs(0.8,1/20,true,2.4);
legend('Rozw przybliżone', 'Rozw analityczne','Location','northwest');

if sum(abs(u_2) >= 5, 'all') > 0
    disp('Schemat nieużyteczny');
end

subplot(3,1,3);
u_3 = lax_friedrichs(0.8,1/40,true,2.4);
legend('Rozw przybliżone', 'Rozw analityczne','Location','northwest');

if sum(abs(u_3) >= 5, 'all') > 0
    disp('Schemat nieużyteczny');
end

% Dla h = 1/10, 1/20, 1/40, lambda = 0.8 schemat jest użyteczny 
% (z wykresu obserwujemy, że otrzymane rozwiązanie przybliża 
% rozwiązanie analityczne). 

% Błąd przybliżenia maleje "tak średnio" (wraz z dwukrotnym
% zmniejszeniem rozmiarów siatki, rozwiązanie nie zbliża się 2 razy
% "szybciej", a znacznie wolniej). Metoda przybliża gorzej niż metoda
% forward-time backward-space.