function [f] = extractCooc(fileName)
    format long e;
    info = imfinfo(fileName);
    imgFormat = info.Format;
    image = double(imread(fileName,imgFormat));
    red = image(:,:,1);
    %green = image(:,:,2);
    %blue = image(:,:,3);
    T = 4;
    %[m,n] = size(red)
    
    %red
    %shiftRightRed = circshift(red,[0 1]);
    differenceRightRedMatrix = red(:,1:(end-1)) - red(:,2:end);
    [m1,n1] = size(differenceRightRedMatrix);
    
    %shiftDownRed = circshift(red,[1 0]);
    differenceDownRedMatrix = red(1:(end-1),:) - red(2:end,:);
    [m2,n2] = size(differenceDownRedMatrix);
    
    %shiftDownRightRed = circshift(red,[1 1]);
    differenceDownRightRedMatrix = red(1:(end-1),1:(end-1)) - red(2:end,2:end);
    [m3,n3] = size(differenceDownRightRedMatrix);
    
    %shiftDownLeftRed = circshift(red,[1 -1]);
    differenceDownLeftRedMatrix = red(1:(end-1),2:end) - red(2:end,1:(end-1));
    [m4,n4] = size(differenceDownLeftRedMatrix);
    
    differenceLeftRedMatrix = red(:,2:end) - red(:,1:(end-1));
    [m5,n5] = size(differenceLeftRedMatrix);
    
    differenceUpRedMatrix = red(2:end,:) - red(1:(end-1),:);
    [m6,n6] = size(differenceUpRedMatrix);
    
    differenceUpRightRedMatrix = red(2:end,1:(end-1)) - red(1:(end-1),2:end);
    [m7,n7] = size(differenceUpRightRedMatrix);
    
    differenceUpLeftRedMatrix = red(2:end,2:end) - red(1:(end-1),1:(end-1));
    [m8,n8] = size(differenceUpLeftRedMatrix);
    
    probabilityMatrixRightRed = zeros(2*T+1,2*T+1);
    for i=1:m1
        for j=1:(n1-1)
            rowDiff = differenceRightRedMatrix(i,j+1);
            colDiff = differenceRightRedMatrix(i,j);
            if rowDiff>= -T && rowDiff<= T && colDiff>= -T && colDiff<= T
                probabilityMatrixRightRed(rowDiff+T+1,colDiff+T+1) = probabilityMatrixRightRed(rowDiff+T+1,colDiff+T+1)+1;
            end
        end
    end
    probabilityMatrixRightRed = probabilityMatrixRightRed/(m1*n1);
    
    probabilityMatrixDownRed = zeros(2*T+1,2*T+1);
    for j=1:n2
        for i=1:(m2-1)
            rowDiff = differenceDownRedMatrix(i+1,j);
            colDiff = differenceDownRedMatrix(i,j);
            if rowDiff>= -T && rowDiff<= T && colDiff>= -T && colDiff<= T
                probabilityMatrixDownRed(rowDiff+T+1,colDiff+T+1) = probabilityMatrixDownRed(rowDiff+T+1,colDiff+T+1)+1;
            end
        end
    end
    probabilityMatrixDownRed = probabilityMatrixDownRed/(m2*n2);
    
    
    
    probabilityMatrixDownRightRed = zeros(2*T+1,2*T+1);
    for i=1:(m3-1)
        for j=1:(n3-1)
            rowDiff = differenceDownRightRedMatrix(i+1,j+1);
            colDiff = differenceDownRightRedMatrix(i,j);
            if rowDiff>= -T && rowDiff<= T && colDiff>= -T && colDiff<= T
                probabilityMatrixDownRightRed(rowDiff+T+1,colDiff+T+1) = probabilityMatrixDownRightRed(rowDiff+T+1,colDiff+T+1)+1;
            end
        end
    end
    probabilityMatrixDownRightRed = probabilityMatrixDownRightRed/(m3*n3);
    
    
    probabilityMatrixDownLeftRed = zeros(2*T+1,2*T+1);
    for i=1:(m4-1)
        for j=2:n4
            rowDiff = differenceDownLeftRedMatrix(i+1,j-1);
            colDiff = differenceDownLeftRedMatrix(i,j);
            if rowDiff>= -T && rowDiff<= T && colDiff>= -T && colDiff<= T
                probabilityMatrixDownLeftRed(rowDiff+T+1,colDiff+T+1) = probabilityMatrixDownLeftRed(rowDiff+T+1,colDiff+T+1)+1;
            end
        end
    end
    probabilityMatrixDownLeftRed = probabilityMatrixDownLeftRed/(m4*n4);
    
    
    
    probabilityMatrixLeftRed = zeros(2*T+1,2*T+1);
    for i=1:m5
        for j=2:n5
            rowDiff = differenceLeftRedMatrix(i,j-1);
            colDiff = differenceLeftRedMatrix(i,j);
            if rowDiff>= -T && rowDiff<= T && colDiff>= -T && colDiff<= T
                probabilityMatrixLeftRed(rowDiff+T+1,colDiff+T+1) = probabilityMatrixLeftRed(rowDiff+T+1,colDiff+T+1)+1;
            end
        end
    end
    probabilityMatrixLeftRed = probabilityMatrixLeftRed/(m5*n5);
    
    
    
    probabilityMatrixUpRed = zeros(2*T+1,2*T+1);
    for i=2:m6
        for j=1:n6
            rowDiff = differenceUpRedMatrix(i-1,j);
            colDiff = differenceUpRedMatrix(i,j);
            if rowDiff>= -T && rowDiff<= T && colDiff>= -T && colDiff<= T
                probabilityMatrixUpRed(rowDiff+T+1,colDiff+T+1) = probabilityMatrixUpRed(rowDiff+T+1,colDiff+T+1)+1;
            end
        end
    end
    probabilityMatrixUpRed = probabilityMatrixUpRed/(m6*n6);
    
    probabilityMatrixUpRightRed = zeros(2*T+1,2*T+1);
    for i=2:m7
        for j=1:(n7-1)
            rowDiff = differenceUpRightRedMatrix(i-1,j+1);
            colDiff = differenceUpRightRedMatrix(i,j);
            if rowDiff>= -T && rowDiff<= T && colDiff>= -T && colDiff<= T
                probabilityMatrixUpRightRed(rowDiff+T+1,colDiff+T+1) = probabilityMatrixUpRightRed(rowDiff+T+1,colDiff+T+1)+1;
            end
        end
    end
    probabilityMatrixUpRightRed = probabilityMatrixUpRightRed/(m7*n7);
    
    
    probabilityMatrixUpLeftRed = zeros(2*T+1,2*T+1);
    for i=2:m4
        for j=2:n4
            rowDiff = differenceUpLeftRedMatrix(i-1,j-1);
            colDiff = differenceUpLeftRedMatrix(i,j);
            if rowDiff>= -T && rowDiff<= T && colDiff>= -T && colDiff<= T
                probabilityMatrixUpLeftRed(rowDiff+T+1,colDiff+T+1) = probabilityMatrixUpLeftRed(rowDiff+T+1,colDiff+T+1)+1;
            end
        end
    end
    probabilityMatrixUpLeftRed = probabilityMatrixUpLeftRed/(m8*n8);
    
    %f1 = (probabilityMatrixRightRed(:) + probabilityMatrixDownRed(:))/2;
    %f2 = (probabilityMatrixDownRightRed(:) + probabilityMatrixDownLeftRed(:))/2;
    f1 = (probabilityMatrixRightRed(:) + probabilityMatrixLeftRed(:) + probabilityMatrixDownRed(:)+ probabilityMatrixUpRed(:))/4;
    f2 = (probabilityMatrixDownRightRed(:) + probabilityMatrixUpLeftRed(:) + probabilityMatrixDownLeftRed(:)+ probabilityMatrixUpRightRed(:))/4;
    f = [f1 f2];
    %differenceRightRedMatrixVector = differenceRightRedMatrix(:)';
    %differenceDownRedMatrixVector = differenceDownRedMatrix(:)';
    %differenceDownRightRedMatrixVector = differenceDownRightRedMatrix(:)';
    %differenceDownLeftRedMatrixVector = differenceDownLeftRedMatrix(:)';
    %position = 1;
    %values = [];
    %for i=-T:T
    %    values(position) = i;
    %    position = position +1;
    %end
    %values = [-4 -3 -2 -1 0 1 2 3 4];
    
    %countElRightRed=histc(differenceRightRedMatrixVector,values);
    %countElDownRed=histc(differenceDownRedMatrixVector,values);
    %countElDownRightRed=histc(differenceDownRightRedMatrixVector,values);
    %countElDownLeftRed=histc(differenceDownLeftRedMatrixVector,values);
    
    %relRightRedFreq=countElRightRed/numel(differenceRightRedMatrixVector);
    %relDownRedFreq=countElDownRed/numel(differenceDownRedMatrixVector);
    %relDownRightRedFreq=countElDownRightRed/numel(differenceDownRightRedMatrixVector);
    %relDownLeftRedFreq=countElDownLeftRed/numel(differenceDownLeftRedMatrixVector);

    
    %f1 = (relRightRedFreq+relDownRedFreq)/2;
    %f2 = (relDownRightRedFreq+relDownLeftRedFreq)/2;
    %f = [f1 f2];
    
    %green
    %shiftRightGreen = circshift(green,[0 1]);
    %differenceRightGreenMatrix = green - shiftRightGreen;
    
    %shiftDownGreen = circshift(green,[1 0]);
    %differenceDownGreenMatrix = green - shiftDownGreen;
    
    %shiftDownRightGreen = circshift(green,[1 1]);
    %differenceDownRightGreenMatrix = green - shiftDownRightGreen;
    
    %shiftDownLeftGreen = circshift(green,[1 -1]);
    %differenceDownLeftGreenMatrix = green - shiftDownLeftGreen;
    
    %blue
    %shiftRightBlue = circshift(blue,[0 1]);
    %differenceRightBlueMatrix = blue - shiftRightBlue;
    
    %shiftDownBlue = circshift(blue,[1 0]);
    %differenceDownBlueMatrix = blue - shiftDownBlue;
    
    %shiftDownRightBlue = circshift(blue,[1 1]);
    %differenceDownRightBlueMatrix = blue - shiftDownRightBlue;
    
    %shiftDownLeftBlue = circshift(blue,[1 -1]);
    %differenceDownLeftBlueMatrix = blue - shiftDownLeftBlue;