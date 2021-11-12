s = out.s.Data;
s_star = C_features_desired(:);

figure(11)
hold on

for i=2:1000:(size(s,1)-1)
    plot3(s(i,[1]),s(i,[2]),s(i,[3]),'g*');
    plot3(s(i,[4]),s(i,[5]),s(i,[6]),'g+');
    plot3(s(i,[7]),s(i,[8]),s(i,[9]),'go');
end

plot3(s(1,[1]),s(1,[2]),s(1,[3]),'b*');
plot3(s(1,[4]),s(1,[5]),s(1,[6]),'b+');
plot3(s(1,[7]),s(1,[8]),s(1,[9]),'bo');

plot3(s(end,[1]),s(end,[2]),s(end,[3]),'r*');
plot3(s(end,[4]),s(end,[5]),s(end,[6]),'r+');
plot3(s(end,[7]),s(end,[8]),s(end,[9]),'ro');

plot3(s_star([1]),s_star([2]),s_star([3]),'k*');
plot3(s_star([4]),s_star([5]),s_star([6]),'k+');
plot3(s_star([7]),s_star([8]),s_star([9]),'ko');

plotBari(s(1,:),'b.')
plotBari(s_star,'k.')
plotBari(s(end,:),'r.')

axis equal

function plotBari(s,c)

n_f = numel(s)/3;
s = reshape(s,3,n_f);
bari = sum(s,2)/n_f;

plot3(bari(1),bari(2),bari(3),c);


end