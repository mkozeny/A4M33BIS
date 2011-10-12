function [F]=spam(fileName)

img = double(imread(fileName));
T = 4;

%vytvoreni submatic a odecteni pro vytvoreni differenci v danem smeru
right = img(:,1:end-1) - img(:,2:end);
left =   img(:,2:end) - img(:,1:end-1);
up = img(2:end,:) - img(1:end-1,:);
%up = img(1:end-1,:) - img(2:end,:);
down = img(1:end-1,:) - img(2:end,:);
upLeft = img(2:end,2:end) - img(1:end-1,1:end-1);
downLeft = img(1:end-1,2:end) - img(2:end,1:end-1);
upRight = img(1:end-1,2:end) - img(2:end,1:end-1);
downRight = img(1:end-1,1:end-1) - img(2:end,2:end);


%Vypocet podminenych pravdepodobnosti pro smery
Mright = probability(right,0,1,T);
Mleft  = probability(left,0,-1,T);
Mup    = probability(up,-1,0,T);
Mdown  = probability(down,1,0,T);

MupRight = probability(upRight,-1,1,T);
MupLeft  = probability(upLeft,-1,-1,T);
MdownRight = probability(downRight,1,1,T);
MdownLeft = probability(downLeft,1,-1,T);

%vypocet features
F1 = (Mright + Mleft + Mdown + Mup) / 4;
F2 = (MdownRight + MupLeft + MdownLeft + MupRight) /4;
F = [F1 F2]; 
F = F(:);



