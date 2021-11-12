e = out.e.Data;
s = out.s.Data;
t = out.e.Time;

n1 = zeros(1,numel(t));
n2 = n1;

for i=1:numel(t)
    n1(i) = norm(pinv(computeL(s(i,:)))*(e(i,:)'));
    n2(i) = norm(pinv(computeL(s(i,:))))*norm((e(i,:)'));
end

figure,plot(t,n1,t,n2)