function f = fminGoldStandard(p, xy, XYZ, w, T, U)

%reassemble P
P = [p(1:4);p(5:8);p(9:12)];
Pd = T^-1*P*U;

[~,R] = qr(Pd(1:3,1:3)^-1);
K = R^-1;

%compute squared geometric error
xy_hat = P*XYZ;
n = size(xy,2);
error = 0;
for i = 1:n
    xy_hatn = xy_hat(:,i)/xy_hat(3,i);
    error = error+sum( (xy(:,i)-xy_hatn).^2 );
end

%compute cost function value
f = error + w*K(1,2)^2 + w*(K(1,1)-K(2,2))^2;
end