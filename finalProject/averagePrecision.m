function [score] = averagePrecision(predictedY, realY)
    nominator = 0;
    denominator = 0;
    score = zeros(size(predictedY));
    for ii = 1:(size(predictedY, 1))
        denominator = denominator + 1;
        if predictedY(ii) == realY(ii)
            nominator = nominator + 1;
            score(ii) = nominator / denominator;
        else 
            score(ii) = 0 / denominator;
        end
    end
    
    score = sum(score) / size(predictedY, 1);
end