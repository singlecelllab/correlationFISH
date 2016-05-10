function newimagecorr=corrfishsubcellcountculture(img1,img2,mmm,nnn)

%partition cell into subregions
[m,n] = size(img1);
nblockcolumn = mmm;
nblockrow = nnn;
dcol = fix(n/nblockcolumn);
drow = fix(m/nblockrow);
 
indices = reshape(1:nblockrow* nblockcolumn,nblockcolumn,nblockrow);
imagesc(indices), colorbar
newimagecorr=zeros(nblockcolumn,nblockrow);
newimageint=zeros(nblockcolumn,nblockrow);

%spatially register images
fileshiftresults=shiftcorrect(img1, img2);
 xshift=fileshiftresults(1);
 yshift=fileshiftresults(2);
 
img2= circshift(img2,[xshift,-yshift]);

for index = 1:nblockrow* nblockcolumn
    
[r,c] = ind2sub([nblockrow,nblockcolumn],index );
 
subimage = img1((r-1)*drow+1:r*drow, (c-1)*dcol+1:c*dcol,:);
subimage2 = img2((r-1)*drow+1:r*drow, (c-1)*dcol+1:c*dcol,:);

%find the FISH signal threshold compared to background
if mean(mean(subimage))>5000%was1000
objectcounts=corrfishcountquantification(subimage,subimage2);
else
objectcounts=0;
end

subplot(nblockrow,nblockcolumn,index)

newimagecorr(r,c)=objectcounts;


close all;


end

clear objectcounts;

end

