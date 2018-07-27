% MATCH_FEATURES: Match SIFT features in a single image using our multiple
%                 match strategy.
% 
% INPUTS:
%   filename        - image filename (if features have to be computed) or
%                     descriptors filename in the other case
%   filesift        - [opt] file containing sift descriptors
%
% OUTPUTS:
%   num             - number of matches
%   p1,p2           - coordinates of pair of matches
%   tp              - computational time    
%
% EXAMPLES:
%   e.g. extract features and matches from a '.jpg' image:
%   [num p1 p2 tp] = match_features('examples/tampered1.jpg')
%
%   e.g. import features and matches from a '.sift' descriptors file:
%   [num p1 p2 tp] = match_features('examples/tampered2.sift',0)                      
% 
% ---
% Authors: I. Amerini, L. Ballan, L. Del Tongo, G. Serra
% Media Integration and Communication Center
% University of Florence
% May 7, 2012

function [num p1 p2 tp] = match_features(filename, filesift)

% thresholds used for g2NN test
dr2 = 0.95;  % originally 0.5

%lim = 40;

% extract_feat = 1; % by default extract SIFT features using Hess' code
% 
% if(exist('filesift','var') && ~strcmp(filesift,'nofile'))
%     extract_feat = 0; 
% end
% 
 tic; % to calculate proc time
% 
% if extract_feat
%     sift_bin = fullfile('lib','sift','bin','siftfeat');   % e.g. 'lib/sift/bin/siftfeat' in linux
%     [pf,nf,ef] = fileparts(filename);
%     desc_file = [fullfile(pf,nf) '.txt'];
%     
%     im1=imread(filename);
%     if (size(im1,1)<=1000 && size(im1,2)<=1000)
%         status1 = system([sift_bin ' -x -o ' desc_file ' ' filename]);
%     else
%         status1 = system([sift_bin ' -d -x -o ' desc_file ' ' filename]);
%     end
% 
%     if status1 ~=0 
%         error('error calling executables');
%     end
% 
%     % import sift descriptors
%     [num, locs, descs] = import_sift(desc_file);
%     system(['rm ' desc_file]);
% else
%     % import sift descriptors
%     [num, locs, descs] = import_sift(filesift);
% end

img = rgb2gray(imread(filename));


points = detectSURFFeatures(img);
points = points.selectStrongest(50);
num = points.Count;
locs = points.Location;

% % select anyone of the feature for feature matching
% % SURF feature
% SURF_feature = extractFeatures(img,points);
% descs = SURF_feature;

% % HOG feature
% HOG_feature = extractHOGFeatures(img,points);
% descs = HOG_feature;

%LBP feature
uLBP_feature = extract_uLBP(img,locs);
%descs = LBP_feature;

%riLBP feature
uriLBP_feature = extract_uriLBP(img,locs);
%descs = riLBP_feature;

% % uriLBP feature
% uriLBP_feature = extract_uriLBP(img,locs);
% descs = uriLBP_feature;

% SVD feature
svd_feature = extract_svd(img,locs);
%descs = svd_feature;

% DCT feature
dct_feature = extract_dct(img,locs);
%descs = dct_feature;

descs = [uLBP_feature uriLBP_feature svd_feature dct_feature];

% % RLBP feature 
% RLBP_feature = extract_RLBP(img,locs);
% descs = RLBP_feature;

% % uRLBP feature 
% uRLBP_feature = extract_uRLBP(img,locs);
% descs = uRLBP_feature;

% LTP feature
%LTP_feature = extract_LTP(img,locs);
%descs = LTP_feature;

%descs = [RLBP_feature LTP_feature];

% % ORB feature
% ORB_feature  = extractORBFeaturesOCV(img,points);
% descs = ORB_feature;



% %%%%%%% reading features from file
% 
% points = csvread('sift_cor_g_noise_1.csv');
% features = csvread('sift_des_g_noise_1.csv');
% num = lim;
% 
% 
% i = filename;
% locs = points((lim*(i-1)+1):lim*i,:);
% descs = features((lim*(i-1)+1):lim*i,:);


if (num==0)
    p1=[];
    p2=[];
    tp=[];
else
    p1=[];
    p2=[];
    num=0;
    
    % load data
    loc1 = locs(:,1:2);
    %scale1 = locs(:,3);
    %ori1 = locs(:,4);
    des1 = descs;
    
    % descriptor are normalized with norm-2
    if (size(des1,1)<15000)
        des1 = des1./repmat(sqrt(diag(des1*des1')),1,size(des1,2));
    else
        des1_norm = des1; 
        for j= 1 : size(des1,2)
            des1_j = des1_norm(j,:);
            des1_norm(j,:) = des1_j/norm(des1_j,2); 
        end
        des1 = des1_norm;
    end
    
    % sift matching
    des2t = des1';   % precompute matrix transpose
    if size(des1,1) > 1 % start the matching procedure iff there are at least 2 points
        for ii = 1 : size(des1,1)
            dotprods = des1(ii,:) * des2t;        % Computes vector of dot products
            [vals,indx] = sort(acos(dotprods));  % Take inverse cosine and sort results

            j=2;
            while vals(j)<dr2* vals(j+1) 
                j=j+1;
            end
            for k = 2 : j-1
                match(ii) = indx(k); 
                if pdist([loc1(ii,1) loc1(ii,2); loc1(match(ii),1) loc1(match(ii),2)]) > 1 % originally 10
                    p1 = [p1 [loc1(ii,2); loc1(ii,1); 1]];
                    p2 = [p2 [loc1(match(ii),2); loc1(match(ii),1); 1]];
                    num=num+1;
                end
            end
        end
    end
    
    tp = toc; % processing time (features + matching)
    
    if size(p1,1)==0
        fprintf('Found %d matches.\n', num);
    else
        p=[p1(1:2,:)' p2(1:2,:)'];
        p=unique(p,'rows');
        p1=[p(:,1:2)'; ones(1,size(p,1))];
        p2=[p(:,3:4)'; ones(1,size(p,1))];
        num=size(p1,2);
        fprintf('Found %d matches.\n', num);
    end
   
end
