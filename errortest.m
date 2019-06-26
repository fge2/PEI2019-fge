function varargout=errortest(float_name,points,order)
% [error,mu,sd,sse]=errortest(float_name,points,order)
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
% error       The vector of errors of the prediction
% mu          The mean of the error
% sd          The standard deviation of the error
% sse         The error sum of squares
%
% Last modified by fge@princeton.edu on 6/26/19

defval('float_name','P017');
defval('points',7);
defval('order',2);

[name,t,lat,lon]=mread(float_name);
[dive,~]=indexsplit(t);
n=length(dive);
error=zeros(1,n-1);

% calculate error
for i=points:n-1
    [nextlat,nextlon]=mpredict2(float_name,i,points,order);
    error(i)=distance(nextlat,nextlon,lat(dive(i+1)),lon(dive(i+1)));
    if lat(dive(i+1))<nextlat
        error(i)=-error(i);
    end
end

error=error(points+1:end);
figure
hist(error,20);
title(strcat('Histogram of Error for',{' '},num2str(points),...
' Points @ Order',{' '},num2str(order)));
xlabel('Magnitude of Error');
ylabel('Frequency');

mu=mean(error);
sd=std(error);
sse=sum(error.^2);

% Optional output
varns={error,mu,sd,sse};
varargout=varns(1:nargout);
