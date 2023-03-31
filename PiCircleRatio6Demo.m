% PiCircleRatio6Demo
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
Pi=[3,getPi(767)];
% 762-767
% 配色数据
CM=[239,32,120;239,60,52;247,98,32;255,182,60;247,235,44;
    142,199,57;55,180,70;0,170,239;40,56,146;147,37,139]./255;
% 绘制圆圈
hold on
t=linspace(0,2*pi,100);
x=cos(t).*.9.*.5;
y=sin(t).*.9.*.5;
for i=1:6:length(Pi)
    n=round((i-1)/6+1);
    [col,row]=ind2sub([10,13],n);
    tNum=Pi(i:i+5);
    numNum=find([diff(sort(tNum)),1]);
    numNum=[numNum(1),diff(numNum)];
    cumNum=cumsum(numNum);
    uniNum=unique(tNum);
    for j=length(cumNum):-1:1
        fill(x./6.*cumNum(j)+col,y./6.*cumNum(j)+row,CM(uniNum(j)+1,:),'EdgeColor','none')
    end
end
% 绘制图例
for i=1:10
   fill(x./4+5.5+(i-5.5)*.32,y./4+14.5,CM(i,:),'EdgeColor','none')
   text(5.5+(i-5.5)*.32,14.9,num2str(i-1),'Color',[1,1,1],'FontSize',...
       9,'FontName','Cambria','HorizontalAlignment','center')
end
text(5.5,-.2,'FEYNMAN POINT of \pi','Color',[1,1,1],'FontName','Cambria',...
    'HorizontalAlignment','center','FontSize',25,'FontAngle','italic')
% 图窗和坐标区域修饰
set(gcf,'Position',[200,100,600,820]);
ax=gca;
ax.YDir='reverse';
ax.Position=[0,0,1,1];
ax.XLim=[.3,10.7];
ax.YLim=[-1,15.5];
ax.XTick=[];
ax.YTick=[];
ax.Color=[0,0,0];
ax.DataAspectRatio=[1,1,1];
