function u = algorytm_thomasa_zmodyfikowany(a,b,c,d)

n = length(a);

x = algorytm_thomasa(a,b,c,d,0,0);
y = algorytm_thomasa(a,b,c,zeros(1,n+1),1,0);
z = algorytm_thomasa(a,b,c,zeros(1,n+1),0,1);

r = ((z(1,1)-1)*x(1,end)-z(1,end)*x(1,1))/...
    (z(1,end)*y(1,1)-(y(1,end)-1)*(z(1,1)-1));
s = ((y(1,end)-1)*x(1,1)-y(1,1)*x(1,end))/...
    (z(1,end)*y(1,1)-(y(1,end)-1)*(z(1,1)-1));
u = x(1:end-1) + r*y(1:end-1) + s*z(1:end-1);
end