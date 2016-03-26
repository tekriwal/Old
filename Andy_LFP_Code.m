%WY is Patient 10 as of 3/15/16 - Ilknur and I are using the same excel
%file now, dimensions {[32008747x32 double' char(10) ']}

% load('Patient_10_Sleep_LFP.mat')

%%

data1 = data(1).data;
data_v2 = ones(31858747,32);

if data1(1:15386874,:) ;
    data_v2(1:15386874,:) = data1(1:15386874,:);
end

if data1(15536875:31858747,:);
    data_v2(15386875:31858747,:) = data1(15536876:31858747,:);
       
end
 

size_data1 = size(data(1).data);
size_v2 = size(data_v2); % 31858747


%%

data(1).data_total = [data_v2 ; data(2).data]; 

size_data2 = size(data(2).data); % 1043987
size_total = size(data_v2); % 32902734

%%

%contact 0 is most ventral
lfp(:,1)=data_v2(:,23)-data_v2(:,24); 
lfp(:,2)=data_v2(:,24)-data_v2(:,25);
lfp(:,3)=data_v2(:,25)-data_v2(:,26);

%remove amplifier overload section in sleep stage score section 45
%(13926872:16752505,:); visualually identified region to cut out as
%(15386875:15536875,:); then altered Pat10_Matlab_Events to account for 150k
%sample deletion

emg(:,1)=data_v2(:,2)-data_v2(:,13); % bicep
emg(:,2)=data_v2(:,1)-data_v2(:,12); % FDC

%%
[b,a] = butter(2,1/512,'high');
lfp=filter(b,a,lfp);

[b,a] = butter(2,40/512,'high');
emg=filter(b,a,emg);
emg=emg/100;

%Notch for 60 Hz

Fs = 1024;
%tubs = number of bins
tubs = 500;
%f1 and f2 are stop bands, normalized to nyphist freq, so nyquist is equal
%to 1, Nyphist = 512, so normalized 60 Hz is 60/512 = 0.117

f1 = 0.115;
f2 = 0.119;
notch = fir1(tubs,[f1 f2], 'stop');

%%
tic
lfp2 = filter(notch, 1, lfp);
toc

%%
figure(1);
plot(lfp(:));

figure(2);
plot(lfp2(:,1));

figure(3);
pwelch(lfp(:,1));

figure(4);
pwelch(lfp2(:,1));

%for below you need to import the excel file into matlab so it can read it
%as a variable, not as a file, import as numeric matrix

%%
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

