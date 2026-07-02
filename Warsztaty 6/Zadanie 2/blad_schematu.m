function err = blad_schematu(u_przyblizone,u_dokladne,h,t)
err = sqrt(h*(u_przyblizone(:, t) - u_dokladne(:, t))'*...
    (u_przyblizone(:, t) - u_dokladne(:, t)));
end