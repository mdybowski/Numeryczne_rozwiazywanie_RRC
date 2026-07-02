function [u,v,X,M,N,K,psi,omega,psi_SOR_iter, omega_SOR_iter]...
    = NavierStokesSquare(T, u0, v0, options)

options_SOR = struct;
options_SOR.gType = "matrix";
options_SOR.fType = "matrix";
options_SOR.boundary = "Dirichlet";
options_SOR.error = options.error;
options_SOR.h = options.h;
options_SOR.nu = options.nu;
options_SOR.delta_t = options.delta_t;

delta_t = options.delta_t;

Omega = [1 1];
t = 0:delta_t:T;
K = length(t);
h = options.h;

X = 0:options_SOR.h:1;
M = length(X);
N = M;

psi = zeros(M,N,K+1);
omega = zeros(M,N,K+1);
u = zeros(M,N,K);
v = zeros(M,N,K);

g_k = zeros(M,N);

psi_SOR_iter = zeros(1,K);
omega_SOR_iter = zeros(1,K);

% Warunek poczatkowy dla omegi
for m = 2:M-1
    for n = 2:N-1
        omega(m,n,1) = (1/(2*h))*(v0((m+1)*h,n*h) - v0((m-1)*h,n*h)...
            - u0(m*h,(n+1)*h) + u0(m*h,(n-1)*h));
   end
end

% Wyznaczenie psi dla pierwszego kroku czasowego
f_k = -omega(:,:,1);

options_SOR.omega = options.theta;
[psi(:,:,1), ~, ~, ~, ~, psi_SOR_iter(1)] = PoissonEquationSOR(f_k,...
    g_k, Omega, options_SOR);

% Algorytm wyznaczania pola wektorowego [u, v]
for k=1:K
    disp(['Krok ' num2str(k) 'z' num2str(K)]);
    
    %Odzyskujemy u korzystajac z tego, ze u = psi_y  
    u(:,2:end-1,k) = (1/(2*h))*(psi(:,3:end,k) - psi(:,1:end-2,k));
    
    %Odzyskujemy v korzystajac z tego, ze v = -psi_x    
    v(2:end-1,:,k) = -(1/(2*h))*(psi(3:end,:,k) - psi(1:end-2,:,k)); 
    
    G_k = zeros(M,N);
    
    % Warunki brzegowe pierwszego rzędu
    %G_k(1,:) = (-2/(h*h))*psi(2,:,k);
    %G_k(end,:) = (-2/(h*h))*psi(M-1,:,k);
    %G_k(:,1) = (-2/(h*h))*psi(:,2,k);
    %G_k(:,end) = (-2/(h*h))*(psi(:,N-1,k) + options.u_falka*h);
    
    % Warunki brzegowe ze zwiekszonym rzedem
    G_k(1,:) = (-1/(2*h*h))*(8*psi(2,:,k) - psi(3,:,k));
    G_k(end,:) = (-1/(2*h*h))*(8*psi(M-1,:,k) - psi(M-2,:,k));
    G_k(:,1) = (-1/(2*h*h))*(8*psi(:,2,k) - psi(:,3,k));
    G_k(:,end) = (-1/(2*h*h))*(8*psi(:,N-1,k) - psi(:,N-2,k) +...
        6*options.u_falka*h);
    
    options_SOR.omega = options.sigma;
    % Ustawienie iter_0 jako omega z poprzedniego kroku czasowego
    % przyspieszy SORa
    options_SOR.iter0 = omega(:,:,k);
    [omega(:,:,k+1), ~, ~, ~, ~, omega_SOR_iter(k)] =...
        PoissonEquationSOR_omega(G_k, Omega, options_SOR, k, psi, omega);
    
    f_k = -omega(:,:,k+1);
    
    options_SOR.omega = options.theta;
    % Ustawienie iter_0 jako psi z poprzedniego kroku czasowego
    % przyspieszy SORa
    options_SOR.iter0 = psi(:,:,k);
    [psi(:,:,k+1), ~, ~, ~, ~, psi_SOR_iter(k)]...
        = PoissonEquationSOR(f_k, g_k, Omega, options_SOR);    
end

psi = psi(:,:,1:end-1);
omega = omega(:,:,1:end-1);

end