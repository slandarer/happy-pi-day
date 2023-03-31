% PiPolarCircle4Demo
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
Pi=[3,getPi(1199)];
% 配色数据
CM=[239,32,120;239,60,52;247,98,32;255,182,60;247,235,44;
    142,199,57;55,180,70;0,170,239;40,56,146;147,37,139]./255;
% CM=slanCM(184,10);
% 绘制圆圈
hold on
T=0;R=1;
t=linspace(0,2*pi,100);
x=cos(t).*.7;
y=sin(t).*.7;
for i=1:4:length(Pi)
    X=R.*cos(T);Y=R.*sin(T);
    tNum=Pi(i:i+3);
    numNum=find([diff(sort(tNum)),1]);
    numNum=[numNum(1),diff(numNum)];
    cumNum=cumsum(numNum);
    uniNum=unique(tNum);
    for j=length(cumNum):-1:1
        fill(x./4.*cumNum(j)+X,y./4.*cumNum(j)+Y,CM(uniNum(j)+1,:),'EdgeColor','none')
    end
    T=T+1./R.*1.4;
    R=a+b*T;
end
text(14,16.5,{'The ratio of four numbers from \pi';'—— 1200 digits'},...
    'Color',[1,1,1],'FontName','Cambria',...
    'HorizontalAlignment','right','FontSize',23,'FontAngle','italic')
% 图窗和坐标区域修饰
set(gcf,'Position',[200,100,820,820]);
ax=gca;
ax.XLim=[-15,15.5];
ax.YLim=[-15,19];
ax.XTick=[];
ax.YTick=[];
ax.Color=[0,0,0];
ax.DataAspectRatio=[1,1,1];