function varargout=mpredict2(float_name,finish,points,order)
% [nextlat,nextlon]=mpredict2(float_name,finish,points,order)
%
% Predicts mermaid location after a given finish index
%
% INPUT:
%
% float_name  The name of the mermaid float
% finish      The index which you want to predict afterwards
%             Upper limit is the 'length of the dive vector-1' given from
%             indexsplit()
% points      The number of previous points to perform regression on
% order       The order of regression
%
% OUTPUT:
%
% nextlat     The latitude prediction 
% nextlon     The longitude prediction
%
% Last modified by fge@princeton.edu on 6/26/19

defval('float_name','P017');
defval('points',4);
defval('order',2);
[name,t,lat,lon]=mread(float_name);
[mag,theta]=vplt(float_name,0);
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
[mcurve,S1,mu1]=polyfit(timeframe,mset,order);
[tcurve,S2,mu2]=polyfit(timeframe,tset,order);
next=dive_time(finish+1);
mpredict=polyval(mcurve,dive_time(end)+next,S1,mu1);
tpredict=polyval(tcurve,dive_time(end)+next,S2,mu2);
latpredict=mpredict * sin(tpredict);
lonpredict=mpredict * cos(tpredict);
latdist=latpredict * next;
londist=lonpredict * next;
changelat=distdim(latdist,'m','deg','earth');
changelon=distdim(londist,'m','deg','earth');
nextlat=changelat + lat(dive(finish));
nextlon=changelon + lon(dive(finish));

% Optional output
varns={nextlat,nextlon};
varargout=varns(1:nargout);


