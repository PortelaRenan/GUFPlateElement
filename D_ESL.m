function [ D ] = D_ESL( degrees_of_freedom_structure, N, geometry_structure )

h_bot = geometry_structure(N).z_low;
h_top = geometry_structure(1).z_top;

%%---------------------- Degrees of freedom -------------------------------
dofx = degrees_of_freedom_structure.x;
dofy = degrees_of_freedom_structure.y;
dofz = degrees_of_freedom_structure.z;

%%---------------------- Matrices pre-allocation --------------------------
D.uxuxt = zeros(dofx); dx = size(D.uxuxt,1);
D.uxuxb = zeros(dofx);
D.uyuyt = zeros(dofy); dy = size(D.uyuyt,1);
D.uyuyb = zeros(dofy);
D.uzuzt = zeros(dofz); dz = size(D.uzuzt,1);
D.uzuzb = zeros(dofz);

%%------------------------ UX UX (TOP) ------------------------------------
for ii = 1 : dx
    for jj = 1 : dx
        func = h_top;
        
        % POLYNOMIALS FUNCTIONS
        
        eq1 = zeros(1,dofx);
        eq1(dofx - ii + 1) = 1;
        F1 = polyval(eq1,func); 
        
        eq2 = zeros(1,dofx);
        eq2(dofx - jj + 1) = 1;
        F2 = polyval(eq2,func);         
        
        D.uxuxt(ii,jj) = D.uxuxt(ii,jj) + F1*F2;
    end
end

%%------------------------ UX UX (BOTTOM) ---------------------------------
for ii = 1 : dx
    for jj = 1 : dx
        func = h_bot;
        
        % POLYNOMIALS FUNCTIONS
        
        eq1 = zeros(1,dofx);
        eq1(dofx - ii + 1) = 1;
        F1 = polyval(eq1,func); 
        
        eq2 = zeros(1,dofx);
        eq2(dofx - jj + 1) = 1;
        F2 = polyval(eq2,func); 
        
        D.uxuxb(ii,jj) = D.uxuxb(ii,jj) + F1*F2;
        
    end
end

%%------------------------ UY UY (TOP) ------------------------------------
for ii = 1 : dy
    for jj = 1 : dy
        func = h_top;
        
        % POLYNOMIALS FUNCTIONS
        
        eq1 = zeros(1,dofy);
        eq1(dofy - ii + 1) = 1;
        F1 = polyval(eq1,func); 
        
        eq2 = zeros(1,dofy);
        eq2(dofy - jj + 1) = 1;
        F2 = polyval(eq2,func); 
        
        D.uyuyt(ii,jj) = D.uyuyt(ii,jj) + F1*F2;
    end
end

%%------------------------ UY UY (BOTTOM) ---------------------------------
for ii = 1 : dy
    for jj = 1 : dy
        func = h_bot;
        
        % POLYNOMIALS FUNCTIONS
        
        eq1 = zeros(1,dofy);
        eq1(dofy - ii + 1) = 1;
        F1 = polyval(eq1,func); 
        
        eq2 = zeros(1,dofy);
        eq2(dofy - jj + 1) = 1;
        F2 = polyval(eq2,func);
        
        D.uyuyb(ii,jj) = D.uyuyb(ii,jj) + F1*F2;
    end
end

%%------------------------ UZ UZ (TOP) ------------------------------------
for ii = 1 : dz
    for jj = 1 : dz
        func = h_top;
        
        % POLYNOMIALS FUNCTIONS
        
        eq1 = zeros(1,dofz);
        eq1(dofz - ii + 1) = 1;
        F1 = polyval(eq1,func); 
        
        eq2 = zeros(1,dofz);
        eq2(dofz - jj + 1) = 1;
        F2 = polyval(eq2,func); 
        
        D.uzuzt(ii,jj) = D.uzuzt(ii,jj) + F1*F2;
    end
end

%%------------------------ UZ UZ (BOTTOM) ---------------------------------
for ii = 1 : dz
    for jj = 1 : dz
        func = h_bot;
        
        % POLYNOMIALS FUNCTIONS
        
        eq1 = zeros(1,dofz);
        eq1(dofz - ii + 1) = 1;
        F1 = polyval(eq1,func); 
        
        eq2 = zeros(1,dofz);
        eq2(dofz - jj + 1) = 1;
        F2 = polyval(eq2,func); 
        
        D.uzuzb(ii,jj) = D.uzuzb(ii,jj) + F1*F2;
    end
end

end