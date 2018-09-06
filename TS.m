%Applies Otsu gray level thresholding to detach the chromosomes from
%background, receives a gray level image as input outputs a binary image where
%chromosomes' pixels are One and background is zero. 
function [outputImage] = TS(inputImage)

    %SmoothImage = imgaussfilt(inputImage);
    %figure;imshow(SmoothImage);

    %Finds Otsu's threshold
    level = graythresh(inputImage);
    
    %Converts gray level input image to a binary image
    BW = im2bw(inputImage,level);
    
    %Showing the thresholded input image
    %imshow(BW);
    
    %Setting return value
    outputImage = BW; 
end