function [tex_map] = texton_map(f_response,textons)
%
%calculate distance between filter responses and cluster center of the texton library
%	INPUT
%		f_response			filter bank response
%		textons				texton library
%
%	OUTPUT
%		tex_map				texon map
%
d = numel(f_response); %%d=24; n=154401
n = numel(f_response{1});
response = zeros(d,n);
for i = 1:d,
 response(i,:) = f_response{i}(:)'; %% 24*154401
end
response=response'; %% 154401*24
textons1=textons'; %% 32*24
distance = dist2(response,textons1); %%154401*32
[y,tex_map] = min(distance,[],2); %%tex_map=154401*1 minimum distance among 32 textons
[w,h] = size(f_response{1});
tex_map = reshape(tex_map,w,h);%% resize to image width and height
