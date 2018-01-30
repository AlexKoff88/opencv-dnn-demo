cmake_minimum_required(VERSION 3.3)

if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
    find_package(OpenCV 3 REQUIRED)
endif()

add_executable(example_googlenet example_googlenet.cpp)
target_compile_options(example_googlenet  PUBLIC "-std=c++11")
target_link_libraries(example_googlenet  PRIVATE ${OpenCV_LIBS})

set_target_properties(example_googlenet
    PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

add_executable(example_mobilenet example_mobilenet.cpp)
target_compile_options(example_mobilenet  PUBLIC "-std=c++11")
target_link_libraries(example_mobilenet  PRIVATE ${OpenCV_LIBS})

set_target_properties(example_mobilenet
    PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

