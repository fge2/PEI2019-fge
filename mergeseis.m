function varargout=mergeseis(YYYY,MM,DD,indexno)
%

finalseis=zeros(360000*24,1);
%prefix=strcat('/home/fge/seismometer/',YYYY,'/',MM,'/',DD,'/');
prefix=strcat('/home/fge/seismometer/all',YYYY,'/');
for i=0:23
    filename=strcat(prefix,'PP.S0001.00.HHX.D.',YYYY,'.',num2str(indexno),'.',sprintf('%02d',i),'0000.SAC');
    if exist(filename,'file')==0
        seis=NaN(360000,1);
    else
        seis=readsac(filename);
    end
    if length(seis)~=360000
        temp=seis;
        seis=NaN(360000,1);
        seis(1:length(temp))=temp;
    end
    finalseis(i*360000+1:(i+1)*360000)=seis;
end

plot=0;
if plot
    startdate=datetime(strcat(MM,'/',DD,'/',YYYY),'InputFormat','MM/dd/yyyy');
    t=seconds(0:(length(finalseis)-1))/100 + startdate;
    plot(t,detrend(finalseis));
    xlim([t(1) t(end)])
    title(strcat('Guyot Seismogram',{' '},MM,'/',DD,'/',YYYY))
    xlabel('Hour')
end 

% Optional output
varns={finalseis};
varargout=varns(1:nargout);