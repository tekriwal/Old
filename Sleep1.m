% Figure out how to save something in Matlab...
% accomplished, next step is figuring out whether I need the editor window
% *don't forget semicolons
% *don't forget to save
% do I need to keep re-importing the data file? Doesn't seem right...

%data2 = uint16(data.data);
%plot(data.data(1:10000000,24))

%this changes the data into 16 bit form and plots something out in the
%second line


%questions for Dr. Thompson - how do I sync up with github, do I really
%need to import the data file every time that I close down Matlab?

%Goal 1 - identify a fingerprint of sleep, will try for N2 signs of sleep
%spindles (12-14 Hz for ~0.5 second) and K wave (sharp negative deflection
%shortly after spindle) 

%Which data sets to pull from? For EEG need two central channels and two
%occipital channels, sampled from in 30-seconds. Occipital channels O1 and
%O2 correspond to columns 5 and 16, and central channels C3 and C4
%correspond to columns 7 and 18 in the montage set


% Figure out how to save something in Matlab...
% accomplished, next step is figuring out whether I need the editor window
% *don't forget semicolons
% *don't forget to save
% do I need to keep re-importing the data file? Doesn't seem right...

%data2 = uint16(data.data);
%plot(data.data(1:10000000,24))

%this changes the data into 16 bit form and plots something out in the
%second line


%questions for Dr. Thompson - how do I sync up with github, do I really
%need to import the data file every time that I close down Matlab?

%Goal 1 - identify a fingerprint of sleep, will try for N2 signs of sleep
%spindles (12-14 Hz for ~0.5 second) and K wave (sharp negative deflection
%shortly after spindle) 

%Which data sets to pull from? For EEG need two central channels and two
%occipital channels, sampled from in 30-seconds. Occipital channels O1 and
%O2 correspond to columns 5 and 16, and central channels C3 and C4
%correspond to columns 7 and 18 in the montage set



%%
%alldata=data.data;
%%
%allLFP=alldata(:,23:26);

% 2/7/16
%reached directory through Users > AndyTekriwal > Documents > MATLAB >
%Abosch > Git in order to get here, hopefully this will push to repos Dr.
%Thompson has access to through GitHub

%Occipital channels O1 and O2 correspond to columns 5 and 16, and central channels C3 and C4
%correspond to columns 7 and 18 in the montage set

%EEG1 = data.data(:,5);
%EEG2 = data.data(:,16);
%EEG3 = data.data(:,7);
%EEG4 = data.data(:,18);

%deleting data2 variable, just going to deal with running the big file unti

git init
git add .
git commit -m "Initial commit"



