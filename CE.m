%Chromosome Extractor: This function receives W which is binary image of a set of
%overlapped chromosome and L which is the line description of one of them (skeleton).
%It extracts the chromosome from W and returns that as C. 
function [C] = CE(W,L)

C = repmat(uint8(0),[size(W,1) size(W,2)]);

for i=1:size(W,1)
    for j=1:size(W,2)
        if(W(i,j) == 1)
            if(L(i,j) == 1) 
                C(i,j) = 1;
                continue;
            end
            
            for m=-5:5
                for n=-5:5
                    if(m + i <= 0 || n + j <= 0 || m + i >= size(W,1) || n + j >= size(W,2))
                        continue;
                    end
                    if(L(i+m, j+n) == 1)
                        C(i,j) = 1;
                    end
                end
            end
                
            
        end
    end
end

C = mat2gray(C);
C = im2bw(C);


end