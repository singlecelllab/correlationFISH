function deconvresult=deconvhybimg(imgraw,n_itr,file_h)

ps =0.136;     % sensor pixel size (um)%was 2
intp = 1;       % interpolation ratio (for raw image only, PSF should be high-resolution in the first place.)

%read image to be deconvolved
file_img=imgraw;
Img=file_img;
Img = mean(Img,3);       % use the intensity
[Hm Wm] = size(Img);
xm = (0:Wm-1)*ps;
ym = (0:Hm-1)*ps;

% prepare h
h = double(imread(file_h));
border_h = [h(1,1:end-1),(h(1:end-1,end))',h(end,2:end),(h(2:end,1))'];
[n,xout] = hist(border_h,length(border_h));
bkg_h = mean(xout(n==max(n)));
h = h-bkg_h;
h = h./sum(h(:));   % normalize 
h = padarray(h,[intp-1 intp-1],0,'post');    % pad the PSF to make the matrix dimension = intp*N

%perform Lucy Richardson Deconvolution
DampTh = 0.0;     % threshold for damping   
Imgb = interp2(xm,ym,Img,xm(1):ps/intp:xm(end),(ym(1):ps/intp:ym(end))');
J = deconvlucy({Imgb},h,n_itr,DampTh);
deconvresult=J{2};

end





