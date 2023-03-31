% PiLogoDemo
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
Pi=[3,-1,getPi(150)];

CM=[109,110,113;224,25,33;244,126,26;253,207,2;154,203,57;111,150,124;
    121,192,235;6,109,183;190,168,209;151,118,181;233,93,163]./255;
ST={'.','ZERO','ONE','TWO','THREE','FOUR','FIVE','SIX','SEVEN','EIGHT','NINE'};

n=1;
hold on
% 循环绘制字母
for i=1:20%:10
    STList='';
    NMList=[];
    PicListR=uint8(zeros(400,0));
    PicListG=uint8(zeros(400,0));
    PicListB=uint8(zeros(400,0));
    % PicListA=uint8(zeros(400,0));
    for j=1:6
        STList=[STList,ST{Pi(n)+2}];
        NMList=[NMList,ones(size(ST{Pi(n)+2})).*(Pi(n)+2)];
        n=n+1;
        if length(STList)>15&&length(STList)+length(ST{Pi(n)+2})>20
            break;
        end
    end
    for k=1:length(STList)
        tPic=imread(['image\',STList(k),'.png']);
        % PicListA=[PicListA,tPic(:,:,1)];
        PicListR=[PicListR,(255-tPic(:,:,1)).*CM(NMList(k),1)];
        PicListG=[PicListG,(255-tPic(:,:,2)).*CM(NMList(k),2)];
        PicListB=[PicListB,(255-tPic(:,:,3)).*CM(NMList(k),3)];
    end
    PicList=cat(3,PicListR,PicListG,PicListB);
    image([-1200,1200],[0,150]-(i-1)*150,flipud(PicList))
end
% 图窗及坐标区域修饰
set(gcf,'Position',[200,100,600,820]);
ax=gca;
ax.DataAspectRatio=[1,1,1];
ax.XLim=[-1300,1300];
ax.Position=[0,0,1,1];
ax.XTick=[];
ax.YTick=[];
ax.Color=[0,0,0];
ax.YLim=[-19*150-80,230];