% PiCircosDemo
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
Class=getPi(1001)+1;
Data=diag(ones(1,1000),-1);

className={'0','1','2','3','4','5','6','7','8','9'};
colorOrder=[239,65,75;230,115,48;229,158,57;232,136,85;239,199,97;
           144,180,116;78,166,136;81,140,136;90,118,142;43,121,159]./255;


CC=circosChart(Data,Class,'ClassName',className,'ColorOrder',colorOrder);
CC=CC.draw();

ax=gca;
ax.Color=[0,0,0];
CC.setClassLabel('Color',[1,1,1],'FontSize',25,'FontName','Cambria')
CC.setLine('LineWidth',.7)

