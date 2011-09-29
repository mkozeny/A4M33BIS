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
    max_message_length = ceil(log(image_size));
    %rand('seed',key);
    %fprintf('mesage length: %i\n',length(message));
    %height = randi(parameters(1),1,length(message)+max_message_length);
    fprintf('---HEIGHT: %i---\n',parameters(1));
    %rand('seed',key+4);
    %width = randi(parameters(2),1,length(message)+max_message_length);
    fprintf('---WIDTH: %i---\n',parameters(2));
    message_length_binary_array = length(message);
    fprintf('---LENGTH ENCODING: %i---\n',message_length_binary_array);
    for j=1:max_message_length,
        fprintf('---POSITION: %i, BIT VALUE: %i---\n',j,bitget(message_length_binary_array,j));
        if (bitget(message_length_binary_array,j)==1 & mod(image(ceil(positions(j)/width),mod(positions(j),width),1),2)==0) | (bitget(message_length_binary_array,j)==0 & mod(image(ceil(positions(j)/width),mod(positions(j),width),1),2)==1)
            if image(ceil(positions(j)/width),mod(positions(j),width),1)~= 0 & image(ceil(positions(j)/width),mod(positions(j),width),1)~= 255
                flipcoin = randperm(2);
                if flipcoin(1)==1
                    fprintf('adding +1 to: %i %i; color: %i\n',ceil(positions(j)/width),mod(positions(j),width),image(ceil(positions(j)/width),mod(positions(j),width),1));
                    image(ceil(positions(j)/width),mod(positions(j),width),1) = image(ceil(positions(j)/width),mod(positions(j),width),1)+1;
                elseif flipcoin(1)==2
                    fprintf('adding -1 to: %i %i; color: %i\n',ceil(positions(j)/width),mod(positions(j),width),image(ceil(positions(j)/width),mod(positions(j),width),1));
                    image(ceil(positions(j)/width),mod(positions(j),width),1) = image(ceil(positions(j)/width),mod(positions(j),width),1)-1;
                end
            elseif image(ceil(positions(j)/width),mod(positions(j),width),1)== 0
                fprintf('adding +1 to: %i %i; color: %i\n',ceil(positions(j)/width),mod(positions(j),width),image(ceil(positions(j)/width),mod(positions(j),width),1));
                image(ceil(positions(j)/width),mod(positions(j),width),1) = image(ceil(positions(j)/width),mod(positions(j),width),1)+1;
            elseif image(ceil(positions(j)/width),mod(positions(j),width),1)== 255
                fprintf('adding -1 to: %i %i; color: %i\n',ceil(positions(j)/width),mod(positions(j),width),image(ceil(positions(j)/width),mod(positions(j),width),1));
                image(ceil(positions(j)/width),mod(positions(j),width),1) = image(ceil(positions(j)/width),mod(positions(j),width),1)-1;
            end
        else
            fprintf('adding nothing to: %i %i; color: %i\n',ceil(positions(j)/width),mod(positions(j),width),image(ceil(positions(j)/width),mod(positions(j),width),1));
        end
    end
    fprintf('\n---MESSAGE ENCODING: %i---\n',message_length_binary_array);
    for i=(max_message_length+1):(message_length_binary_array+max_message_length),
            fprintf('---POSITION: %i, BIT VALUE: %i---\n',i,message(i-max_message_length));
            if (message(i-max_message_length)==1 & mod(image(ceil(positions(i)/width),mod(positions(i),width),1),2)==0) | (message(i-max_message_length)==0 & mod(image(ceil(positions(i)/width),mod(positions(i),width),1),2)==1)
                if image(ceil(positions(i)/width),mod(positions(i),width),1)~= 0 & image(ceil(positions(i)/width),mod(positions(i),width),1)~= 255
                    flipcoin = randperm(2);
                    if flipcoin(1)==1
                        fprintf('adding +1 to: %i %i; color: %i\n',ceil(positions(i)/width),mod(positions(i),width),image(ceil(positions(i)/width),mod(positions(i),width),1));
                        image(ceil(positions(i)/width),mod(positions(i),width),1) = image(ceil(positions(i)/width),mod(positions(i),width),1)+1;
                    elseif flipcoin(1)==2
                        fprintf('adding -1 to: %i %i; color: %i\n',ceil(positions(i)/width),mod(positions(i),width),image(ceil(positions(i)/width),mod(positions(i),width),1));
                        image(ceil(positions(i)/width),mod(positions(i),width),1) = image(ceil(positions(i)/width),mod(positions(i),width),1)-1;
                    end
                elseif image(ceil(positions(i)/width),mod(positions(i),width),1)== 0
                    image(ceil(positions(i)/width),mod(positions(i),width),1) = image(ceil(positions(i)/width),mod(positions(i),width),1)+1;
                elseif image(ceil(positions(i)/width),mod(positions(i),width),1)== 255
                    image(ceil(positions(i)/width),mod(positions(i),width),1) = image(ceil(positions(i)/width),mod(positions(i),width),1)-1;
                end
            else
                fprintf('adding nothing to: %i %i; color: %i\n',ceil(positions(i)/width),mod(positions(i),width),image(ceil(positions(i)/width),mod(positions(i),width),1));
            end
        
    end
    imwrite(image,output_name,format)