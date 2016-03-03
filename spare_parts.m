%old thoughts/comments/script, use for parts

%(ROW, COLUMN)

%nyquist tells you that you need to sample at twice the frequency of
%interest

%for using github, just drag and drop file directly from Matlab into the
%online userface



%% EEG related information

% in N2 signs of sleep spindles (12-14 Hz for ~0.5 second) and K wave (sharp negative deflection
%shortly after spindle) 

%Which data sets to pull from? For EEG need two central channels and two
%occipital channels, sampled from in 30-seconds. Occipital channels O1 and
%O2 correspond to columns 5 and 16, and central channels C3 and C4
%correspond to columns 7 and 18 in the montage set

%% EEG related code


%allLFP=alldata(:,23:26);


%Occipital channels O1 and O2 correspond to columns 5 and 16, and central channels C3 and C4
%correspond to columns 7 and 18 in the montage set

EEG1 = data.data(:,5);
EEG2 = data.data(:,16);
EEG3 = data.data(:,7);
EEG4 = data.data(:,18);

% Rules for scoring - https://sleepdata.org/datasets/chat/pages/manuals/polysomnography
% -reading-center/6-08-01-scoring-sleep-stages-and-arousals.md

%upgraded to the bundle package, so now have access to signal processing
%commands, intend on using EEG1-4 to try and isolate spindles using 
%p = bandpower(x,fs,freqrange)
%x is time series input...?
%fs is sampling frequency which I think should be 1024
%for freq range: [0, (N-1)fs/(2N)] if x is real-valued and N is odd

%bandpower(EEG1,1024,[12,14])
%12-14 represents Hz range of interest (I think)

%fvtool - good function, I think..

%questions for John - 
%1) Do I need to do pre-processing analogous to Rachel's LFP_PreProcess1.m?
% answer - maybe
%2) Create/apply band
% answer - see below, what we want to do is have a moving window which will
% evaluate the power spectral density for 12-14 Hz in periods that are a
% bit larger than what we're interested in, so like 2 secs if sleep
% spindles are usually about 0.5 sec



%% this changes the data into 16 bit form and plots something out in the second line

data2 = uint16(data.data);
plot(data.data(1:10000000,24))

%% script workspace

