function TestHomework(image,msgLength,key)
if (nargin<3)
 key = 1;
end
if (nargin<2)
 msgLength = 10000;
end
if (nargin<1)
 image = 'cover.png';
end

%generation of the random message
s = RandStream('mt19937ar','Seed', key);
RandStream.setDefaultStream(s);
message=round(rand(msgLength,1));

embed(image,message,key,'stego.png');
extMessage=extract('stego.png',key);

if sum(message~=extMessage)==0
    fprintf('Message correctly extracted\n');
else
    fprintf('Message not embedded correctly.\n');
end
cover=imread(image);
stego=imread('stego.png');
D=double(cover)-double(stego);
if max(D(:))>1
	fprintf('difference between pixels >1\n');
end

LSBCover=mod(cover,2);
odd=D(LSBCover==1);
even=D(LSBCover==0);
fprintf('even pixels: %d (%.0f%%) pixels increased, %d (%.0f%%) pixels decreased\n',sum(even(:)>0),100*sum(even(:)>0)/msgLength,sum(even(:)<0),100*sum(even(:)<0)/msgLength);
fprintf('odd pixels: %d (%.0f%%) pixels increased, %d (%.0f%%) pixels decreased\n',sum(odd(:)>0),100*sum(odd(:)<0)/msgLength,sum(odd(:)<0),100*sum(odd(:)<0)/msgLength);

%show the differences
imshow(abs(D));
