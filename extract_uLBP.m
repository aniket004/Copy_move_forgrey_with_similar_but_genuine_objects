function uLBP_feature = extract_uLBP(img,locs)

[m n] = size(locs);

% % parameter for LBP and RILBP
% nFiltSize=8;
% nFiltRadius=1;
% filtR=generateRadialFilterLBP(nFiltSize, nFiltRadius);
% binsRange=(1:2^nFiltSize)-1;
for i = 1:m
    x_pt = floor(locs(i,2));
    y_pt = floor(locs(i,1));
    
    % 5*5 image patch
    img_patch = img(x_pt-2:x_pt+2,y_pt-2:y_pt+2);
    loc_feature(i,:) = [x_pt y_pt];
    
    % uriLBP feature
    MAPPING=getmapping(8,'u2');
    LBPHIST_u=lbp(img_patch,1,8,MAPPING,'hist');
    uLBP_feature(i,:) = LBPHIST_u;
    
end
end