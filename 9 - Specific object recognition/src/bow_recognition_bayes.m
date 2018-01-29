function label = bow_recognition_bayes( histogram, vBoWPos, vBoWNeg)

    [muPos, sigmaPos] = computeMeanStd(vBoWPos);
    [muNeg, sigmaNeg] = computeMeanStd(vBoWNeg);

    % Calculating the probability of appearance each word in observed histogram
    % according to normal distribution in each of the positive and negative bag of words
    pHistPos = 0;
    pHistNeg = 0;
    for i = 1:length(histogram)
        pP = log(normpdf(histogram(i), muPos(i), sigmaPos(i)));
        if ~isnan(pP)
            pHistPos = pHistPos + pP;
        end
        pN = log(normpdf(histogram(i), muNeg(i), sigmaNeg(i)));
        if ~isnan(pN)
            pHistNeg = pHistNeg + pN;
        end
    end
    pHistPos = exp(pHistPos);
    pHistNeg = exp(pHistNeg);
    
    pPos = 0.5;
    pNeg = 0.5;
    if pPos * pHistPos > pNeg * pHistNeg
        label = 1;
    else
        label = 0;
    end
    
end