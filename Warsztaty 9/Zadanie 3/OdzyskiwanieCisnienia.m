function p = OdzyskiwanieCisnienia(u, v, omega, options)
options_SOR = struct;
options_SOR.gType = "matrix";
options_SOR.fType = "matrix";
options_SOR.boundary = "Neumann";
options_SOR.error = options.error;
options_SOR.h = options.h;
options_SOR.omega = options.theta;
options_SOR.additionalPoint = [0.5, 0.5, 0];

Omega = [1, 1];


size_u = size(u);
M = size_u(1);
N = size_u(2);
K = size_u(3);

p = zeros(M,N,K);
f = zeros(M,N,K);

czynnik = 1/(2*options.h*options.h);

f(2:end-1,2:end-1,:) = czynnik*((u(3:end,2:end-1,:) -...
    u(1:end-2,2:end-1,:)).*(v(2:end-1,3:end,:) - v(2:end-1,1:end-2,:))...
    - (v(3:end,2:end-1,:) - v(1:end-2,2:end-1,:)).*...
    (u(2:end-1,3:end,:) - u(2:end-1,1:end-2,:)));

g = zeros(M,N,K);
czynnik = options.nu/(2*options.h);

g(1,2:end-1,:) = czynnik*(omega(1,3:end,:) - omega(1,1:end-2,:));
g(end,2:end-1,:) = -czynnik*(omega(end,3:end,:) - omega(end,1:end-2,:));


g(2:end-1,1,:) = -czynnik*(omega(3:end,1,:) - omega(1:end-2,1,:));
g(2:end-1,end,:) = czynnik*(omega(3:end,end,:) - omega(1:end-2,end,:));


for k = 1:K
    disp(['Krok ' num2str(k) 'z' num2str(K)]);
    [p(:,:,k), ~, ~, ~, ~, ~] = PoissonEquationSOR(f(:,:,k), g(:,:,k),...
    Omega, options_SOR);
    options_SOR.iter0 = p(:,:,k);
end

end

