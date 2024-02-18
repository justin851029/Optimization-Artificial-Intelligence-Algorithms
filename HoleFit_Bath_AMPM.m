function spp = HoleFit_ice_cream_AMPM (aa)            
global days node node2 depot neednode need_demand point_Capacity Bcar_load_limit Scar_load_limit 
global jobs a1 a2 a3 we bb cars_daily_cost y1 Vehicle_num  AM_node PM_node AMPM_node  penalty cycle_type time_window node_type
global Car1_AM_matrix Car1_PM_matrix Car2_AM_matrix Car2_PM_matrix
% a1=[1 1 1 1 1 1]; %123
% a2=[1 0 1 0 1 0;0 1 0 1 0 1]; %4 5 6 7 8 9 10
% a3=[1 0 0 1 0 0;0 1 0 0 1 0 ;0 0 1 0 0 1];%11 12 13 14 15 16
 %aa=[ 1 2 25 22 17 41 24 37 28 35 31 23 48 29 26 21 16 12 8 39 13 19 32 7 18 6 27 34 38 15 5 11 42 36 40 46 43 30 20 47 9 3 4 14 44 45 10 33]
%aa=[78 39 21 38 65 53 69 10 7 91 94 83 1 56 44 9 33 31 46 23 15 77 67 60 63 71 100 57 14 26 61 104 98 28 40 108 48 73 24 5 18 17 82 2 11 36 16 62 59 42 72 35 32 81 55 25 47 99 109 107 92 70 89 4 96 19 80 20 76 85 101 110 106 52 90 45 64 102 41 75 97 3 30 58 68 37 93 88 66 86 22 12 8 54 50 29 79 74 84 43 34 103 51 87 105 13 6 95 27 49]

Capacity_down_time=0;
Capacity1=zeros(2*days,node2);
%cycle_type
%aa=[24	92	31	8	42	21	99	91	25	55	85	15	50	51	27	30	94	39	26	106	2	88	87	29	97	68	95	53	49	72	104	69	67	22	75	57	44	16	19	36	102	48	105	10	78	33	7	35	98	4	61	46	103	83	38	70	54	77	74	107	101	60	28	3	11	80	64	66	96	40	43	52	79	56	76	47	71	90	14	32	108	6	12	81	23	65	9	63	45	41	73	37	59	58	89	84	5	20	93	62	18	13	34	17	1	82	86	100	]

dd=zeros(days,node2);
D_path_AM_C1=[]; D_path_AM_C2=[];  % Node sequence for node in PM (Car1 and Car2)
D_path_PM_C1=[]; D_path_PM_C2=[];
N_seq=[1:jobs];  % Normal sequence 1 2 3 4 ....
Car1_AM_matrix=zeros(50,14); Car1_PM_matrix=Car1_AM_matrix;Car2_AM_matrix=Car1_AM_matrix;Car2_PM_matrix=Car1_AM_matrix;
J_index_now=1;
 
%'--------------Compute cycle and car type for each user------'
for i=1:50
   % '---------------'
   % i
    ss11=sum(((node_type(i)==[1 2]).*[10 20]))   ;
    ss12=sum(((time_window(i)==[1 2 3]).*[1 2 3]));
    case_no=ss11+ss12;
    %pause
        j= J_index_now ;% the index of used random number to select (cycle) or (car type) or (AM/PM) 
        [a1 a2]=sort(aa(j:j+13))  ;
        selected_cycle=cycle_type(find(aa(j)==a1),:);%aa(j) %find(aa(j)==a1) using the 1st-14th random numbers
        switch case_no % 6 possible cases   11 12 13 for type 1 of AM PM AM/PM, 21 22 23 for type 2 of AM PM AM/PM
           case {11}  % type 1  AM
             %  '11'
                selected_car=(aa(j+1)<aa(j+2))+(aa(j+1)>aa(j+2))*2 ; % select car 1 or car 2 for type 1 patient using the 2nd-3rd random numbers
                switch selected_car
                    case {1}
             %           '=======Car1_AM_matrix========'
                        ww1=find (1==selected_cycle);
                        selected_cycle(ww1)=aa(j:j+1);
                        Car1_AM_matrix(i,:)=selected_cycle;
                    case {2}
              %          '=======Car2_AM_matrix 11 PM========'
                        ww1=find (1==selected_cycle);
                        selected_cycle(ww1)=aa(j:j+1);
                        Car2_AM_matrix(i,:)=selected_cycle;
                end
                J_index_now=J_index_now+2;
                %pause
           case {12}  % type 1  PM
              % '12'
                selected_car=(aa(j+1)<aa(j+2))+(aa(j+1)>aa(j+2))*2 ; % select car 1 or car 2 for type 1 patient using the 2nd-3rd random numbers
                switch selected_car
                    case {1}
                      %  '=======Car1_PM_matrix========'
                        ww1=find (1==selected_cycle);
                        selected_cycle(ww1)=aa(j:j+1);
                        Car1_PM_matrix(i,:)=selected_cycle;
                    case {2}
                      %  '=======Car2_PM_matrix 12 PM========'
                        ww1=find (1==selected_cycle);
                        selected_cycle(ww1)=aa(j:j+1);
                        Car2_PM_matrix(i,:)=selected_cycle;
                end
                J_index_now=J_index_now+2;
                %pause
           case {13}  % type 1  AM/PM
              % '13'
                selected_car=(aa(j+1)<aa(j+2))+(aa(j+1)>aa(j+2))*2; % select car using the 2nd-3rd random numbers
                sss1=(aa(j+2)<aa(j+3))+(aa(j+2)>aa(j+3))*2 ;% select AM/PM using the 3rd-4th random numbers
                switch selected_car;
                    case {1}
                        ww1=find (1==selected_cycle);
                        selected_cycle(ww1)=aa(j:j+1);
                        if sss1==1  % AM 
                          % '=======Car1_AM_matrix========'
                           Car1_AM_matrix(i,:)=selected_cycle;
                        else        % PM
                          %  '=======Car1 PM_matrix========'
                           Car1_PM_matrix(i,:)=selected_cycle;
                        end
                    case {2}
                        ww1=find (1==selected_cycle);
                        selected_cycle(ww1)=aa(j:j+1);
                        if sss1==1  % AM 
                        %'=======Car2_AM_matrix========'
                           Car2_AM_matrix(i,:)=selected_cycle;
                        else
                       % '=======Car2_PM_matrix========'
                           Car2_PM_matrix(i,:)=selected_cycle;
                        end
                end
                J_index_now=J_index_now+3;
                %pause
% --------------------------------------------------------------------------------------------------------       
            case {21}  % type 1  AM
              % '21'
              % '=======Car2_AM_matrix 11 PM========'
                ww1=find (1==selected_cycle);
                selected_cycle(ww1)=aa(j:j+1);
                Car2_AM_matrix(i,:)=selected_cycle;
                J_index_now=J_index_now+1;
                %pause
           case {22}  % type 1  PM
              % '22'
               %  '=======Car2_PM_matrix 12 PM========'
                ww1=find (1==selected_cycle);
                selected_cycle(ww1)=aa(j:j+1);
                Car2_PM_matrix(i,:)=selected_cycle;
                J_index_now=J_index_now+1;
                %pause
           case {23}  % type 1  AM/PM
             %  '23'
                sss1=(aa(j+1)<aa(j+2))+(aa(j+1)>aa(j+2))*2; % select AM/PM using the  2nd-3rd random numbers
                ww1=find (1==selected_cycle);
                selected_cycle(ww1)=aa(j:j+1);
                if sss1==1  % AM 
              %     '=======Car2_AM_matrix========'
                   Car2_AM_matrix(i,:)=selected_cycle;
                else        % PM
              %     '=======Car2 PM_matrix========'
                   Car2_PM_matrix(i,:)=selected_cycle;
                end
          J_index_now=J_index_now+2;
                %pause               
        end
       % pause
end

%Car1_AM_matrix
%Car1_PM_matrix
%Car2_AM_matrix
%Car2_PM_matrix
%pause

OBJ_AMPM_C1=zeros(1,14);OBJ_AMPM_C2=zeros(1,14);
Path_AM_C1_list=[]; Path_PM_C1_list=[]; Path_AM_C2_list=[]; Path_PM_C2_list=[]; 

for i=1:14
    %%'--------------day-------Compute routing distance------------------------------------------'
    %i
    Path_AM_C1=[];Path_PM_C1=[];Path_AM_C2=[];Path_PM_C2=[];
    
    %'======= Car 1======'
    [bb1 bb2]=sort(Car1_AM_matrix); 
    MAT_temp=Car1_AM_matrix(:,i); bb1_temp=bb1(:,i);
    Path_AM_C1_temp=bb1_temp(find(bb1_temp));
    C1_AM_not_empty=~isempty(Path_AM_C1_temp);
    
    if C1_AM_not_empty
        %'==AM==='
       for j=1:max(size(Path_AM_C1_temp))
           Path_AM_C1=[Path_AM_C1 neednode(find(Path_AM_C1_temp(j)==MAT_temp))];
       end
       Length_AM_C1=compute_path_total_length_AMPM(Path_AM_C1);
       Path_AM_C1_list=[Path_AM_C1_list 0 Path_AM_C1];
    else
       Path_AM_C1_list=[Path_AM_C1_list 999];
    end
    
    [bb1 bb2]=sort(Car1_PM_matrix); 
    MAT_temp=Car1_PM_matrix(:,i); bb1_temp=bb1(:,i);
    Path_PM_C1_temp=bb1_temp(find(bb1_temp));
    C1_PM_not_empty=~isempty(Path_PM_C1_temp);
    
    if C1_PM_not_empty
        %'==PM=='
       for j=1:max(size(Path_PM_C1_temp))
           Path_PM_C1=[Path_PM_C1 neednode(find(Path_PM_C1_temp(j)==MAT_temp))];
       end
       Length_PM_C1=compute_path_total_length_AMPM(Path_PM_C1);
       Path_PM_C1_list=[Path_PM_C1_list 0 Path_PM_C1];
    else
       Path_PM_C1_list=[Path_PM_C1_list 999];
    end
           
    if (C1_AM_not_empty) | (C1_PM_not_empty)  % OR function
       Length_AMPM_C1=compute_path_total_length_AMPM([Path_AM_C1 Path_PM_C1]);
       pp1=0;pp2=0;
       if C1_AM_not_empty
          pp1=penalty*(Length_AM_C1>240)*(Length_AM_C1-240);
       end
        if C1_PM_not_empty
          pp2=penalty*(Length_PM_C1>240)*(Length_PM_C1-240);
       end
       OBJ_AMPM_C1(1,i)=Length_AMPM_C1+pp1+pp2;     
    end

    %'======= Car 2======'
    [bb1 bb2]=sort(Car2_AM_matrix); 
    MAT_temp=Car2_AM_matrix(:,i); bb1_temp=bb1(:,i);
    Path_AM_C2_temp=bb1_temp(find(bb1_temp));
    C2_AM_not_empty=~isempty(Path_AM_C2_temp);
    if C2_AM_not_empty
        %'==AM==='
       for j=1:max(size(Path_AM_C2_temp))
           Path_AM_C2=[Path_AM_C2 neednode(find(Path_AM_C2_temp(j)==MAT_temp))];
       end
       Length_AM_C2=compute_path_total_length_AMPM(Path_AM_C2);
       Path_AM_C2_list=[Path_AM_C2_list 0 Path_AM_C2];
    else
       Path_AM_C2_list=[Path_AM_C2_list 999];
    end
    
    [bb1 bb2]=sort(Car2_PM_matrix); 
    MAT_temp=Car2_PM_matrix(:,i); bb1_temp=bb1(:,i);
    Path_PM_C2_temp=bb1_temp(find(bb1_temp));
    C2_PM_not_empty=~isempty(Path_PM_C2_temp);
    if C2_PM_not_empty
        %'==PM=='
       for j=1:max(size(Path_PM_C2_temp))
           Path_PM_C2=[Path_PM_C2 neednode(find(Path_PM_C2_temp(j)==MAT_temp))];
       end
       Length_PM_C2=compute_path_total_length_AMPM(Path_PM_C2);
       Path_PM_C2_list=[Path_PM_C2_list 0 Path_PM_C2];
    else
       Path_PM_C2_list=[Path_PM_C2_list 999];
    end
           
    if (C2_AM_not_empty) | (C2_PM_not_empty)  % OR function
       Length_AMPM_C2=compute_path_total_length_AMPM([Path_AM_C2 Path_PM_C2]);
       pp1=0;pp2=0;
       if C2_AM_not_empty
          pp1=penalty*(Length_AM_C2>240)*(Length_AM_C2-240);
       end
        if C2_PM_not_empty
          pp2=penalty*(Length_PM_C2>240)*(Length_PM_C2-240);
       end
       OBJ_AMPM_C2(1,i)=Length_AMPM_C2+pp1+pp2;    
    end
end

%Path_AM_C1_list
%Path_PM_C1_list
%Path_AM_C2_list
%Path_PM_C2_list


%OBJ_AMPM_C1
%OBJ_AMPM_C2
spp =sum(OBJ_AMPM_C1+OBJ_AMPM_C2);
%pause







