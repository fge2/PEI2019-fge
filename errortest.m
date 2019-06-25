function varargout=errortest(t,lat,lon,points,order)
% [error,mu,sd,sse]=errortest(t,lat,lon,points,order)
%
% Plots histogram of errors resulting from mpredict2
%
% INPUT:
% t           The datetime vector
% lat         The latitude vector
% lon         The longitude vector
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
% Last modified by fge@princeton.edu on 6/25/19

defval('points',4);
defval('order',2);

[dive,~]=indexsplit(t);
n=length(dive);
error=zeros(1,n-1);

% calculate error
for i=points:n-1
    [nextlat,nextlon]=mpredict2(t,lat,lon,i,points,order);
    error(i)=distance(nextlat,nextlon,lat(dive(i+1)),lon(dive(i+1)));
    % error(i)=distdim(arclen,'deg','m','earth');
end

error=error(points+1:end);
figure
hist(error);
title('Histogram of Errors');
xlabel('Magnitude of Error');
ylabel('Frequency');

mu=mean(error);
sd=std(error);
sse=sum(error.^2);

% Optional output
varns={error,mu,sd,sse};
varargout=varns(1:nargout);
