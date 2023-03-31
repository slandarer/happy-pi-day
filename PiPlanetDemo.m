% PiPlanetDemo
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
Pi=[3,getPi(71)];K=.18;
% 基础配置
CM=[239,32,120;239,60,52;247,98,32;255,182,60;247,235,44;
    142,199,57;55,180,70;0,170,239;40,56,146;147,37,139]./255;
T=linspace(0,2*pi,length(Pi)+1)';
T=T(1:end-1);
ct=linspace(0,2*pi,100);
cx=cos(ct).*.027;
cy=sin(ct).*.027;
% 初始数据
Pi=Pi(:);
N=Pi;
X=cos(T);Y=sin(T);
VX=T.*0;VY=T.*0;
PX=X;PY=Y;
% 未碰撞时初始质量
getM=@(x)(x+1).^K;
M=getM(N);
% 绘制初始圆圈
hold on
for i=1:length(N)
    fill(cx+X(i),cy+Y(i),CM(N(i)+1,:),'EdgeColor','w','LineWidth',1)
end
for k=1:800
    % 计算加速度
    Rn2=1./squareform(pdist([X,Y])).^2;
    Rn2(eye(length(X))==1)=0;
    MRn2=Rn2.*(M');
    AX=X'-X;AY=Y'-Y;
    normXY=sqrt(AX.^2+AY.^2);
    AX=AX./normXY;AX(eye(length(X))==1)=0;
    AY=AY./normXY;AY(eye(length(X))==1)=0;
    AX=sum(AX.*MRn2,2)./150000;
    AY=sum(AY.*MRn2,2)./150000;
    % 计算速度及新位置
    VX=VX+AX;X=X+VX;PX=[PX,X];
    VY=VY+AY;Y=Y+VY;PY=[PY,Y];
    % 检测是否有碰撞
    R=squareform(pdist([X,Y]));
    R(triu(ones(length(X)))==1)=inf;
    [row,col]=find(R<=0.04);
    if length(X)==1
        break;
    end
    if ~isempty(row)
        % 碰撞的点合为一体
        XC=(X(row)+X(col))./2;YC=(Y(row)+Y(col))./2;
        VXC=(VX(row).*M(row)+VX(col).*M(col))./(M(row)+M(col));
        VYC=(VY(row).*M(row)+VY(col).*M(col))./(M(row)+M(col));
        PC=nan(length(row),size(PX,2));
        NC=mod(N(row)+N(col),10);
        % 删除碰撞点并绘图
        uniNum=unique([row;col]);
        X(uniNum)=[];VX(uniNum)=[];
        Y(uniNum)=[];VY(uniNum)=[];
        for i=1:length(uniNum)
            plot(PX(uniNum(i),:),PY(uniNum(i),:),'LineWidth',2,'Color',CM(N(uniNum(i))+1,:))
        end
        PX(uniNum,:)=[];PY(uniNum,:)=[];N(uniNum,:)=[];
        % 绘制圆形
        for i=1:length(XC)
            fill(cx+XC(i),cy+YC(i),CM(NC(i)+1,:),'EdgeColor','w','LineWidth',1)
        end
        % 补充合体点
        X=[X;XC];Y=[Y;YC];VX=[VX;VXC];VY=[VY;VYC];
        PX=[PX;PC];PY=[PY;PC];N=[N;NC];M=getM(N);
    end
end
for i=1:size(PX,1)
    plot(PX(i,:),PY(i,:),'LineWidth',2,'Color',CM(N(i)+1,:))
end
text(-1,1,{['Num=',num2str(length(Pi))];['K=',num2str(K)]},'FontSize',13,'FontName','Cambria')
% 图窗及坐标区域修饰
set(gcf,'Position',[200,100,820,820]);
ax=gca;
ax.Position=[0,0,1,1];
ax.DataAspectRatio=[1,1,1];
ax.XLim=[-1.1,1.1];
ax.YLim=[-1.1,1.1];
ax.XTick=[];
ax.YTick=[];
ax.XColor='none';
ax.YColor='none';