% this is an anumaration for finding the optimal C for the SVM classifier
% due to its accuracy and detection ability for the validation data 
% takes about 80-90 minuts 
% increasing C gives higher weight to the slack variables si, meaning the
% optimization attempts to make a stricter separation between classes. 
function [C] = FindBestC (training,group,validation,groupVal)

cparams = 0.1:0.1:1;
Ceffect=zeros(length(cparams),2,'single');
count=0;
for C=cparams
    
    count=count+1;
    [svm_struct] = svmtrain(training,group,'KKTViolationLevel',0.7,'boxconstraint',C, 'kernel_function','rbf');
    % evaluate performance on validation data
    valRes = svmclassify(svm_struct,validation) ;
    TP=0;
    TN=0;
    FP=0;
    FN=0;
    detected=0;
    eventsNum=0;
    inEvent=0; % this is an event
    found=0; % the event was detected
  
    for j=1:length(valRes)
        if valRes(j)==1 % the time step was classified as an outlier
            if groupVal(j)==1
                TP=TP+1;  % during a real event
            else
                FP=FP+1; % during normal operation
            end
        else % the time step was classified as normal
            if groupVal(j)==0
                TN=TN+1;   % during normal operation
            else
                FN=FN+1;   % during an event
            end
        end

        if groupVal(j)==1
            if ~(inEvent) % this event was first found
                inEvent=1;
                eventsNum=eventsNum+1;
            end
            if valRes(j)==1
                if ~(found)
                    detected=detected+1;
                    found=1;
                end
            end
        else
            inEvent=0;
            found=0;
        end
    end
    valAccuracy = (TP+TN)/(TP+TN+FP+FN);
    eventDetected = detected/eventsNum;
    Ceffect(count,1) = valAccuracy; % holds the accuracy for different c values
    Ceffect(count,2)=eventDetected;
    fprintf('Turing C:%.2f-accuracy:%.4f; eventDetected:%d\n', C, valAccuracy,eventDetected);
end
% [measure,I]=max(sum(Ceffect,2));
measure=sum(Ceffect,2);
ind=find(measure == max(measure));
I= 1;
seq=1;
longestSeq=seq;
if length(ind)>2
    for k=2:length(ind)
        if (ind(k)-ind(k-1))==1
            seq=seq+1;
            if seq>longestSeq
                I=k;    % I will mark the last elelment in the sequence
                longestSeq=seq;
            end
        else
            seq=1; % for the next sequence will start from 1
        end
        
    end
end
mid= (I-longestSeq+1) + floor(longestSeq / 2) ;
Cind = ind(mid);
C=Cind*0.1; % the best C according to the calculated measure