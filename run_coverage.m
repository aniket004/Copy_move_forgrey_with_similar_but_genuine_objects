% RUN EXPERIMENT

% parameters for clustering
metric = 'ward';
th = 2.2;
min_pts = 3;

% results
%th=3 riLBP 0.4559
%th=2.2 riLBP 0.4341
%th=3 rlbp 0.1481
%th3 min_pts=3 rlbp 0.4496
% th =2.2 rlbp+ltp 0.4375
% th = 2.2 rlbp(2,16) 0.4615
% th = 2.2  min_pts=3 rlbp(3,8) dr2 =0.7 0.5429
% th = 2.2 min_pt=3 rlbp(3,8) dr2=0.5 0.4496
% th =2.2 min_pt=3 rlbp(3,8) 17*17 dr2 = 0.9 0.6353
% th =2.2 min_pt=3 rlbp(3,8) 19*19 dr2 = 0.95 d=0.01  0.6484
% th =2.2 min_pt=3 rlbp(1,8) 21*21 dr2 = 0.95 d=1 0.4789 TP 34 TN 92 FN 66
% FP 8.
% th =2.2 min_pt=3 rlbp(2,8) 21*21 dr2 = 0.95 d=1 0.5802 TP 47 TN 85 FN 53
% FP 15.
% th =2.2 min_pt=3 rlbp(3,8) 21*21 dr2 = 0.95 d=1 0.6519 TP 59 TN 78 FN 41
% FP 22.
% th =2.2 min_pt=3 rlbp(4,8) 21*21 dr2 = 0.95 d=1 0.6947 TP 66 TN 76 FN 34
% FP 24.  (acc = 71)
% th =2.2 min_pt=3 rlbp(4,8) 21*21 dr2 = 0.95 d=2 0.6839 TP 66 TN 73 FN 34
% FP 27.
% th =2.2 min_pt=3 rlbp(4,8) 21*21 dr2 = 0.95 d=1 no_gem_tr=1 0.6258 TP 51
% TN 88 FN 49 FP 12. %% best no_gem_tr=1. 
% th =2.2 min_pt=3 urlbp(4,8) 21*21 dr2 = 0.95 d=1 no_gem_tr=1 0.6809 TP 64
% TN 76 FN 36 FP 24. %% best no_gem_tr=1.
% th =2.2 min_pt=3 urlbp(3,8) 21*21 dr2 = 0.95 d=1 no_gem_tr=1 0.6467 TP 54
% TN 87 FN 46 FP 13. %% best no_gem_tr=1.
% th =2.2 min_pt=3 SURF dr2 = 0.95 d=1 no_gem_tr=1 0.6141 TP 74
% TN 33 FN 26 FP 67.   (acc = 53.5 )
% th =2.2 min_pt=3 LBP+riLBP+svd+dct dr2=0.95 d=1 0.6154 TP 64 TN 56 FN 36
% FP 44
% ICASSP th =2.2 min_pt=3 uLBP+uriLBP+svd+dct dr2=0.95 d=1 0.4713 TP 37 TN
% 80 FN 63 FP 20  (acc = 58.5 )
% th =2.2 min_pt=3 rlbp(5,8) 21*21 dr2 = 0.95 d=1 0.6737 TP 64 TN 74 FN 36
% FP 26.
% th =2.2 min_pt=3 rlbp(6,8) 21*21 dr2 = 0.95 d=1 0.6484 TP 59 TN 77 FN 41
% FP 23.
% coverage_QF_60 th =2.2 min_pt=3 rlbp(4,8) 21*21 dr2 = 0.95 d=1  0.5430 TP
% 41 TN 90 FN 59 FP 10.  (acc = 65.5 )
% coverage_QF_60 th =2.2 min_pt=3 SURF 21*21 dr2 = 0.95 d=1   0.6349  TP
% 80 TN 28 FN 20 FP 72.  (acc = 54 )
% coverage_QF_60 th =2.2 min_pt=3 ICASSP 21*21 dr2 = 0.95 d=1   0.4839  TP 
% 30 TN 54 FN 43 FP 21. (interapted 149) (acc = 42 )
% coverage_QF_80 th =2.2 min_pt=3 rlbp(4,8) 21*21 dr2 = 0.95 d=1  0.6467 TP
% 54 TN 87 FN 46 FP 13.  (acc = 70.5 )
% coverage_QF_80 th =2.2 min_pt=3 SURF 21*21 dr2 = 0.95 d=1  0.6556   TP
% 79 TN 38 FN 21 FP 62.  (acc = 58.5 )
% coverage_QF_80 th =2.2 min_pt=3 ICASSP 21*21 dr2 = 0.95 d=1   0.4371   TP 
% 33 TN 82 FN 67 FP 18.  (acc = 57.5 )
% coverage_g_noise_0.5 th =2.2 min_pt=3 rlbp(4,8) 21*21 dr2 = 0.95 d=1  0.6701 TP
% 65 TN 71 FN 35 FP 29.  (acc = 68 )
% coverage_g_noise_0.5 th =2.2 min_pt=3 SURF 21*21 dr2 = 0.95 d=1  0.6457  TP
% 82 TN 28 FN 18 FP 72. (acc = 55 )
% coverage_g_noise_0.5 th =2.2 min_pt=3 ICASSP 21*21 dr2 = 0.95 d=1  0.4790  TP
% 40 TN 73 FN 60 FP 27. (acc = 56.5 )
% coverage_g_noise_1 th =2.2 min_pt=3 rlbp(4,8) 21*21 dr2 = 0.95 d=1  0.6316 TP
% 66 TN 57 FN 34 FP 43. (acc = 61.5 )
% coverage_g_noise_1 th =2.2 min_pt=3 SURF 21*21 dr2 = 0.95 d=1  0.6337  TP
% 77 TN 34 FN 23 FP 66. (acc = 55.5)
% coverage_g_noise_1 th =2.2 min_pt=3 ICASSP 21*21 dr2 = 0.95 d=1  0.4380  TP
% 93 TN 30 FN 70 FP 7. (acc = 61.5)

% other database 
% Manipulate th =2.2 min_pt=3 rlbp(4,8) 21*21 dr2 = 0.5 d=10  0.9091 TP 40
% TN 0 FN 8 FP 0.   %% 48 images 


% parameter for LBP and RILBP
nFiltSize=8;
nFiltRadius=1;
filtR=generateRadialFilterLBP(nFiltSize, nFiltRadius);
binsRange=(1:2^nFiltSize)-1;

% input images from dataset
%dr=uigetdir();

dr = 'E:\research_MS_code\Coverage\sift-forensic-master\sift-forensic-master\COVERAGE_Modified\image\';

list=dir([dr, '/*.tif']);        %here jpg is file extension of the images
num_images = length(list);

TP = 0;   % True Positive
TN = 0;   % True Negative
FP = 0;   % False Positive
FN = 0;   % False Negative

for i = 1:1
%parfor i = 1:num_images   % use for parallel computation (needs matlabpool)

%     % original '0' | forged '1'
%     if( isempty(findstr(list(i).name,'t.')) == 0 )
%         label(i) = 1 ;
%     else
%         label(i) = 0;
%     end
    
    label(i) = 1;
    
    % reading image 
    imagePath = [dr, '/', list(i).name];
                
    % process an image
    i
    countTrasfGeom = process_image(imagePath, metric, th, min_pts, 0);
                
    if countTrasfGeom>=1
        if (label(i) == 1)
            TP = TP+1;
        else
            FP = FP+1;
        end 
    else
        if (label(i) == 1)
            FN = FN+1;
        else
            TN = TN+1;
        end
    end

end

% compute performanca
fmeas = 2*TP/(2*TP+FN+FP)


% % compute performance             
% FPR  = FP/(FP+TN);
% TPR  = TP/(TP+FN);
% fprintf('\nCopy-Move Forgery Detection performance:\n');
% fprintf('\nTPR = %1.2f%%\nFPR = %1.2f%%\n', TPR*100, FPR*100);

% % compute computational time
% tproc = toc(tstart);
% tps = datestr(datenum(0,0,0,0,0,tproc),'HH:MM:SS');
% fprintf('\nComputational time: %s\n', tps);
