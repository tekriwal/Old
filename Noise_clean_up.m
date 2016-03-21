load('Patient_4_Sleep_LFP.mat')

assign LFPs
lfp(:,1)=data(1).data(:,23)-data(1).data(:,24);
lfp(:,2)=data(1).data(:,24)-data(1).data(:,25);
lfp(:,3)=data(1).data(:,25)-data(1).data(:,26);

%want to clean up the section from data that contains large artifact from
%amplifier being overloaded - either 13748716 to 13926872 or 13926872 to
%16752505

%lfp1 = lfp(13748716:13926872,:);
lfp2 = lfp(13926872:16752505,:);

%plot(lfp1)
%hold on
plot(lfp2)

%so the section is definitely lfp2 (13926872:16752505)
%cut it down to (14926872:15752505) and uploaded to Mathworks for help as
%'PleaseClean'
%%
D = load('PleaseClean.mat');
s  = D.PleaseClean;
Fs = 1024;                  % Sampling Frequency (Hz)
Fn = Fs/2;                  % Nyquist Frequency
L  = size(s,1);
t = linspace(0, 1, L)/Fs;   % Sampling Time

plot(s)

%%
Smean = mean(s);
Sstd  = std(s);
CE95  = bsxfun(@plus, Smean, bsxfun(@times,Sstd*1.96,[-1  1]'));
[maxs,idx] = max(s);
sLen = min(idx-10);
s = s(1:sLen,:);
t = t(1:sLen);
figure(1)
subplot(3,1,1)
plot(t, s(:,1))
axis([xlim    0.001*CE95(:,1)'])
grid
subplot(3,1,2)
plot(t, s(:,2))
axis([xlim    0.001*CE95(:,2)'])
grid
subplot(3,1,3)
plot(t, s(:,3))
axis([xlim    CE95(:,3)'])
grid
Q1 = s(1:5,:);    % Look
fts = fft(s)/sLen;
Fv = linspace(0, 1, fix(sLen/2)+1)*Fn;
Iv = 1:length(Fv);
figure(2)
subplot(3,1,1)
plot(Fv, abs(fts(Iv,1))*2)
axis([0  100    0  1E-1])
grid
subplot(3,1,2)
plot(Fv, abs(fts(Iv,2))*2)
axis([0  100    0  1E-1])
grid
subplot(3,1,3)
plot(Fv, abs(fts(Iv,3))*2)
axis([0  100    0  1E-4])
grid
Wp =  50/Fn;
Ws =  75/Fn;
Rp = 10;
Rs = 50;
[n,Wn] = buttord(Wp, Ws, Rp, Rs);
[b,a] = butter(n,Wn);
[sos,g] = tf2sos(b,a);
figure(3)
freqz(sos, 2048, Fs)
sf = filtfilt(sos,g,s);
Q2 = sf(1:5,:);   % Look
figure(4)
subplot(3,1,1)
plot(t, sf(:,1))
axis([xlim    0.001*CE95(:,1)'])
grid
subplot(3,1,2)
plot(t, sf(:,2))
axis([xlim    0.001*CE95(:,2)'])
grid
subplot(3,1,3)
plot(t, sf(:,3))
axis([xlim    CE95(:,3)'])
grid
figure(5)
plot3(sf(:,1), sf(:,2), sf(:,3))
grid on



