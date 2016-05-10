function [a, res] = gaussfit(corr,type,pixelsize,whitenoise)

%Fit Gaussian to obtain peak value and width of correlation result 

[X,Y] = meshgrid(-((size(corr,2)-1)/2)*pixelsize:pixelsize:((size(corr,2)-1)/2)*pixelsize,-((size(corr,1)-1)/2)*pixelsize:pixelsize:(size(corr,1)-1)/2*pixelsize);
grid = [X Y];
   
[Y0, X0] = find(ismember(corr,max(max(corr))),size(corr,3));
X0 = mod(X0,size(corr,2));


EvilX0 = find(ismember(X0,0));
X0(EvilX0) = size(corr,2);

    % Sets curve fit options, and sets lower bounds for amplitude and beam
    % radius to zero
    lb = [0 0 -1 min(min(grid)) min(min(grid))];
    ub = [];
    
    weights = ones(size(corr));
    
 %surpress white noise
if strcmp(whitenoise,'y')
    if strcmp('2d',type)
       for j=1:2
       i = find(ismember(corr(:,:,:),max(max(corr(:,:,:)))));
       ZerChan = i;
       corr(i) = [0];
       weights(i) = 0;
       end
    end
      
end

%make an initial guess for lsq curve fit
y0 = zeros(size(corr,3),1);
g0 = max(max(corr));
g0 = squeeze(g0);
wguess = 0.4*ones(size(g0));
for i=1:size(corr,3)
  X0(i) = X(1,X0(i)); 
end
for i=1:size(corr,3)
  Y0(i) = Y(Y0(i),1);  
end
initguess = [g0 wguess y0 X0 Y0];

%perform lsqfit 
curvefitoptions = optimset('Display','off');
    if strcmp('2d',type)
    for i=1:size(corr,3)
        a0 = initguess(i,:);
        a0xy(1:2) = initguess(i,1:2);
        a0xy(3) = a0xy(2);
        a0xy(4:6) = initguess(i,3:5);
        [a(i,:),res(i),RESIDUAL,EXITFLAG,OUTPUT,LAMBDA] = lsqcurvefit(@gausstwodspatial,a0xy,grid,corr(:,:,i).*weights(:,:,i),lb,ub,curvefitoptions,weights(:,:,i));

    end
    end

    

