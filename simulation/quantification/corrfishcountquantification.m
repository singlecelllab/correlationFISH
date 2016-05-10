function [G11objects,G22objects,G12objects,C]=corrfishcountquantification(img1,img2)

img1=double(img1);
img2=double(img2);

pixelsize=0.13;  
whitenoise='y';  %for simulation 'n', for experiments should be 'y'
type='2d';       %the fitting type 

sizeimgx=size(img1);
sizex=sizeimgx(1);
sizey=sizeimgx(2);

%perform autocorrelations and cross correlatio

A = corrFISHcrop(crosscor(img1,img1),pixelsize);   % autocorrelation
B = corrFISHcrop(crosscor(img2,img2),pixelsize);   % autocorrelation
try
     C = corrFISHcrop(crosscor(img1,img2),pixelsize);   % crosscorrelation
catch
    C=crosscor(img1,img2);
end

%Perform gaussian fitting in 2d for the cropped autocorr and crosscorr
%images
Auto1fit = gaussfit(A,type,pixelsize,whitenoise);     % fit gaussian to the regression plot
Auto2fit = gaussfit(B,type,pixelsize,whitenoise);
cross_fit = gaussfit(C,type,pixelsize,whitenoise);

% In iterate fit to better approximate peak
        diff = 1; it = 1; val(1:2) = 0;
        index = ismember(A(:,:,:),max(max(A(:,:,:))));
        while diff > 0.0001 && it < 10
            A(index) = Auto1fit(1) + Auto1fit(4);
            Auto1fit = gaussfit(A,type,pixelsize,'n');
            val(it) = Auto1fit(1);
            if it>1
                diff = val(it)- val (it-1);
            end
            it = it+1;
        end
        if it == 10
            disp('Perhaps non-optimum fit!')
        end
        diff = 1; it = 1; clear val, val(1:2) = 0;
        index = ismember(B(:,:,:),max(max(B(:,:,:))));
        while diff > 0.0001 && it < 10
            B(index) = Auto2fit(1) + Auto2fit(4);
            Auto2fit = gaussfit(B,type,pixelsize,'n');
            val(it) = Auto2fit(1);
            if it>1
                diff = val(it)- val (it-1);
            end
            it = it+1;
        end
        if it == 10
            disp('Perhaps non-optimum fit!')
        end
        diff = 1; it = 1; clear val, val(1:2) = 0;
        index = ismember(C(:,:,:),max(max(C(:,:,:))));
        while diff > 0.0001 && it < 10
            C(index) = cross_fit(1) + cross_fit(4);
            cross_fit = gaussfit(C,type,pixelsize,'n');
            val(it) = cross_fit(1);
            if it>1
                diff = val(it)- val (it-1);
            end
            it = it+1;
        end
        if it == 10
            disp('Perhaps non-optimum fit!')
        end

plotgaussfit(cross_fit(1,1:6),C(:,:,1),pixelsize,whitenoise); title('Cross-correlation (G12)');

%i-)computed the transcriptsperPSFarea
%ii-)computed the PSF area from the width of guassian fits 
%iii-)computed the density[1/um2]=transcriptsperPSFarea/PSFarea
%iv-)computed the totalnumberoftranscripts=totalarea[um2]*density[1/um2]

%note that beam width can also be replaced by PSFwidth

G11=mean(Auto1fit(:,1));
transciptsPerBeamArea1 = 1/G11;
PSFArea1 = pi*mean(Auto1fit(:,2))*mean(Auto1fit(:,3));
density1 = transciptsPerBeamArea1/PSFArea1;
G11objects=(sizex*sizey*(pixelsize)^2)*density1;

G22=mean(Auto2fit(:,1));
transciptsPerBeamArea1 = 1/G22;
PSFArea2 = pi*mean(Auto2fit(:,2))*mean(Auto2fit(:,3));
density2 = transciptsPerBeamArea1/PSFArea2;
G22objects=(sizex*sizey*(pixelsize)^2)*density2;


G12Amplitude= mean(cross_fit(:,1));
transciprtsperPSFarea=(G12Amplitude/(G11*G22));
PSFArea=pi*mean(cross_fit(:,2))*mean(cross_fit(:,3));
transcriptdensity=transciprtsperPSFarea/PSFArea;
G12objects= ((sizex*sizey*(pixelsize)^2)*transcriptdensity);



warning off;

end
