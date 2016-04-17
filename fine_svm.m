function [ tpr_array,fpr_array,params ] = fine_svm( train_data, train_label, validate_data, validate_label )
%   ����SVMģ�͵Ĳ���
%   ����ѵ�����Ͳ��Լ�
%   ���ز�ͬ�����µ�ѵ�����
%   ����ֵ�� tpr_array����ͬ������TPR�Ľ��
%           fpr_array����ͬ������FPR�Ľ��
%           params: ��ͬ����
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
            % ���ָ��svm����ѵ��������ģ������֤����TPRС��0.8�� ��ֱ��������
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

