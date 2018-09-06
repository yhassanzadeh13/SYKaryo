%Ac matrix update: This function updates the Ac matrix of the LT.m, after
%moiving in each direction, this function increases the value of that
%direction by one and two axiluarry directions by 0.5
function [Ac] = AcU(Ac, i, j)

if(i == 1 && j ==1)
        Ac(1,1) = Ac(1,1) + 1;
        Ac(2,1) = Ac(2,1) + IF;
        Ac(1,2) = Ac(1,2) + IF;
        return;
end

if(i == 1 && j ==2)
        Ac(1,1) = Ac(1,1) + IF ;
        Ac(1,2) = Ac(1,2) + 1;
        Ac(1,3) = Ac(1,3) + IF;
        return;
end

if(i == 1 && j ==3)
        Ac(1,2) = Ac(1,2) + IF;
        Ac(1,3) = Ac(1,3) + 1;
        Ac(2,3) = Ac(2,3) + IF;
        return;
end

if(i == 2 && j ==1)
        Ac(1,1) = Ac(1,1) + IF;
        Ac(2,1) = Ac(2,1) + 1;
        Ac(3,1) = Ac(3,1) + IF;
        return;
end

if(i == 2 && j ==3)
        Ac(2,3) = Ac(2,3) + 1;
        Ac(1,3) = Ac(1,3) + IF;
        Ac(3,3) = Ac(3,3) + IF;
        return;
end

if(i == 3 && j ==1)
        Ac(3,1) = Ac(3,1) + 1;
        Ac(2,1) = Ac(2,1) + IF;
        Ac(3,2) = Ac(3,2) + IF;
        return;
end

if(i == 3 && j ==2)
        Ac(3,1) = Ac(3,1) + IF;
        Ac(3,2) = Ac(3,2) + 1;
        Ac(3,3) = Ac(3,3) + IF;
        return;
end

if(i == 3 && j ==3)
        Ac(3,3) = Ac(3,3) + 1;
        Ac(2,3) = Ac(2,3) + IF;
        Ac(3,2) = Ac(3,2) + IF;
        return;
end
end