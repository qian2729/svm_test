function [ TPR, FPR ] = get_TPR_FPR( true_label, predicted_label )
%   ������׼��������Ԥ��������������TPR��FPR
%   
    conf = confusionmat(true_label,predicted_label);
    TPR = conf(2,2) / sum(conf(2,:));
    FPR = conf(1,2) / sum(conf(1,:));
end

