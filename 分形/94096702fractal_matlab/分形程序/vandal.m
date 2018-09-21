function d = vandal(n)
% VANDAL  Symbolic Vandermonde matrix.
%    Exercise:
%    What does VANDAL(N) compute and how does it compute it?
%    Under what conditions on X is the matrix VANDER(X) nonsingular?

x = sym(ones(n,1));
for i = 1:n
   x(i) = sym(['x' int2str(i)]);
end

V = sym(ones(n,n));
for j = 2:n
   V(:,j) = x.*V(:,j-1);
end

pretty(V)

d = 1;
for k = 1:n-1
   for i = k+1:n
      V(i,:) = V(i,:) - V(k,:);
      p = V(i,k+1);
      d = d*p;
      V(i,:) = simplify(V(i,:)/p);
   end
end
