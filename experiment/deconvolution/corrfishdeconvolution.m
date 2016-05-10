function [Image1proc,Image2proc]=corrfishdeconvolution(Image1subt,Image2subt,psffiledir)

niteration=6;
Image1proc=deconvhybimg(Image1subt,niteration,psffiledir);
Image2proc=deconvhybimg(Image2subt,niteration,psffiledir);
end