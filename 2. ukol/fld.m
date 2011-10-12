function v = fld(P, N)

    [rowsP,colsP] = size(P);
    [rowsN,colsN] = size(N);
    my1 = mean(P);
    my2 = mean(N);
    
    s1 = zeros(size(P,2));
    for i=1:rowsP
        s1 = s1 +((P(i,:) - my1)'*(P(i,:) - my1));
    end
    s1 = s1/rowsP;
    s2 = zeros(size(N,2));
    for i=1:rowsN
        s2 = s2 +((N(i,:) - my2)'*(N(i,:) - my2));
    end
    s2 = s2/rowsN;
    
    sb = (my1 - my2)'*(my1 - my2);
    sw = s1 + s2;
    [v1,d] = eig(sb,sw);
    [r,c] = find(d==max(max(d)));
    v = v1(:,c)
    
    