subplot(2,2,1);
bar3(magic(4))
subplot(2,2,2);
y=2*sin(0:pi/10:2*pi);
stem3(y);
subplot(2,2,3);
pie3([2347,1827,2043,3025]);
subplot(2,2,4);
fill3(rand(3,5),rand(3,5),rand(3,5), 'y' )
