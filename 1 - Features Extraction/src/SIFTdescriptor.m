function SIFTdescriptor(img, peak_thresh,fig)
figure(fig)
imshow(img,[]);
I = single(rgb2gray(img));
[f,d] = vl_sift(I,'PeakThresh',peak_thresh);
h1 = vl_plotframe(f(:,:));
set(h1,'color','y','linewidth',3);
h3 = vl_plotsiftdescriptor(d(:,:),f(:,:));
set(h3,'color','g');
end