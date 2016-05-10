
clear all;clc;close all;

%This code was prepared for corrFISH analysis of multiplex labeled
%molecules in single cells (03/19/2016)

%Load sequential hybridization images

Image1=loadtiff('TestImageHyb1.tif');
Image2=loadtiff('TestImageHyb2.tif');
Imagebckraw=loadtiff('TestImageBackground.tif');

%make sure to change to your current directory for measured PSF input
currentdirectory=pwd;
psffiledirectory=strcat(pwd,'\','deconvolution\psf.png');

%Cell background is subtracted from each hybridization image
[Image1subt,Image2subt]=corrfishbcksubtraction(Image1,Image2,Imagebckraw);

%Background subtracted images are deconvolved to remove out-of-focus light
[Image1proc,Image2proc]=corrfishdeconvolution(Image1subt,Image2subt,psffiledirectory);

%Final images of both hybridization images are quantified by corrFISH
[objectcounts36z,corrimgraw]=corrfishcountquantification(Image1proc,Image2proc);

%Results are plotted in a final figure with RNA A counts and images
plotresults(Image1,Imagebckraw,Image1subt,Image1proc,Image2proc,corrimgraw,objectcounts36z);





