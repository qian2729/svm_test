function [ TPR, FPR ] = get_TPR_FPR( true_label, predicted_label )
%   给定标准类标输出和预测类标输出，返回TPR和FPR
%   
    conf = confusionmat(true_label,predicted_label);
    TPR = conf(2,2) / sum(conf(2,:));
    FPR = conf(1,2) / sum(conf(1,:));
end

