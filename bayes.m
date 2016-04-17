function [ event_prediction ] = bayes(predict_label,TPR,FPR)
%   应用贝叶斯方法根据异常推断输出事件推断
%   
    % Block 4: Calculate event probablity from each indicator
    %-------------------------------------------------------------------------
    pe0=1e-5;                     %Set value for initial probability of an event
    alpha=0.6;                    %Set smoothing parameter 0.3<alpha<0.9
    pe=pe0;
    P_event = zeros(1,length(predict_label));
    for i=1:length(predict_label)    %Iterate Bayse Update Rule
        if predict_label(i) == 1  %If Outlier then
            pe1=pe;
            pe=TPR*pe/(TPR*pe+FPR*(1-pe));               %Outlier Bayse rule
            pe=alpha*pe+(1-alpha)*pe1;                %Smoothing
            pe=min(pe,0.95);                          %Eliminate convergence to 1
        else
            pe1=pe;
            pe=(1-TPR)*pe/((1-TPR)*pe+(1-FPR)*(1-pe));   %No-Outlier Bayse rule
            pe=alpha*pe+(1-alpha)*pe1;                %Smoothing
            pe=max(pe,pe0);                           %Eliminate convergence to 0
        end
        P_event(i)=pe;                             %Save indicators probabilities
    end


    Pcr=0.9;                               %Set critical probability to alarm events.
    event_prediction=1*(P_event>=Pcr);        %Classify
end

