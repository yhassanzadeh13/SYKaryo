%Chromosome separator: This is a high level function which receives the binary image of a 
%set of overlapped chromosomes (W) and skeleton of that binary image (L).
%It returns the number of chromosomes in that binary image as counter and
%more importantly, it separate each chromosome and returns it as the C
%vector, each element of C has two field, image is the binary image of the
%chromosome and line is the skeleton of it. 
function [C counter] = CS(W,L)
    %Extracting the skeleton of the lines
    Rest = L;
    counter = 0;
    while true
        %finding endpoints of lines in cordinates
        Rest = bwmorph(Rest,'skel',inf);

        ep          = bwmorph(Rest, 'endpoints');
        [rows cols] = find(ep);

        bp = bwmorph(Rest,'branchpoints');
        [bprows bpcols] = find(bp);


        [Line Rest] = LT(Rest, rows(1), cols(1));
        
        counter = counter + 1;
        C(counter).image = CE(W,Line);
        C(counter).line  = mat2gray(Line);
        
        for i=1:size(bprows)
            Rest(bprows(i), bpcols(i)) = 1;
        end

        Rest = bwmorph(Rest, 'diag');
        Rest = bwmorph(Rest, 'bridge');
        Rest = bwmorph(Rest, 'clean');

        if(sum(Rest(:)) == 0)
            break;
        end
    end

    

end