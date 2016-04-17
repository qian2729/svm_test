function [train_data, train_label, validate_data, validate_label ] = ...
                split_train( train_data, train_label, split_count, split_index )
%   划分训练数据集为split_count份，指定第split_index份做验证，其他做训练
%   

    block_size = ceil(size(train_data,1) / split_count);
    start = (split_index - 1) * split_count + 1;
    validate_data = train_data(start:start + block_size - 1, :);
    validate_label = train_label(start:start + block_size - 1, :);
    train_data = [train_data(1:start -1,:); train_data(start + block_size:end,:)];
    train_label = [train_label(1:start -1,:); train_label(start + block_size:end,:)];
end

