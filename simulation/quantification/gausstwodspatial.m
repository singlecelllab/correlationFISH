function F = gausstwodspatial(a,data,weights)

X = data(:,1:size(data,2)/2);
Y = data(:,size(data,2)/2+1:end);

F = (a(1)*exp(    -((X-a(5)).^2/(a(2)^2)+(Y-a(6)).^2/(a(3)^2))   ) + a(4)).*weights;

%Parameters required for curve fitting