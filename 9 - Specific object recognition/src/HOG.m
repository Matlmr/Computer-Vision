function hist = HOG(angles, magnitudes, numberBins)
    binSize = pi/numberBins;
    hist = zeros(1,numberBins);
    
    % same line for angle and angle + pi. This way we are between 0 and 180
    for i = 1:numel(angles)
        if angles(i) < 0
            angles(i) = angles(i) + pi;
        end
    end
    
    binAngles = zeros(1,numberBins);
    for i = 1:numberBins
        binAngles(i) = i*binSize-binSize/2;
    end
    
    for i = 1:numel(angles)
        diffAngles = abs(binAngles-angles(i));
        [minDiff,nearestInd] = min(diffAngles);
        minDiff2 = min(diffAngles(diffAngles>minDiff));
        nearestInd2 = find(diffAngles == minDiff2,1);
        hist(nearestInd) = magnitudes(i) * (binSize-minDiff)/binSize;
        hist(nearestInd2) = magnitudes(i) * (binSize-minDiff2)/binSize;
    end
end

