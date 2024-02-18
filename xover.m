function [new_gen,sites] = XOVER(old_gen,Pc,sprand)
%XOVER  Creates a NEW_GEN from OLD_GEN using crossover.
%	[NEW_GEN,SITES] = XOVER(OLD_GEN,Pc) performs crossover
%       procreation on pairs of OLD_GEN with probability Pc.
%       Crossover SITES are chosen at random (re: there will be
%       half as many SITES as there are individuals.
%

lchrom = size(old_gen,2);
sites = ceil(rand(size(old_gen,1)/2,1)*(lchrom-1));
sites = sites.*(rand(size(sites))<Pc);
for i = 1:length(sites);
   k1=old_gen([2*i-1 2*i],1:sites(i));

   if sites(i)~=0
      index1=[];index2=[];
      for j=1:(sites(i))
         index1(j)=find(old_gen(2*i,:)==old_gen(2*i-1,j));
         index2(j)=find(old_gen(2*i-1,:)==old_gen(2*i,j));
      end
      k21=old_gen(2*i,:); k21(index1)=[];
      k22=old_gen(2*i-1,:); k22(index2)=[];
   else
      k21=old_gen(2*i-1,:);
      k22=old_gen(2*i,:);
   end
   k2=[k21;k22];
      
   new_gen([2*i-1 2*i],:) = [k1 k2];
end 

% end xover




%for i = 1:length(sites);
%   new_gen([2*i-1 2*i],:) = [old_gen([2*i-1 2*i],1:sites(i)) ...
%                             old_gen([2*i 2*i-1],sites(i)+1:lchrom)];
%end 

