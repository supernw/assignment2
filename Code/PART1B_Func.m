function [Vmap, X, Y, f, nx, ny] = PART1B_Func(L,W)
    nx = L;
    ny = W;


    %Finite Difference Method
    G = sparse(nx*ny);
    F = zeros(1,nx*ny);

    for i = 1:nx
        for j = 1:ny
            n = j + (i-1)*ny; %Node Mapping

            if i == 1 %Set Left Voltage to 1
               G(n,:) = 0;
               G(n,n) = 1;
               F(n) = 1;
            elseif i == nx %Set Right Voltage to 1
                G(n,:) = 0;
                G(n,n) = 1;
                F(n) = 1;
            elseif j == 1 %Set Bottom Voltage to 0
                G(n,:) = 0;
                G(n,n) = 1;
                F(n) = 0;
            elseif j == ny %Set Top Voltage to 0
                G(n,:) = 0;
                G(n,n) = 1;
                F(n) = 0;
            else %Bulk
                nxp = j + i*ny;
                nxm = j + (i-2)*ny;
                nyp = n + 1;
                nym = n - 1;

                G(n,nxm) = 1;
                G(n,nxp) = 1;
                G(n,nym) = 1;
                G(n,nyp) = 1;
                G(n,n) = -4;  
            end
        end
    end

    V = G\F';

    %Reverse Node Mapping
    Vmap = zeros(nx,ny);
    for i = 1:nx
        for j =1:ny
            n = j+(i-1)*ny;
            Vmap(i,j) = V(n);
        end
    end
    
    %Analytical Method
    b = L/2; %x goes from -b to b
    a = W; %y goes from 0 to a

    f = @(x,y,n) (1/n).*( ( cosh((n.*pi.*x)./a) )./( cosh((n.*pi.*b)./a ) ) ).*sin((n.*pi.*y)./a);

    xa = linspace(-b,b,nx);
    ya = linspace(0,a,ny);
    [X,Y] = meshgrid(xa,ya);
    
end

