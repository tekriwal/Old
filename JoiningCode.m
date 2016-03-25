load('Patient_10_Sleep_LFP.mat')

Patient_10_1 = data(1).data;
Patient_10_2 = data(2).data;

save('Pat_10_1','Patient_10_1', '-v7.3');
save('Pat_10_2','Patient_10_2');

clear all

x = load('Pat_10_1.mat')
y = load('Pat_10_2.mat')

vrs = fieldnames(x);
if ~isequal(vrs,fieldnames(y))
    error('Different variables in these MAT-files')
end

Concatenate data
for k = 1:length(vrs)
    x.(vrs{k}) = [x.(vrs{k});y.(vrs{k})];
end
% Save result in a new file
save('Pat_10_Total','-struct','x')
