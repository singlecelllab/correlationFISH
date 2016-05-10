
clear all;clc;close all;

%This code was prepared for corrFISH analysis of multiplex labeled
%molecules in single cells (03/19/2016)

%Load sequential hybridization images

Image1=loadtiff('TestSimulHyb1.tif');
Image2=loadtiff('TestSimulHyb2.tif');

%Final images of both hybridization images are quantified by corrFISH
[G11objects,G22objects,G12objects,corrimgraw]=corrfishcountquantification(Image1,Image2);


%Results are plotted in a final figure with RNA A counts and images
plotresults(Image1,Image2,corrimgraw,G11objects,G22objects,G12objects);





