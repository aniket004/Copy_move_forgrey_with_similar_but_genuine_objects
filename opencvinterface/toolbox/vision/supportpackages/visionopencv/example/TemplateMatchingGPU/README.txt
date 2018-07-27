This example is only supported on 64-bit platforms (Linux and Windows).

To run the Template Matching GPU example, follow these steps:

1. Change your current working folder to example/TemplateMatching where 
source file matchTemplateOCV_GPU.cpp is located

2. Create MEX-file from the source file:

On PC:
>> mexOpenCV matchTemplateOCV_GPU.cpp -lgpu -lmwocvgpumex -largeArrayDims

On Linux:
>> mexOpenCV matchTemplateOCV_GPU.cpp -lmwgpu -lmwocvgpumex -largeArrayDims


3. Run the test script:
>> testMatchTemplateGPU.m 
The test script uses the generated MEX-file.

