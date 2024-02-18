function [new_gen,sites] = Crossover3(old_gen,Pc)
% load AA;
% old_gen=AA;
[Is Js]=size(old_gen);

% old_gen=old_gen(1:2,:);
% 'Crossove_3'
temp=[];
new_gen=[];
new_gen_temp=[];

for h=1:2
A=randperm(Is);
old_gen=old_gen(A,:);
for i=1:2:Is
    temp=[];
    for k=1:Js
        if old_gen(i,k)== old_gen(i+1,k)
            new_gen_temp=[new_gen_temp,old_gen(i,k)];
        else
            if k==1
                if rand<Pc
                    new_gen_temp=[new_gen_temp,old_gen(i,k)];
                else
                    new_gen_temp=[new_gen_temp,old_gen(i+1,k)];
                    temp=[temp,old_gen(i,k)];
                end
            else
                if rand<Pc
                    N1=find(new_gen_temp==old_gen(i,k));
                    if isempty(N1)
                        new_gen_temp=[new_gen_temp,old_gen(i,k)];
                    else
                        N1=find(new_gen_temp==old_gen(i+1,k));
                        if isempty(N1)
                            new_gen_temp=[new_gen_temp,old_gen(i+1,k)];
                        else
                            while ~isempty(find(temp(1)==new_gen_temp))
                                temp(1)=[];
                            end
                            new_gen_temp=[new_gen_temp,temp(1)];    
                            temp(1)=[];
                        end
                    end
                else
                    N1=find(new_gen_temp==old_gen(i,k));
                    if isempty(N1)
                        temp=[temp,old_gen(i,k)];
                    end
                    
                    N1=find(new_gen_temp==old_gen(i+1,k));
                    if isempty(N1)
                        new_gen_temp=[new_gen_temp,old_gen(i+1,k)];
                    else
                        while ~isempty(find(temp(1)==new_gen_temp))
                            temp(1)=[];
                        end
                        new_gen_temp=[new_gen_temp,temp(1)];    
                        temp(1)=[];
                        
                        
                    end
                end                    
            end
        end
    end
    new_gen=[new_gen;new_gen_temp];
    new_gen_temp=[];
end

end
% 'end_crossover'