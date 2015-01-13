function [keys, key, keyscores] = findkey(chromavec)
%given a chroma vector, returns the most likely key and a matrix of scores for all possible keys

majChroma = [0.148934, 0.049866, 0.094673, 0.041497, 0.108552, 0.105067, 0.062321, 0.145902, 0.043267, 0.064755, 0.033317, 0.101851];
minChroma = [0.135583, 0.046654, 0.091167, 0.090486, 0.051792, 0.105598, 0.069482, 0.143637, 0.081738, 0.043966, 0.049288, 0.090606];

%create matrix of chroma vectors for all keys
keys = [];
for x = 0:11
    keys = [keys; majChroma([ end-x+1:end 1:end-x])];
end;
for x = 0:11
    keys = [keys; minChroma([ end-x+1:end 1:end-x])];
end;

%calculate distance scores
scores = [];
for key = 1:24
    distance = 0;
    for pc = 1:12
        distance = distance + (keys(key, pc) - chromavec(pc))^2;
    end;
    distance = sqrt(distance);
    distance = distance*100;
    scores = [scores distance];
end;
scores = [scores; 0:23]';           %pair scores with keys
scores = sortrows(scores);          %sort from low to high distance

keyscores(:,1) = scores(:,2);       %put keys on left side of matrix
keyscores(:,2) = scores(:,1);

key = keyscores(1,1);               %find most likely key
