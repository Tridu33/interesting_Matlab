function COMM(hedit,hpopup,hlist)
com=get(hedit,'String');
n1=get(hpopup,'Value');
n2=get(hlist,'Value');
if ~isempty(com)    %编辑框输入非空时
eval(com');      %执行从编辑框输入的命令
    chpop={'spring','summer','autumn','winter'};
    chlist={'grid on','grid off','box on','box off'};
    colormap(eval(chpop{n1}));
    eval(chlist{n2});
end
