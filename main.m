clc;
close all;
clear;
% step 1: 加载训练数据和测试数据
% -----------------------------------------------------------------------------
FileNameEvents = 'data_with_low_events.txt';
FileNameNormal = 'data_without_events.txt';
 [Xdata_events_train,Ydata_events_train,...
  Xdata_events_test,Ydata_events_test,...
  events_flag_train,events_flag_test] = create_dataset(FileNameNormal,FileNameEvents);
        
% step 2: 利用神经网络模型做预测，计算预测与实际测量的误差
% -----------------------------------------------------------------------------
[ train_err ] = ann_predict_error( Xdata_events_train, Ydata_events_train );  % 训练数据误差
[ test_err ] = ann_predict_error( Xdata_events_test, Ydata_events_test );  % 测试数据误差

% step 3: 将训练数据划分成7份其中一份做验证，6份做训练
% -----------------------------------------------------------------------------
split_count = 7;
split_index = 7;
[train_data, train_label, validate_data, validate_label ] = ...
                split_train( train_err, events_flag_train, split_count, split_index );

% step 3: 选择SVM模型的参数 －－手动选择，选择好参数后注释该段代码，并修改step 4中C和level值
%         为选择好的参数
% -----------------------------------------------------------------------------
[ tpr_array,fpr_array,params ] = fine_svm( train_data, train_label, validate_data, validate_label );
save('trained_params.mat','tpr_array','fpr_array','params'); % 保存训练的结果
% load('trained_params.mat');
% vis_tpr_fpr(tpr_array,fpr_array,params);
 

% step 4: 利用测试集评估模型，设置好level和C的参数后执行
% -----------------------------------------------------------------------------
level = 0.8;
C = 0.2;
% evaluate( train_data, train_label,test_err,events_flag_test,level,C );
