close all;
for i=1:10
    fileName=strcat(int2str(i),'.jpg');
    [NumError(i),ErrorAvg(i)]=Run(fileName);
    NumError(i)
    ErrorAvg(i)
end

NumError
ErrorAvg