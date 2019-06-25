function varargout=mpredict2(t,lat,lon,finish,points,order)
% [nextlat,nextlon]=mpredict(t,lat,lon,finish,points,order)
%
% Predicts mermaid location after a given finish index
%
% INPUT:
%
% t           The datetime vector
% lat         The latitude vector
% lon         The longitude vector
% points      The number of previous points to perform regression on
% order       The order of regression
% next        The time in seconds after the final point which is to be 
%             predicted
% plotornot   1 makes plots (default)
%             0 does not%
%
% OUTPUT:
%
% nextlat     The latitude prediction 
% nextlon     The longitude prediction
%
% Last modified by fge@princeton.edu on 6/25/19

[mag,theta]=vplt([],t,lat,lon,0);
[dive,~]=indexsplit(t);

% setting x and y for regression
start=finish-points+1;
mset=mag(dive(start:finish));
tset=theta(dive(start:finish));
ellapsed_time=date2sec(t);
dive_time=ellapsed_time(dive);
timeframe=zeros(1,points);
for i=2:points
    timeframe(i)=timeframe(i-1)+dive_time(start+i-1);
end

% predicting new latitude and longitude
[mcurve,S1,mu1] = polyfit(timeframe,mset,order);
[tcurve,S2,mu2] = polyfit(timeframe,tset,order);
next=dive_time(finish+1);
mpredict = polyval(mcurve,dive_time(end)+next,S1,mu1);
tpredict = polyval(tcurve,dive_time(end)+next,S2,mu2);
latpredict = mpredict * sin(tpredict);
lonpredict = mpredict * cos(tpredict);
latdist = latpredict * next;
londist = lonpredict * next;
changelat = distdim(latdist,'m','deg','earth');
changelon = distdim(londist,'m','deg','earth');
nextlat = changelat + lat(dive(finish));
nextlon = changelon + lon(dive(finish));

% Optional output
varns={nextlat,nextlon};
varargout=varns(1:nargout);


