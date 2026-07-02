function [u, X, Y, M, N, SOR_iter] = PoissonEquationSOR(f, g, Omega, options)
a = Omega(1);
b = Omega(2);
h = options.h;
eps = options.error;
omega = options.omega;

X = 0:h:a;
Y = 0:h:b;

M = length(X);
N = length(Y);

if isfield(options,'iter0')
    u = options.iter0;
else
    u = zeros(M,N);
end

if options.boundary == "Dirichlet"
    
    % Warunek brzegowy typu Dirichleta
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
elseif options.boundary == "Neumann"
    
    point = options.additionalPoint;
else
    error_msg = "Bledny typ warunku brzegowego";
    error(error_msg);
end


% Implementacja metody SOR

SOR_iter = 0;

if options.fType == "matrix"
    
    u_GS = zeros(M,N);
    
    while 1
        SOR_iter = SOR_iter + 1;
        u_old = u;
        for m = 2:M-1
            for n = 2:N-1
                u_GS(m,n) = 0.25*(u(m-1,n) + u(m+1,n) +...
                u(m,n-1) + u(m,n+1) -...
                (h^2)*f(m,n)) - u(m,n);
                
                u(m,n) = u(m,n) + omega*u_GS(m,n);   
            end
        end
        
        if options.boundary == "Neumann"
            if options.gType == "matrix"
               u(1,:) = (1/3)*(4*u(2,:) - u(3,:) - 2*h*g(1,:));
               u(:,1) = (1/3)*(4*u(:,2) - u(:,3) - 2*h*g(:,1));
               u(end,:) = (1/3)*(4*u(end-1,:) - u(end-2,:) + 2*h*g(end,:));
               u(:,end) = (1/3)*(4*u(:,end-2) - u(:,end-2) + 2*h*g(:,end));
            else
               u(1,:) = (1/3)*(4*u(2,:) - u(3,:) - 2*h*g(0,Y));
               u(:,1) = (1/3)*(4*u(:,2) - u(:,3) - 2*h*g(X,0)');
               u(end,:) = (1/3)*(4*u(end-1,:) - u(end-2,:) + 2*h*g(a,Y));
               u(:,end) = (1/3)*(4*u(:,end-2) - u(:,end-2) + 2*h*g(X,b)'); 
            end
            
            n0 = sum(Y <= point(2));
            m0 = sum(X <= point(1));
            u = u + point(3) - u(m0, n0);
        end

        % Jesli blad roznicy miedzy rozwiazaniem w poprzednim kroku,
        % a obecnym (mierzony w normie L2) < eps, to konczymy metode
        if norma_L2(u-u_old,h) < eps
            break;
        end

    end
    
elseif options.fType == "function"
    
    u_GS = zeros(M,N);
    while 1
        SOR_iter = SOR_iter + 1;
        u_old = u;
        for m = 2:M-1
            for n = 2:N-1
                u_GS(m,n) = 0.25*(u(m-1,n) + u(m+1,n) +...
                u(m,n-1) + u(m,n+1) -...
                (h^2)*f(X(m),Y(n))) - u(m,n);
                
                u(m,n) = u(m,n) + omega*u_GS(m,n);
            end
        end
        
        if options.boundary == "Neumann"          
            if options.gType == "matrix"
               u(1,:) = (1/3)*(4*u(2,:) - u(3,:) - 2*h*g(1,:));
               u(:,1) = (1/3)*(4*u(:,2) - u(:,3) - 2*h*g(:,1));
               u(end,:) = (1/3)*(4*u(end-1,:) - u(end-2,:) + 2*h*g(end,:));
               u(:,end) = (1/3)*(4*u(:,end-2) - u(:,end-2) + 2*h*g(:,end));
            else
               u(1,:) = (1/3)*(4*u(2,:) - u(3,:) - 2*h*g(0,Y));
               u(:,1) = (1/3)*(4*u(:,2) - u(:,3) - 2*h*g(X,0)');
               u(end,:) = (1/3)*(4*u(end-1,:) - u(end-2,:) + 2*h*g(a,Y));
               u(:,end) = (1/3)*(4*u(:,end-2) - u(:,end-2) + 2*h*g(X,b)'); 
            end
            
            n0 = sum(Y <= point(2));
            m0 = sum(X <= point(1));
            u = u + point(3) - u(m0, n0);
        end    
        
        % Jesli blad roznicy miedzy rozwiazaniem w poprzednim kroku,
        % a obecnym (mierzony w normie L2) < eps, to konczymy metode
        if norma_L2(u-u_old,h) < eps
            break;
        end

    end
    
else
    error_msg = "Bledny typ obiektu f";
    error(error_msg);
end
   
end