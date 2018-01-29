function [P] = dlt(xy, XYZ)
%computes DLT, xy and XYZ should be normalized before calling this function

n = size(xy,2);
A = [];

for i = 1:n
    A = [A;xy(3,i)*XYZ(:,i)', zeros(1,4), -xy(1,i)*XYZ(:,i)';
           zeros(1,4), -xy(3,i)*XYZ(:,i)', xy(2,i)*XYZ(:,i)'];
end

[~,~,V] = svd(A);
P_vec = V(:,end);
P = reshape(P_vec,[4,3])';

end
