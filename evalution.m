err_dataset = load('err_dataset');
err_train = cell2mat(err_dataset.err_events_train);
err_train_label = err_dataset.events_flag_train;
err_test = cell2mat(err_dataset.err_events_test);
err_test_label = err_dataset.events_flag_test;
err_train = err_train(:,2:6);
err_test = err_test(:, 2:6);
level = 0.8;
c = 0.2;
svm_struct = svmtrain(err_train,err_train_label,'KKTViolationLevel',level,'boxconstraint',c, 'kernel_function','rbf');

train_extimate = svmclassify(svm_struct, err_train);
conf = confusionmat(err_train_label,train_extimate);
tp = conf(2,2);
tn = conf(1,1);
fn = conf(2,1);
fp = conf(1,2);
TP = tp / (tp + fn);
FP = fp / (fp + tn);

extimate = svmclassify(svm_struct,err_test);


% Block 4: Calculate event probablity from each indicator
%-------------------------------------------------------------------------
pe0=1e-5;                     %Set value for initial probability of an event
alpha=0.6;                    %Set smoothing parameter 0.3<alpha<0.9
pe=pe0;
P_event = zeros(1,length(extimate));
for i=1:length(extimate)    %Iterate Bayse Update Rule
    if extimate(i) == 1  %If Outlier then
        pe1=pe;
        pe=TP*pe/(TP*pe+FP*(1-pe));               %Outlier Bayse rule
        pe=alpha*pe+(1-alpha)*pe1;                %Smoothing
        pe=min(pe,0.95);                          %Eliminate convergence to 1
    else
        pe1=pe;
        pe=(1-TP)*pe/((1-TP)*pe+(1-FP)*(1-pe));   %No-Outlier Bayse rule
        pe=alpha*pe+(1-alpha)*pe1;                %Smoothing
        pe=max(pe,pe0);                           %Eliminate convergence to 0
    end
    P_event(i)=pe;                             %Save indicators probabilities
end


Pcr=0.9;                               %Set critical probability to alarm events.
event_prediction=1*(P_event>=Pcr);        %Classify


figure
subplot(311)
bar(extimate);
subplot(312)
bar(err_test_label);
subplot(313)
bar(event_prediction);
title('event_prediction');
conf = confusionmat(err_test_label,event_prediction);
tp = conf(2,2);
tn = conf(1,1);
fn = conf(2,1);
fp = conf(1,2);
TP = tp / (tp + fn);
FP = fp / (fp + tn);
fprintf('Test TPR:%d-FPR:%d\n', TP, FP);
