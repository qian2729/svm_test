function [ err ] = ann_predict_error( Xdata, Ydata )
%   ����������ģ����Ԥ�⣬����Ԥ������
%   
    load ('trained_neural_networks.mat')
    for i=1:6
        eval(['Model=net' num2str(i) ';']);             %Choose the specific parameter network.
        err{i}=sim(Model,Xdata{i}')' - Ydata{i};        %Calculate the errors
    end
    err = cell2mat(err);
end

