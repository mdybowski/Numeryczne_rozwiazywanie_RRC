function u = algorytm_thomasa(a,b,c,d,beta_0,beta_m)
n = length(a);

p = zeros(1, n+1);
q = zeros(1, n+1);
u = zeros(1, n);

q(1,1) = beta_0;


for i = 2:n+1
    p(1,i) = (-1/(a(1,i-1)*p(1,i-1) + b(1,i-1)))*c(1,i-1);
    q(1,i) = (1/(a(1,i-1)*p(1,i-1) + b(1,i-1)))*(d(1,i-1)...
        - a(1,i-1)*q(1,i-1));
end

u(1,end) = p(1,end)*beta_m + q(1,end);
for i=n-1:-1:1
   u(1,i) = p(1,i+1)*u(1,i+1) + q(1,i+1);
end

end