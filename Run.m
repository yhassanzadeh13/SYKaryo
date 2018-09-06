function [NumError,ErrorAvg]=Run(fileName)
%=========================================================================
%read the image
Image=imread(fileName);
figure;imshow(Image);
%=========================================================================
%change to gray image
if size(Image,3)==3
    GImage=rgb2gray(Image);
    figure;imshow(GImage);
else
    GImage=Image;
end
%=========================================================================
%increase the contrast
AdaptImg= adapthisteq(GImage);
figure;imshow(AdaptImg);
%=========================================================================
% Create the gaussian filter with hsize = [5 5] and sigma = 2
G = fspecial('gaussian',[5 5],5);
% Filter it
SmoothedImage=medfilt2(AdaptImg, [9 9]);
SmoothedImage = imfilter(SmoothedImage,G,'same');
figure;imshow(SmoothedImage);
%=========================================================================
%apply otsu to change image to a binary image
BinaryImage=TS(SmoothedImage);
Data=BinaryImage<1; %cconvert zeros to ones and viseversa
figure;imshow(Data);
%=========================================================================
%remove meaningless components
Data = bwareaopen(Data,200); %remove connected component having less than 200 pixels
figure;imshow(Data);
%=========================================================================
%=========================================================================
%find the the objects
Regions = regionprops(Data,{'EquivDiameter','Perimeter','Image','Orientation','MajorAxisLength'});
%=========================================================================
[totalComp,~]=size(Regions);
Lengths=zeros(totalComp,1);
extra=0;
for i=2:totalComp
    Chromosome=Regions(i).Image;
    Stroke=bwmorph(Regions(i).Image,'thin',inf);
    [Comp,count]=CS(Chromosome,Stroke);
    if count>1
%         figure;imshow(Chromosome);
%         figure;imshow(Stroke);
        Regions(i).Image=Comp(1).image;
        Lengths(i)=sum(Comp(1).line(:));
%         figure;imshow( Comp(1).line);
        for j=2:count
%             figure;imshow(Comp(j).line);
            extra=extra+1;
            Regions(totalComp+extra).Image=Comp(j).image;
            Lengths(totalComp+extra)=sum(Comp(j).line(:));
        end
    else
        Lengths(i)=sum(Stroke(:));
    end
    
end
%========================================================================
%sort the objects based on e measurement
[Sorted,Ind]=sort(Lengths);
%=========================================================================
%Display the results
Chromosoms={Regions(Ind(2:end)).Image};
ChromosomsOr={Regions(Ind(2:end)).Orientation};
Display(Chromosoms,ChromosomsOr,Sorted(2:end));
%=========================================================================
%evaluation
error=0;
for i=2:2:size(Sorted)-1
    error=error+abs(Sorted(i)-Sorted(i+1));
end
ChromosomeNum=(size(Sorted,1)-1);
Groups=ceil(ChromosomeNum/2);
ErrorAvg=error/Groups;
NumError=46-ChromosomeNum;
end