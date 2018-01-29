function vPoints = grid_points(img,nPointsX,nPointsY,border)
	[H, W] = size(img);
    
	sizeX = floor((H-2*border-1)/(nPointsX-1));
    x = border+1:sizeX:H-border;

	sizeY = floor((W-2*border-1)/(nPointsY-1));
	y = border+1:sizeY:W-border;

	vPoints = [];
	for i= 1:nPointsX
    	for j= 1:nPointsY
			vPoints = [vPoints; x(i), y(j)];
    	end
	end
   
end
