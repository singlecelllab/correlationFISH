function plotresults(objectcountsresult,BiImstackhyb1a647,BiImstackhyb2a647,newtissueimage)

figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,3,1);imshow(BiImstackhyb1a647(:,:,1),[0 100000]);colormap('copper');axis image;hold on;
title('Hyb1 Optical Section 1 Image');
subplot(2,3,2);imshow(BiImstackhyb2a647(:,:,1),[0 100000]);colormap('copper');axis image;
title('Hyb2 Optical Section 1 Image');
subplot(2,3,3);imshow(newtissueimage(:,:,1),[0 100]);colormap('copper');axis image;hold on;
title('Section 1 corrFISH Image of Rps2 Gene');
hold on;text(10,3,num2str(int16(sum(sum(newtissueimage(:,:,1)))),'%d'),'Color',[1 1 1],'FontSize',20);
subplot(2,3,4);imshow(BiImstackhyb1a647(:,:,3),[0 100000]);colormap('copper');axis image;
title('Hyb1 Optical Section 3 Image');
subplot(2,3,5);imshow(BiImstackhyb2a647(:,:,3),[0 100000]);colormap('copper');axis image;
title('Hyb2 Optical Section 3 Image');
subplot(2,3,6);imshow(newtissueimage(:,:,3),[0 70]);axis image;colormap('copper');hold on;
hold on;
title('Section 3 corrFISH Image of Rps2 Gene');
text(10,3,num2str(int16(sum(sum(newtissueimage(:,:,3)))),'%d'),'Color',[1 1 1],'FontSize',20);



end
