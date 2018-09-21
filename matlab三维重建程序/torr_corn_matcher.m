% 
% %designed for the good of the world by Philip Torr based on ideas contained in 
% copyright Philip Torr and Microsoft Corp 2002
% 
% @inproceedings{Torr93b,
%         author = "Torr, P. H. S.  and Murray, D. W.",
%         title  = "Outlier Detection and Motion Segmentation",
%         booktitle = "Sensor Fusion VI",
%         editor = "Schenker, P. S.",
%         publisher = "SPIE volume 2059",
%         note = "Boston",
% 	pages = {432-443},
%         year = 1993 }
% 
%     
% @phdthesis{Torr:thesis,
%         author="Torr, P. H. S.",
%         title="Outlier Detection and Motion Segmentation",
%         school=" Dept. of  Engineering Science, University of Oxford",
%         year=1995}
% 
% @inproceedings{Beardsley96a,
%          author="Beardsley, P. and Torr, P. H. S. and Zisserman, A.",
%          title="{3D} Model Aquisition from Extended Image Sequences",
%          booktitle=eccv4.2,
%         editor = "Buxton, B. and Cipolla R.",
%        publisher = "Springer--Verlag",
%          pages={683--695},
%          year=1996}


% 
% \pai
% \bi
% \item {\tt im1, im2} the two input images, arrays of doubles as described in
% Section~\ref{det_cor:sec}.
% \item {\tt clist1, clist2} two $nc \times 2$ arrays of corner positions 
% as described in
% Section~\ref{det_cor:sec}, $nc$ is the number of corners.
% \item {\tt max\_disparity} the size of the search window (square) in the next image.
% \item {\tt half\_size} the half size of the correlation window.
% \ei
% 
% \pao
% \bi
% \item {\tt matches12} matches in an $n \times 4$ array of matches $(x,y,x'y')$, in this
% case $n$ is the number of matches.
% \item {\tt minc} is the minimum value of $C$ for each corner.
% \item {\tt mat12} is defined such that {\tt mat(i) = j} means corner $i$ matches to
% corner $j$.
% \ei



function [matches12,minc,mat12] = torr_corn_matcher(im1, im2, clist1, clist2, max_disparity,half_size)

maxc = 10000000000;
mat12 = zeros(length(clist1),1);

%holds the value of the minimum correlation for each corner
minc = ones(length(clist1),1)* maxc;

for i = 1:length(clist1)
    for j = 1:length(clist2)
        if	sum(abs(clist1(i,:) - clist2(j,:))) < max_disparity
            A = patch_match(im1,im2,clist1(i,2),clist1(i,1),clist2(j,2),clist2(j,1),half_size,minc(i));            
            %non mex correlation code
            %             for xi = -3:3
            %                 for yi = -3:3
            %                     %maybe add Birchfield and Tomasi here?
            %                     A(i,j) = A(i,j) + abs(im1(clist1(i,2)+xi,clist1(i,1)+yi) -im2(clist2(j,2)+xi,clist2(j,1)+yi));
            %                     %A(i,j) = sum(abs(im1(i,:)- im2(j,:)));
            %                     %A(i,j) = sum(abs(clist1(i,:) - clist2(j,:)));
            %                     %jump out
            %                     if A(i,j) > minc(i)
            %                         xi = 3;
            %                         yi = 3;
            %                     end
            %                 end
            %             end
            if A < minc(i);
                minc(i) = A;
                mat12(i) = j;
            end
        end
    end
end



n_matches = 0;
for i = 1:length(mat12)
    if mat12(i) ~= 0
        n_matches = n_matches +1;
        matches12(n_matches,:) = [clist1(i,:) clist2(mat12(i),:)];      
    end
end
