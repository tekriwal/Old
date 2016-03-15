load('Patient_4_Sleep_LFP.mat')

lfp(:,1)=data(1).data(:,23)-data(1).data(:,24);
lfp(:,2)=data(1).data(:,24)-data(1).data(:,25);
lfp(:,3)=data(1).data(:,25)-data(1).data(:,26);

emg(:,1)=data(1).data(:,2)-data(1).data(:,13); % bicep, AT change
emg(:,2)=data(1).data(:,1)-data(1).data(:,12); % FDC

[b,a] = butter(2,1/512,'high');
lfp=filter(b,a,lfp);

[b,a] = butter(2,40/512,'high');
emg=filter(b,a,emg);
emg=emg/100;

annot=round('Pat4_Matlab_Events.xlsx');
S=size(annot,1);
hmap=zeros(513,S);


for s=1:S
    figure(1);
    clf;
    plot(lfp([annot(s,1):annot(s,2)]+1,1));
    hold on;
    plot(lfp([annot(s,1):annot(s,2)]+1,2)-0.02,'k');
    plot(lfp([annot(s,1):annot(s,2)]+1,3)-0.04,'r');
    
    plot(emg([annot(s,1):annot(s,2)]+1,1)-0.08,'g');
    plot(emg([annot(s,1):annot(s,2)]+1,2)-0.12,'g');
    
    for k=1:3
        [Pxx(:,k),f] = pwelch(lfp([annot(s,1):annot(s,2)]+1,k),hanning(1024),512,1024,1024);
    end
    
    ttl=sprintf('%d-%d, State:%d', annot(s,1)+1, annot(s,2)+1, annot(s,3));
    title(ttl);
    figure(2);
    clf;
    plot(f,Pxx);
    legend('LFP01','LFP12','LFP23');
    xlim([0 120]);
    pause;
    
    hmap(:,s)=Pxx(:,1);
    
end