function mexOpenCV(varargin)
%mexOpenCV Build custom C++ MEX-function based on OpenCV
%
%  Usage:
%     mexOpenCV [options ...] file [files ...]
% 
%  Description:
%     mexOpenCV compiles and links source files into a shared library
%     called a mex-file, executable from within MATLAB. The function is an
%     extension of MATLAB mex function. It automatically links against
%     OpenCV libraries and routines to convert between MATLAB and OpenCV
%     data types. 
%
%     The conversion routines are defined in 
%           (matlabroot)\extern\include\opencvmex.hpp.
%
%  Command Line Options Available on All Platforms:
%     See <a href="matlab:doc('mex')">mex function documentation</a> to learn about all available options.
%
%  Example - Create mex function calling OpenCV template matching routine
%  ----------------------------------------------------------------------
%  % Change folder to the location of matchTemplateOCV.cpp
%  baseFolder = fileparts(which('mexOpenCV.m'));
%  cd(fullfile(baseFolder,'example','TemplateMatching'));
%
%  % Create matchTemplateOCV.<mex file extension> in current folder with
%  % optional debug and verbose flags.
%  mexOpenCV matchTemplateOCV.cpp -g -v
%
%  % Test the generated mex file.
%  testMatchTemplate
%
%  See also mex

% Copyright 2014 The MathWorks, Inc.

arch = computer('arch');
baseDir = fileparts(mfilename('fullpath'));

%% Fill in structure describing items needed to build OpenCV based MEX file
cvstocvutil.include = fullfile(matlabroot, 'extern','include');
ocvconfig.include   = fullfile(baseDir,'opencv','include');

%% Check compiler compatibility
% Get the name of compiler from mex command; Warn for incompatible compiler
checkCompilerCompatibility();

%% Setup include paths
if ispc
    % Get the path for opencv .lib files from support package
    ocvconfig.sharedLibraries = fullfile(baseDir,'opencv', arch, 'lib');    
    % Get the path for libmwocvmex.lib from Computer Vision System Toolbox
    libDir = 'microsoft';
    linkLibPathMS = fullfile(matlabroot,'extern','lib',computer('arch'),libDir);
    cvstocvutil.sharedLibraries = linkLibPathMS;
else
    % Get the path for opencv .so/.dylib files from Computer Vision System
    % Toolbox
    ocvconfig.sharedLibraries = fullfile(matlabroot, 'bin', arch);
    % Get the path for libmwocvmex{.so, .dylib} from Computer Vision System
    % Toolbox
    cvstocvutil.sharedLibraries = ocvconfig.sharedLibraries;
end
ocvconfig.outputDirectory = pwd;

%% Define library info
% Use OpenCV version 2.4.9
if ispc
    ocvVer = '249'; 
    prefix = 'opencv_';
    lFlag = '-l';    
elseif ismac
    ocvVer = '.2.4.9';
    prefix = 'opencv_'; 
    lFlag = '-l';    
else  % linux  
    ocvVer = '.so.2.4.9';
    prefix = 'libopencv_'; 
    lFlag = '-l:';% use ":" to link against the full names of the libraries
end

%% Specify libraries to link against
% Full set is listed here: opencv_core opencv_features2d opencv_imgproc 
%    opencv_legacy opencv_ml opencv_nonfree opencv_objdetect opencv_photo
%    opencv_calib3d opencv_video opencv_flann opencv_contrib opencv_highgui
%    opencv_stitching opencv_ts opencv_videostab opencv_gpu
% Unsupported libraries are: opencv_highgui

% A limited set of the libraries are used below; you may wish to add more
%
%

libs = {'core', 'features2d', 'imgproc', 'ml', 'legacy', 'nonfree', ...
    'objdetect', 'photo', 'calib3d', 'video', 'flann', 'contrib'};

dashLibs = {'mwocvmex'};

includes = {['-I' ocvconfig.include],['-I' cvstocvutil.include]};

% Add GPU related files
if ~ismac % GPU not supported on mac
    if exist(fullfile(matlabroot,'toolbox','distcomp'),'dir')
        libs = [libs 'gpu'];       
        includes = [includes ['-I' ...
            fullfile(toolboxdir('distcomp'),'gpu','extern','include')]];
    end
end

libs          = strcat(prefix, libs, ocvVer);
versionedLibs = strcat(lFlag, libs);
dashLibs      = strcat('-l', dashLibs);


%% Build custom MEX function that links against OpenCV
try
    mex(includes{:},...
        ['-L' ocvconfig.sharedLibraries], ['-L' cvstocvutil.sharedLibraries],...
        dashLibs{:}, versionedLibs{:}, varargin{:} ); 
catch ME
    throw(ME);
end

%% ------------------------------------------------------------------------
function checkCompilerCompatibility()
compilerForMex = mex.getCompilerConfigurations('C++','selected');

thisComputer = computer;
isCompatCompiler = true;
if strcmp(thisComputer, 'GLNXA64')
    isCompatCompiler = strcmpi(compilerForMex.Name, 'g++') && ...
        (~isempty(strfind(compilerForMex.Location,'gcc-4.7.2/')) || ...
         ~isempty(strfind(compilerForMex.Details.CompilerExecutable,'gcc-4.7.2/')));
    compilerUsedForOpenCVlib = 'gcc-4.7.2 (g++)';

elseif strcmp(thisComputer, 'MACI64')
    isCompatCompiler = strcmpi(compilerForMex.Name, 'Xcode Clang++') && ...
        (~isempty(strfind(compilerForMex.Location,'Xcode5.0.2')) || ...
         ~isempty(strfind(compilerForMex.Details.CompilerExecutable,'Xcode5.0.2')));
    compilerUsedForOpenCVlib = 'Xcode 5.0.2 (Clang++)';
    
elseif strcmp(thisComputer, 'PCWIN64')
    isCompatCompiler = strcmpi(compilerForMex.Name, 'Microsoft Visual C++ 2012') && ...
        (~isempty(strfind(compilerForMex.Location,'Microsoft Visual Studio 11.0')) || ...
         ~isempty(strfind(compilerForMex.Details.CompilerExecutable,'Microsoft Visual Studio 11.0')));
    compilerUsedForOpenCVlib = 'Microsoft Visual C++ 2012';
    
end
if ~isCompatCompiler
    msg = horzcat('The OpenCV libraries were built using %s. \n Your ',... 
      'compiler is %s. \n These compilers may not be compatible. \n Note ',...
      'that you can select a compiler using ''mex -setup'' command.');
    warning(msg, compilerUsedForOpenCVlib, compilerForMex.Name);
end


