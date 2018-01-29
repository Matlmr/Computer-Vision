function d = distSampson( point1, F,  point2)
% d = distSampson( point1, F,  point2)
d = distPointLine(point2,F*point1) + distPointLine(point1,F'*point2);
end