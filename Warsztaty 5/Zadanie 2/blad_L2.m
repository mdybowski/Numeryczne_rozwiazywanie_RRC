function err = blad_L2(u_przyblizone,u_dokladne,h)
err = sqrt(h*sum((u_przyblizone - u_dokladne).^2));
end