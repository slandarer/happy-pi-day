function PiTree(X,pos,D)
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
lw=2;
theta=pi/2+(rand(1)-.5).*pi./12;
% 树叶及花朵颜色
CM=[237,32,121;237,62,54;247,99,33;255,183,59;245,236,43;
    141,196,63;57,178,74;0,171,238;40,56,145;146,39,139]./255;
hold on
if all(X(1:end-2)==0)
    endSet=[pos,pos,theta];
else
    kplot(pos(1)+[0,cos(theta)],pos(2)+[0,sin(theta)],lw./.6)
    endSet=[pos,pos+[cos(theta),sin(theta)],theta];
    % 计算层级
    Layer=0;
    for i=1:length(X)
        Layer=[Layer,ones(1,X(i)).*i];
    end
    % 计算树枝
    if D
    for i=1:length(X)-2
        if X(i)==0 % 若数值为0则不长树枝
            newSet=endSet(1,:);
        elseif X(i)==1 % 若数值为1则一长一短两个树枝
            tTheta=endSet(1,5);
            tTheta=linspace(tTheta+pi/8,tTheta-pi/8,2)'+(rand([2,1])-.5).*pi./8;
            newSet=repmat(endSet(1,3:4),[X(i),1]);
            newSet=[newSet.*[1;1],newSet+[cos(tTheta),sin(tTheta)].*.7^Layer(i).*[1;.1],tTheta];
        else % 其他情况数值为几长几个树枝
            tTheta=endSet(1,5);
            tTheta=linspace(tTheta+pi/5,tTheta-pi/5,X(i))'+(rand([X(i),1])-.5).*pi./8;
            newSet=repmat(endSet(1,3:4),[X(i),1]);
            newSet=[newSet,newSet+[cos(tTheta),sin(tTheta)].*.7^Layer(i),tTheta];
        end
        % 绘制树枝
        for j=1:size(newSet,1)
            kplot(newSet(j,[1,3]),newSet(j,[2,4]),lw.*.6^Layer(i))
        end
        endSet=[endSet;newSet];
        endSet(1,:)=[];
    end
    end
end
% 计算叶子和花朵位置
FLSet=endSet(:,3:4);
[~,FLInd]=sort(FLSet(:,1));
FLSet=FLSet(FLInd,:);
[~,tempInd]=sort(rand([1,size(FLSet,1)]));
tempInd=sort(tempInd(1:length(X)-2));
flowerInd=tempInd(randi([1,length(X)-2],[1,1]));
leafInd=tempInd(tempInd~=flowerInd);

% 绘制树叶
for i=1:length(leafInd)
    scatter(FLSet(leafInd(i),1),FLSet(leafInd(i),2),70,'filled','CData',CM(X(i)+1,:))
end
% 绘制花朵
for i=1:5
%     if ~D
%         tC=CM(X(end)+1,:);
%     else
%         tC=CM(X(end-2)+1,:);
%     end
    scatter(FLSet(flowerInd,1)+cos(pi*2*i/5).*.18,FLSet(flowerInd,2)+sin(pi*2*i/5).*.18,60,...
        'filled','CData',CM(X(end-2)+1,:),'MarkerEdgeColor',[1,1,1])
end
scatter(FLSet(flowerInd,1),FLSet(flowerInd,2),60,'filled','CData',CM(X(end)+1,:),'MarkerEdgeColor',[1,1,1])
drawnow;%axis tight
% =========================================================================
    function kplot(XX,YY,LW,varargin)
        LW=linspace(LW,LW*.6,10);%+rand(1,20).*LW./10;
        XX=linspace(XX(1),XX(2),11)';
        XX=[XX(1:end-1),XX(2:end)];
        YY=linspace(YY(1),YY(2),11)';
        YY=[YY(1:end-1),YY(2:end)];
        for ii=1:10
            plot(XX(ii,:),YY(ii,:),'LineWidth',LW(ii),'Color',[.1,.1,.1])
        end
    end
end