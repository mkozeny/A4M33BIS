function embed(image_name,message,key,output_name)
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
    fprintf('Length for encoding message: %i\n',max_message_length);
    %rand('seed',key);
    %fprintf('mesage length: %i\n',length(message));
    %height = randi(parameters(1),1,length(message)+max_message_length);
    fprintf('---HEIGHT: %i---\n',parameters(1));
    %rand('seed',key+4);
    %width = randi(parameters(2),1,length(message)+max_message_length);
    fprintf('---WIDTH: %i---\n',parameters(2));
    fprintf('Max. length of message is: %i\n',image_size-max_message_length);
    message_length_binary_array = length(message);
    if(message_length_binary_array>(image_size-max_message_length))
       error('Message is too long\n'); 
    end
    %color_values = 
    fprintf('---LENGTH ENCODING: %i---\n',message_length_binary_array);
    for j=1:max_message_length,
        x = ceil(positions(j)/width);
        y = mod(positions(j),width)+1;
        fprintf('---POSITION: %i, BIT VALUE: %i---\n',j,bitget(message_length_binary_array,j));
        if (bitget(message_length_binary_array,j)==1 & mod(image(x,y,1),2)==0) | (bitget(message_length_binary_array,j)==0 & mod(image(x,y,1),2)==1)
            if image(x,y,1)~= 0 & image(x,y,1)~= 255
                flipcoin = randperm(2);
                if flipcoin(1)==1
                    fprintf('adding +1 to: %i %i; color: %i\n',x,y,image(x,y,1));
                    image(x,y,1) = image(x,y,1)+1;
                elseif flipcoin(1)==2
                    fprintf('adding -1 to: %i %i; color: %i\n',x,y,image(x,y,1));
                    image(x,y,1) = image(x,y,1)-1;
                end
            elseif image(x,y,1)== 0
                fprintf('adding +1 to: %i %i; color: %i\n',x,y,image(x,y,1));
                image(x,y,1) = image(x,y,1)+1;
            elseif image(x,y,1)== 255
                fprintf('adding -1 to: %i %i; color: %i\n',x,y,image(x,y,1));
                image(x,y,1) = image(x,y,1)-1;
            end
        else
            fprintf('adding nothing to: %i %i; color: %i\n',x,y,image(x,y,1));
        end
    end
    fprintf('\n---MESSAGE ENCODING: %i---\n',message_length_binary_array);
    for i=(max_message_length+1):(message_length_binary_array+max_message_length),
            x = ceil(positions(i)/width);
            y = mod(positions(i),width)+1;
            %fprintf('---X: %i, Y: %i---\n',x,y);
            %fprintf('---POSITION: %i, BIT VALUE: %i---\n',i,message(i-max_message_length));
            if (message(i-max_message_length)==1 & mod(image(x,y,1),2)==0) | (message(i-max_message_length)==0 & mod(image(x,y,1),2)==1)
                if image(x,y,1)~= 0 & image(x,y,1)~= 255
                    flipcoin = randperm(2);
                    if flipcoin(1)==1
                        %fprintf('adding +1 to: %i %i; color: %i\n',x,y,image(x,y,1));
                        image(x,y,1) = image(x,y,1)+1;
                    elseif flipcoin(1)==2
                        %fprintf('adding -1 to: %i %i; color: %i\n',x,y,image(x,y,1));
                        image(x,y,1) = image(x,y,1)-1;
                    end
                elseif image(x,y,1)== 0
                    image(x,y,1) = image(x,y,1)+1;
                elseif image(x,y,1)== 255
                    image(x,y,1) = image(x,y,1)-1;
                end
            %else
                %   fprintf('adding nothing to: %i %i; color: %i\n',x,y,image(x,y,1));
            end
        
    end
    imwrite(image,output_name,format)