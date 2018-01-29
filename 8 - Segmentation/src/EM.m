function [map, cluster] = EM(img)

% Create X matrix
img = double(img);
img1 = img(:,:,1); img2 = img(:,:,2); img3 = img(:,:,3);
X = [img1(:),img2(:),img3(:)];
Xh = [X';ones(1,size(X,1))];
[Xn,T] = normalise3dpts(Xh);
Xn = Xn(1:3,1:end)';

% Find ranges of values in L*a*b space
LMax = max(Xn(:,1)); Lmin = min(Xn(:,1));
aMax = max(Xn(:,2)); amin = min(Xn(:,2));
bMax = max(Xn(:,3)); bmin = min(Xn(:,3));

% number of clusters
K = 5;

alpha_s = ones(1,K)/K;
% use function generate_mu to initialize mus
mu_s = generate_mu(LMax,Lmin,aMax,amin,bMax,bmin,K);
% use function generate_cov to initialize covariances
var_s = generate_cov(LMax,Lmin,aMax,amin,bMax,bmin,K);

% iterate between maximization and expectation
tol = 0.3;
deltaMu = tol+1;
while deltaMu > tol;
    % use function expectation
    P = expectation(mu_s,var_s,alpha_s,Xn);
    % use function maximization
    [mu_sp1, var_sp1, alpha_sp1] = maximization(P, Xn);
    deltaMu = norm(mu_s(:)-mu_sp1(:));
    mu_s = mu_sp1; var_s = var_sp1; alpha_s = alpha_sp1;
%   ids = visualizeMostLikelySegments(Xn,alpha_s,mu_s,var_s);
end

% find most likely cluster for each pixel
[~,index] = max(P,[],2);
map = reshape(index,size(img1));
cluster = mu_sp1;

% Unnormalize the peak
clusterh = [cluster';ones(1,size(cluster,1))];
clusteru = T \ clusterh;
cluster = clusteru(1:3,:)';

% report values for report
%cluster_peaks = cluster
%cov = var_s
%weight = alpha_s

end