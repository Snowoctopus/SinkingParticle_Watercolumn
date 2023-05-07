function(rho,rho0,eta)
rho=1100; %颗粒密度 kg/m3
rho0=1000;%水体密度 kg/m3
g=9.8; %重力加速度 m/s2
eta=1.005d-3;%水体的粘滞系数 Pa*s
d;%颗粒物的直径，为公式表达简洁，取量纲为 m
n;%颗粒物的个数
u=d.*d.*(rho-rho0).*g/18./eta;
for t=1:14 %设时间间隔 单位暂时定为s
    z(:,t+1)=u.*t;
end
if sum(sum(z>1.5))~=0 %判断是否存在沉降距离大于水柱高度的颗粒
    [row,column]=find(z>1.5);%识别沉降距离大于水柱高度的颗粒并记录其下标
    z(row,column)=1.5;%使沉降距离大于水柱高度的颗粒停留在水柱底部，即位置不再变化
end
size=d*100;
sz=60;
for k=1:1+t
    test=z(:,k);
    figure()
    scatter(n,test,sz,size,'fill');
    %scatter(n,test,size,'MarkerFaceColor','r','MarkerEdgeColor','k')
    set(gcf,'PaperPositionMode','auto');
    set(gca,'XAxisLocation','top');
    set(gca,'YDir','reverse'); 
    ylim([0 1.5]);
    xlabel('number of particles','fontsize',12);
    ylabel('depth(m)','fontsize',12);
    caxis([0,0.18]);
    colorbar
    title(['Second',num2str(k)],'fontsize',14);
    colormap(flipud(colormap));
    print('-dpng','-r200',[num2str(k),'.png']);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:15;
    str = strcat(num2str(k), '.png');
    A=imread(str);
    [I,map]=rgb2ind(A,256);
    if(k==1)
        imwrite(I,map,'movefig.gif','DelayTime',0.1,'LoopCount',Inf)
    else
        imwrite(I,map,'movefig.gif','WriteMode','append','DelayTime',0.1)
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%画时间序列
