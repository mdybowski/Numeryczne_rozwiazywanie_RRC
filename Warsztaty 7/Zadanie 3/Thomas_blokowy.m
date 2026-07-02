function x = Thomas_blokowy(A, B, C, q)
M = size(q,1);
n = size(q,2);
x = zeros(M,n);
gamma = zeros(n,n,M-1);
beta = zeros(M, n);

gamma(:,:,1) = B(:,:,1)\C(:,:,1);
beta(1,:) = (B(:,:,1)\q(1,:)')';

for k = 2:M-1
    gamma(:,:,k) = (B(:,:,k) - A(:,:,k)*gamma(:,:,k-1))\C(:,:,k);
    beta(k,:) = ((B(:,:,k) - A(:,:,k)*gamma(:,:,k-1))\...
        (q(k,:)' - A(:,:,k)*beta(k-1,:)'))';
end

beta(M,:) = ((B(:,:,M) - A(:,:,M)*gamma(:,:,M-1))\...
    (q(M,:)' - A(:,:,M)*beta(M-1,:)'))';
x(M,:) = beta(M,:);

for k = M-1:-1:1
    x(k,:) = (beta(k,:)' - gamma(:,:,k)*x(k+1,:)')';
end

end