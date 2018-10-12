% efficiency of cooling with hybrid and real-time strategy
clear
close all
clc
load('divpattern.mat');  

data=LO;
[l,m]=size(data);

argument=struct('Tsafe',63.12,'Tstandard',50 ,'k1',36.286 , ...
  'b1',57.095,'k2',10,'b2',72,'threshold',0.5, 'cop_chiller',3.6, ...
'F',0.5/3600,'nTerval',3,'Terval',5*60,'activ',1, 'cpuJudge',0.5);

%%    test on water T
iseries=0;
E_hybrid=[];
E_chiller=[];
E_tec=[];
for i=1:8
    argument.Tstandard=44+i;
    iseries(i)=44+i;
[Ekwh , Ekwhmono, Ekwhtec, EhybridOpt]=simulation(data,argument);
E_hybrid(i,:)=sum(Ekwh);
E_chiller(i)=sum(Ekwhmono);
E_tec(i)=sum(Ekwhtec);
E_opt(i)=sum(EhybridOpt);
end
plot(iseries,E_hybrid(:,1),'-o','LineWidth',1 );
set(gca,'FontSize',16);

xlim([iseries(1) max(iseries)]);
hold on 
plot(iseries,E_chiller,'-^','LineWidth',1  );
hold on 
plot(iseries,E_tec,'-*','LineWidth',1  );

plot(iseries,E_opt,'-s','LineWidth',1 );
grid on 
xlabel('Water Temperature ( ^oC )','FontSize',18);
ylabel('Energy Consumption( kWh )','FontSize',18);
legend('Ehybrid','Echiller','Etec','EhybridOpt','Location','northwest');
% figure 
% plot(iseries,E_hybrid(:,1),'b-o',iseries,E_hybrid(:,2),'g--^',iseries,E_hybrid(:,3),'m--*','LineWidth',1 );
% set(gca,'FontSize',16);
% xlim([iseries(1) max(iseries)]);
% hold on
% xlabel('Water Temperature ( ^oC )','FontSize',18 );
% ylabel('Energy Consumed of \itCommon\rm( kWh )','FontSize',18);
% legend('Total Energy','Proportion of chiller','Proportion of TEC','Location','northwest');
%  

%% 

argument=struct('Tsafe',63.12,'Tstandard',50 ,'k1',36.286 , ...
  'b1',57.095,'k2',10,'b2',72,'threshold',0.5, 'cop_chiller',3.6, ...
'F',0.5/3600,'nTerval',3,'Terval',5*60,'activ',1, 'cpuJudge',0.5);
[Ekwh , Ekwhmono, Ekwhtec, EhybridOpt]=simulation(data,argument);

sumdata=sum(data,2);

x=[1:l];
figure
yyaxis left
plot(x,Ekwh(:,1),'b','LineWidth',0.9);
hold on
set(gca,'FontSize',16);
plot(x,Ekwh(:,3),'c','LineWidth',1.3);
plot(x,Ekwh(:,2),'g','LineWidth',1.2);

ylabel('Energy Consumption( kWh )','FontSize',18);
ylim([-5 120]);
yyaxis right
plot(x,sumdata,'LineWidth',1 );
ylim([0 600]);
ylabel('Aggregated CPU utilization','FontSize',18);
xlabel('Time ( every 5 minutes )');
legend('Total consumption','Proportion of Chiller','Proportion of TEC','CPU utilization','Location','northeast');
xlim([0 l]);
hold on


%% test on the number of one judgement interval


argument=struct('Tsafe',63.12,'Tstandard',50 ,'k1',36.286 , ...
  'b1',57.095,'k2',10,'b2',72,'threshold',0.5, 'cop_chiller',3.6, ...
'F',0.5/3600,'nTerval',3,'Terval',5*60,'activ',1, 'cpuJudge',0.5);

iseries=[];
E_hybrid=[];
E_chiller=[];
E_tec=[];
E_opt=[];
for i=1:11
    argument.nTerval=i+1;
        iseries(i)=5*(i+1);
[Ekwh , Ekwhmono, Ekwhtec,EhybridOpt]=simulation(data,argument);
E_hybrid(i,:)=sum(Ekwh);
E_chiller(i)=sum(Ekwhmono);
E_tec(i)=sum(Ekwhtec);
E_opt(i)=sum(EhybridOpt);
end
figure
plot(iseries,E_hybrid(:,1),'-o','LineWidth',1 );
hold on 
set(gca,'FontSize',16);
xlim([iseries(1) max(iseries)]);
%ylim([3300 6700]);
% plot(iseries,E_chiller,'-^','LineWidth',1 );
% plot(iseries,E_tec,'-*','LineWidth',1 );

plot(iseries,E_opt,'-s','LineWidth',1 );
grid on 
xlabel('Cooling Control Interval( minutes )','FontSize',18);
ylabel('Energy Consumption( kWh )','FontSize',18);
legend('Ehybrid', 'EhybridOpt','Location','northwest');


 %% test on cop of chiller
% 
% iseries=0;
% E_hybrid=[];
% E_chiller=[];
% E_tec=[];
% E_opt=[];
% for i=1:7
%     argument.cop_chiller=1+i;
%         iseries(i)=1+i;
% [Ekwh , Ekwhmono, Ekwhtec,EhybridOpt]=simulation(data,argument);
% E_hybrid(i,:)=sum(Ekwh);
% E_chiller(i)=sum(Ekwhmono);
% E_tec(i)=sum(Ekwhtec);
% E_opt(i)=sum(EhybridOpt);
% end
% %%
% plot(iseries,E_hybrid(:,1),'-o');
% hold on 
% plot(iseries,E_chiller,'-^');
% hold on 
% plot(iseries,E_tec,'-*');
% 
% plot(iseries,E_opt,'-s');
% grid on 
% xlabel('Value of COP of Chiller');
% ylabel('Energy Consumed of \itCommon\rm ( kWh )');
% legend('Ehybrid','Echiller','Etec','EhybridOpt','Location','northwest');

 %% test on the activ and cpujudge
 
 
argument=struct('Tsafe',63.12,'Tstandard',50 ,'k1',36.286 , ...
  'b1',57.095,'k2',10,'b2',72,'threshold',0.5, 'cop_chiller',3.6, ...
'F',0.5/3600,'nTerval',3,'Terval',5*60,'activ',1, 'cpuJudge',0.5);

iseries=0;
E_hybrid=[];
E_chiller=[];
E_tec=[];
E_opt=[];
for i=1:10
    argument.cpuJudge=0.1*i;
    iseries(i)=0.1*i;
    [Ekwh , Ekwhmono, Ekwhtec,EhybridOpt]=simulation(data,argument);
    E_hybrid(i,:)=sum(Ekwh);
    E_chiller(i)=sum(Ekwhmono);
    E_tec(i)=sum(Ekwhtec);
    E_opt(i)=sum(EhybridOpt);
end
% plot(iseries,E_hybrid(:,1),'-o','LineWidth',1 );
% hold on 
% set(gca,'FontSize',16);
% xlim([iseries(1) max(iseries)]);
% plot(iseries,E_chiller,'-^','LineWidth',1 );
% hold on 
% plot(iseries,E_tec,'-*','LineWidth',1 );
% 
% plot(iseries,E_opt,'-s','LineWidth',1 );
% grid on 
% xlabel('Threshold to Activate Chiller ','FontSize',18);
% ylabel('Energy Consumtion( kWh )','FontSize',18);
% legend('Ehybrid','Echiller','Etec','EhybridOpt','Location','northwest');
figure 
plot(iseries,E_hybrid(:,1),'b-o',iseries,E_hybrid(:,2),'g--^',iseries,E_hybrid(:,3),'m--*','LineWidth',1 );
hold on
set(gca,'FontSize',16);
xlim([iseries(1) max(iseries)]);
ylim([0 16000]);
xlabel('Threshold to Activate Chiller','FontSize',18);
ylabel('Energy Consumption( kWh )','FontSize',18);
legend('Total Energy','Proportion of Chiller','Proportion of TEC','Location','northwest');
