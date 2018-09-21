% 
% %designed for the good of the world by Philip Torr based on ideas contained in 
% copyright Philip Torr and Microsoft Corp 2002
% 


% /*
% *****************************************
% */This gives a new method for estimating F that I developed (see citations below) from 7 points:

% 
% thus we can get a one parameter family of solutions (modulo scale) F = F1 + a F2
% exploiting  det | F | = 0 
% this gives us 1,2 or 3 distinct solutions for a

%MORE DETAILS IN:
% @phdthesis{Torr:thesis,
%         author="Torr, P. H. S.",
%         title="Outlier Detection and Motion Segmentation",
%         school=" Dept. of  Engineering Science, University of Oxford",
%         year=1995}
% 
% 
% @article{Torr97c,
%         author="Torr, P. H. S.  and Murray, D. W. ",
%         title="The Development and Comparison of Robust Methods for Estimating the Fundamental Matrix",
%         journal="IJCV",
%         volume = 24,
%         number = 3,
%         pages = {271--300},
%         year=1997
% }

%A is a 7 x 9 design matrix;
%big_result is a 3x9 matrix of putative F's

% returns 0,1,2 or 3 the number of fits gained.


% 
function [no_F, big_result] = torr_F_constrained_fit(x1,y1,x2,y2,m3)

A(:,1) = x1(:).* x2(:);
A(:,2) = y1(:).* x2(:);
A(:,3) = m3* x2(:);

A(:,4) = x1(:).* y2(:);
A(:,5) = y1(:).* y2(:);
A(:,6) = m3* y2(:);

A(:,7) = x1(:).* m3;
A(:,8) = y1(:).* m3;
A(:,9) = m3* m3;

no_F = 0;
sizeA = size(A);
if ((sizeA(1) ~= 7) | (sizeA(2) ~= 9))
    error('A is wrong shape');
    return;
end
% A
% disp(sprintf('Rank of A = %d',rank(A)));
% disp('Null space of A');
% null(A)


[U,S,V] = svd(A);

%the two solutions 
r1 = V(:,length(V));
r2 = V(:,length(V)-1);
% disp('Torr')
% r1
% r2

p = torr_calc_cubic_coefs(r1, r2);
a_roots = roots(p);
%disp('Roots')
%a_roots

% %  we now want to chose a solution so that the constrtaint
% %     | aF_1 + (1-a)F_2 | = 0 is satisfies --- this gives us a cubic in a 
% 
% %coefficients of c_1 a^3 + c_2 a^2 + c_3 a + c_4
% cubic = zeros(4,1);
% 
% cubic = torr_accumulate_coeff(cubic, r1, r2,1,5,9, 1);
% cubic = torr_accumulate_coeff(cubic, r1, r2,1,6,8, 0);
% cubic = torr_accumulate_coeff(cubic, r1, r2,2,4,9, 0);
% cubic = torr_accumulate_coeff(cubic, r1, r2,2,6,7, 1);
% cubic = torr_accumulate_coeff(cubic, r1, r2,3,4,8, 1);
% cubic = torr_accumulate_coeff(cubic, r1, r2,3,5,7, 0);
% 
% %    /* cubic(0) x^3 + cubic(1) x^2 + cubic(2) x + cubic(3) etc */
% a_roots = roots(cubic);

for i_root = 1:3
    if isreal(a_roots(i_root))
%        disp(sprintf('Real root #%d = %0.8g',i_root,a_roots(i_root)))
        no_F = no_F + 1;
        big_result(no_F,:) = r1(:)' * a_roots(i_root) + r2(:)' * (1 - a_roots(i_root));
        
        % test that it is the correct solution.  
        % simply det(big_result) = 0
     %   disp(sprintf('det(aF1 + (1-a)F2)  = %0.8g',det(reshape(big_result(no_F,:),3,3)')))
        
    end
end





%accumulates the coefficients for the 
% function  cubic_out = torr_accumulate_coeff(cubic,f1, f2, a, b, c, plus)
% temp(1) = f1(a) * f1(b) * f1(c);
% temp(2) = f1(a) * f1(b) * f2(c);
% temp(3) = f1(a) * f2(b) * f1(c);
% temp(4) = f1(a) * f2(b) * f2(c);
% temp(5) = f2(a) * f1(b) * f1(c);
% temp(6) = f2(a) * f1(b) * f2(c);
% temp(7) = f2(a) * f2(b) * f1(c);
% temp(8) = f2(a) * f2(b) * f2(c);
% 
% if plus
%     cubic_out(1) = cubic(1) + temp(1) - temp(2) - temp(3) + temp(4) - temp(5) + temp(6) + temp(7) - temp(8);
%     cubic_out(2) = cubic(2) + temp(2) + temp(3) - 2*temp(4) + temp(5) - 2*temp(6) - 2*temp(7)+ 3*temp(8); 
%     cubic_out(3) = cubic(3) +temp(4) + temp(6) + temp(7) - 3 * temp(8);
%     cubic_out(4) = cubic(4) +temp(8);
% else
%     cubic_out(1) = cubic(1) -temp(1) - temp(2) - temp(3) + temp(4) - temp(5) + temp(6) + temp(7) - temp(8);
%     cubic_out(2) = cubic(2) -temp(2) + temp(3) - 2*temp(4) + temp(5) - 2*temp(6) - 2*temp(7)+ 3*temp(8); 
%     cubic_out(3) = cubic(3) -temp(4) + temp(6) + temp(7) - 3 * temp(8);
%     cubic_out(4) = cubic(4) -temp(8);
% end
