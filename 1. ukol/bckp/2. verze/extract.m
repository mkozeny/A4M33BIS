function [message] = extract(image_name,key)
    info = imfinfo(image_name);
    format = info.Format;
    image = imread(image_name,format);
    parameters = size(image);
    height = parameters(1);
    width = parameters(2);
    image_size = height*width;
    rand('seed',key);
    positions = randperm(image_size);
    max_message_length = ceil(log2(image_size));
    %rand('seed',key);
    %height = randi(parameters(1),1,parameters(1));
    fprintf('---HEIGHT: %i---\n',height);
    %rand('seed',key+4);
    %width = randi(parameters(2),1,parameters(2));
    fprintf('---WIDTH: %i---\n',width);
    message_length = 0;
    message = [];
    fprintf('---LENGTH DECODING---\n');
    for j=1:max_message_length,
        x = ceil(positions(j)/width);
        y = mod(positions(j),width)+1;
        fprintf('---POSITION: %i, BIT VALUE: %i---\n',j,image(x,y,1));
        if (mod(image(x,y,1),2)==1)
            fprintf('reading 1 from: %i %i; adding: %i, message length before: %i\n',x,y,2^(j-1),message_length);
            message_length = message_length + 2^(j-1);
        else
            fprintf('reading 0 from: %i %i; adding nothing, message length before: %i\n',x,y,message_length);
        end
    end
    for i=(max_message_length+1):(message_length+max_message_length),
        x = ceil(positions(i)/width);
        y = mod(positions(i),width)+1;
        if (mod(image(x,y,1),2)==1)
            message(i-max_message_length) = 1;
        elseif (mod(image(x,y,1),2)==0)
            message(i-max_message_length) = 0;
        end
        
    end
    message = transpose(message);
    