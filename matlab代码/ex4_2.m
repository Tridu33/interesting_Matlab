% 输入文本文件名
qname=input('Enter file containing questions : ','s');
ip=fopen(qname,'rt');     % 打开该文本文件
if (ip<0)
     error('could not open input file');
end;
op=fopen('qq.log','wt');     % 打开输出文件
if (op<0)
     error('could not open output file');
end;
% 依次向用户提问
q=fgetl(ip);
while (ischar(q))
     fprintf('%s\n',q);
     a=input('Answer T(rue) or F(alse) : ','s');
     while ((a~='T')&(a~='F'))
          a=input('Answer T(rue) or F(alse) : ','s');
     end;
     fprintf(op,'%s\nAnswer: %s\n',q,a);
     q=fgetl(ip);
end;
fclose(ip);
fclose(op);
