function spp = Fit_TSP_length(bb)
global Dist days depot  
Air_time1=[];

%bb

for d=1:days*2
    sum_length=0;
    ff=bb(d,:);
    for i=1:sum(bb(d,:)>0)-1    
        if ff(1,i+1)~=0
          %  [ff(1,i) ff(1,i+1)]
          %  Dist(ff(1,i),ff(1,i+1))
           sum_length=sum_length+Dist(ff(1,i),ff(1,i+1));  % ¶ZÂ÷²Ö­p
        end
    end
    %[ff(1,i) depot]
    Air_time1= [Air_time1,  sum_length+Dist(ff(1,i+1),depot)];
    %pause
end
Air_time1=Air_time1(Air_time1~=0);
spp=( Air_time1);


        
    