function [descriptors,patches] = descriptors_hog(img,vPoints,cellWidth,cellHeight)

    nBins = 8;
    W = cellWidth; % set cell dimensions
    H = cellHeight;   
    NumCells = 4;
    N = size(vPoints,1);

    descriptors = zeros(N,nBins*4*4);%16 cells
    patches = zeros(N,4*W*4*H);    
    [grad_x,grad_y]=gradient(img);
    angles = atan2(grad_y, grad_x);
    magnitudes = sqrt(grad_y.^2 + grad_x.^2);
    
    for i = 1:N % for all local feature points
        firstCell = vPoints(i,:)-[NumCells/2*W, NumCells/2*H];
        patch = img(firstCell(1):firstCell(1)+NumCells*W -1,firstCell(2):firstCell(2)+NumCells*H -1);
        patches(i,:) = patch(:);
        for j = 1:NumCells
            deltaX = firstCell(1) + (j-1)*W;
            for k = 1:NumCells        
                deltaY = firstCell(2) + (k-1)*H;
                cellMagnitudes= magnitudes(deltaX:deltaX+W-1, deltaY:deltaY+H-1);
                cellAngles = angles(deltaX:deltaX+W-1, deltaY:deltaY+H-1);   
                descriptor(j, k, :) = HOG(cellAngles(:),cellMagnitudes(:),nBins);
            end
        end
    descriptors(i,:) = descriptor(:);
    end % for all local feature points
    
end
