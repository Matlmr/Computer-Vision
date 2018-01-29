% Compute the essential matrix using the eight point algorithm
% Input
% 	x1s, x2s 	Point correspondences 3xn matrices
%
% Output
% 	Eh 			Essential matrix with the det F = 0 constraint and the constraint that the first two singular values are equal
% 	E 			Initial essential matrix obtained from the eight point algorithm
%

function [Eh, E] = essentialMatrix(x1s, x2s)

    % normalize the points
    [nx1s T1] = normalizePoints2d(x1s);
    [nx2s T2] = normalizePoints2d(x2s);

    A = [];

    for i = 1:size(x1s,2)
        A = [A; nx2s(1,i)*nx1s(1,i) nx2s(1,i)*nx1s(2,i) nx2s(1,i) nx2s(2,i)*nx1s(1,i) nx2s(2,i)*nx1s(2,i) nx2s(2,i) nx1s(1,i) nx1s(2,i) 1];
    end
    
    [~,~,V] = svd(A);
    nE_vec = V(:,end);
    nE = [nE_vec(1) nE_vec(2) nE_vec(3);
          nE_vec(4)  nE_vec(5)  nE_vec(6);
          nE_vec(7)  nE_vec(8)  nE_vec(9)];
    
    E = T2'*nE*T1;
     
    [U,S,V] = svd(E);
    S = diag([(S(1,1)+S(2,2))/2,(S(1,1)+S(2,2))/2,0]);
    Eh = U*S*V';

end