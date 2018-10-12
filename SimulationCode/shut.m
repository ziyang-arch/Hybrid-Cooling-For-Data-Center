function [ cstat, Tchiller ] = shut( tempmem, Tsafe, activ, cpuJudge , cstat , Tchiller )
%SHUT 此处显示有关此函数的摘要
%   此处显示详细说明
[l,m]=size(tempmem);

score=sum(sum(tempmem>Tsafe))/l/m;

if score<activ*cpuJudge
    cstat=0;
else
    cstat=cstat-1;
    % never lower chiller
%     set=mean(tempmem(tempmem>Tsafe))-Tsafe;
%     if set>Tchiller
%         Tchiller=set;
%     end
     %% 
      line=mean(tempmem,2);
      set=min(line(line>Tsafe))-Tsafe;
      
       if isempty(set)
        set=0;
       end
        Tchiller=set;
      %%
%       line=mean(tempmem,2);
%       set=min(line)-Tsafe;
%       if set>0
%           Tchiller=set;
%       end
end
end
   


