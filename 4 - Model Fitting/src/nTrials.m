function [n] = nTrialNeeded(inlierRation,nSamples,desiredConfidence)
    % Computes the number of iterations needed
    n = round(log(1-desiredConfidence)/log(1-inlierRation^nSamples))
end