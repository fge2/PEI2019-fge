function varargout=mpredict2(float_name,finish,points,order,surfaces)
% [nextlat,nextlon]=mpredict2(float_name,finish,points,order,surfaces)
%
% Predicts mermaid location after a given finish index
% Used for backchecking predictions
%
% INPUT:
%
% float_name  The name of the mermaid float
% finish      The index which you want to predict afterwards
%             Upper limit is the 'length of the dive vector-surfaces' 
%             given from indexsplit()
% points      The number of previous points to perform regression on
% order       The order of regression
% surfaces    The prediction that number of surfaces later
%             ex. surfaces=2 predicts 2 surfaces later
%
% OUTPUT:
%
% nextlat     The latitude prediction 
% nextlon     The longitude prediction
% 
% Last modified by fge@princeton.edu on 6/27/19

defval('float_name','P017');
defval('points',4);
defval('order',2);
defval('surfaces',1);
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
next=sum(dive_time(finish+1:finish+surfaces));
[changelat,changelon,nextm,nextt]=llpredict(mset,tset,timeframe,...
    next,order);
nextlat=changelat + lat(dive(finish));
nextlon=changelon + lon(dive(finish));

% Optional output
varns={nextlat,nextlon};
varargout=varns(1:nargout);


