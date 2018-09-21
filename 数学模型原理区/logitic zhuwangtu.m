%生物模型logistic的蛛网图（迭代图）p0=0.5;k=0.501
p(1) = 0.5;
x = 0:0.001:1;
plot(x,x);
hold on 
y=0.501*x.*(1-x);
plot(0.5,x);
hold on
plot(x,y,'r');
for n =1:20;
    q(n) = 0.501*p(n)*(1-p(n))
    p(n+1)=q(n);
    hold on 
    plot(p(n),p(n),'r.','markersize',15);
    hold on 
    plot(p(n),q(n),'b.','markersize',20);
    hold on 
    plot([p(n),p(n)],[p(n),q(n)]);
    hold on
    plot([p(n),q(n)],[q(n),q(n)]);
    axis([0,1,0,1.1])
end

% %{p(1) = 0.5;
% x = 0:0.001:1;
% plot(x,x);
% hold on 
% y=0.5*x.*(1-x);
% plot(0.5,x);
% hold on
% plot(x,y,'r');
% for n =1:20;
%     q(n) = 0.5*p(n)*(1-p(n))
%     p(n+1)=q(n);
%     hold on 
%     plot(p(n),p(n),'r.','markersize',15);
%     hold on 
%     plot(p(n),q(n),'b.','markersize',20);
%     hold on 
%     plot([p(n),p(n)],[p(n),q(n)]);
%     hold on
%     plot([p(n),q(n)],[q(n),q(n)]);
%     axis([0,1,0,1.1])
% end
% %}
