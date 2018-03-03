B=[];
for n = 1:10000
    A=calculateDirection(1);
    B=[B;A];
end
plot3(B(:,1),B(:,2),B(:,3),'.')