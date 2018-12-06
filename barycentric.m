clear; clc;
A=zeros(1,200);
for n=1:200
%n=100;
xx = linspace(-1,1,5000)';
x = cos(pi*(0:n)'/n);
c = [1/2; ones(n-1,1); 1/2].*(-1).^((0:n)');
% fun = inline('exp(x)./cos(x)');
fun = @(x) exp(x)./cos(x);
f = fun(x);

numer = zeros(size(xx));
denom = zeros(size(xx));
exact = zeros(size(xx));
for j = 1:n+1
xdiff = xx-x(j);
temp = c(j)./xdiff;
numer = numer + temp*f(j);
denom = denom + temp;
exact(xdiff==0) = 1;
end
ff = numer./denom;
error=ff-fun(xx);
n
maxe=max(abs(error));
jj = find(exact); 
ff(jj) = f(exact(jj));
%plot(x,f,'.',xx,ff,'-')
% plot(xx,ff-f)
A(n)=maxe;
end
x = 1:200
plot(x,A),axis([0 200 1e-16 1e0]),hold on

B=zeros(1,200);
for n=1:200
%n=100;
xx = linspace(-1,1,5000)';
x = cos(pi*(0:n)'/n);
c = [1/2; ones(n-1,1); 1/2].*(-1).^((0:n)');
fun = @(x) (1+16.*(x.^2)).^-1;
f = fun(x);

numer = zeros(size(xx));
denom = zeros(size(xx));
exact = zeros(size(xx));
for j = 1:n+1
xdiff = xx-x(j);
temp = c(j)./xdiff;
numer = numer + temp*f(j);
denom = denom + temp;
exact(xdiff==0) = 1;
end
ff = numer./denom;
error=ff-fun(xx);
n
maxe=max(abs(error));
jj = find(exact); 
ff(jj) = f(exact(jj));
%plot(x,f,'.',xx,ff,'-')
% plot(xx,ff-f)
B(n)=maxe;
end
x = 1:200
plot(x,B),axis([0 200 1e-16 1e0]), hold off


