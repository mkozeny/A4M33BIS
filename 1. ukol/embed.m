function  embed(image_name,message,key,output_name)
    info = imfinfo(image_name);
    format = info.Format;
    dict = java.util.Hashtable;
    image = imread(image_name,format);
    parameters = size(image);
    rand('seed',key);
    %fprintf('mesage length: %i\n',length(message));
    height = randi(parameters(1),1,length(message)+16);
    fprintf('---HEIGHT: %i---\n',parameters(1));
    rand('seed',key+4);
    width = randi(parameters(2),1,length(message)+16);
    fprintf('---WIDTH: %i---\n',parameters(2));
    message_length_binary_array = length(message);
    fprintf('---LENGTH ENCODING: %i---\n',message_length_binary_array);
    for j=1:16,
        if isempty(dict.get([num2str(height(j)) ' ' num2str(width(j))]))
            fprintf('put occurence 0 to: %i %i; color: %i\n',height(j),width(j),image(height(j),width(j),1));
            dict.put([num2str(height(j)) ' ' num2str(width(j))],0);
        else
            fprintf('put occurence %i to: %i %i; color: %i\n',dict.get([num2str(height(j)) ' ' num2str(width(j))])+1,height(j),width(j),image(height(j),width(j),1));
            dict.put([num2str(height(j)) ' ' num2str(width(j))],dict.get([num2str(height(j)) ' ' num2str(width(j))])+1);
        end
        fprintf('---POSITION: %i, BIT VALUE: %i---\n',j,bitget(message_length_binary_array,j));
        if (bitget(message_length_binary_array,j)==1 & mod(image(height(j),width(j),1),2)==0) | (bitget(message_length_binary_array,j)==0 & mod(image(height(j),width(j),1),2)==1)
            if image(height(j),width(j),1)~= 0 & image(height(j),width(j),1)~= 255
                flipcoin = randperm(2);
                if flipcoin(1)==1
                    fprintf('adding +1 to: %i %i; color: %i\n',height(j),width(j),image(height(j),width(j),1));
                    image(height(j),width(j),1) = image(height(j),width(j),1)+2^(dict.get([num2str(height(j)) ' ' num2str(width(j))]));
                elseif flipcoin(1)==2
                    fprintf('adding -1 to: %i %i; color: %i\n',height(j),width(j),image(height(j),width(j),1));
                    image(height(j),width(j),1) = image(height(j),width(j),1)-2^(dict.get([num2str(height(j)) ' ' num2str(width(j))]));
                end
            elseif image(height(j),width(j),1)<= 0+2^(dict.get([num2str(height(j)) ' ' num2str(width(j))]))
                fprintf('adding +1 to: %i %i; color: %i\n',height(j),width(j),image(height(j),width(j),1));
                image(height(j),width(j),1) = image(height(j),width(j),1)+2^(dict.get([num2str(height(j)) ' ' num2str(width(j))]));
            elseif image(height(j),width(j),1)>= 255-2^(dict.get([num2str(height(j)) ' ' num2str(width(j))]))
                fprintf('adding -1 to: %i %i; color: %i\n',height(j),width(j),image(height(j),width(j),1));
                image(height(j),width(j),1) = image(height(j),width(j),1)-2^(dict.get([num2str(height(j)) ' ' num2str(width(j))]));
            end
        else
            fprintf('adding nothing to: %i %i; color: %i\n',height(j),width(j),image(height(j),width(j),1));
        end
    end
    fprintf('\n---MESSAGE ENCODING: %i---\n',length(height)-16);
    for i=17:length(height),
        if isempty(dict.get([num2str(height(i)) ' ' num2str(width(i))]))
            fprintf('put occurence 0 to: %i %i; color: %i\n',height(i),width(i),image(height(i),width(i),1));
            dict.put([num2str(height(i)) ' ' num2str(width(i))],0);
        else
            fprintf('put occurence %i to: %i %i; color: %i\n',dict.get([num2str(height(i)) ' ' num2str(width(i))])+1,height(i),width(i),image(height(i),width(i),1));
            dict.put([num2str(height(i)) ' ' num2str(width(i))],dict.get([num2str(height(i)) ' ' num2str(width(i))])+1);
        end
            fprintf('---POSITION: %i, BIT VALUE: %i---\n',i,message(i-16));
            if (message(i-16)==1 & mod(image(height(i),width(i),1),2)==0) | (message(i-16)==0 & mod(image(height(i),width(i),1),2)==1)
                if image(height(i),width(i),1)~= 0 & image(height(i),width(i),1)~= 255
                    flipcoin = randperm(2);
                    if flipcoin(1)==1
                        fprintf('adding +1 to: %i %i; color: %i\n',height(i),width(i),image(height(i),width(i),1));
                        image(height(i),width(i),1) = image(height(i),width(i),1)+2^(dict.get([num2str(height(i)) ' ' num2str(width(i))]));
                    elseif flipcoin(1)==2
                        fprintf('adding -1 to: %i %i; color: %i\n',height(i),width(i),image(height(i),width(i),1));
                        image(height(i),width(i),1) = image(height(i),width(i),1)-2^(dict.get([num2str(height(i)) ' ' num2str(width(i))]));
                    end
                elseif image(height(i),width(i),1)<= 0+2^(dict.get([num2str(height(i)) ' ' num2str(width(i))]))
                    image(height(i),width(i),1) = image(height(i),width(i),1)+2^(dict.get([num2str(height(i)) ' ' num2str(width(i))]));
                elseif image(height(i),width(i),1)>= 255-2^(dict.get([num2str(height(i)) ' ' num2str(width(i))]))
                    image(height(i),width(i),1) = image(height(i),width(i),1)-2^(dict.get([num2str(height(i)) ' ' num2str(width(i))]));
                end
            else
                fprintf('adding nothing to: %i %i; color: %i\n',height(i),width(i),image(height(i),width(i),1));
            end
        
    end
    imwrite(image,output_name,format);