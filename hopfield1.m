clc
clear
close all

X = 2*rand(2,2)-1;

figure(1); hold on;
plot(X(1,:),X(2,:),'ks','linewidth',2,'markersize',15);

net = newhop(X);

view(net);

test_data = 2*rand(2,100)-1;

for k = 1:size(test_data,2)
    test = test_data(:,k);
    plot(test(1),test(2),'bO','linewidth',2,'markersize',5);

    traj = net({1 100},[],test);
    traj = [test cell2mat(traj)];
   
    plot(traj(1,:),traj(2,:),'b');
    
    plot(traj(1,end),traj(2,end),'rO','linewidth',3,'markersize',15);
end

axis([-1.2 1.2 -1.2 1.2]);
axis square
grid minor
legend('train data','test data','trajectory','final point')
