function [probabilityMatrix] = getProbabilityMatrix(differenceMatrix, T, xDir, yDir)
    position = 1;
    values = [];
    for i=-T:T
        values(position) = i;
        position = position +1;
    end
    [m,n] = size(differenceMatrix);
    probabilityMatrix = zeros(2*T+1,2*T+1);
    xStart = 1;
    xEnd = m;
    if xDir==-1
        xStart = 2;
    elseif xDir==1
        xEnd = m-1;
    end
    yStart = 1;
    yEnd = n;
    if yDir==-1
        yStart = 2;
    elseif yDir==1
        yEnd = n-1;
    end
    for i=xStart:xEnd
        for j=yStart:yEnd
            rowDiff = differenceMatrix(i+xDir,j+yDir);
            colDiff = differenceMatrix(i,j);
            if rowDiff>= -T && rowDiff<= T && colDiff>= -T && colDiff<= T
                probabilityMatrix(rowDiff+T+1,colDiff+T+1) = probabilityMatrix(rowDiff+T+1,colDiff+T+1)+1;
            end
        end
    end
    probabilityMatrix = probabilityMatrix/((m-abs(xDir))*(n-abs(yDir)));
    probabilityMatrix = probabilityMatrix./differenceFrequency(differenceMatrix,values, T);