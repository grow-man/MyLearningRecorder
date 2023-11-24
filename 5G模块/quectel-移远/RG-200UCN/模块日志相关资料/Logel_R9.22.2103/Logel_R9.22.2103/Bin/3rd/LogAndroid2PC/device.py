import os
import time
import logging
import subprocess
from threading import Timer
import psutil
import csv
class Device(object):
    def __init__(self, deviceID):
        self.mDeviceID = deviceID
        self.ADB = "adb -s " + self.mDeviceID
        self.sdcardPath = ""
    def getDeviceID(self):
        return  self.mDeviceID

    def getProp(self, prop):
        cmd = self.ADB + " shell getprop " + prop
        result,output,error = self.runCmd(cmd)
        if result == 0:
            return  output.strip()
        else:
            return ""

    def getProductName(self):
        productName = self.getProp("ro.product.name")
        return productName

    def waitForDeviceConnected(self, timeout):
        DISCONNECED = "not found"
        startTime = time.time()
        while time.time() - startTime < timeout:
            cmd_1 = self.ADB+" shell getprop dev.bootcomplete"
            resultCode_1, output_1, error_1 = self.runCmd(cmd_1)
            if DISCONNECED in output_1 or DISCONNECED in error_1:
				cmd_2 = self.ADB+" root"
				resultCode_2, output_2, error_2 = self.runCmd(cmd_2)
				if DISCONNECED in output_2 or DISCONNECED in error_2:
					logging.info(self.mDeviceID + "device is not connected ,wait....")
					time.sleep(2)
				else:
					logging.info(self.mDeviceID+" device connected")
					return True
            else:
                logging.info(self.mDeviceID+" device connected")
                return  True
        return False

    def pushFile(self, source,  des):
        cmd = self.ADB + " push " + source + " " + des
        output = os.popen(cmd)
        for line in output.readlines():
            logging.info(line)

    def runLongTimeCmd(self, cmd):
        cmd_list = self.split(cmd)
        adb_proc = subprocess.Popen(cmd_list, stdin=subprocess.PIPE, \
                                        stdout=subprocess.PIPE, \
                                        stderr=subprocess.STDOUT, shell=False)
        while True:
            line = adb_proc.stdout.readline()
            logging.info(str(line))
            if not line:
                if adb_proc.poll() is not None:
                    break
        return adb_proc.returncode

    def pullFile(self, source,  des):
        deviceConnected = self.waitForDeviceConnected(60)
        if deviceConnected == False:
            logging.warning("device is not connected")
            result = -1
            error= "device is not connected"
            return result,error
        cmd = self.ADB + " pull \"" + source + "\" \"" + des+ "\""
        result = self.runLongTimeCmd(cmd)
        return  result

    def root(self):
        cmd = self.ADB + " root"
        self.runCmd(cmd)

    def getSdcardPath(self):
        if len(self.sdcardPath) > 0:
            logging.info(self.mDeviceID +"  sdcard path is "+self.sdcardPath)
            return  self.sdcardPath
        res = self.waitForDeviceConnected(10)
        if res == False:
            logging.error("device is not connected")
            return ""
        self.sdcardPath = "/storage/sdcard0"
        res,fileList = self.getFileList (self.sdcardPath)
        if len(fileList) > 0:
            logging.info(self.mDeviceID + ":sdcard path is " + self.sdcardPath)
            return self.sdcardPath
        self.sdcardPath = "/storage/sdcard1"
        res,fileList = self.getFileList (self.sdcardPath)
        if len(fileList) > 0:
            logging.info(self.mDeviceID + ":sdcard path is " + self.sdcardPath)
            return self.sdcardPath
        self.sdcardPath = self.getProp("vold.sdcard0.path")
        if len(self.sdcardPath) > 0:
            logging.info(self.mDeviceID + ":sdcard path is " + self.sdcardPath)
            return  self.sdcardPath
        else:
            self.sdcardPath = ""
            resultCode, output, error = self.runCmd(self.ADB + " shell mount")
            if resultCode == 0:
                temp = output.split("\n")
                for line in temp:
                    if "/mnt/media_rw/" in line:
                        temp1 = line.split()
                        if len(self.sdcardPath ) > 0:
                            break
                        for words in temp1:
                            if "/mnt/media_rw/" in words:
                                self.sdcardPath = words.replace("/mnt/media_rw/","/storage/")
                                break
        logging.info(self.mDeviceID + ":sdcard path is "+str(self.sdcardPath))
        return  self.sdcardPath

    def getFileList(self,dir):
        res = 0
        fileList = []
        ERROR_CMD = "Unknown option"
        ERROR_DIR = "No such file or directory"
        cmd = "adb -s " + self.mDeviceID + " shell ls -1 " + dir
        #logging.info("list files in " + dir+":")
        resultCode, output, error = self.runCmd(cmd)
        if ERROR_CMD in output or ERROR_CMD in error:
            cmd = "adb -s " + self.mDeviceID + " shell ls " + dir
            resultCode, output, error = self.runCmd(cmd)
        #logging.info("output " + output )
        temp = output.split("\n")
        for line in temp:
            line = line.strip()
            if ERROR_DIR in line:
                res = 1
                break
            elif line.startswith("ls"):
                continue
            else:
                name = line.strip().replace("\\", "")
                if len(name) > 0:
                    fileList.append(name)
        if resultCode != 0:
            res = 3
            logging.warning("getFileList error:"+error)
        if len(fileList) == 0:
            res = 2
        return res,fileList

    def runCmd(self, cmd):
        resultCode = 0
        error = ""
        output = ""
        try:
            cmd_list = self.split(cmd)
            adb_proc = subprocess.Popen(cmd_list, stdin=subprocess.PIPE, \
                                        stdout=subprocess.PIPE, \
                                        stderr=subprocess.PIPE, shell=False)
            (output, error) = adb_proc.communicate()
            resultCode = adb_proc.returncode
        except:
            pass
        return resultCode,output,error

    def kill_proc(self, proc, timeout):
        timeout["value"] = True
        psutil.Process(proc.pid).terminate()
        proc.kill()

    def split(self,str):
        for row in csv.reader([str], delimiter=" "):
            return row

    def runCmdTimeout(self, cmd, timeout_sec):
        cmd = self.ADB + " shell "+ cmd
        output = ""
        error = ""
        timeout = {"value": False}
        try:
            cmd_list = self.split(cmd)
            adb_proc = subprocess.Popen(cmd_list,  stdout=subprocess.PIPE, \
                                        stderr=subprocess.PIPE, shell=False)
            timer = Timer(timeout_sec, self.kill_proc, [adb_proc, timeout])
            timer.start()

            (output, error) = adb_proc.communicate()
            timer.cancel()
            return timeout["value"],output,error

        except Exception, e:
            print repr(e)
            pass

        return timeout["value"],output,error
