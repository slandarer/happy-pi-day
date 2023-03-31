% PiPolarDemo
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
Pi=getPi(600);
% 配色列表
CM=[78,121,167;242,142,43;225,87,89;118,183,178;89,161,79;
    237,201,72;176,122,161;255,157,167;156,117,95;186,176,172]./255;
% 绘制圆圈
hold on
t=linspace(0,2*pi,100);
x=cos(t).*.8;
y=sin(t).*.8;
for i=1:600
    X=i.*cos(i./10)./10;
    Y=i.*sin(i./10)./10;
    fill(X+x,Y+y,CM(Pi(i)+1,:),'EdgeColor','none','FaceAlpha',.9)
end
text(0,65,'The Circle of \pi','Color',[1,1,1],'FontName','Cambria',...
    'HorizontalAlignment','center','FontSize',25,'FontAngle','italic')
% 图窗和坐标区域修饰
set(gcf,'Position',[200,100,820,820]);
ax=gca;
ax.XLim=[-60,60];
ax.YLim=[-60,70];
ax.XTick=[];
ax.YTick=[];
ax.Color=[0,0,0];
ax.DataAspectRatio=[1,1,1];