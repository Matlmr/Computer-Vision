function d = distPointLine( point, line )
% d = distPointLine( point, line )
% point: inhomogeneous 2d point (2-vector)
% line: 2d homogeneous line equation (3-vector)

a = line(1);
b = line(2);
c = line(3);
d = abs((a*point(1)+b*point(2)+c)/sqrt(a^2+b^2));

end