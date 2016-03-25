

%load('Patient_10_Sleep_LFP.mat')
size1 = size(data(1).data);
data(1).data((15386875:15536875),:) = [];
size2 = size(data(1).data);

%%
%assign LFP channel data to one variable, 
lfp(:,1)=data(1).data(:,23)-data(1).data(:,24); 
lfp(:,2)=data(1).data(:,24)-data(1).data(:,25);
lfp(:,3)=data(1).data(:,25)-data(1).data(:,26);

%%

Fs = 1024
%tubs = number of bins
tubs = 1000
%f1 and f2 are stop bands, normalized to nyphist freq, so nyquist is equal
%to 1, Nyphist = 512, so normalized 60 Hz is 60/512 = 0.117. Take 0.1 in
%either direction
f1 = 0.115
f2 = 0.119
notch = fir1(tubs,[f1 f2], 'stop');

%%
lfp2 = filter(notch, 1, lfp);


%%
figure(1);
plot(lfp(:,1));

figure(2);
plot(lfp2(:,1));

figure(3);
pwelch(lfp(:,1));

figure(4);
pwelch(lfp2(:,1));
