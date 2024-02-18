% The program is for museum visiting routing problem (MVRP)  
% The objective is to minimize the makespan for rooms
% Groups 1-4 have to visit Rooms 1-4 (no selective rooms)

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
service_time=[t1 t1 t1 t1 t1      t1 t1 t1 t1 t1     t1 t1 t1 t1 t1   t1 t1 t1 t1 t1      t1 t1 t1 t1 t1   t1 t1 t1 t1 t1    t1 t1 t1 t1 t1       t2 t2 t2 t2 t2    t2 t2 t2 t2 t2    t2 t2 t2 t2 t2 ];    % service timeAM_node=neednode(time_window==1);
PM_node=neednode(time_window==2);
AMPM_node=neednode(time_window==3);
node=max(size(neednode));

jobs=110;   %   total nodes----------- change
Vehicle_num=2;  % number of cars can be used each day
%Bcar_load_limit=3243375/15;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 大車子(容量Capacity) 
%Scar_load_limit=3243375/30;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 小車子(容量Capacity) 
%y1=[4 1 4 1 4 1];
cycle_type=[
1	0	0	0	0	0	0	0	1	0	0	0	0	0	;
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
%cars_daily_cost=[Cc(1) Cc(2) Cc(1)+Cc(2) 2*Cc(1) 2*Cc(2)] ;% (C c C+c CC cc)   total cost of car for 5 options  
%point_Capacity=zeros(1,Total_points_in_Map);
%point_Capacity(1,depot)=0;

%for i=1:node
    %point_Capacity(1,neednode(i))=need_demand(i);
    
%end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 參數設定  Parameters                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
POP_size=20; % 初始族群   
gen=500;      % 最大演化代數 
qi=0.9;      % 複製後被挑選的比例 
Pc=0.7;      % 交配率 set number to run 0.96  crossover rate
Pm=0.3;      % mutation rate
Pc1=0.92;      % 交配率 set number to run 0.9 
Pm1=0.13;     % 
N=7;          % max number of individual to be cloned. 
n=ceil(POP_size/2);  % no. of best-matching cells taken for each Ag (Selection)　

Total_iter=1;
BB=[];  CC=zeros(Total_iter, jobs);   TTime=[]; Iter_list=[]; randall=[];

Total_iter_max=1; %<------------------------- (3) % 重複次數
while Total_iter<=Total_iter_max  
     best_obj_now=99999999999;
      Total_iter  
      Fitness=[];
      iter=1;
      s_stop=0;
      incumb=10^10;
      GBestAll = [];
      fGBestAll = [];
      RUNNET = 0;
      Matrix_iter_best_seq=[];
      Memory=[];
      best_sol=[];
      best=[];
      CPU_time1=cputime;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 　　                  (母體初始化+產生初始基因0101)　                  　 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Generation1=[];
for i=1:POP_size
      Generation1(i,:)=randperm(jobs); % <<<<<<<<< 1  is the first
end 
CPUtime_1=cputime;
randall(:,:,Total_iter)=Generation1;
while and(iter <= gen,s_stop<=200) %<--------------------- 若目標值1000沒改變則直接結束
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         評估(將0101解碼(aa)+算出適應值)                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1 : size(Generation1,1)
    aa= Generation1(i,:);
    Fitness(i) =HoleFit_Bath_AMPM(aa);  % 目標函數方程式
end

if min(Fitness)<best_obj_now
   % '-----xxx-----------'
   BB(Total_iter)=min(Fitness);
   i_now=find (min(Fitness)==Fitness);
   Best_seq_now=Generation1(i_now(1),:);
   best_obj_now=BB(Total_iter);
   %pause
end

[b, RI] = min(Fitness);
  for i=1:length(Fitness)
         x=min(Fitness)-Fitness(i);
    if x == 0
            [dddd,ABC]=sort(Generation1(i,:));
    end
  end  
  if incumb>b
       incumb=b;
       count=0;
  end
best=[best,b];
best_sol(iter,:)=min(best);
Matrix_iter_best_seq=[Matrix_iter_best_seq;Generation1(RI,:)];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 選擇/複製                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1>10
F1=(Fitness-min(Fitness))+0.01;
in=find(max(F1)==F1);
F1(in)=F1(in)*1.12;
norm_fit = F1/sum(F1);
selected = rand(length(Fitness),1);
sum_fit = 0;
for i=1:length(Fitness)
   sum_fit = sum_fit + norm_fit(i);
   index = find(selected<sum_fit);
   selected(index) = i*ones(size(index));
end
Generation1 = Generation1(selected,:);
Fitness=Fitness(selected);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  複製過程                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FIT = (Fitness - min(Fitness))./((max(Fitness)-min(Fitness))+0.0000001); % calculate the weight of each individual
[Dn,I] = sort(FIT');
n=ceil(length(FIT)/2);
Nc = floor(N-Dn(1:n,:)*N); %no. of clones to be generated
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Clone the Anti-body and improvement by using Genetic Operations)     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[n1,L1] = size(Generation1); [n,n2] = size(Nc);
CLONE = Generation1(I(1),:); % Maintenance of the fittest cell before maturation 
for i=1:n
   vones=ones(Nc(i),1);
   CLONE = [CLONE; vones * Generation1(I(i),:)];
end
k=size(CLONE,1);
if rem(k,2)~=0
   CLONE(k,:)=[];  % The number of strings must be an even number.
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 　　                       結束複製準備突變與交換                    　   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% Mating Pool 交配池 %
   Generation1 = Mate(CLONE);
% Crossover & Mutate 交叉&變異 %
   if incumb==b
       count=count+1;
   end
   if count<5
        Generation1 = Crossover3(Generation1,Pc1); % Single point xover
        Generation1 = Mutation(Generation1,Pm);
   else        
        Generation1 = xover(Generation1,Pc,aa);
        Generation1 = Crossover3(Generation1,Pc); % Single point xover
        Generation1 = Mutation(Generation1,Pm1);               
   end  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
% 　　　　                        再選擇過程                      　  　   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
Fitness=[];
for i=1:size(Generation1,1)
     Fitness(i)= HoleFit_Bath_AMPM (Generation1(i,:)); % 目標方程式 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       突變與交換後需要選擇幾個留做下一子代                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Dn,I] = sort(Fitness');
nR = round(qi*length(Fitness));  % qi is the % of re-selection from C
m = Generation1(I(1:nR),:);        % 1 clone for each Ag
D = Fitness(I(1:nR))';            % new affinities
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              消除相似性過高的子代                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ip = find(D >= mean(Fitness)); %%%%%% The criteria for eliminating the clones of antibody <<<<<<<<<
mean(Fitness);
length(Ip);
Da=D';
Ip=Ip';
if ~isempty(Ip);
   m(Ip,:)=[];
   D(Ip)=[];
end
   
Memory=[Memory;m];
Fitness=[];
for i=1:size(Memory,1);
    [D,I]=sort(Memory(i,:));
     D=D(:,I);  
       aa=Memory(i,:);
      Fitness(i) =  HoleFit_Bath_AMPM (aa);   % 目標方程式 
end
D1 = dist(Memory, Memory');
aux = triu(D1,1);  % simplify the D1 as an upper triangular matrix
[Is,Js] = find (aux==0); %  (aux>0 & aux<=0.05)   find(aux==0)  <-------  affinity set 
if ~isempty(Is)
   IJs=[Is,Js];
   id=find(Is<Js);
   ids=IJs(id,2);
   Memory(ids,:)=[];
end
Fitness=[];
if size(Memory,1)>POP_size
   for i=1:size(Memory,1)
      [D,I]=sort(Memory(i,:));
      D(:,I)=D;
       Fitness(i)  = HoleFit_Bath_AMPM (Memory(i,:));  % 目標方程式 
   end  
   [Dn,I] = sort(Fitness');
   Memory=Memory(I(1:POP_size),:);
   Fitness=Fitness(1:POP_size);
end
Generation1=Memory;

   if rem(iter,50)==0 % 顯示
      plot(best_sol(1:iter));
      min(best);
      pause(0.00000000001);
   end
   
    if abs(min(best(1:iter))-min(best(1:iter-1)))<0.000001
         s_stop=s_stop+1;
      else
         s_stop=0;
    end
      
      
    GBestAll = [GBestAll;ABC];
    fGBestAll = [fGBestAll;b];
    [fGBest, z] = min(fGBestAll);
    fGBest;
    fGBestAll(z);
    iter = iter + 1;
end

CPUtime_2=cputime;
 
time=CPUtime_2-CPU_time1;
Fitness=[];
for i=1:size(Memory,1)/10
    [D,I]=sort(Memory(i,:));
    D(:,I)=D;
    Fitness(i)    =  HoleFit_Bath_AMPM(aa);   % <-- must set the objective function  ********* (11)
 end
%fname= [ '_minGBest=' num2str(ABC) '_time=' num2str(time)];
% csvwrite([fname 'sort.csv'],GBestAll(z,:));
%fname= [ '_minGBest=' num2str(b) '_time=' num2str(time)];
% csvwrite([fname 'fit.csv'],min(fGBestAll));
alltime=[alltime;time];%記錄所有執行的時間
   
xyz=[xyz;min(fGBestAll)];
%fname= [ 'AllfGBest_time=' num2str(time) ];
%csvwrite([fname 'All.csv'],xyz);
%fname= [ 'Alltime=' num2str(time) ];
%csvwrite([fname 'All.csv'],alltime);
'%%%%%%%%%%%%%%%%%%%'

BB(Total_iter)=min(best);    
[b, RI] = min(best);
CC(Total_iter,:)=Best_seq_now;
TTime(Total_iter)=time;
Iter_list(Total_iter)=iter-1-s_stop;
Total_iter=Total_iter+1;
end

BB
CC
Iter_list
TTime


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            儲存結果為excell檔(最佳解,基因,時間)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fname= [ 'Allans-Best_ans=' num2str(min(BB)) ];
csvwrite([fname '.csv'],BB);
fname= [ 'Allaa-Best_aa=' num2str(min(BB)) ];
csvwrite([fname '.csv'],CC);
fname= [ 'AllRun_time=' num2str(min(BB)) ];
csvwrite([fname '.csv'],TTime);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  收集    收集    收集    收集    收集  %%%%%%%%%%%%%%%%%%%%%'

disp('-----IA-Bath-----')
[penalty t1 t2]

'-------------obj----min-avg-max-stdev----'
BB
[min(BB) mean(BB)  max(BB) std(BB)]

'---------------iter---min-avg-max-stdev------------'
Iter_list
[min(Iter_list) mean(Iter_list) max(Iter_list) std(Iter_list)]  

'-------------CPU----min-avg-max-stdev----'
TTime
[min(TTime) mean(TTime) max(TTime) std(TTime)]

'-------------Sequence-for BB----'
CC

'----------------best sequence------------------------'
ii_now=find (min(BB)==BB);
Best_seq_global=CC(ii_now(1),:)

'----------------best allocation of car for customers------------------------'
HoleFit_Bath_AMPM_show (Best_seq_global)






