function [message] = extract(image_name,key)
    info = imfinfo(image_name);
    format = info.Format;
    image = imread(image_name,format);
    parameters = size(image);
    rand('seed',key);
    height = randi(parameters(1),1,parameters(1));
    fprintf('---HEIGHT: %i---\n',parameters(1));
    rand('seed',key+4);
    width = randi(parameters(2),1,parameters(2));
    fprintf('---WIDTH: %i---\n',parameters(2));
    message_length = 0;
    message = [];
    fprintf('---LENGTH DECODING---\n');
    for j=1:16,
        fprintf('---POSITION: %i, BIT VALUE: %i---\n',j,image(height(j),width(j),1));
        if (mod(image(height(j),width(j),1),2)==1)
            fprintf('reading 1 from: %i %i; adding: %i, message length before: %i\n',height(j),width(j),2^(j-1),message_length);
            message_length = message_length + 2^(j-1);
        else
            fprintf('reading 0 from: %i %i; adding nothing, message length before: %i\n',height(j),width(j),message_length);
        end
    end
     disp(message_length);

    for i=17:(message_length+16),
        
        if (mod(image(height(i),width(i),1),2)==1)
            message(i-16) = 1;
        elseif (mod(image(height(i),width(i),1),2)==0)
            message(i-16) = 0;
        end 
        
    end
    