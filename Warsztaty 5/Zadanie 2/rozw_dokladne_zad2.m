function u = rozw_dokladne_zad2(x, t)

u = 0.5;

for l= 0:100
    u = u + 2*((-1)^l)*(cos(pi*(2*l+1)*x)/(pi*(2*l+1)))'.*...
        exp(-pi*pi*(2*l+1)*(2*l+1)*t); 
end

end

