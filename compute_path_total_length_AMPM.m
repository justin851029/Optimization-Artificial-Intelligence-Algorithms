function spp = compute_path_total_length_AMPM(bbb)
global days node node2 depot neednode need_demand point_Capacity Bcar_load_limit Scar_load_limit 
global jobs a1 a2 a3 we bb cars_daily_cost y1 Vehicle_num Dist service_time 

first_node_in_bbb=bbb(1);
last_node_in_bbb=bbb(max(size(bbb)));
%car_load_now=need_demand(first_node_in_bbb);
Total_dist=Dist(depot,bbb(1))+service_time(find(bbb(1)==neednode))*60;
Delivery_node_seq=[depot bbb(1)];

if max(size(bbb))>1
   for i=1:max(size(bbb))-1  
    %'111111111'
       Total_dist=Total_dist+Dist(bbb(i),bbb(i+1))+service_time(find(bbb(i+1)==neednode))*60;  % add service time 
       Delivery_node_seq=[Delivery_node_seq   bbb(i+1)];
   end
end

Delivery_node_seq=[Delivery_node_seq depot];
%'--------3333-------'
%last_node_in_bbb
%depot
%Dist(last_node_in_bbb,depot)
%Total_dist
Total_dist=Total_dist+Dist(last_node_in_bbb,depot);
spp=Total_dist;
%pause