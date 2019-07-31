function varargout=mergeweek(year,start,weeks)
% [totaltime,totalTa]=mergeweek(year,start,weeks)
%
% This function merges weeks of weather data together

totaltime=[];
totalTa=[];
totalPa=[];
for i=1:weeks
[time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=readweek(year,start+((i-1)*7));
totaltime=[totaltime; time];
totalTa=[totalTa; Ta];
totalPa=[totalPa; Pa];
end

z=find(totaltime==0);
z=flip(z);

for j = z'
    if j > 1
        totaltime(j:end)=totaltime(j:end)+totaltime(j-1);
    end
end
totaltime=totaltime-totaltime(1);

% Optional output
varns={totaltime,totalTa,totalPa};
varargout=varns(1:nargout);


