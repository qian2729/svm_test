function [] = vis_tpr_fpr(tpr_array,fpr_array,params)
%   对不同参数下的TPR和FPR进行可视化展示，以进行参数的选择
%   
    figure;
    scatter(fpr_array, tpr_array);
    text(fpr_array, tpr_array, params);
    title('不同SVM参数对应的TPR和FPR');
end

