function [  stat, set ] = act(datainT,Tsafe, activ, cpuJudge,nTerval )
% %{ ACT 判断在T内的服务器温度分布是否满足启动chiller的要求,
% stat数值代表chiller还要运行的周期数
% 满足后就将set置为需要降低的温度

[l, m]=size(datainT);
test=zeros(1,m);

   score=sum(sum(datainT>Tsafe))/l/m;
   
    if score>activ*cpuJudge

       % set=mean(datainT(datainT>Tsafe))-Tsafe;
        line=mean(datainT,2);
        set=min(line)-Tsafe;
        stat=nTerval;
    else
        stat=0;
        set=0;
    end
    if isempty(set)||set<0
        set=0;
    end

end



