function [G] = crosscor(img1,img2)

G = zeros(size(img1)); 

img1 = double(img1);
img2 = double(img2);

for z = 1:size(img1,3)
G(:,:,z) = ((fftshift(real(ifft2(fft2(img1(:,:,z)).*conj(fft2(img2(:,:,z)))))))/...
    (mean(mean(img1(:,:,z)))*size(img1,1)*mean(mean(img2(:,:,z)))*size(img2,2))) - 1;

end


