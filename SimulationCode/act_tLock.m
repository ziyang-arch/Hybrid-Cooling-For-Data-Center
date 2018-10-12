function [  stat, set ] = act_tLock(datainT,Tsafe, activ, cpuJudge,nTerval )
% %{ ACT 判断在T内的服务器温度分布是否满足启动chiller的要求,
% stat数值代表chiller还要运行的周期数
% 满足后就将set置为需要降低的温度

[l, m]=size(datainT);
test=zeros(1,m);

    for i=1:m
        test(i)=sum(datainT(:,m)>Tsafe)/l;
    end
    score=sum(test>cpuJudge)/m;%将过热的标准设为在chiller的最小运行周期内过热的时间百分比
    if score>activ
        sumT=sum(datainT,2);
        %set=min(sumT(sumT>Tsafe*m))/m-Tsafe;
        %用平均温度最低的cpu(但高于安全温度)的平均温度减去安全温度作为chiller的应降温值
        set=median(sumT(sumT>Tsafe*m))/m-Tsafe;
        stat=nTerval;
    else
        stat=0;
        set=0;
   
    end
    if isempty(set)
        set=0;
    end

end


