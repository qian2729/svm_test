function [ TPR, FPR,event_prediction ] = train_svm(train_data, train_label, validate_data, validate_label,level,C)
%   指定不同的参数，训练SVM
%   输入为训练数据集和验证数据集，训练数据集用来训练svm模型，验证数据集用来评估模型
%   返回TPR和FPR值作为评估结果,以及SVM的训练结果
        svm_struct = svmtrain(train_data, train_label,'KKTViolationLevel',level,'boxconstraint',C, 'kernel_function','rbf');
        train_predict = svmclassify(svm_struct, train_data);
        [TPR,FPR] = get_TPR_FPR( train_label, train_predict );
        predict_label = svmclassify(svm_struct,validate_data);
        [event_prediction ] = bayes(predict_label, TPR,FPR);
        [TPR,FPR] = get_TPR_FPR( validate_label, event_prediction );
end

