function varargout=llpredict(mset,tset,timeframe,next,order)
% [changelat,changelon,nextm,nextt]=llpredict(mset,tset,timeframe,next,order)
%
% Predicts mermaids change in position and velocity using polyfit on 
% magnitude and velocity vectors
%
% INPUT:
%
% mset        The magnitude vector for regression
% tset        The theta vector for regression
% timeframe   The time vector for regression
% next        The time after you would like to predict
% order       The order of regression
%
% OUTPUT:
%
% changelat   The delta latitude prediction 
% changelon   The delta longitude prediction
% nextm       The magnitude prediction 
% nextt       The angle prediction
%
% Last modified by fge@princeton.edu on 6/27/19

% predicting new latitude and longitude
[mcurve,S1,mu1]=polyfit(timeframe,mset,order);
[tcurve,S2,mu2]=polyfit(timeframe,tset,order);
nextm=polyval(mcurve,timeframe(end)+next,S1,mu1);
nextt=polyval(tcurve,timeframe(end)+next,S2,mu2);
latpredict=nextm * sin(nextt);
lonpredict=nextm * cos(nextt);
latdist=latpredict * next;
londist=lonpredict * next;
changelat=distdim(latdist,'m','deg','earth');
changelon=distdim(londist,'m','deg','earth');
%nextlat=changelat + lat(dive(finish));
%nextlon=changelon + lon(dive(finish));

% Optional output
varns={changelat,changelon,nextm,nextt};
varargout=varns(1:nargout);

