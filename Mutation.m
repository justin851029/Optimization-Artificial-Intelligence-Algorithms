function [new_gen,mutated] = Mutation(old_gen,Pm)
%MUTATE Changes a gene of the OLD_GEN with probability Pm.
%	[NEW_GEN,MUTATED] = MUTATE(OLD_GEN,Pm) performs random
%       mutation on the population OLD_POP.  Each gene of each
%       individual of the population can mutate independently
%       with probability Pm.  Genes are assumed possess boolean
%       alleles.  MUTATED contains the indices of the mutated genes.

% 'motation-start'
lchrom = size(old_gen,1);
mutated = find(rand(lchrom,1)<Pm);
new_gen = old_gen;
if ~isempty(mutated)
   for i=1:length(mutated)
      new_gen(mutated(i),:)=swap(old_gen(mutated(i),:));
   end
end
% 'motation_end'
% mutated = find(rand(size(old_gen))<Pm);
% new_gen = old_gen;
% new_gen(mutated) = 1-old_gen(mutated);

% end mutate

