function err = norma_L2(u,h)
err = sqrt(h*h*sum(u.^2,'all'));
end