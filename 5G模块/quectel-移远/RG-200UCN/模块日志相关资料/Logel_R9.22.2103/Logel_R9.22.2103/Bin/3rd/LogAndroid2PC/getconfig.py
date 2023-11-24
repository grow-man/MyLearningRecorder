import subprocess
def runCmd( cmd):
    resultCode = 0
    error = ""
    try:
        adb_proc = subprocess.Popen(cmd, stdin=subprocess.PIPE, \
                                    stdout=subprocess.PIPE, \
                                    stderr=subprocess.PIPE, shell=True)
        (output, error) = adb_proc.communicate()
        resultCode = adb_proc.returncode
    except:
        pass
    return resultCode, output, error
if __name__ == "__main__":
    des_dir = "/data/anr/"
    des_dir = des_dir[0:-1]
    str = "/asdfdf/modem_memory.log"
    str = str.replace("external_storage","/storage/sdcard0")
    print(str)
