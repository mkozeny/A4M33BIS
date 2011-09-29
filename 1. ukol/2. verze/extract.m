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
    max_message_length = ceil(log(image_size));
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
        fprintf('---POSITION: %i, BIT VALUE: %i---\n',j,image(ceil(positions(j)/width),mod(positions(j),width),1));
        if (mod(image(ceil(positions(j)/width),mod(positions(j),width),1),2)==1)
            fprintf('reading 1 from: %i %i; adding: %i, message length before: %i\n',ceil(positions(j)/width),mod(positions(j),width),2^(j-1),message_length);
            message_length = message_length + 2^(j-1);
        else
            fprintf('reading 0 from: %i %i; adding nothing, message length before: %i\n',ceil(positions(j)/width),mod(positions(j),width),message_length);
        end
    end
     disp(message_length);

    for i=(max_message_length+1):(message_length+max_message_length),
        
        if (mod(image(ceil(positions(i)/width),mod(positions(i),width),1),2)==1)
            message(i-max_message_length) = 1;
        elseif (mod(image(ceil(positions(i)/width),mod(positions(i),width),1),2)==0)
            message(i-max_message_length) = 0;
        end
        
    end
    