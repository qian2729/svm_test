function [ tpr_array,fpr_array,params ] = fine_svm( train_data, train_label, validate_data, validate_label )
%   调整SVM模型的参数
%   给定训练集和测试集
%   返回不同参数下的训练结果
%   返回值： tpr_array：不同参数下TPR的结果
%           fpr_array：不同参数下FPR的结果
%           params: 不同参数
    levels = 0.1:0.02:2;
    c_params = 0.1:0.02:2;
    params = {};
    tpr_array = [];
    fpr_array = [];
    index = 0;
    for level = levels
        for c = c_params
            [ TPR, FPR ] = train_svm(train_data, train_label, validate_data, validate_label,level,c);
            param = sprintf('l:%.2f-c:%.2f',level, c);
            fprintf('%s\n',param);
            % 如果指定svm参数训练出来的模型在验证集上TPR小于0.8， 就直接舍弃掉
%             if TPR < 0.8
%                 continue;
%             end
            tpr_array = [tpr_array TPR];
            fpr_array = [fpr_array FPR];
            index = index + 1;
            params{index} = param;
        end    
    end

end

