function [] = vis_tpr_fpr(tpr_array,fpr_array,params)
%   �Բ�ͬ�����µ�TPR��FPR���п��ӻ�չʾ���Խ��в�����ѡ��
%   
    figure;
    scatter(fpr_array, tpr_array);
    text(fpr_array, tpr_array, params);
    title('��ͬSVM������Ӧ��TPR��FPR');
end

