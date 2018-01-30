cmake_minimum_required(VERSION 3.3)

set(THE_PROJECT_NAME opencv-dnn-demo)
set(THE_PROJECT_VERSION 1.0.0)

project(${THE_PROJECT_NAME} VERSION ${THE_PROJECT_VERSION})

find_package(OpenCV 3 REQUIRED)

add_subdirectory(src)
