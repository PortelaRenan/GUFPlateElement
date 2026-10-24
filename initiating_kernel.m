function [ kernel ] = initiating_kernel( theory, geo, app )

switch theory.strs
    case 'layerwise' 
        stress = 1;
        switch theory.disp
            case 'layerwise'
                displacement = 1;
            case 'shear_deformation'
                displacement = 1;
            case 'zig_zag'
                displacement = 2;
        end
    case 'shear_deformation'
        stress = 1;
        switch theory.disp
            case 'layerwise'
                displacement = 1;
            case 'shear_deformation'
                displacement = 1;
            case 'zig_zag'
                displacement = 2;
        end
end

% UX
kernel.ux_ux = zeros(app(2,1) + displacement, app(2,1) + displacement, geo(3).layers);
kernel.ux_uy = zeros(app(2,1) + displacement, app(2,2) + displacement, geo(3).layers);
kernel.ux_uz = zeros(app(2,1) + displacement, app(2,3) + displacement, geo(3).layers); 
kernel.ux_sx = zeros(app(2,1) + displacement, app(1,1) + stress, geo(3).layers); 
kernel.ux_sy = zeros(app(2,1) + displacement, app(1,2) + stress, geo(3).layers);
kernel.ux_sz = zeros(app(2,1) + displacement, app(1,3) + stress, geo(3).layers);

% UY
kernel.uy_ux = zeros(app(2,2) + displacement, app(2,1) + displacement, geo(3).layers);
kernel.uy_uy = zeros(app(2,2) + displacement, app(2,2) + displacement, geo(3).layers);
kernel.uy_uz = zeros(app(2,2) + displacement, app(2,3) + displacement, geo(3).layers);
kernel.uy_sx = zeros(app(2,2) + displacement, app(1,1) + stress, geo(3).layers);
kernel.uy_sy = zeros(app(2,2) + displacement, app(1,2) + stress, geo(3).layers);
kernel.uy_sz = zeros(app(2,2) + displacement, app(1,3) + stress, geo(3).layers); 

% UZ
kernel.uz_ux = zeros(app(2,3) + displacement, app(2,1) + displacement, geo(3).layers);
kernel.uz_uy = zeros(app(2,3) + displacement, app(2,2) + displacement, geo(3).layers);
kernel.uz_uz = zeros(app(2,3) + displacement, app(2,3) + displacement, geo(3).layers);
kernel.uz_sx = zeros(app(2,3) + displacement, app(1,1) + stress, geo(3).layers); 
kernel.uz_sy = zeros(app(2,3) + displacement, app(1,2) + stress, geo(3).layers);
kernel.uz_sz = zeros(app(2,3) + displacement, app(1,3) + stress, geo(3).layers); 

% SX
kernel.sx_ux = zeros(app(1,1) + stress, app(2,1) + displacement, geo(3).layers);
kernel.sx_uy = zeros(app(1,1) + stress, app(2,2) + displacement, geo(3).layers);
kernel.sx_uz = zeros(app(1,1) + stress, app(2,3) + displacement, geo(3).layers);
kernel.sx_sx = zeros(app(1,1) + stress, app(1,1) + stress, geo(3).layers);
kernel.sx_sy = zeros(app(1,1) + stress, app(1,2) + stress, geo(3).layers);
kernel.sx_sz = zeros(app(1,1) + stress, app(1,3) + stress, geo(3).layers);

% SY
kernel.sy_ux = zeros(app(1,2) + stress, app(2,1) + displacement, geo(3).layers);
kernel.sy_uy = zeros(app(1,2) + stress, app(2,2) + displacement, geo(3).layers);
kernel.sy_uz = zeros(app(1,2) + stress, app(2,3) + displacement, geo(3).layers);
kernel.sy_sx = zeros(app(1,2) + stress, app(1,1) + stress, geo(3).layers); 
kernel.sy_sy = zeros(app(1,2) + stress, app(1,2) + stress, geo(3).layers); 
kernel.sy_sz = zeros(app(1,2) + stress, app(1,3) + stress, geo(3).layers);

% SZ
kernel.sz_ux = zeros(app(1,3) + stress, app(2,1) + displacement, geo(3).layers);
kernel.sz_uy = zeros(app(1,3) + stress, app(2,2) + displacement, geo(3).layers);
kernel.sz_uz = zeros(app(1,3) + stress, app(2,3) + displacement, geo(3).layers);
kernel.sz_sx = zeros(app(1,3) + stress, app(1,1) + stress, geo(3).layers);
kernel.sz_sy = zeros(app(1,3) + stress, app(1,2) + stress, geo(3).layers);
kernel.sz_sz = zeros(app(1,3) + stress, app(1,3) + stress, geo(3).layers); 




end

