%%function clearWindow(cbo, eventdata,Hf)
function [b] = clearWindow(cbo, eventdata,im,Hf,Hdendro,HtopCls)

disp('clicked on clear');
clf(Hf);
clf(Hdendro);
clf(HtopCls);

%%%%%%%%%%%%%%%%% recreate interface  %%%%%%%%%%%%%%%%%%%%%%
hndl.simbutton = uicontrol('parent', Hf, 'style', 'pushbutton',...
 'string', 'Clear',...
 'position', [600 30 70 40]);

hndl.simbutton1 = uicontrol('parent', Hf, 'style', 'pushbutton',...
 'string', 'Show Edge',...
 'position', [705 30 70 40]);

hndl.sl=uicontrol('parent', Hf,'Style', 'slider',...
        'Min',0,'Max',1,'Value',0,...
        'Position', [810 40 120 20],'Tag', 'threshold','Callback', {@thresholded_Image});

hndl.s2=uicontrol('parent',HtopCls,'Style', 'slider',...
        'Min',0,'Max',100,'Value',20,...
        'Position', [810 40 120 20],'Tag', 'thresholdCls','Callback', {@threshold_cluster});   % Uses cell array function handle callback
                                    % Implemented as a subfunction with an argument 		

figure(Hf);
imshow(im);

figure(HtopCls);
imshow(im);		
set(hndl.sl, 'callback', {@thresholded_Image,im,Hf,Hdendro,HtopCls});
set(hndl.simbutton, 'callback', {@clear_Window,im,Hf,Hdendro,HtopCls});
set(hndl.s2, 'callback', {@threshold_cluster,im,Hf,Hdendro,HtopCls});


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

