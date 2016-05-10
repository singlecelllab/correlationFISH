
clear all;clc;close all;

ImstackHyb1=loadtiff('TestCultureCellHyb1Cell1.tif');
ImstackHyb2=loadtiff('TestCultureCellHyb2Cell1.tif');
zplanerange=4; 

[objectcountsresult,BiImstackhyb1a647,BiImstackhyb2a647,newtissueimage]=corrbyplanefishanalyze(ImstackHyb1,ImstackHyb2,zplanerange);%Rps2


plotresults(objectcountsresult,BiImstackhyb1a647,BiImstackhyb2a647,newtissueimage)
