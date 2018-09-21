function encrypt(filein,fileout)
%ENCRYPT  Apply the CRYPTO function to a text file.
%  ENCRYPT 
%      with no arguments prompts for a input file name.
%  ENCRYPT inputfilename
%      encrypts the text in the input file and displays the results.
%  ENCRYPT inputfilename outputfilename
%      stores the encrypted text in the output file.
% See also CRYPTO.

if nargin < 1
   filein = input('Input file = ','s');
end
fin = fopen(filein);

if nargin == 2
   fout = fopen(fileout,'w');
else
   fout = 1;
end

while ~feof(fin)
   s = fgetl(fin);
   t = crypto(s);
   fprintf(fout,'%s\n',t);
end

fclose all;
