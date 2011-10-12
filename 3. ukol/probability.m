function [M]=probability(D,directionX,directionY,T)

[x,y]=size(D);


% Pa = Pa prunik Pb / Pb
n = (2*T+1);
indexShift = T+1;
Pb = zeros(1,n);
M = zeros(n,n);

for i=1 : x
    for j=1 : y  
      if (D(i,j)>=-T && D(i,j) <=T)
           
        Pb(D(i,j)+indexShift) = Pb(D(i,j)+indexShift) + 1;                        
        %dvojice
        if(i+directionX > 0 && j+directionY > 0 && j+directionY <= y &&  i+directionX <= x)
            if( D(i+directionX,j+directionY)<=T && D(i+directionX,j+directionY)>= -T)
                M(D(i+directionX,j+directionY)+indexShift,D(i,j)+indexShift) = M(D(i+directionX,j+directionY)+indexShift,D(i,j)+indexShift) + 1;                
             
            end
        end
      end 
    end
end

Pb = Pb / (x*y) 
%Pb = Pb;


M = M / ((x-abs(directionX))*(y-abs(directionY)));
%M = M;
M = M ./ repmat(Pb,n,1);




