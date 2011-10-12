function [f] = extractCooc2(fileName)
    format long e;
    info = imfinfo(fileName);
    imgFormat = info.Format;
    image = double(imread(fileName,imgFormat));
    red = image(:,:,1);
    %green = image(:,:,2);
    %blue = image(:,:,3);
    T = 4;
    position = 1;
    values = [];
    for i=-T:T
        values(position) = i;
        position = position +1;
    end
    %values
    %[m,n] = size(red)
    
    %red
    %shiftRightRed = circshift(red,[0 1]);
    differenceRightRedMatrix = red(:,1:(end-1)) - red(:,2:end);
    [m1,n1] = size(differenceRightRedMatrix);
    countElRightRed = zeros(1,2*T+1);
    for i=1:m1
        for j=1:n1
            positionVal = differenceRightRedMatrix(i,j);
            if positionVal>= -T && positionVal<= T
                countElRightRed(positionVal+T+1) = countElRightRed(positionVal+T+1)+1;
            end
        end
    end
    %countElRightRed=histc(sort(differenceRightRedMatrix(:)'),values); %# get the count of elements
    relRightRedFreq=double(countElRightRed)/double(numel(differenceRightRedMatrix));
    relRightRedFreqMatrix = repmat(relRightRedFreq,2*T+1,1);

    
    %shiftDownRed = circshift(red,[1 0]);
    differenceDownRedMatrix = red(1:(end-1),:) - red(2:end,:);
    [m2,n2] = size(differenceDownRedMatrix);
    countElDownRed = zeros(1,2*T+1);
    for i=1:m2
        for j=1:n2
            positionVal = differenceDownRedMatrix(i,j);
            if positionVal>= -T && positionVal<= T
                countElDownRed(positionVal+T+1) = countElDownRed(positionVal+T+1)+1;
            end
        end
    end
    %countElDownRed=histc(sort(differenceDownRedMatrix(:)'),values); %# get the count of elements
    relDownRedFreq=double(countElDownRed)/double(numel(differenceDownRedMatrix));
    relDownRedFreqMatrix = repmat(relDownRedFreq,2*T+1,1);
    
    %shiftDownRightRed = circshift(red,[1 1]);
    differenceDownRightRedMatrix = red(1:(end-1),1:(end-1)) - red(2:end,2:end);
    [m3,n3] = size(differenceDownRightRedMatrix);
    countElDownRightRed = zeros(1,2*T+1);
    for i=1:m3
        for j=1:n3
            positionVal = differenceDownRightRedMatrix(i,j);
            if positionVal>= -T && positionVal<= T
                countElDownRightRed(positionVal+T+1) = countElDownRightRed(positionVal+T+1)+1;
            end
        end
    end
    %countElDownRightRed=histc(sort(differenceDownRightRedMatrix(:)'),values); %# get the count of elements
    relDownRightRedFreq=double(countElDownRightRed)/double(numel(differenceDownRightRedMatrix));
    relDownRightRedFreqMatrix = repmat(relDownRightRedFreq,2*T+1,1);
    
    %shiftDownLeftRed = circshift(red,[1 -1]);
    differenceDownLeftRedMatrix = red(1:(end-1),2:end) - red(2:end,1:(end-1));
    [m4,n4] = size(differenceDownLeftRedMatrix);
    countElDownLeftRed = zeros(1,2*T+1);
    for i=1:m4
        for j=1:n4
            positionVal = differenceDownLeftRedMatrix(i,j);
            if positionVal>= -T && positionVal<= T
                countElDownLeftRed(positionVal+T+1) = countElDownLeftRed(positionVal+T+1)+1;
            end
        end
    end
    %countElDownLeftRed=histc(sort(differenceDownLeftRedMatrix(:)'),values); %# get the count of elements
    relDownLeftRedFreq=double(countElDownLeftRed)/double(numel(differenceDownLeftRedMatrix));
    relDownLeftRedFreqMatrix = repmat(relDownLeftRedFreq,2*T+1,1);
    
    differenceLeftRedMatrix = red(:,2:end) - red(:,1:(end-1));
    [m5,n5] = size(differenceLeftRedMatrix);
    
    countElLeftRed = zeros(1,2*T+1);
    for i=1:m5
        for j=1:n5
            positionVal = differenceLeftRedMatrix(i,j);
            if positionVal>= -T && positionVal<= T
                countElLeftRed(positionVal+T+1) = countElLeftRed(positionVal+T+1)+1;
            end
        end
    end
    %countElLeftRed=histc(sort(differenceLeftRedMatrix(:)'),values); %# get the count of elements
    relLeftRedFreq=double(countElLeftRed)/double(numel(differenceLeftRedMatrix));
    relLeftRedFreqMatrix = repmat(relLeftRedFreq,2*T+1,1);
    
    differenceUpRedMatrix = red(2:end,:) - red(1:(end-1),:);
    [m6,n6] = size(differenceUpRedMatrix);
    countElUpRed = zeros(1,2*T+1);
    for i=1:m6
        for j=1:n6
            positionVal = differenceUpRedMatrix(i,j);
            if positionVal>= -T && positionVal<= T
                countElUpRed(positionVal+T+1) = countElUpRed(positionVal+T+1)+1;
            end
        end
    end
    %countElUpRed=histc(sort(differenceUpRedMatrix(:)'),values); %# get the count of elements
    relUpRedFreq=double(countElUpRed)/double(numel(differenceUpRedMatrix));
    relUpRedFreqMatrix = repmat(relUpRedFreq,2*T+1,1);
    
    differenceUpRightRedMatrix = red(2:end,1:(end-1)) - red(1:(end-1),2:end);
    [m7,n7] = size(differenceUpRightRedMatrix);
    countElUpRightRed = zeros(1,2*T+1);
    for i=1:m7
        for j=1:n7
            positionVal = differenceUpRightRedMatrix(i,j);
            if positionVal>= -T && positionVal<= T
                countElUpRightRed(positionVal+T+1) = countElUpRightRed(positionVal+T+1)+1;
            end
        end
    end
    %countElUpRightRed=histc(sort(differenceUpRightRedMatrix(:)'),values); %# get the count of elements
    relUpRightRedFreq=double(countElUpRightRed)/double(numel(differenceUpRightRedMatrix));
    relUpRightRedFreqMatrix = repmat(relUpRightRedFreq,2*T+1,1);
    
    differenceUpLeftRedMatrix = red(2:end,2:end) - red(1:(end-1),1:(end-1));
    [m8,n8] = size(differenceUpLeftRedMatrix);
    countElUpLeftRed = zeros(1,2*T+1);
    for i=1:m8
        for j=1:n8
            positionVal = differenceUpLeftRedMatrix(i,j);
            if positionVal>= -T && positionVal<= T
                countElUpLeftRed(positionVal+T+1) = countElUpLeftRed(positionVal+T+1)+1;
            end
        end
    end
    %countElUpLeftRed=histc(sort(differenceUpLeftRedMatrix(:)'),values); %# get the count of elements
    relUpLeftRedFreq=double(countElUpLeftRed)/double(numel(differenceUpLeftRedMatrix));
    relUpLeftRedFreqMatrix = repmat(relUpLeftRedFreq,2*T+1,1);
    
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
    probabilityMatrixRightRed = double(probabilityMatrixRightRed)/double(m1*n1);
    probabilityMatrixRightRed = double(probabilityMatrixRightRed)./double(relRightRedFreqMatrix);
    
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
    probabilityMatrixDownRed = double(probabilityMatrixDownRed)/double(m2*n2);
    probabilityMatrixDownRed = double(probabilityMatrixDownRed)./double(relDownRedFreqMatrix);
    
    
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
    probabilityMatrixDownRightRed = double(probabilityMatrixDownRightRed)/double(m3*n3);
    probabilityMatrixDownRightRed = double(probabilityMatrixDownRightRed)./double(relDownRightRedFreqMatrix);
    
    
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
    probabilityMatrixDownLeftRed = double(probabilityMatrixDownLeftRed)/double(m4*n4);
    probabilityMatrixDownLeftRed = double(probabilityMatrixDownLeftRed)./double(relDownLeftRedFreqMatrix);
    
    
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
    probabilityMatrixLeftRed = double(probabilityMatrixLeftRed)/double(m5*n5);
    probabilityMatrixLeftRed = double(probabilityMatrixLeftRed)./double(relLeftRedFreqMatrix);
    
    
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
    probabilityMatrixUpRed = double(probabilityMatrixUpRed)/double(m6*n6);
    probabilityMatrixUpRed = double(probabilityMatrixUpRed)./double(relUpRedFreqMatrix);
    
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
    probabilityMatrixUpRightRed = double(probabilityMatrixUpRightRed)/double(m7*n7);
    probabilityMatrixUpRightRed = double(probabilityMatrixUpRightRed)./double(relUpRightRedFreqMatrix);
    
    
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
    probabilityMatrixUpLeftRed = double(probabilityMatrixUpLeftRed)/double(m8*n8);
    probabilityMatrixUpLeftRed = double(probabilityMatrixUpLeftRed)./double(relUpLeftRedFreqMatrix);
    
    %f1 = (probabilityMatrixRightRed(:) + probabilityMatrixDownRed(:))/2;
    %f2 = (probabilityMatrixDownRightRed(:) + probabilityMatrixDownLeftRed(:))/2;
    f1 = double(probabilityMatrixRightRed(:) + probabilityMatrixLeftRed(:) + probabilityMatrixDownRed(:)+ probabilityMatrixUpRed(:))/double(4);
    f2 = double(probabilityMatrixDownRightRed(:) + probabilityMatrixUpLeftRed(:) + probabilityMatrixDownLeftRed(:)+ probabilityMatrixUpRightRed(:))/double(4);
    f = [f1 f2];