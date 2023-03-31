% PiScatterDemo
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
Pi=[3,getPi(399)];
% 配色数据
CM=[248,65,69;246,152,36;249,198,81;67,170,139;87,118,146]./255;
% 绘制圆圈
hold on
t=linspace(0,2*pi,100);
x=cos(t).*.8.*.5;
y=sin(t).*.8.*.5;
for i=1:400
    [col,row]=ind2sub([20,20],i);
    if mod(Pi(i),2)==0
        fill(x+col,y+row,CM(round((Pi(i)+1)/2),:),'LineWidth',1,'EdgeAlpha',.8)
    else
        fill(x+col,y+row,[0,0,0],'EdgeColor',CM(round((Pi(i)+1)/2),:),'LineWidth',1,'EdgeAlpha',.7)
    end
end
text(10.5,-.4,'\pi on a grid — 400 digits','Color',[1,1,1],'FontName','Cambria',...
    'HorizontalAlignment','center','FontSize',25,'FontAngle','italic')
% 图窗和坐标区域修饰
set(gcf,'Position',[200,100,820,820]);
ax=gca;
ax.YDir='reverse';
ax.XLim=[.5,20.5];
ax.YLim=[-1,20.5];
ax.XTick=[];
ax.YTick=[];
ax.Color=[0,0,0];
ax.DataAspectRatio=[1,1,1];