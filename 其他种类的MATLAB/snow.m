function snow(N) 
x(1)=1;x(2)=4; 
y(1)=0;y(2)=0; 
t=sqrt(3); 
for j=1:N 
    L=length(x); 
    X=x; 
    Y=y; 
    n=0; 
    for i=2:L 
        if Y(i)==Y(i-1) 
            d1=x(i+3*n)-x(i-1+3*n); 
            d2=y(i+3*n)-y(i-1+3*n); 
            for k=length(x):-1:i+3*n 
                x(k+3)=x(k); 
                y(k+3)=y(k); 
            end 
            x(i+3*n)=x(i-1+3*n)+1/3*d1; 
            y(i+3*n)=y(i-1+3*n)+1/3*d2; 
            x(i+1+3*n)=x(i-1+3*n)+1/2*d1; 
            y(i+1+3*n)=y(i-1+3*n)+sqrt(3)/6*d1; 
            x(i+2+3*n)=x(i-1+3*n)+2/3*d1; 
            y(i+2+3*n)=y(i-1+3*n)+2/3*d2; 
            n=n+1; 
        end 
        if (Y(i)-Y(i-1))/(X(i)-X(i-1))==sym(t) 
                d1=x(i+3*n)-x(i-1+3*n); 
                d2=y(i+3*n)-y(i-1+3*n); 
                for k=length(x):-1:i+3*n 
                    x(k+3)=x(k); 
                    y(k+3)=y(k); 
                end 
                x(i+3*n)=x(i-1+3*n)+1/3*d1; 
                y(i+3*n)=y(i-1+3*n)+1/3*d2; 
                x(i+1+3*n)=x(i-1+3*n); 
                y(i+1+3*n)=y(i-1+3*n)+2/3*d2; 
                x(i+2+3*n)=x(i-1+3*n)+2/3*d1; 
                y(i+2+3*n)=y(i-1+3*n)+2/3*d2; 
                n=n+1; 
        end 
        if (Y(i)-Y(i-1))/(X(i)-X(i-1))==sym(-t) 
                d1=x(i+3*n)-x(i-1+3*n); 
                d2=y(i+3*n)-y(i-1+3*n); 
                for k=length(x):-1:i+3*n 
                    x(k+3)=x(k); 
                    y(k+3)=y(k); 
                end 
                x(i+3*n)=x(i-1+3*n)+1/3*d1; 
                y(i+3*n)=y(i-1+3*n)+1/3*d2; 
                x(i+1+3*n)=x(i-1+3*n)+d1; 
                y(i+1+3*n)=y(i-1+3*n)+1/3*d2; 
                x(i+2+3*n)=x(i-1+3*n)+2/3*d1; 
                y(i+2+3*n)=y(i-1+3*n)+2/3*d2; 
                n=n+1; 
        end 
    end 
end 
plot(x,y,'-'); 
axis('equal'); 
axis([1 4 -0.5 1]);

