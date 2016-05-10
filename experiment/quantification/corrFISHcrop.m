function [crop,flag,rect] = corrFISHcrop(series,pixelsize)

[ZeroChanRow, ZeroChanCol] = find(ismember(series(:,:,1),max(max(series(:,:,1)))));
w = 2*pixelsize;  % can be 1 or 2

% Number of oiubts to fit
pfitp = floor(w/pixelsize*4);
pfitp = pfitp(1);

if ((pfitp*2) > size(series,1))
    pfitp = (size(series,1)/2-1);
end
if ((pfitp*2) > size(series,2))
    pfitp = (size(series,2)/2-1);
end

rect = [ZeroChanCol-pfitp ZeroChanRow-pfitp 2*pfitp 2*pfitp];  
if length(rect)==2
    errordlg('length(rect) should be 4')
end
rect = ceil(rect);

crop = zeros(rect(4)+1,rect(3)+1,size(series,3)); % Pre-allocates matrix

for i=1:size(series,3)

%%% fix for the identified peak at the edges
if rect(1)<=0 || rect(2)<=0 || (rect(2)+rect(4))>size(series,1) || (rect(1)+rect(3))>size(series,2) 
    flag=1;
   
else
    
    crop(:,:,i) = imcrop(series(:,:,i),rect);
    flag=0;
end
end