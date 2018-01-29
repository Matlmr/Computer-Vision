function [ meanState ] = estimate( particles, particles_w )
%ESTIMATE estimate the mean state given particles and their weight
%   Detailed explanation goes here

    meanState = zeros(1,size(particles,2));
    for i = 1:size(particles,2)
       meanState(i) = dot(particles_w,particles(:,i));
    end
    
end

