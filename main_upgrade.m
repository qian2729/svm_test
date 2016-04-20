clc;
close all;
clear;
% step 1: ����ѵ�����ݺͲ�������
% -----------------------------------------------------------------------------
fprintf('step 1 load data\n');
FileNameEvents = 'data_with_low_events.txt';
FileNameNormal = 'data_without_events.txt';
 [Xdata_events_train,Ydata_events_train,...
  Xdata_events_test,Ydata_events_test,...
  events_flag_train,events_flag_test] = create_dataset(FileNameNormal,FileNameEvents);
        
% step 2: ����������ģ����Ԥ�⣬����Ԥ����ʵ�ʲ��������
% -----------------------------------------------------------------------------
fprintf('step 2 ����в�\n');
[ train_err ] = ann_predict_error( Xdata_events_train, Ydata_events_train );  % ѵ���������
[ test_err ] = ann_predict_error( Xdata_events_test, Ydata_events_test );  % �����������

% step 3: ��ѵ�����ݻ��ֳ�7������һ������֤��6����ѵ��
% -----------------------------------------------------------------------------
fprintf('step 3 ����ѵ�����Ͳ��Լ�\n');
split_count = 7;
split_index = 7;
[train_data, train_label, validate_data, validate_label ] = ...
                split_train( train_err, events_flag_train, split_count, split_index );


            
            
            
% step 4: ѡ��SVMģ�͵Ĳ��� �����ֶ�ѡ��ѡ��ò�����ע�͸öδ��룬���޸�step 4��C��levelֵ
%         Ϊѡ��õĲ���
% -----------------------------------------------------------------------------
fprintf('step 4 ��������\n');
% [ tpr_array,fpr_array,params ] = fine_svm( train_data, train_label, validate_data, validate_label );
% save('trained_params.mat','tpr_array','fpr_array','params'); % ����ѵ���Ľ��
% load('trained_params.mat');
% vis_tpr_fpr(tpr_array,fpr_array,params);
 

% step 5: ���ò��Լ�����ģ�ͣ����ú�level��C�Ĳ�����ִ��
% -----------------------------------------------------------------------------
fprintf('step 5 ��������\n');
level = 0.8;
C = 0.2;
evaluate( train_data, train_label,test_err,events_flag_test,level,C );