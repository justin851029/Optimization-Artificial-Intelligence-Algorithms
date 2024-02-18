function spp = compute_path_total_length_AMPM_show(bbb,load_limit)
global days node node2 depot neednode need_demand point_Capacity Bcar_load_limit Scar_load_limit 
global jobs a1 a2 a3 we bb cars_daily_cost y1 Vehicle_num Dist service_time 

first_node_in_bbb=find(bbb(1)==neednode);
last_node_in_bbb=find(bbb(max(size(bbb)))==neednode);
car_load_now=need_demand(first_node_in_bbb);
Total_dist=Dist(depot,bbb(1));
Delivery_node_seq=[depot bbb(1)];

for i=1:max(size(bbb))-1  

    node_next=find(bbb(i+1)==neednode); % location in neednode
    %pause
    %[car_load_now_AM  need_demand(node_next)];
    if car_load_now+need_demand(node_next)<=Bcar_load_limit
    %'111111111'
       car_load_now=car_load_now+need_demand(node_next);
       Total_dist=Total_dist+Dist(bbb(i),bbb(i+1))+service_time(node_next) ;  % add service time 
       Delivery_node_seq=[Delivery_node_seq   bbb(i+1)];
       %pause
    else
       %'22222222'
       car_load_now=need_demand(node_next);
       Total_dist=Total_dist+Dist(bbb(i),bbb(i+1))+service_time(node_next); % ;  
       Delivery_node_seq=[Delivery_node_seq   depot   bbb(i+1)];
       %pause
    end
end
'---------------------------------------'
Delivery_node_seq=[Delivery_node_seq depot]
%'--------3333-------'
%last_node_in_bbb
%depot
%Dist(last_node_in_bbb,depot)
%Total_dist
Total_dist=Total_dist+Dist(last_node_in_bbb,depot);
spp=Total_dist;

%pause