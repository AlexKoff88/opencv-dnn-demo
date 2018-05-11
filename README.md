
# opencv-dnn-demo

Repository with samples of OpenCV DNN module usage

## Prerequisites
* MicroSoft Visual Studio 2015 (https://www.visualstudio.com/vs/older-downloads/)

## Installation
* If you use git you need to set you proxy settings like this:
``` 
 git config --global http.proxy http://<address>:<port>
 git config --global https.proxy http://<address>:<port>
```
* Set proxy variables for Windows command line:
 ``` 
set HTTP_PROXY=http://<address>:<port>
set HTTPS_PROXY=http://<address>:<port>
```
* Install cmake: https://cmake.org/download/
* Clone or download OpenCV 3.4 source: https://github.com/opencv/opencv
```
git clone -b 3.4 https://github.com/opencv/opencv.git
```
* Create build directory and enter it
* Build OpenCV with DNN module:
```
"C:\Program Files\CMake\bin\cmake.exe" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DBUILD_EXAMPLES=ON ^
    -DBUILD_LIST=dnn,python2,videoio,highgui ^
    -DWITH_IPP=OFF -DWITH_OPENCL=OFF ^
    -G "Visual Studio 14 Win64" /path/to/opencv

"C:\Program Files\CMake\bin\cmake.exe" --build . --config Release -- /m:4
```
## Get samples
 * Clone or download Demo source: https://github.com/AlexKoff88/opencv-dnn-demo
 * Create build directory and enter it
 * Build it using cmake, specify OpenCV build folder:
 ```
 "C:\Program Files\CMake\bin\cmake.exe" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -G "Visual Studio 14 Win64" ^
    -DOpenCV_DIR=<path to OpenCV build> <path to source code>

 "C:\Program Files\CMake\bin\cmake.exe" --build . --config Release -- /m:4
```
 * Copy OpenCV DLLs into output folder, by default it is ```bin\Release```
 
## Download models
* Run cmd.exe and execute a ```scripts/download_data.ps1``` PowerShell  script from repository to download models:
   ```
  Powershell.exe -ExecutionPolicy ByPass -File download_data.ps1
  ```
 ## Run samples
 * Go to output project folder,  by default it is ```bin\Release```
 * Classification example (Caffe):
   ```
   example_googlenet.exe --image=data\space_shuttle.jpg  --label=data\synset_words.txt ^
   --model=data\bvlc_googlenet.caffemodel --proto=data\bvlc_googlenet.prototxt
   ```
 * Detection example (TensorFlow):
   * For single image or video
        ```
      example_mobilenet.exe ^
      --model=data\ssd_mobilenet_v1_coco_11_06_2017\frozen_inference_graph.pb ^
      --proto=data\ssd_mobilenet_v1_coco.pbtxt  --video=data\googlenet_0.png ^
      --min_confidence=0.5 
     ```
   * Using your web camera:
        ```
      example_mobilenet.exe ^
      --model=data\ssd_mobilenet_v1_coco_11_06_2017\frozen_inference_graph.pb ^
      --proto=data\ssd_mobilenet_v1_coco.pbtxt  --camera=0 ^
      --min_confidence=0.5 
     ```
## Run model in your browser
 * https://docs.opencv.org/3.4.0/d5/d86/tutorial_dnn_javascript.html (web camera is required)