%It displays the result of chromosome classification
function Display(Chromosoms,ChromosomsOr,Lengths)
row=5;
col=14;
count=0;
for i=1:size(Chromosoms,2)
    count=count+1;
    
    if mod(count,col)~=0 && mod(mod(count,col),3)==0
        count=count+1;
    end
    subplot(row,col,count)  
    if mod(abs(ChromosomsOr{i}),90)<80
        if ChromosomsOr{i}<0
            
             subimage(imrotate( Chromosoms{i}, -90+mod( abs(ChromosomsOr{i}),90 ) ) );
             axis off;
        else
            
            subimage(imrotate( Chromosoms{i}, 90-mod( abs(ChromosomsOr{i}),90 ) ) );
            axis off;
        end
        
    else
       subimage(Chromosoms{i} ); 
       axis off;
       
    end
     title(Lengths(i))

end