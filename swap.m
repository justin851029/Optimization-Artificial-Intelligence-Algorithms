function [new_gen]= swap(old_gen)

temp=rand(size(old_gen));
maxi=find(temp==max(temp));
mini=find(temp==min(temp));
new_gen=old_gen;
new_gen(maxi)=old_gen(mini);
new_gen(mini)=old_gen(maxi);
