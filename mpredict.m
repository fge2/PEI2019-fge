function varargout=mpredict(float_name,f,points,order,next)
% [nextlat,nextlon]=mpredict(float_name,f,points,order,next)
%
% Predicts and plots future mermaid location
%
% INPUT:
%
% float_name  The name of the mermaid float
% f           The figure handle of positionplt
% points      The number of previous points to perform regression on
% order       The order of regression
% next        The time in seconds after the final point which is to be 
%             predicted
%
% OUTPUT:
%
% nextlat     The latitude prediction a week later
% nextlon     The longitude prediction a week later
%
% Last modified by fge@princeton.edu on 6/26/19

defval('float_name','P017')
defval('points',6);
defval('order',2);
defval('next',604800);
[name,t,lat,lon]=mread(float_name);

input=1;
switch input
    case 0
        nextlat=lat(end);
        nextlon=lon(end);
        figure(f)
        geoshow(nextlat,nextlon,'DisplayType','Point','Marker','o',...
        'MarkerFaceColor','b','MarkerEdgeColor','b''Markersize',5)
        
    case 1
        [mag,theta]=vplt(float_name,0);
        [dive,~]=indexsplit(t);
        
        % setting x and y for regression
        start=length(dive)-points+1;
        mset=mag(dive(start:end));
        tset=theta(dive(start:end));
        ellapsed_time=date2sec(t);
        dive_time=ellapsed_time(dive);
        timeframe=zeros(1,points);
        for i=2:points
            timeframe(i)=timeframe(i-1)+dive_time(start+i-1);
        end
        
        % predicting new latitude and longitude
        [mcurve,S1,mu1] = polyfit(timeframe,mset,order);
        [tcurve,S2,mu2] = polyfit(timeframe,tset,order);
        mpredict = polyval(mcurve,dive_time(end)+next,S1,mu1);
        tpredict = polyval(tcurve,dive_time(end)+next,S2,mu2);
        latpredict = mpredict * sin(tpredict);
        lonpredict = mpredict * cos(tpredict);
        latdist = latpredict * next;
        londist = lonpredict * next;
        changelat = distdim(latdist,'m','deg','earth');
        changelon = distdim(londist,'m','deg','earth');
        nextlat = changelat + lat(end);
        nextlon = changelon + lon(end);
        
        % plotting prediction
        figure(f)
        hold on
        geoshow(nextlat,nextlon,'DisplayType','Point','Marker','o',...
        'MarkerFaceColor','b','MarkerEdgeColor','b','Markersize',5,...
        'DisplayName','Prediction')
        trajectory = quiverm(lat(end),lon(end),changelat,changelon,'c');
        trajectory(1).HandleVisibility = 'off';
        trajectory(2).HandleVisibility = 'off'; 
end

% Optional output
varns={nextlat,nextlon};
varargout=varns(1:nargout);
