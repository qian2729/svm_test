function [ TPR, FPR,event_prediction ] = train_svm(train_data, train_label, validate_data, validate_label,level,C)
%   ָ����ͬ�Ĳ�����ѵ��SVM
%   ����Ϊѵ�����ݼ�����֤���ݼ���ѵ�����ݼ�����ѵ��svmģ�ͣ���֤���ݼ���������ģ��
%   ����TPR��FPRֵ��Ϊ�������,�Լ�SVM��ѵ�����
        svm_struct = svmtrain(train_data, train_label,'KKTViolationLevel',level,'boxconstraint',C, 'kernel_function','rbf');
        train_predict = svmclassify(svm_struct, train_data);
        [TPR,FPR] = get_TPR_FPR( train_label, train_predict );
        predict_label = svmclassify(svm_struct,validate_data);
        [event_prediction ] = bayes(predict_label, TPR,FPR);
        [TPR,FPR] = get_TPR_FPR( validate_label, event_prediction );
end

