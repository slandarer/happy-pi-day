% PiDirLineDemo
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
n=1200;
% 获取pi前n位小数
Pi=getPi(n); 

CM=[239,65,75;230,115,48;229,158,57;232,136,85;239,199,97;
           144,180,116;78,166,136;81,140,136;90,118,142;43,121,159]./255;
hold on
endPoint=[0,0];
t=linspace(0,2*pi,100);
T=linspace(0,2*pi,11)+pi/2;
fill(endPoint(1)+cos(t).*.5,endPoint(2)+sin(t).*.5,CM(Pi(1)+1,:),'EdgeColor','none')
for i=1:n
    theta=T(Pi(i)+1);
    plot(endPoint(1)+[0,cos(theta)],endPoint(2)+[0,sin(theta)],'Color',[CM(Pi(i)+1,:),.8],'LineWidth',1.2);
    endPoint=endPoint+[cos(theta),sin(theta)];
end
fill(endPoint(1)+cos(t).*.5,endPoint(2)+sin(t).*.5,CM(Pi(n)+1,:),'EdgeColor','none')

% 图窗和坐标区域修饰
set(gcf,'Position',[200,100,820,820]);
ax=gca;
ax.XTick=[];
ax.YTick=[];
ax.Color=[0,0,0];
ax.DataAspectRatio=[1,1,1];
ax.XLim=[-30,5];
ax.YLim=[-5,40];
% 绘制图例
endPoint=[1,35];
for i=1:10
    theta=T(i);
    plot(endPoint(1)+[0,cos(theta).*2],endPoint(2)+[0,sin(theta).*2],'Color',[CM(i,:),.8],'LineWidth',3);
    text(endPoint(1)+cos(theta).*2.7,endPoint(2)+sin(theta).*2.7,num2str(i-1),'Color',[1,1,1].*.7,...
        'FontSize',12,'FontWeight','bold','FontName','Cambria','HorizontalAlignment','center')
end
text(-15,35,'Random walk of \pi digits','Color',[1,1,1],'FontName','Cambria',...
    'HorizontalAlignment','center','FontSize',25,'FontAngle','italic')