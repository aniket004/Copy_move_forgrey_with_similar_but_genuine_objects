CONTENTS OF THIS FILE
---------------------
* Introduction
* Requirements
* Installation
* Contents
* How to compile OpenCV mex function
* Example


INTRODUCTION
------------
"Computer Vision System Toolbox OpenCV Interface" is used to create mex files 
that link against OpenCV.

REQUIREMENTS
------------
This package requires the following:
* Computer Vision System Toolbox® Version R2015a installation
* A compatible C++ compiler

The mex function uses pre-built OpenCV libraries which are shipped with the 
Computer Vision System Toolbox. Your compiler must be compatible with the 
pre-built OpenCV libraries. The following is a list of compatible compilers:
    Windows 32 bit: MS Visual Studio 2012
    Windows 64 bit: MS Visual Studio 2012
    Linux 64 bit: gcc-4.7.2 (g++)
    Mac 64 bit: Xcode 5.0.2 (Clang++)

INSTALLATION
------------
Use the support package installer which can be invoked using the  
visionSupportPackages function.
After the support package is installed, the location of the package can be 
found by executing the following MATLAB command:
>> fileparts(which('mexOpenCV.m'))

CONTENTS
--------
In addition to the files and folders required by the support package installer, 
the package contains the following folders:

example: Three subfolders containing examples. Each subfolder contains a source 
	 file that calls the OpenCV function and the test script to test the 
	 generated mex file.
opencv:  OpenCV header files and the .lib files required for Windows® platforms. 
     This folder also contains the OpenCV license file.

HOW TO COMPILE OPENCV MEX FUNCTION
----------------------------------
Follow these steps:
1. Change your current working folder to the folder where the source file is located. 
2. Call the mexOpenCV function with the source file. 
>> mexOpenCV yourfile.cpp

To get more information, type the following at the MATLAB command prompt:
>> help mexOpenCV

EXAMPLES
--------
There are three examples included in the package: 
* Template Matching  
* Image registration using ORB detector and descriptor
* Foreground Detection

To run them, follow the steps in the README.txt file located in the corresponding 
sub-folders of the examples folder.

