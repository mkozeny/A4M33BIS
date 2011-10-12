function [f] = spamFeatures(fileName)
    format long e;
    info = imfinfo(fileName);
    imgFormat = info.Format;
    image = double(imread(fileName,imgFormat));
    imageMatrix = image(:,:,1);
    T = 4;
    
    
    differenceRightMatrix = imageMatrix(:,1:(end-1)) - imageMatrix(:,2:end);
    differenceLeftMatrix = imageMatrix(:,2:end) - imageMatrix(:,1:(end-1));
    differenceDownMatrix = imageMatrix(1:(end-1),:) - imageMatrix(2:end,:);
    differenceUpMatrix = imageMatrix(2:end,:) - imageMatrix(1:(end-1),:);
    differenceDownRightMatrix = imageMatrix(1:(end-1),1:(end-1)) - imageMatrix(2:end,2:end);
    differenceUpLeftMatrix = imageMatrix(2:end,2:end) - imageMatrix(1:(end-1),1:(end-1));
    differenceDownLeftMatrix = imageMatrix(1:(end-1),2:end) - imageMatrix(2:end,1:(end-1));
    differenceUpRightMatrix = imageMatrix(2:end,1:(end-1)) - imageMatrix(1:(end-1),2:end);
    
    
    
    probabilityMatrixRight = getProbabilityMatrix(differenceRightMatrix,T,0,1);
    probabilityMatrixLeft = getProbabilityMatrix(differenceLeftMatrix,T,0,-1);
    probabilityMatrixDown = getProbabilityMatrix(differenceDownMatrix,T,1,0);
    probabilityMatrixUp = getProbabilityMatrix(differenceUpMatrix,T,-1,0);
    probabilityMatrixDownRight = getProbabilityMatrix(differenceDownRightMatrix,T,1,1);
    probabilityMatrixUpLeft = getProbabilityMatrix(differenceUpLeftMatrix,T,-1,-1);
    probabilityMatrixDownLeft = getProbabilityMatrix(differenceDownLeftMatrix,T,1,-1);
    probabilityMatrixUpRight = getProbabilityMatrix(differenceUpRightMatrix,T,-1,1);
    
    
    
    
    f1 = double(probabilityMatrixRight(:) + probabilityMatrixLeft(:) + probabilityMatrixDown(:)+ probabilityMatrixUp(:))/double(4);
    f2 = double(probabilityMatrixDownRight(:) + probabilityMatrixUpLeft(:) + probabilityMatrixDownLeft(:)+ probabilityMatrixUpRight(:))/double(4);
    f = [f1 f2];
    f = f(:);