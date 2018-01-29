% Generate initial values for mu
% K is the number of segments

function mu = generate_mu(LMax,Lmin,aMax,amin,bMax,bmin,K)

mu = zeros(K,3);
% spreading equally in L*a*b space
stepL = (LMax - Lmin)/(K+1);
stepa = (aMax - amin)/(K+1);
stepb = (bMax - bmin)/(K+1);

for i = 1:K
    mu(i,:) = [i*stepL,i*stepa,i*stepb];
end

end