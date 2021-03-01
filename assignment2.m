addpath('./Code/');

%PART 1A
Vmap_1A = PART1A_Func(75, 50);

figure(1)
surf(Vmap_1A','linestyle', 'none');
view(0,90)
title('Part 1A - Top and Bottom Not Fixed') 
xlabel('Length');
ylabel('Width');

%PART 1B

%Finite Difference
[Vmap_1B, X1B, Y1B, f1B, nx, ny] = PART1B_Func(75, 50);

figure(2)
surf(Vmap_1B','linestyle', 'none');
view(0,90)
title('Part 1B - Saddle') 
xlabel('Length');
ylabel('Width');

%Analytic
n_it = 100; %Number of iterations
Va_sum = zeros(nx,ny);
Va = zeros(nx,ny);
for n = 1:2:n_it
    Va_sum = Va_sum + f1B(X1B,Y1B,n)';
    
    Va = Va_sum.*(4*1/pi);
    figure(3)
    surf(Va','linestyle', 'none');
    %view(0,90)
    title('Part 1B - Saddle (Analytic)') 
    xlabel('Length');
    ylabel('Width');

    pause(0.05);
end

%Difference
dV = Vmap_1B-Va;
figure(4)
surf(dV','linestyle', 'none')
title('Part 1B - Finite Difference vs. Analytic Difference Comparison')
xlabel('Length')
ylabel('Width')

[cMap, Vmap, Ex, Ey, Jx, Jy, Current, Box_top_rec, Box_bottom_rec] = PART2_Func(25,0,0.25,0.4,0, 10^(-2));
fprintf('Current = %f\n',Current);
figure(5)
surf(cMap')
title('Conductivity - sigma(x,y) Graph')
view(0,90);
xlabel('Length')
ylabel('Width')

figure(6)
surf(Vmap','linestyle', 'none');
view(0,90)
title('Voltage - V(x,y) Graph') 
xlabel('Length');
ylabel('Width');
rectangle('Position', Box_top_rec)
rectangle('Position', Box_bottom_rec)

figure(7)
quiver(-Ex,-Ey)
title('Electric Field - E(x,y) Graph')
xlabel('Length');
ylabel('Width');

figure(8)
quiver(Jx,Jy)
title('Current Density - J(x,y) Plot')
xlabel('Length');
ylabel('Width');
%Current vs. Mesh Size (Box Size Proportion Stays the Same)
LWInc = linspace(1,100,100); %Vary RatioVal to vary mesh size
CurrentMeshVary = zeros(1,length(LWInc));
Meshx = zeros(1,length(LWInc));
Meshy = zeros(1,length(LWInc));
MeshSizeSq = zeros(1,length(LWInc));
for i = 1:length(LWInc)
    [cMap, Vmap, Ex, Ey, Jx, Jy, Current] = PART2_Func(10,LWInc(i),0.25,0.4,0, 10^(-2));
    CurrentMeshVary(i) = Current;
    Meshx(i) = 10*3 + LWInc(i);
    Meshy(i) = 10*2 + LWInc(i);
    MeshSizeSq(i) = Meshx(i)*Meshy(i);
    fprintf('Calculating Current vs. Mesh %0.1f\n', (i/length(LWInc))*100); 
end

figure(9)
plot(MeshSizeSq, CurrentMeshVary)
title('Mesh Size vs. Current')
xlabel('Total Area Size')
ylabel('Current')

%Various Bottlenecks
BN_nar = linspace(-10,15, 25); %Decrease bottleneck by this amount
CurrentBNVary = zeros(1,length(BN_nar));
BN_gap = zeros(1,length(BN_nar));

for i = 1:length(BN_nar)
    [cMap, Vmap, Ex, Ey, Jx, Jy, Current] = PART2_Func(10,0,0.25,0.4,BN_nar(i), 10^(-2));
    CurrentBNVary(i) = Current;
    BN_gap(i) = 10 - BN_nar(i);
    fprintf('Calculating Current vs. Bottleneck %0.1f\n', (i/length(BN_nar))*100); 
end

figure(10)
plot(BN_gap, CurrentBNVary);
title('Current vs. Bottle Neck Size')
xlabel('BottleNeck Gap')
ylabel('Current')

%Varying Conductivity of Box
condInVar = linspace((10^-5), 1, 1000);
CurrentCondInVary = zeros(1,length(condInVar));
for i = 1:length(condInVar)
    [cMap, Vmap, Ex, Ey, Jx, Jy, Current] = PART2_Func(10,0,0.25,0.4,0, condInVar(i));
    CurrentCondInVary(i) = Current;
    fprintf('Calculating Current vs. Conductivity of Box %0.1f\n', (i/length(condInVar))*100); 
end

figure(11)
plot(condInVar, CurrentCondInVary)
title('Current vs. Box Conductivity Graph')
xlabel('Conductivity of Box')
ylabel('Current')




