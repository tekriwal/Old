%WY is Patient 10 as of 3/15/16 - Ilknur and I are using the same excel
%file now, dimensions {[32008747x32 double' char(10) ']}

load('Patient_10_Sleep_LFP.mat')
size1 = size(data(1).data)
data(1).data((15386875:15536875),:) = [];
size2 = size(data(1).data)

%%
%assign LFP channel data to one variable, 
lfp(:,1)=data(1).data(:,23)-data(1).data(:,24); 
lfp(:,2)=data(1).data(:,24)-data(1).data(:,25);
lfp(:,3)=data(1).data(:,25)-data(1).data(:,26);

%remove amplifier overload section in sleep stage score section 45
%(13926872:16752505,:); visualually identified region to cut out as
%(15386875:15536875,:); then altered Pat10_Matlab_Events to account for 150k
%sample deletion


%assign EMGs
emg(:,1)=data(1).data(:,2)-data(1).data(:,13); % bicep
emg(:,2)=data(1).data(:,1)-data(1).data(:,12); % FDC

%%
[b,a] = butter(2,1/512,'high');
lfp=filter(b,a,lfp);

[b,a] = butter(2,40/512,'high');
emg=filter(b,a,emg);
emg=emg/100;

%for below you need to import the excel file into matlab so it can read it
%as a variable, not as a file, import as numeric matrix

annot=round(Pat10MatlabEvents);
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
    
    %changed hanning to hamming above
    
    ttl=sprintf('%d-%d, State:%d', annot(s,1)+1, annot(s,2)+1, annot(s,3));
    title(ttl);
    figure(2);
    clf;
    plot(f,Pxx);
    legend('LFP01','LFP12','LFP23');
    xlim([0 120]);
    pause(2.5);
    
    hmap(:,s)= Pxx(:,1);
    
end

