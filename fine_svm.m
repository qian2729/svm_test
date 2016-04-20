function [ tpr_array,fpr_array,params ] = fine_svm( train_data, train_label, validate_data, validate_label )
%   ����SVMģ�͵Ĳ���
%   ����ѵ�����Ͳ��Լ�
%   ���ز�ͬ�����µ�ѵ�����
%   ����ֵ�� tpr_array����ͬ������TPR�Ľ��
%           fpr_array����ͬ������FPR�Ľ��
%           params: ��ͬ����
    levels = 0.1:0.05:2;
    c_params = 0.1:0.05:2;
    params = {};
    tpr_array = [];
    fpr_array = [];
    index = 0;
    for level = levels
        for c = c_params
            [ TPR, FPR ] = train_svm(train_data, train_label, validate_data, validate_label,level,c);
            
            % ���ָ��svm����ѵ��������ģ������֤����TPRС��0.8�� ��ֱ��������
%             if TPR < 0.8
%                 continue;
%             end
            tpr_array = [tpr_array TPR];
            fpr_array = [fpr_array FPR];
            param = sprintf('l:%.2f-c:%.2f:tpr:%.4f fpr:%.4f',level, c,TPR,FPR);
            fprintf('%s\n',param);
            index = index + 1;
            params{index} = param;
        end    
    end

end

