function plotresults(Image1,Imagebckraw,Image1subt,Image1proc,Image2proc,corrimgraw,objectcounts36z)

figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,3,1);imshow(Image1,[0,30000]);colormap(copper);hold on;
title('Raw Hyb1 Image');
subplot(2,3,2);imshow(Imagebckraw,[0,30000]);colormap(copper);hold on;
title('Background Image');
subplot(2,3,3);imshow(Image1subt,[0,30000]);colormap(copper);hold on;
title('Bck Subtracted Hyb1 Image');
subplot(2,3,4);imshow(Image1proc,[0,30000]);colormap(copper);hold on;
title('Deconvolved Hyb1 Image');
subplot(2,3,5);imshow(Image2proc,[0,30000]);colormap(copper);hold on;
title('Deconvolved Hyb2 Image');
subplot(2,3,6);imshow(corrimgraw,[0,0.2]);colormap(copper);hold on;
title('Cross-correlation Result');hold on;text(7,3,num2str(int16(objectcounts36z),'%d'),'Color',[1 1 1],'FontSize',25);


end