project('QLog','c')
executable('QLog', \
    'main.c', 'asr.c', 'mdm.c', 'tty2tcp.c', 'sahara.c', 'tftp.c', 'ymodem.c', 'unisoc.c', 'usb_linux.c', 'ftp.c', 'mtk.c', 'sony.c', \
    dependencies : [ declare_dependency(link_args: '-lpthread') ], \
    c_args : [ '-Wall', '-Wextra', '-Werror' ] \
)
