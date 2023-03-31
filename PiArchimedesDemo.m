% PiArchimedesDemo
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
a=1;b=.227;

Pi=getPi(500);
% 配色列表
CM=[78,121,167;242,142,43;225,87,89;118,183,178;89,161,79;
    237,201,72;176,122,161;255,157,167;156,117,95;186,176,172]./255; 
% 绘制圆圈
hold on
T=0;R=1;
t=linspace(0,2*pi,100);
x=cos(t).*.7;
y=sin(t).*.7;
for i=1:500
    X=R.*cos(T);Y=R.*sin(T);
    fill(X+x,Y+y,CM(Pi(i)+1,:),'EdgeColor','none','FaceAlpha',.9)
    T=T+1./R.*1.4;
    R=a+b*T;
end
text(17.25,22,{'The Archimedes spiral of \pi';'—— 500 digits'},...
    'Color',[1,1,1],'FontName','Cambria',...
    'HorizontalAlignment','right','FontSize',25,'FontAngle','italic')
% 图窗和坐标区域修饰
set(gcf,'Position',[200,100,820,820]);
ax=gca;
ax.XLim=[-19,18.5];
ax.YLim=[-20,25];
ax.XTick=[];
ax.YTick=[];
ax.Color=[0,0,0];
ax.DataAspectRatio=[1,1,1];

