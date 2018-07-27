//////////////////////////////////////////////////////////////////////////
// Creates C++ MEX-file for Gaussian Mixture-based Background/Foreground 
// Segmentation Algorithm in OpenCV. This uses BackgroundSubtractorMOG2 
// class in OpenCV.
//
// Copyright 2014 The MathWorks, Inc.
//////////////////////////////////////////////////////////////////////////

#include "opencvmex.hpp"
// On some platforms, the following include is needed for "placement new".
// For more information see: http://en.wikipedia.org/wiki/Placement_syntax
#include <memory> 
using namespace cv;

static BackgroundSubtractorMOG2 *ptrBackgroundModel = NULL;

//////////////////////////////////////////////////////////////////////////////
// Check inputs
//////////////////////////////////////////////////////////////////////////////
void checkInputs(int nrhs, const mxArray *prhs[])
{
    if ((nrhs < 1) || (nrhs > 2))
    {
        mexErrMsgTxt("Incorrect number of inputs. Function expects 1 or 2 inputs.");
    }
}

//////////////////////////////////////////////////////////////////////////////
// Get MEX function inputs
//////////////////////////////////////////////////////////////////////////////
void getParams(int &history, float &varThreshold, bool &bShadowDetection, const mxArray* mxParams)
{
    const mxArray* mxfield;

    //--history--
    mxfield = mxGetField(mxParams, 0, "history");
    if (mxfield)
        history = (int)mxGetScalar(mxfield);

    //--varThreshold--
    mxfield = mxGetField(mxParams, 0, "varThreshold");
    if (mxfield)
        varThreshold = (float)mxGetScalar(mxfield);

    //--bShadowDetection--
    mxfield = mxGetField(mxParams, 0, "bShadowDetection");
    if (mxfield)
        bShadowDetection = (bool)mxGetScalar(mxfield);
}

//////////////////////////////////////////////////////////////////////////////
// Exit function for freeing persistent memory
//////////////////////////////////////////////////////////////////////////////
void exitFcn() 
{
    if (ptrBackgroundModel != NULL){
        // explicitly call destructor for "placement new"
        ptrBackgroundModel->~BackgroundSubtractorMOG2();
        mxFree(ptrBackgroundModel);
        ptrBackgroundModel = NULL;
    }
}

//////////////////////////////////////////////////////////////////////////////
// Construct object
//////////////////////////////////////////////////////////////////////////////
void constructObject(const mxArray *prhs[])
{  
    int history;
    float varThreshold;
    bool bShadowDetection;

    // second input must be struct
    if (mxIsStruct(prhs[1]))
        getParams(history, varThreshold, bShadowDetection, prhs[1]);

    if (ptrBackgroundModel!=NULL) exitFcn();

    // Allocate memory for background subtractor model
    ptrBackgroundModel = (BackgroundSubtractorMOG2 *)mxCalloc(1, sizeof(BackgroundSubtractorMOG2));
    // Make memory allocated by MATLAB software persist after MEX-function completes. 
    // This lets us use the updated background subtractor model for the next frame.
    mexMakeMemoryPersistent(ptrBackgroundModel);
    // Use "placement new" to construct an object on memory that was
    // already allocated using mxCalloc
    new (ptrBackgroundModel) BackgroundSubtractorMOG2(history, varThreshold, bShadowDetection);

    // Register a function that gets called when the MEX-function is cleared. 
    // This function is responsible for freeing persistent memory
    mexAtExit(exitFcn);
}

//////////////////////////////////////////////////////////////////////////////
// Compute foreground mask
//////////////////////////////////////////////////////////////////////////////
void computeForegroundMask(mxArray *plhs[], const mxArray *prhs[])
{
    if (ptrBackgroundModel!=NULL)
    {
        Mat fgmask, fgimg;

        cv::Ptr<cv::Mat> img = ocvMxArrayToImage_uint8(prhs[1], true);

        // compute foreground mask
        ptrBackgroundModel->operator ()(*img, fgmask);
        plhs[0] = ocvMxArrayFromImage_bool(fgmask);
    }
}

//////////////////////////////////////////////////////////////////////////////
// The main MEX function entry point
//////////////////////////////////////////////////////////////////////////////
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{  	
    checkInputs(nrhs, prhs);
    const char *str = mxIsChar(prhs[0]) ? mxArrayToString(prhs[0]) : NULL;

    if (str != NULL) 
    {
        if (strcmp (str,"construct") == 0)
            constructObject(prhs);
        else if (strcmp (str,"compute") == 0)
            computeForegroundMask(plhs, prhs);
        else if (strcmp (str,"destroy") == 0)
            exitFcn();

        // Free memory allocated by mxArrayToString
        mxFree((void *)str);
    }
}

