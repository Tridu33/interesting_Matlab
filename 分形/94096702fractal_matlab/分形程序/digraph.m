function digraph(file)
%DIGRAPH  Principal component analysis of text digraph frequency matrix.
%  DIGRAPH(filename)
%  Example
%     digraph('gettysburg.txt')

% Read entire file

fid = fopen(file);
txt = fread(fid);
fclose(fid);

% Convert to integers between 1 and 26

k = upper(char(txt)) - 'A' + 1;
k(k < 1 | k > 26) = [];

% Generate the digraph frequency matrix and compute its SVD

j = k([2:length(k) 1]);
A = full(sparse(k,j,1,26,26));
cnt = sum(A);
[U,S,V] = svd(A);

% Plot the second left and right singular vectors

shg
clf
s = 4/3*max(max(abs(U(:,2))),max(abs(V(:,2))));
axis(s*[-1 1 -1 1])
axis square
for i = 1:26
   if cnt(i) > 0
      text(U(i,2),V(i,2),char('A'+i-1))
   end
end
line([0 0],[-s s],'color','b')
line([-s s],[0 0],'color','b')
box
title(sprintf('%d characters',length(k)))
