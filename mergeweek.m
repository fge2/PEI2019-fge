function varargout=mergeweek(year,start,weeks)
% []=mergeweek(start,weeks)

totaltime=zeros();
totalTa=zeros();
for i=1:weeks
[time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=readweek(year,start+((i-1)*7));
totaltime=[totaltime; time];
totalTa=[totalTa; Ta];
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
varns={totaltime,totalTa};
varargout=varns(1:nargout);


