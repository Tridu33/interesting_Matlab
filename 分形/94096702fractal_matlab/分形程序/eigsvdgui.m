function D = eigsvdgui(A,job)
%EIGSVDGUI Demonstrate computation of matrix eigenvalues and singular values.
%   EIGSVDGUI shows three variants of the QR algorithm.
%
%   EIGSVDGUI(A) for square, nonsymmetric A, or EIGSVDGUI(A,'eig'), reduces
%   A to Hessenberg form, then applies a double-shift, eigenvalue-preserving
%   QR algorithm.  The result is the real Schur block upper triangular form,
%   with one-by-one diagonal blocks for real eigenvalues and two-by-two
%   diagonal blocks for pairs of complex eigenvalues.
%
%   EIGSVDGUI(A) for square, symmetric A, or EIGSVDGUI(A,'symm'), reduces
%   the symmetric part, (A+A')/2, to tridiagonal form, then applies a
%   single-shift, eigenvalue-preserving QR algorithm.  The result is
%   a diagonal matrix containing the eigenvalues, which are all real.
%
%   EIGSVDGUI(A) for rectangular A, or EIGSVDGUI(A,'svd'), reduces A to
%   bidiagonal form, then applies a single-shift QR algorithm that preserves
%   the singular values.  The result is a diagonal matrix containing the
%   singular values.
%
%   If A is symmetric and positive definite, the three variants compute
%   the same final diagonal matrix by three different algorithms.
%
%   D = EIGSVDGUI(...) returns the diagonal or Schur result.

if nargin < 1
   A = randn(24,24);
   job = 'symm';
elseif nargin < 2
   if isequal(A,A')
      job = 'symm';
   elseif isequal(size(A),size(A'))
      job = 'eig';
   else
      job = 'svd';
   end
elseif isequal(A,'gcf')
   A = get(gcf,'userdata');
end

shg
J = jet(256);
J(1,:) = get(gcf,'color');
set(gcf,'doublebuffer','on','colormap',J,'userdata',A, ...
   'name',['eigsvdgui(A,''' job ''')'],'menu','none','numbertitle','off');

if isequal(job,'symm');
   A = eiggui((A+A')/2);
elseif isequal(job,'eig')
   A = eiggui(A);
else
   A = svdgui(A);
end

eig = uicontrol('units','norm','pos',[.02,.02,.10,.04], ...
   'string','eig','callback','eigsvdgui(''gcf'',''eig'')');
symm = uicontrol('units','norm','pos',[.14,.02,.10,.04], ...
   'string','symm', 'callback','eigsvdgui(''gcf'',''symm'')');
svd = uicontrol('units','norm','pos',[.26,.02,.10,.04], ...
   'string','svd', 'callback','eigsvdgui(''gcf'',''svd'')');
stop = uicontrol('units','norm','pos',[.38,.02,.10,.04], ...
   'string','close','callback','close');
if ~isequal(size(A),size(A'))
   set([eig,symm],'foreground',[.66 .66 .66],'callback',[])
end
if nargout > 0
   D = A;
end


% -------------------------------------------

function A = eiggui(A)

scale = 256/sqrt(max(abs(diag(A'*A))));
imageh = image(ceil(scale*abs(A))+1);
daspect([1 1 1])
issymm = isequal(A,A');
iscmplx = ~isreal(A);

% Househoulder reduction to tridiagonal or Hessenberg form.

[n,n] = size(A);
for k = 1:n-2

   % Introduce zeros below the subdiagonal in the k-th column.

   u = A(:,k);
   u(1:k) = 0;
   sigma = norm(u);
   if sigma ~= 0
      if u(k+1) ~= 0, sigma = sign(u(k+1))*sigma; end
      u(k+1) = u(k+1) + sigma;
      rho = 1/(sigma'*u(k+1));
      v = rho'*A*u;
      w = (rho*u'*A)';
      gamma = rho/2*u'*v;
      v = v - gamma*u;
      gamma = rho/2*u'*w;
      w = w - gamma*u;
      A = A - v*u' - u*w';
      A(k+2:n,k) = 0;
      if issymm, A(k,k+2:n) = 0; end
   end
   set(imageh,'cdata',ceil(scale*abs(A))+1)
   pause(.1)
end

% Tridiagonal or Hessenberg QR algorithm.

it = 0;
titleh = title('0');
k = n;
while k > 1

   % 1-by-1 convergence test.

   if abs(A(k,k-1)) <= 2*eps*(abs(A(k-1,k-1)) + abs(A(k,k)))
      A(k,k-1) = 0;
      if issymm
         A(k-1,k) = 0;
         A(k,k) = real(A(k,k));
      end
      k = k-1;
   else

      % Wilkinson shift, eigenvalues of lower 2-by-2, A(k-1:k,k-1:k).
   
      r = (A(k,k)-A(k-1,k-1))/(2*A(k,k-1));
      s = r^2 + A(k-1,k)/A(k,k-1);
   
      % Use single shift for real eigenvalues of real matrices
      % and for all eigenvalues of complex matrices.
   
      if iscmplx | s >= 0 
   
         % Single real shift, eigenvalue of 2-by-2 closest to A(k,k).
   
         s = sqrt(s);
         if r < 0, s = -s; end
         if r+s ~= 0, s = A(k,k) + A(k-1,k)/(r+s); end
   
         % Single QR step.
   
         I = eye(k,k);
         [Q,R] = qr(A(1:k,1:k) - s*I);
         A(1:k,1:k) = R*Q + s*I;
         it = it+1;
   
      else
   
         % Complex eigenvalues of real matrices.
         % 2-by-2 convergence test.
   
         if k == 2
            k = 0;
         elseif abs(A(k-1,k-2)) <= 2*eps*(abs(A(k-2,k-2)) + abs(A(k-1,k-1)))
            A(k-1,k-2) = 0;
            if issymm, A(k-2,k-1) = 0; end
            k = k-2;
         else
   
            % Sum and product of eigenvalues of lower 2-by-2.
      
            t = A(k-1,k-1) + A(k,k);
            d = A(k-1,k-1)*A(k,k) - A(k,k-1)*A(k-1,k);
      
            % Double QR step.
      
            I = eye(k,k);
            [Q,R] = qr(A(1:k,1:k)^2 - t*A(1:k,1:k) + d*I);
            A(1:k,1:k) = triu(Q'*A(1:k,1:k)*Q,-1);
            it = it+2;
         end
      end
   end
   if issymm, A(1:k,1:k) = tril(A(1:k,1:k),1); end
   set(imageh,'cdata',ceil(scale*abs(A))+1)
   set(titleh,'string',num2str(it))
   pause(.1)
end
if issymm, A(1,1) = real(A(1,1)); end


% -------------------------------------------

function A = svdgui(A)
%SVDGUI Demonstrate the computation of the SVD.
%   SVDGUI(A) shows the steps in the computation of the
%   singular value decomposition of any real or complex matrix.

scale = 256/sqrt(max(abs(diag(A'*A))));
imageh = image(ceil(scale*abs(A))+1);
daspect([1 1 1])

% Househoulder reduction to bidiagonal form.

[m,n] = size(A);
for k = 1:min(m,n)

   % Introduce zeros below the diagonal in the k-th column.

   u = A(:,k);
   u(1:k-1) = 0;
   sigma = norm(u);
   if sigma ~= 0
      if u(k) ~= 0, sigma = sign(u(k))*sigma; end
      u(k) = u(k) + sigma;
      rho = 1/(sigma'*u(k));
      v = rho*(u'*A);
      A = A - u*v;
      A(k+1:m,k) = 0;
   end
   set(imageh,'cdata',ceil(scale*abs(A))+1);
   pause(.1)

   % Introduce zeros to the right of the superdiagonal in the k-th row.

   u = A(k,:);
   u(1:k) = 0;
   sigma = norm(u);
   if sigma ~= 0
      if u(k+1) ~= 0, sigma = sign(u(k+1))*sigma; end
      u(k+1) = u(k+1) + sigma;
      rho = 1/(sigma'*u(k+1));
      v = rho*(A*u');
      A = A - v*u;
      A(k,k+2:n) = 0;
   end
   set(imageh,'cdata',ceil(scale*abs(A))+1);
   pause(.1)
end

% Bidiagonal SVD QR iteration.

it = 0;
titleh = title('0');
k = min(m,n);
while k > 1

   % Convergence test.

   if abs(A(k-1,k)) <= 2*eps*(abs(A(k-1,k-1)) + abs(A(k,k)))
      A(k-1,k) = 0;
      k = k-1;
   else

      % One step of single shift QR iteration.
      % Wilkinson shift, eigenvalue of lower 2-by-2 of A'*A.
   
      T = A(1:k,1:k)'*A(1:k,1:k);
      r = (T(k,k)-T(k-1,k-1))/(2*T(k,k-1));
      s = sqrt(r^2 + T(k-1,k)/T(k,k-1));
      if r < 0, s = -s; end
      if r+s ~= 0, s = T(k,k) + T(k-1,k)/(r+s); end

      I = eye(k,k);
      [Q,R] = qr(T-s*I);
      A(1:k,1:k) = A(1:k,1:k)*Q;
      [Q,R] = qr(A(1:k,1:k));
      A(1:k,1:k) = tril(R,1);
      it = it+1;
   end

   set(imageh,'cdata',ceil(scale*abs(A))+1);
   set(titleh,'string',num2str(it))
   pause(.1)
end
A = abs(A);
