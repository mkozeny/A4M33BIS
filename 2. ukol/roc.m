function roc(c,P,N)

Y1 = c'*P';
Y2 = c'*N';

SizeN = size(Y1,2);
SizeP = size(Y2,2);

%hold on
%plot(Y1, P,'rx');
%plot(Y2, N,'bo');
%hold off
values = sort([Y1 Y2]);
Xpoints = [];
Ypoints = [];
hold on;

index = 1;
for i=values    
    CorrectCnt = size(find(Y1>=i),2);
    FalseCnt = size(find(Y2>=i),2);
    Xpoints(index) = FalseCnt / (SizeP);
    Ypoints(index) = CorrectCnt / (SizeN);
    index = index + 1 ;
end
plot(Xpoints,Ypoints,'-');
xlabel('false positive rate')
ylabel('1 - false negative rate')

hold off