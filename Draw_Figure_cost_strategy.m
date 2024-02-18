
Car_15_combination_6_days=[
1	1	1	1	1	1	; %1-------------
2	2	2	2	2	2	; %2-------------
3	3	3	3	3	3	; %3
4	4	4	4	4	4	; %4
5	5	5	5	5	5	; %5
1	2	1	2	1	2	; %6-------------
1	3	1	3	1	3	; %7
1	4	1	4	1	4	; %8
1	5	1	5	1	5	; %9
2	3	2	3	2	3	; %10
2	4	2	4	2	4	; %11
2	5	2	5	2	5	; %12
3	4	3	4	3	4	; %13
3	5	3	5	3	5	; %14
4	5	4	5	4	5	]%15

%Dist_6_days=[428.4	444.687	626.827	522.899	461.664	647.45	19	78.9	450.5875	525.102	568.36	526.9325	637.5185	493.062	574.7045]
Dist_6_days=[511.05	809.68	587.71	541.13	824.97	608.15	524.85	520.01	617.28	652.86	619.01	806.09	561.76	684.99	640.92]

B_Cost=200; %Basic_Cost 200
G_Cost=10;  % gap of cost e.g., gap=10, then 200,190,180,170,...

Cost_car=[B_Cost+10  B_Cost+10]
Strategy=[]; %(C c C+c CC cc) 
Total_obj_Fig=zeros(20,20);
for i=1:20
    CS=Cost_car(1)-i*G_Cost;  % cost of big car
    for j=1:20
        CB=Cost_car(2)-j*G_Cost ;
        [i j CB CS];
        %pause
        % cost of small car
%1      2     3          4         5         6          7           8          9           10         11        12          13         14          15
rr=[6*CB 6*CS 6*(CB+CS) 6*(2*CB) 6*(2*CS) 3*(CB+CS) 3*(2*CB+CS) 3*(CB+2*CB) 3*(CB+2*CS) 3*(CS+CB+CS) 3*(CS+2*CB) 3*(CS+2*CS) 3*(3*CB+CS) 3*(CB+3*CS) 3*(2*CB+2*CS)];
  rr2=Dist_6_days+rr ;        
        if CB>CS
           %[ 20-i+1  20-j+1]
           Total_obj_Fig(i,20-j+1)=find(min(rr2)==rr2);
           %pause
        end
    end
    Cost_car(2)=Cost_car(2);
end

Total_obj_Fig

size(Total_obj_Fig)
           



