function plotresults(Image1,Image2,corrimgraw,G11objects,G22objects,G12objects)
summary=[G11objects G22objects G12objects];

figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,2,1);imshow(Image1,[0,3000]);colormap(copper);hold on;
title('Hyb1 Image');
subplot(2,2,2);imshow(Image2,[0,3000]);colormap(copper);hold on;
title('Hyb2 Image');
subplot(2,2,3);imshow(corrimgraw,[0,0.3]);colormap(copper);hold on;
title('Cross-correlation Result');text(7,3,num2str(int16(G12objects),'%d'),'Color',[1 1 1],'FontSize',25);
subplot(2,2,4);
bar(1:3,summary);title('G11 - G22 - G12  (Number of objects)');

end