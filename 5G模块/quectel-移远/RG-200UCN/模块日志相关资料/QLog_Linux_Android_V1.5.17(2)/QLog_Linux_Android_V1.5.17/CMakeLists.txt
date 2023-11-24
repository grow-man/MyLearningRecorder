cmake_minimum_required(VERSION 2.4) 

project(QLog) 
add_definitions(-Wall -Wextra -Werror -O1)

set( QLog_SRCS
     main.c asr.c mdm.c tty2tcp.c sahara.c tftp.c ymodem.c unisoc.c usb_linux.c ftp.c mtk.c sony.c
     )

add_executable(QLog ${QLog_SRCS})
target_link_libraries(QLog PUBLIC pthread) 
install (TARGETS QLog DESTINATION bin)
