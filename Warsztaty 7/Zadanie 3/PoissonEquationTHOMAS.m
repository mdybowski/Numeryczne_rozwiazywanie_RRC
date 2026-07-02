function [u, X, Y, M, N] = PoissonEquationTHOMAS(f, g, Omega, options)
a = Omega(1);
b = Omega(2);
h = options.h;

X = 0:h:a;
Y = 0:h:b;

M = length(X);
N = length(Y);

u = zeros(M,N);

% Warunek brzegowy Dirichleta
if options.gType == "matrix"
    u(1,:) = g(1,:);
    u(end,:) = g(end,:);
    u(:,1) = g(:,1);
    u(:,end) = g(:,end);
elseif options.gType == "function"
    u(1,:) = g(0,Y);
    u(end,:) = g(a,Y);
    u(:,1) = g(X,0)';
    u(:,end) = g(X,b)';
else
    error_msg = "Bledny typ obiektu g";
    error(error_msg);
end

% Implementacja schematu podstawowego

I_falka = (1/(h*h))*eye(N);
I_falka(1,1) = 0;
I_falka(end,end) = 0;

I = (1/(h*h))*eye(N);

T = (1/(h*h))*(diag((-4)*ones(1,N)) + diag(ones(1,N-1),1)...
    + diag(ones(1,N-1),-1));
T(1,1) = 1/(h*h);
T(end,end) = 1/(h*h);
T(1,2) = 0;
T(end,end-1) = 0;

A = zeros(N,N,M);
B = zeros(N,N,M);
C = zeros(N,N,M-1);

B(:,:,1) = I;
for i = 2:M-1
    A(:,:,i) = I_falka;
    B(:,:,i) = T;
    C(:,:,i) = I_falka;       
end
B(:,:,M) = I;

b = zeros(N,M);
b(:,1) = u(1,:);
b(1,:) = u(:,1)';
b(end,:) = u(:,end)';
b(:,end) = u(end,:);

if options.fType == "matrix"
for i= 2:N-1
    b(i,2:end-1) = f(:,i)';
end
elseif options.fType == "function"
for i= 2:N-1
    b(i,2:end-1) = f(X(2:end-1),(i-1)*h);
end
else
    error_msg = "Bledny typ obiektu f";
    error(error_msg);
end

u = Thomas_blokowy(A,B,C,b');


end