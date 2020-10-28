#########################
# CUDA
#########################
 

 
string (APPEND CMAKE_CUDA_FLAGS  " -cudart shared")


string (APPEND CMAKE_CUDA_FLAGS  " -gencode arch=compute_30,code=sm_30")


#string(APPEND CMAKE_CUDA_FLAGS  " --use_fast_math"  )
 #string(APPEND CMAKE_CUDA_FLAGS  " -std=c++14"  )
  set (CMAKE_CUDA_FLAGS_DEBUG "-Xcompiler=\"    -Ob0 /MDd  /Z7 /std:c++14\"")
  set (CMAKE_CUDA_FLAGS_RELEASE "-Xcompiler=\"  -Ob2 /MD /std:c++14\"")

 
set(LIBS_CUDA   cudart cuda cudadevrt curand cublas)
set(LIBS_CUDA_NPP  nppicc  nppc  nppim nppig nppist )
set(LIBS_CUDA_NVML     nvml )
set (LIBS_CUDA_STREAMS npps)
 




#only default to cuda 9.1 if not defined (jenskins cmake bug in cmd line)
 if ("${CUDA_TOOLKIT_ROOT_DIR}"  STREQUAL  "")
 message(STATUS "undefined cuda toolkit. Defaulting to 9.1")
 file(TO_CMAKE_PATH $ENV{CUDA_PATH_V10_0} CUDA100_NORMALISED_PATH)
 set (CUDA_TOOLKIT_PATH ${CUDA100_NORMALISED_PATH})
 else()
 set(CUDA_TOOLKIT_PATH ${CUDA_TOOLKIT_ROOT_DIR})
 endif() 

 
 include_directories( "${CUDA_TOOLKIT_PATH}/include")		
 SET(CUDA_DEPENDENCIES ${CUDA_DEPENDENCIES}
  #cuda
  "${CUDA_TOOLKIT_PATH}/bin/cudart64_100.dll"
  "${CUDA_TOOLKIT_PATH}/bin/cufft64_100.dll"
  "${CUDA_TOOLKIT_PATH}/bin/curand64_100.dll"
  "${CUDA_TOOLKIT_PATH}/bin/nppc64_100.dll"
  "${CUDA_TOOLKIT_PATH}/bin/npps64_100.dll"
  "${CUDA_TOOLKIT_PATH}/bin/nppicc64_100.dll"
  "${CUDA_TOOLKIT_PATH}/bin/nppig64_100.dll"
  "${CUDA_TOOLKIT_PATH}/bin/nppial64_100.dll"
  "${CUDA_TOOLKIT_PATH}/bin/nppidei64_100.dll"
  "${CUDA_TOOLKIT_PATH}/bin/nppif64_100.dll"
  "${CUDA_TOOLKIT_PATH}/bin/nppim64_100.dll"
  "${CUDA_TOOLKIT_PATH}/bin/nppist64_100.dll"
  "${CUDA_TOOLKIT_PATH}/bin/nppitc64_100.dll"

  "${CUDA_TOOLKIT_PATH}/bin/cublas64_100.dll"
)
 