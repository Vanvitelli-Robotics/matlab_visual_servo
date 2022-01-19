T = 0.05;
lT = .3333;

a_vect = 0:0.1:10;

v2T = [];
r = [];
sdmMAX = [];
for a = a_vect
   lT = 1;
   eG = 0.08;
   
   a0 = T^2;
   a1 = T*(2*(1-lT) + .25);
   a2 = -lT/(1+a^2);
   
   pol = [a2 a1 a0];
   
   v2T(end+1) = polyval(pol, 2*T);
   
   rr = roots(pol);
   
   rr = rr(rr>0);
   
   if(numel(rr) == 1 && isreal(rr))
      r(end+1) = rr; 
      sdmMAX(end+1) = eG*sqrt(1+a)/rr;
   else
       r(end+1) = nan;
       sdmMAX(end+1) = nan;
       warning("problema");
   end
   
end

figure
plot(a_vect,v2T);
grid on


figure
plot(a_vect,r);
grid on

figure
plot(a_vect,sdmMAX);
grid on