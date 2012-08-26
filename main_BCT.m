function[pb]=main_BCT(varargin)
% This is tha main function to calculate boundary using brightness, color and texture
%
%INPUT
%	varargin		any combination of 'b','c' and 't'
%					'b' for brightness
%					'c' for color
%					't' for texture
%					for example  main_BCT('b','t') will detect boundary using brightness and texture
%
%OUTPUT			    detect bounday using given image feature like brightness, color and texture
%	

if nargin>3, error(sprintf('Number of argument should be less than four'));end
for i = 1:nargin,
	opt = varargin{i};
	switch opt,
		case {'b','c','t'}, feature(i)=opt;
		otherwise, error(sprintf('invalid input=''%s''',opt));
	end	 
end  


%%%%%%%%%%%%%%%%% User Interface %%%%%%%%%%%%%%%%%%%%%%

Hf = figure('position', [50 50 1550 900],...
'resize', 'on', 'toolbar', 'none',...
 'name', 'Main Window','numbertitle', 'off',...
 'backingstore', 'off', 'doublebuffer', 'on');

hndl.simbutton = uicontrol('parent', Hf, 'style', 'pushbutton',...
 'string', 'Clear',...
 'position', [600 30 70 40]);

hndl.simbutton1 = uicontrol('parent', Hf, 'style', 'pushbutton',...
 'string', 'Show Edge',...
 'position', [705 30 70 40]);

hndl.sl=uicontrol('parent', Hf,'Style', 'slider',...
        'Min',0,'Max',1,'Value',.2,...
        'Position', [810 40 120 20],'Tag', 'threshold','Callback', {@thresholded_Image});   % Uses cell array function handle callback
                                    % Implemented as a subfunction with an argument
									
Hdendro =figure('position', [50 50 1550 900],...
'resize', 'on', 'toolbar', 'none',...
 'name', 'Dendrogram','numbertitle', 'off',...
 'backingstore', 'off', 'doublebuffer', 'on');

HtopCls =figure('position', [50 50 1550 900],...
'resize', 'on', 'toolbar', 'none',...
 'name', 'Top Clusters','numbertitle', 'off',...
 'backingstore', 'off', 'doublebuffer', 'on'); 
 
 hndl.s2=uicontrol('parent', HtopCls,'Style', 'slider',...
         'Min',0,'Max',100,'Value',20,...
         'Position', [810 40 120 20],'Tag', 'thresholdCls','Callback', {@threshold_cluster});   % Uses cell array function handle callback
                                    % % Implemented as a subfunction with an argument

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


img_ids = load(fullfile(main_dir,'iids_test.txt')); 
output_dir = fullfile(main_dir,'Final Output images');
ignore = mkdir(output_dir);
for i = 1:numel(img_ids),
	img_id = img_ids(i);
    fprintf(1,'Computing boundary...\n'...
    );
	img_name = fullfile(main_dir,'images',sprintf('%d.jpg',img_id)); 
	im1=imread(img_name);
	figure(Hf);
	imshow(im1); 
	hold on; 
    im = double(imread(img_name)) / 255;
	set(hndl.simbutton1, 'callback', {@pr_G,im,feature,Hf,Hdendro,HtopCls});
	set(hndl.sl, 'callback', {@thresholded_Image,im,Hf,Hdendro,HtopCls});
	set(hndl.simbutton, 'callback', {@clear_Window,im,Hf,Hdendro,HtopCls});
	set(hndl.s2, 'callback', {@threshold_cluster,im,Hf,Hdendro,HtopCls});
	%%pb=load('probability_i4.txt');
	%%imwrite(pb,fullfile(output_dir,sprintf('%d.jpg',img_id)),'jpg');
end


