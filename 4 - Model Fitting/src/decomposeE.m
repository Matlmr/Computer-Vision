% Decompose the essential matrix
% Return P = [R|t] which relates the two views
% Yu will need the point correspondences to find the correct solution for P
function P = decomposeE(E, x1s, x2s)
    
    [U,~,V] = svd(E);
    t = U(:,end);
    t = t/norm(t);
    
    W = [0, -1, 0;
         1,  0, 0;
         0,  0, 1];
     
    R1 = U*W*V';
    R2 = U*W'*V';
    
    R1 = R1*det(R1); 
    R2 = R2*det(R2);
    
    P1 = [R1, t];
    P2 = [R1,-t];
    P3 = [R2, t];
    P4 = [R2,-t];
    Ps = {P1,P2,P3,P4};
    P0 = [eye(3), zeros(3,1)];

    right_config = zeros(1,4);
    for i = 1:4
        [Xs,~] = linearTriangulation(P0,x1s,Ps{i},x2s);
        PXs = Ps{i}*Xs;
        
        if min(Xs(3,:)) > 0 && min(PXs(3,:)) > 0;
            right_config(i) = 1;
            showCameras({[P0;0,0,0,1],[Ps{i};0,0,0,1]},i+4);
            figure(i+4)
            hold on
            plot3(Xs(1,:),Xs(2,:),Xs(3,:),'x')
        end

    end
    
    if numel(find(right_config == 1)) ~= 1
       error('More than one P matrix seem to work') 
    else
       P = Ps{find(right_config == 1)};
    end
    
end