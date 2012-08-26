function [fim] = filter_bank(fb,im2)
%
% Run a filterbank on an image 

fim = cell(size(fb));
for i = 1:numel(fb), %% 24
  fim{i} = conv2(im2,fb{i},'same'); %% numel(fim)=24; numel(fim{i}= image w * h= 154401)
end
