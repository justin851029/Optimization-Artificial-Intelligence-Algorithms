
function [fxmax, xmax, Swarm, history] = PSO(psoOptions)

clc
clear all
xyz=[];
alltime=[];% 清除記錄所有執行的時間  
%定義全域變數
global  Total_points_in_Map  days  node node2 we depot neednode point_Capacity Bcar_load_limit Scar_load_limit need_demand load_limit
global   a1 a2 a3 jobs  Dist cars_daily_cost y1 time_window Vehicle_num service_time AM_node PM_node AMPM_node penalty node_type cycle_type time_window
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 題目資訊                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Total_points_in_Map=103;
Dist_103(Total_points_in_Map);
Dist=Dist/1;  %  Wehgited distance
%days=6;  % AM PM
node2=50;  % PROBLEM HERE
depot=44;   % 醫院中心 depot
%a1=[1 1 1 1 1 1]; %123    (6 points)   
%a2=[1 0 1 0 1 0;0 1 0 1 0 1]; %4 5 6 7 8 9 10     (9 points) 

penalty=5
t1=1;     % 第一類服務時間
t2=2;   % 第二類服務時間
[t1 t2]
we=[1 0];    
% weight for obj1 obj2
% weight for obj1 obj2
%            [1  2   3  4  5    6  7  8 9  10   11  12  13 14 15   16 17 18 19 20  21 22 23 24 25   26 27 28 29 30    31 32 33 34 35    36 37 38  39 40   41 42 43 44 45   46 47 48 49 50]; 
%neednode   =[1  2   3  4  5    6  7  8 9  10   11  12  13 14 15   16 17 18 19 20  21 22 23 24 25   26 27 28 29 30    31 32  33 34 35   36 37 38  39 40   41 42 43 44 45   46 47 48 49 50];  % demand nodes   
neednode=    [54 66 98 101 8       27 5 14 42 78   59 53 77 73 24   70 37 12  7 11       60  3 83 99 35   25 88 47 65 10    95 20 51 69 103    62 92 15 100 63  48 90 86 21 93   64 68 18 75 85]
node_type   =[1 1 1 1 1            1 1 1 1  1        1  1  1  1  1     1  1  1  1  1       1  1  1  1  1    1  1  1  1  1     1  1  1  1  1       2  2  2  2  2      2  2  2  2  2    2  2  2  2  2];
time_window =[1 1 1 1 1            1 1 1 1  1        2  2  2  2  2     2  2  2  2  2       2  2  2  2  2    2  2  2  2  2     3  3  3  3  3       1  1  1  1  1      2  2  2  2  2    3  3  3  3  3 ];   % 1=AM, 2=PM, 3=AM/PM
service_time=[t1 t1 t1 t1 t1      t1 t1 t1 t1 t1     t1 t1 t1 t1 t1   t1 t1 t1 t1 t1      t1 t1 t1 t1 t1   t1 t1 t1 t1 t1    t1 t1 t1 t1 t1       t2 t2 t2 t2 t2    t2 t2 t2 t2 t2    t2 t2 t2 t2 t2 ];   % service time
AM_node=neednode(time_window==1);
PM_node=neednode(time_window==2);
AMPM_node=neednode(time_window==3);
node=max(size(neednode));

jobs=110;   %   total nodes----------- change
Vehicle_num=2;  % number of cars can be used each day
%Bcar_load_limit=3243375/15;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 大車子(容量Capacity) 
%Scar_load_limit=3243375/30;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% 小車子(容量Capacity) 
%y1=[4 1 4 1 4 1];
cycle_type=[1	0	0	0	0	0	0	0	1	0	0	0	0	0	;
1	0	0	0	0	0	0	0	0	1	0	0	0	0	;
1	0	0	0	0	0	0	0	0	0	1	0	0	0	;
1	0	0	0	0	0	0	0	0	0	0	1	0	0	;
0	1	0	0	0	0	0	0	0	1	0	0	0	0	;
0	1	0	0	0	0	0	0	0	0	1	0	0	0	;
0	1	0	0	0	0	0	0	0	0	0	1	0	0	;
0	1	0	0	0	0	0	0	0	0	0	0	1	0	;
0	0	1	0	0	0	0	0	0	0	1	0	0	0	;
0	0	1	0	0	0	0	0	0	0	0	1	0	0	;
0	0	1	0	0	0	0	0	0	0	0	0	1	0	;
0	0	1	0	0	0	0	0	0	0	0	0	0	1	;
0	0	0	1	0	0	0	0	0	0	0	1	0	0	;
0	0	0	1	0	0	0	0	0	0	0	0	1	0	;
0	0	0	1	0	0	0	0	0	0	0	0	0	1	;
0	0	0	0	1	0	0	0	0	0	0	0	1	0	;
0	0	0	0	1	0	0	0	0	0	0	0	0	1	;
0	0	0	0	0	1	0	0	0	0	0	0	0	1	];

%==========================================================================
%                               參數設定
%==========================================================================
BB=[];
BB2=[];
alltime=[];
Iter_list=[];
Total_iteration=2; % 重複次數
OPT1=zeros(Total_iteration,jobs);

%alpha=[1 0 0]; %選擇三個目標 1為最小化總時間 2為團體參觀最長時間-最短時間 3為最小化團相加時間 

%==========================================================================
%                       程式開始時間
%==========================================================================
psoOptions = get_psoOptions;
SwarmSize = psoOptions.Vars.SwarmSize;
rand_all=zeros(SwarmSize,psoOptions.Vars.Dim,Total_iteration);

for iii=1:Total_iteration
    best_obj_now=99999999999;
    
    Now_iter=iii

CPU_time1=cputime;
if nargin == 0
    psoOptions = get_psoOptions;
end

s_stop=0;
GBestAll = [];
fGBestAll = [];
kkkkk=0;
jump=0;

% Initializing variables
best_fGBest=[];
iter = 0;   % Iterations' counter

% lipa30b

%==========================================================================
%           　　　　　　　　　　初始粒子和速度                  
%==========================================================================

SwarmSize = psoOptions.Vars.SwarmSize;
Swarm=[];
for i=1 : SwarmSize
    Swarm(i,:)=randperm((jobs));
end

VStep = rand(SwarmSize,psoOptions.Vars.Dim);
%VStep = TEN_FIRST_RAND(iii);
rand_all(:,:,iii)=VStep;
%VStep = PP();

%==========================================================================
%                     評估計算fit
%==========================================================================
fSwarm = [];

for i=1:size(Swarm,1)
    fSwarm(i)=HoleFit_Bath_AMPM (Swarm(i,:)); %　目標函數副程式
end

% Initializing the Best positions matrix and
% the corresponding function values
PBest = Swarm;  %每個粒都一個PBest
fPBest = fSwarm; % fSwarm為fit 

% Finding best particle in initial population
[fGBest, g] = min(fSwarm); %取最小的fit
%lastbpf = fGBest;  目前沒有用到
Best = Swarm(g,:); %Used to keep track of the Best particle ever 找到Swarm最小fit的位置
fBest = fGBest; %fGBest 為最小fit

%==========================================================================
%                              顯示標註名稱
%==========================================================================
if psoOptions.Disp.Interval & (rem(iter, psoOptions.Disp.Interval) == 0)
    %disp(sprintf('Iterations\t\tfGBes'));
end

%==========================================================================
%              PSO演化流程(演化各粒子的位置與速度)
%==========================================================================
while and(iter <= psoOptions.Vars.Iterations,s_stop<=300) %<--------------------- 若目標值200沒改變則直接結束 要改)
    iter = iter+1;  
    
    %%%%%%%%%%%%%%%%%
    % The PLAIN PSO %
    
    % Set GBest
    A = repmat(Swarm(g,:), SwarmSize, 1); %A = GBest. repmat(X, m, n) repeats the matrix X in m rows by n columns.
    
    % Generate Random Numbers
    R1 = rand(SwarmSize, psoOptions.Vars.Dim);
    R2 = rand(SwarmSize, psoOptions.Vars.Dim);
    
    % Calculate Velocity
    %VStep = 0.729*VStep + psoOptions.SParams.c1*R1.*(PBest-Swarm) + psoOptions.SParams.c2*R2.*(A-Swarm);
    VStep = 1*VStep + psoOptions.SParams.c1*R1.*(PBest-Swarm) + psoOptions.SParams.c2*R2.*(A-Swarm);
    
    % Apply Vmax Operator for v > Vmax
    changeRows = VStep > psoOptions.SParams.Vmax;
    VStep(find(changeRows)) = psoOptions.SParams.Vmax;
    
    % Apply Vmax Operator for v < -Vmax
    changeRows = VStep < -psoOptions.SParams.Vmax;
    VStep(find(changeRows)) = -psoOptions.SParams.Vmax;  
    Swarm = Swarm + VStep;
    for  i = 1: SwarmSize
        %Swarm(i,:) =(I - min(I))./((max(I)-min(I))+0.0000001);
        Swarm(i,:) =(Swarm(i,:) - min(Swarm(i,:)))./(max(Swarm(i,:))-min(Swarm(i,:))+0.0000001);
    end
    
    for x = 1:SwarmSize
        [Dn,I]= sort(Swarm(x,:));
        [vvv,vv]=sort(I);
        Swarm(x,:)=vv;
    end
     
    %%%	交換程式碼
    temp2 = []; %用來存所有交換的fit
    temp3 = []; %用來存所有交換的機器排序
	KK = 0;
    kkk=0;
    kkkk=0;
    
	if rem(iter,iter) == 0
        changerow =  (min(fGBestAll) == fGBestAll);
        if sum(changerow) == 100
            KK=1;
            elseif sum(changerow)>=100
                KK=2;         
        end
    end

%==========================================================================
%                  更新粒子後再評估
%==========================================================================
for i=1:size(Swarm,1)
    fSwarm(i)=HoleFit_Bath_AMPM (Swarm(i,:));%<<<<<<<<<<<<<<<<<<<<<<<<<<<<<   (改)  目標函數副程式
end

if min(fSwarm)<best_obj_now
   % '-----xxx-----------'
   BB(iii)=min(fSwarm);
   i_now=find (min(fSwarm)==fSwarm);
   Best_seq_now=Swarm(i_now(1),:);
   best_obj_now=BB(iii);
   %pause
end

[fGBest, z] = min(fSwarm);
% Updating the best position for each particle
changeRows = fSwarm < fPBest; %因為最小化問題所以fSwarm要小於
fPBest(find(changeRows)) = fSwarm(find(changeRows));
PBest(find(changeRows), :) = Swarm(find(changeRows), :);
    
%==========================================================================
%                      產生收斂圖
%==========================================================================    
    % Updating index g 
if fGBest > min(fPBest)
   [fGBest, g] = min(fPBest);
end

if abs(min(best_fGBest)-fGBest)<0.000001
   s_stop=s_stop+1;
else
s_stop=0;
end

best_fGBest=[best_fGBest, fGBest];
    
    %%OUTPUT%%
if psoOptions.Disp.Interval & (rem(iter, psoOptions.Disp.Interval) == 0)
    %disp(sprintf('%4d\t\t\t%.8g\t\t\t%2d', iter, fGBest,Swarm(z,:))); %    '%4d\t\t\t%.5g'
    dd=Swarm(z,:);
    plot(best_fGBest);
    pause(0.0000001);
end
           
GBestAll = [GBestAll;Swarm(z,:)];
fGBestAll = [fGBestAll;fGBest];
end

%==========================================================================
%              結束pso演化流程(紀錄最佳解)
%==========================================================================
CPUtime_2=cputime;
time=CPUtime_2-CPU_time1;
OPT1(iii,:)=Best_seq_now;            
  
%==========================================================================
%                          紀錄
%==========================================================================
%BB = [BB;fGBest]; %記錄執行的最佳解
alltime=[alltime;time];%記錄所有執行的時間
Iter_list(iii)=iter-s_stop;
disp(sprintf('%0.4f\t',time));
%[fxmax, b] = min(fPBest);
%xmax(iii,:) = PBest(b, :);
%BB2(iii,:)=HoleFit_Bath_AMPM (OPT1(iii,:));%%%
disp(sprintf('%0.8f\t',min(fGBest)));
iter   %<<<<<<<<<<< 總共跑的代數(包含設的幾代沒變就停) 也是CPU完成時間
end
'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  收集    收集    收集    收集    收集  %%%%%%%%%%%%%%%%%%%%%'
disp('-----PSO_Bath-----')
[penalty t1 t2]

'-------------obj----min-avg-max-stdev----'
BB
[min(BB) mean(BB)  max(BB) std(BB)]

'---------------iter---min-avg-max-stdev------------'
Iter_list
[min(Iter_list) mean(Iter_list) max(Iter_list) std(Iter_list)]  

'-------------CPU----min-avg-max-stdev----'
alltime'
[min(alltime') mean(alltime') max(alltime') std(alltime')]

'-------------Sequence-for BB----'
OPT1

'----------------best sequence ------------------------'
ii_now=find (min(BB)==BB);
Best_seq_global=OPT1(ii_now(1),:)

'----------------best allocation of car for customers------------------------'
HoleFit_Bath_AMPM_show (Best_seq_global)


