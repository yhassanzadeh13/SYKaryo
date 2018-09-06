%Line Track algorithm
%This function accepts a binary image BI, and coordination of a line's
%endpoint in it as (x,y). It then tracks the line and retrives it from the
%BI. Output is a matrix Line which only has the footprint of the line and
%also the another binary image Rest which is similar to the input (BI)
%except that the extracted line has been omitted from it!
function [Line, Rest] = LT(BI, x, y)

Line = repmat(uint8(0),[size(BI,1) size(BI,2)]);
Rest = BI;

%Adjacency table accumalator
%Ac is a 3*3 binary matrix, it acts as an accumulator. In each moment, Ac
%shows number of pixels that was passed in each direction. In the other
%word, maximum element of Ac corresponds to the direction of line.
Ac = zeros(3,3);

%Ad is the intensity value around each pixel. It acts as a buffer. 
Ad = zeros(3,3);

while true    
    %Finding sum of intensities around a pixel
    for i=-1:1
        for j=-1:1
            if(i == 0 && j == 0)
                Ad(i + 2 ,j + 2) = 0;
            else
                if(x+i>size(BI,1) || x+i<1 || y+j>size(BI,2) || y+j<1)
                    Ad(i + 2 ,j + 2) =0;
                    continue;
                end
                Ad(i + 2 ,j + 2) = BI(x + i,y + j);
            end
        end
    end

    [Mc, Ic] = max(Ac(:));
    [Md, Id] = max(Ad(:));
    Ac(2,2) = 0;
                
    %We are at the first endpoint
    if(Mc == 0)
        %If maximum intensity value around a pixel is zero then that pixel 
        %is a single alone pixel and we can return. 
        if(Md == 0)
            Rest(x,y) = 0;
            break;
        else
            Line(x,y) = 1;
            Rest(x,y) = 0;
            BI(x,y) = 0;
            [i j] = ind2sub([size(Ad,1) size(Ad,2)], Id);
            Ac = AcU(Ac,i,j);
            x = x + i - 2;
            y = y + j - 2;
        end
    %We are not at the first endpoint rather we are at a midpoint    
    else
            [Sc ISc] = sort(Ac(:), 'descend');
            for k=1:9
               [i j] = ind2sub([size(Ad,1) size(Ad,2)], ISc(k)); 
               if(Ad(i,j) ~= 0)
                   break;
               end
            end
            
            if(k == 9 && Ad(i,j) == 0)
                return;
            end

        Line(x,y) = 1;
        Rest(x,y) = 0;
        BI(x,y) = 0;
        Ac = AcU(Ac,i,j);
        x = x + i - 2;
        y = y + j - 2;
    end

    
end



end