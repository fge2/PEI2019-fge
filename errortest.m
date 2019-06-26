function varargout=errortest(float_name,points,order)
% [res,mu,sd,rr,errormag]=errortest(float_name,points,order)
%
% Plots histogram of errors resulting from mpredict2
%
% INPUT:
%
% float_name  The name of the mermaid float
% points      The number of previous points to perform regression on
% order       The order of regression
%
% OUTPUT:
%
% res         The vector of residues for the prediction
% mu          The mean of the error
% sd          The standard deviation of the error
% rr          The r squared values
% errormag    The magnitude of errors for predictions
%
% Last modified by fge@princeton.edu on 6/26/19

defval('float_name','P017');
defval('points',4);
defval('order',2);

[name,t,lat,lon]=mread(float_name);
[dive,~]=indexsplit(t);
n=length(dive);
latguess=zeros(1,n-1);
longuess=zeros(1,n-1);
res=zeros(1,n-1);
late=zeros(1,n-1);
lone=zeros(1,n-1);

% calculate residue/error
for i=points:n-1
    [nextlat,nextlon,laterror,lonerror]=mpredict2(float_name,i,points,order);
    res(i)=distance(nextlat,nextlon,lat(dive(i+1)),lon(dive(i+1)));
    if lat(dive(i+1))<nextlat
        res(i)=-res(i);
    end
    latguess(i)=nextlat;
    longuess(i)=nextlon;
    late(i)=laterror;
    lone(i)=lonerror;
end

res=res(points+1:end);
figure
subplot(2,1,1)
hist(res,20);
title(strcat('Histogram of Residues for',{' '},num2str(points),...
' Points @ Order',{' '},num2str(order)));
xlabel('Magnitude (Degrees)');
ylabel('Frequency');
subplot(2,1,2)
histogram(abs(res),20,'Normalization','cdf')

% statistics
mu=mean(res);
sd=std(res);

% r^2 calculation
latguess=latguess(points+1:end);
longuess=longuess(points+1:end);
latm=mean(lat(dive(points:end)));
lonm=mean(lon(dive(points:end)));
latsst=sum((latguess-latm).^2);
lonsst=sum((longuess-lonm).^2);
sst=(latsst+lonsst)/2;
sse=sum(res.^2);
rr=1-(sse/sst);

% error
late=abs(late(points+1:end));
lone=abs(lone(points+1:end));
errormag=sqrt(late.*lone);
figure
hist(errormag,20);
title(strcat('Histogram of Prediction Errors for',{' '},num2str(points),...
' Points @ Order',{' '},num2str(order)));
xlabel('Magnitude (Degrees)');
ylabel('Frequency');

% Optional output
varns={res,mu,sd,rr,errormag};
varargout=varns(1:nargout);
