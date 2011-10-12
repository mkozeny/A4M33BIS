function [relFreqMatrix] = differenceFrequency(differenceMatrix, values, T)
    countEl=histc(sort(differenceMatrix(:)'),values);
    relFreq=countEl/numel(differenceMatrix);
    relFreqMatrix = repmat(relFreq,2*T+1,1);