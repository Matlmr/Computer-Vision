function [in1, in2, out1, out2, m, F] = ransac8pF(xy1, xy2, threshold)

    bestMatches = 0;
    number = size(xy1,2);
    xy1(3,:) = ones(1,number);
    xy2(3,:) = ones(1,number);
    
    N = 8;
    p = 0.99;
    n = intmax;   % adaptive ransac
    
    i = 0;
    
    iter = 1000;   % standard ransac
    %for i = 1:iter % standard ransac
        
    while (i < n) % adaptive ransac
        
        index = randperm(number,N);
        x1s = xy1(:,index);
        x2s = xy2(:,index);
        [~,F_try] = fundamentalMatrix(x1s,x2s);
        matches = [];
        nomatch = [];
                
        for j = 1:number
            if (distSampson(xy1(:,j),F_try,xy2(:,j)) < threshold)
                matches = [matches j];
            else
                nomatch = [nomatch j];
            end
        end
        
        if numel(matches) > bestMatches
            in1 = xy1(1:2,matches);
            in2 = xy2(1:2,matches);
            out1 = xy1(1:2,nomatch);
            out2 = xy2(1:2,nomatch);
            bestMatches = numel(matches);
           
            % adaptive ransac
            n = nTrials(bestMatches/number,N,p);
        end
       % adaptive ransac
        i = i+1; 
    end
    m = i;
    [~,F] = fundamentalMatrix([in1;ones(1,bestMatches)],[in2;ones(1,bestMatches)]);
    
end