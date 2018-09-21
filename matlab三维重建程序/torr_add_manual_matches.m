% 
% \pao
% \bi
% \item {\tt matches12} matches in an $n \times 4$ array of matches $(x,y,x'y')$, in this
% case $n$ is the number of matches.
% \item {\tt minc} is the minimum value of $C$ for each corner.
% \item {\tt mat12} is defined such that {\tt mat(i) = j} means corner $i$ matches to
% corner $j$.
% \ei

%	By Philip Torr 2002
%	copyright Microsoft Corp.



function matches12 = torr_add_manual_matches(ax_handle2,ax_handle3)

button1 = 1;
button2 = 2;
no_matches = 0;

    
while ~isempty(button1) & ~isempty(button2)
    
    axes(ax_handle2);
    hold on;
    [Xcur,Ycur,button1] = GINPUT(1);
    plot(Xcur,Ycur, 'm+');
    
    
    if ~isempty(button1)
        axes(ax_handle3);
        hold on
        [Xcur2,Ycur2,button2] = GINPUT(1);
        plot(Xcur,Ycur, 'm+');
    end
    
    if (~isempty(button1) & ~isempty(button2))
        no_matches = no_matches + 1;
        matches12(no_matches,:) = [Xcur,Ycur,Xcur2,Ycur2];
        
        axes(ax_handle2);  
        
        u1 = Xcur2 - Xcur;
        v1 = Ycur2 - Ycur;
        quiver(Xcur, Ycur, u1, v1, 0);
        text(Xcur,Ycur,num2str(no_matches),'Color','m');
        
    end
    
    
    
end


hold off

