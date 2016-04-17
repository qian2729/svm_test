function [ ] = evaluate( train_data, train_label,test_err,events_flag_test,level,C )
%   利用训练集对训练的模型进行评估
%   Detailed explanation goes here
    [TPR, FPR,event_prediction] = train_svm(train_data, train_label,test_err,events_flag_test,level,C);
    fprintf('Evaluation: TPR:%.2f, FPR:%.2f\n',TPR * 100, FPR * 100);
    figure
    subplot(211)
    bar(events_flag_test);
    title('true flag');
    subplot(212)
    bar(event_prediction);
    title('event_prediction');
end

