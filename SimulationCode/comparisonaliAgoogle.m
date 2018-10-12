clear
clc
load('divpattern.mat');

argument=struct('Tsafe',63.12,'Tstandard',50 ,'k1',36.286 , ...
  'b1',57.095,'k2',10,'b2',72,'threshold',0.5, 'cop_chiller',3.6, ...
'F',0.5/3600,'nTerval',3,'Terval',5*60,'activ',1, 'cpuJudge',0.5);
%HE£ºhighly engaged£¬ 
%HE£ºlowly engaged with occational peak£¬ 
%LR£ºlowly engaged with rare peak 
%% 
[l,m]=size(HE);
[Ekwh , Ekwhmono, Ekwhtec, Eopt]=simulation(HE,argument);
E_hybrid(1,:)=sum(Ekwh);
E_chiller(1)=sum(Ekwhmono);
E_tec(1)=sum(Ekwhtec);
E_opt(1)=sum(Eopt);
%%
[l,m]=size(LO);

[Ekwh , Ekwhmono, Ekwhtec, Eopt]=simulation(LO,argument);
E_hybrid(2,:)=sum(Ekwh);
E_chiller(2)=sum(Ekwhmono);
E_tec(2)=sum(Ekwhtec);
E_opt(2)=sum(Eopt);

%%
[l,m]=size(LR);
[Ekwh , Ekwhmono, Ekwhtec, Eopt]=simulation(LR,argument);
E_hybrid(3,:)=sum(Ekwh);
E_chiller(3)=sum(Ekwhmono);
E_tec(3)=sum(Ekwhtec);
E_opt(3)=sum(Eopt);
%%  

%y=[log(E_hybrid(:,1)) log(E_chiller')  log(E_tec')];
figure
y=[E_opt' E_hybrid(:,1) E_chiller'  E_tec' ];

bar(y)
set(gca,'FontSize',14);
legend('EhybridOpt','Ehybrid','Echiller','Etec');
xticklabels({'\it Drastic','\it Stable','\it Common'});
ylabel('Energy Consumption ( kWh )','FontSize',15);



