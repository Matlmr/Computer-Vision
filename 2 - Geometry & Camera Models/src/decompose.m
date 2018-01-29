function [ K, R, C, t ] = decompose(P)
%decompose P into K, R and t
lambda = sqrt(P(3,1)^2+P(3,2)^2+P(3,3)^2);
P = P / lambda;
[Q,R] = qr(P(1:3,1:3)^-1);
K = R^-1;
R = Q^-1;
[~,~,V] = svd(P);
C = V(:,end);
C = C/C(end);
t = -R*C(1:3);
end