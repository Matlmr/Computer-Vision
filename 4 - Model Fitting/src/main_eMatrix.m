clear all
close all

clickPoints = false;

%dataset = 0;   % Your pictures
% dataset = 1; % ladybug
 dataset = 2; % rect

% image names
if(dataset==0)
    imgName1 = '';
    imgName2 = '';
    
    % Your camera calibration
    K = [];

elseif(dataset==1)
	imgName1 = 'images/ladybug_Rectified_0768x1024_00000064_Cam0.png';
	imgName2 = 'images/ladybug_Rectified_0768x1024_00000080_Cam0.png';

	K = [130.5024      0  500.0005
	      0  130.5024  372.3164
	      0         0    1.0000];
elseif(dataset==2)
	imgName1 = 'images/rect1.jpg';
	imgName2 = 'images/rect2.jpg';

	K = [  	1653.5  0    	0982.7;
			0    	1655.3 	0725.4;
			0.0		0.0		1.0 ];
end

% read in images
img1 = im2double(imread(imgName1));
img2 = im2double(imread(imgName2));

[pathstr1, name1] = fileparts(imgName1);
[pathstr2, name2] = fileparts(imgName2);

cacheFile = [pathstr1 filesep 'matches_' name1 '_vs_' name2 '.mat'];

% get point correspondences
if (clickPoints)
    [x1s, x2s] = getClickedPoints(img1, img2);
	save(cacheFile, 'x1s', 'x2s', '-mat');
else
	load('-mat', cacheFile, 'x1s', 'x2s');
end

% show clicked points
figure(1),hold off, imshow(img1, []); hold on, plot(x1s(1,:), x1s(2,:), '*r');  
figure(2),hold off, imshow(img2, []); hold on, plot(x2s(1,:), x2s(2,:), '*r');
figure(3),hold off, imshow(img1, []); hold on, plot(x1s(1,:), x1s(2,:), '*r');  
figure(4),hold off, imshow(img2, []); hold on, plot(x2s(1,:), x2s(2,:), '*r');

%% YOUR CODE ...

% image coordinates
nnx1s = K \ x1s;
nnx2s = K \ x2s;

% estimate fundamental matrix
[Eh, E] = essentialMatrix(nnx1s, nnx2s);

% compute the corresponding epipolar lines from F=K_inv'*E*K_inv
F = K'\E/K;

[U,S,V] = svd(F);
S(3,3) = 0;
Fh = U*S*V';

% draw epipolar lines in img 1 
figure(1)
for k = 1:size(x1s,2)
    drawEpipolarLines(F'*x2s(:,k), img1);
end
% draw epipolar lines in img 2 
figure(2)
for k = 1:size(x2s,2)
    drawEpipolarLines(F*x1s(:,k), img2);
end
% draw epipolar lines in img 1 
figure(3)
for k = 1:size(x1s,2)
    drawEpipolarLines(Fh'*x2s(:,k), img1);
end
% draw epipolar lines in img 2 
figure(4)
for k = 1:size(x2s,2)
    drawEpipolarLines(Fh*x1s(:,k), img2);
end

P = decomposeE(E, nnx1s, nnx2s);