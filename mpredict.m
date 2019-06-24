function varargout=mpredict(name,t,lat,lon,points,order,f,input)
% [nextlat,nextlon]=mpredict(name,t,lat,lon,points,order,f,input)
%
% Predicts future mermaid location
%
% INPUT:
% name        The name of the mermaid
% t           The datetime vector
% lat         The latitude vector
% lon         The longitude vector
% f           The figure handle the position plot
% input       0 returns last point
%             1 uses polyfit to predict next point (default)
%
% OUTPUT:
%
% nextlat     The latitude prediction a week later
% nextlon     The longitude prediction a week later
%
% Last modified by fge@princeton.edu on 6/24/19

defval('input',1);
defval('order',2);
figure(f)

switch input
    case 0
        nextlat=lat(end);
        nextlon=lon(end);
        geoshow(nextlat,nextlon,'DisplayType','Point','Marker','o',...
        'MarkerFaceColor','b','Markersize',5)
        
    case 1
        [mag,theta]=vplt(name,t,lat,lon,0);
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
        week_in_seconds = 604800;
        mcurve = polyfit(timeframe,mset,order);
        tcurve = polyfit(timeframe,tset,order);
        mpredict = polyval(mcurve,dive_time(end)+week_in_seconds);
        tpredict = polyval(tcurve,dive_time(end)+week_in_seconds);
        latpredict = mpredict * sin(tpredict);
        lonpredict = mpredict * cos(tpredict);
        latdist = latpredict * week_in_seconds;
        londist = lonpredict * week_in_seconds;
        changelat = distdim(latdist,'m','deg','earth');
        changelon = distdim(londist,'m','deg','earth');
        nextlat = changelat + lat(end);
        nextlon = changelon + lon(end);
        
        % plotting prediction
        figure(f);
        hold on
        geoshow(nextlat,nextlon,'DisplayType','Point','Marker','o',...
        'MarkerFaceColor','b','Markersize',7,'DisplayName','Prediction');
        trajectory = quiverm(lat(end),lon(end),changelat,changelon,'c');
        trajectory(1).HandleVisibility = 'off';
        trajectory(2).HandleVisibility = 'off';  
end

% Optional output
varns={nextlat,nextlon};
varargout=varns(1:nargout);
