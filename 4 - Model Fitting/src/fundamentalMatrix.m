% Compute the fundamental matrix using the eight point algorithm
% Input
% 	x1s, x2s 	Point correspondences
%
% Output
% 	Fh 			Fundamental matrix with the det F = 0 constraint
% 	F 			Initial fundamental matrix obtained from the eight point algorithm
%
function [Fh, F] = fundamentalMatirx(x1s, x2s)

    % normalize the points
    [nx1s, T1] = normalizePoints2d(x1s);
    [nx2s, T2] = normalizePoints2d(x2s);

    A = [];

    for i = 1:size(x1s,2)
        A = [A; nx2s(1,i)*nx1s(1,i) nx2s(1,i)*nx1s(2,i) nx2s(1,i) nx2s(2,i)*nx1s(1,i) nx2s(2,i)*nx1s(2,i) nx2s(2,i) nx1s(1,i) nx1s(2,i) 1];
    end
    
    [~,~,V] = svd(A);
    nF_vec = V(:,end);
    nF = [nF_vec(1) nF_vec(2) nF_vec(3);
          nF_vec(4)  nF_vec(5)  nF_vec(6);
          nF_vec(7)  nF_vec(8)  nF_vec(9)];
    
    F = T2'*nF*T1;
    
    [U,S,V] = svd(F);
    S(3,3) = 0;
    Fh = U*S*V';
    
end