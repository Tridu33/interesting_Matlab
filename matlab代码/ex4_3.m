a=1:5;
fid=fopen('fdat.bin','w');   %以写方式打开文件fdat.bin
fwrite(fid,a,'int16');      %将a的元素以双字节整型写入文件fdat.bin
status=fclose(fid);             
fid=fopen('fdat.bin','r');    %以读数据方式打开文件fdat.bin
status=fseek(fid,6,'bof');   %将文件指针从开始位置向尾部移动6个字节
four=fread(fid,1,'int16');   %读取第4个数据，并移动指针到下一个数据
position=ftell(fid);         %ftell的返回值为8    
status=fseek(fid,-4,'cof');   %将文件指针从当前位置往前移动4个字节
three=fread(fid,1,'int16');   %读取第3个数据
status=fclose(fid);
