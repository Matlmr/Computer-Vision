% Generate initial values for the K
% covariance matrices

function cov = generate_cov(LMax,Lmin,aMax,amin,bMax,bmin, K)

rangeLab = [LMax-Lmin,aMax-amin,bMax-bmin];
cov = zeros(3,3,K);
for i = 1:K
    cov(:,:,i) = diag(rangeLab);
end

end