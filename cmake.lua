local cmake_start = s({
  name = "camke boilerplate",
  trig = "cmake_minimum_required",
  desc = "Basic camke boilerplate"
},
  fmt([[
cmake_minimum_required(VERSION 3.5)
set(PROJECT_NAME {})
project(${{PROJECT_NAME}})
set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_CXX_STANDARD {})
set(CMAKE_EXPORT_COMPILE_COMMANDS true)
set(CMAKE_CXX_FLAGS "-g -O0")
set(SOURCE_FILES
    ${{CMAKE_SOURCE_DIR}}/src/main.cpp
  {}
)
add_executable(${{PROJECT_NAME}} ${{SOURCE_FILES}})
target_include_directories(${{PROJECT_NAME}} PRIVATE
  ${{CMAKE_SOURCE_DIR}}/include
)
]], { i(1, "project_name"), i(2, "23"), i(3)}
  )
)

return {
  cmake_start
}
