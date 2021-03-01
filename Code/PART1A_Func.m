function [Vmap,outputArg2] = PART1A_Func(L,W)
    nx = L;
    ny = W;

    G = sparse(nx*ny);
    F = zeros(1,nx*ny);

    for i = 1:nx
        for j = 1:ny
            n = j + (i-1)*ny; %Node Mapping

            if i == 1 %Set Left Voltage to 1
               G(n,:) = 0;
               G(n,n) = 1;
               F(n) = 1;
            elseif i == nx %Set Right Voltage to 0
                G(n,:) = 0;
                G(n,n) = 1;
                F(n) = 0;
            elseif j == 1 %Top - Insulated
                nxm = j + (i-2)*ny;
                nxp = j + i*ny;
                nyp = n + 1;

                G(n,nxm) = 1;
                G(n,nxp) = 1;
                G(n,nyp) = 1; 

                G(n,n) = -3;
            elseif j == ny
                nxm = j + (i-2)*ny;
                nxp = j + i*ny;
                nym = n - 1;

                G(n,nxm) = 1;
                G(n,nxp) = 1;
                G(n,nym) = 1;

                G(n,n) =-3; %Only 3 resistors
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
end

