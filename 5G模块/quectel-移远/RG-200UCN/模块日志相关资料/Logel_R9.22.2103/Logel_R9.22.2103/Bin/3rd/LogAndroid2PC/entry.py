import logging
import os
import sys
import time
import re
ver = sys.version_info
if ver[0] == 3:
    mopen = open;
else:
    def mopen(file, mode='rb', buffering=-1, encoding=None, errors=None, newline=None, closefd=True, opener=None):
        return open(file, mode+'b')

def replace_invalid_word(name):
    rstr = r"[\/\\\:\*\?\"\<\>\|]"
    new_name = re.sub(rstr, "_", name)
    return new_name


def convert_data_time_to_milliseconds( date, time_stame):
    if date is not None and time is not None:
        date_time = date + " " + time_stame
        time_array = time.strptime(date_time, "%Y-%m-%d %H:%M")
        seconds = long(time.mktime(time_array))
        return seconds

def sort_log_entry_list_by_time(core_file_array):
    count = len(core_file_array)
    for i in range(0, count):
        for j in range(i + 1, count):
            if core_file_array[i].time_stam > core_file_array[j].time_stam:
                core_file_array[i], core_file_array[j] = core_file_array[j], core_file_array[i]

class CoreFileInfo(object):
    def __init__(self, name ,pid,time):
        self.name = name
        self.pid = pid
        self.time_stam = time
        self.pull_des_name = replace_invalid_word(name)

    def print_info(self):
        print (self.name +" " + str(self.time_stam))

class Entry:
    def __init__(self, param ,desDirInPc, isCmd):
        self.mParam = param
        self.nOldParam = param
        self.desDirInPc = desDirInPc
        self.isCmd = isCmd
        self.isFile = False
        self.mHavePulledFileList = []
        self.mNeedPullFileList = []
        self.RETRY_TIMES = 3
        self.error = 0

    def pullCorefile(self,device,result):
        '''
    -rw-------  1 u0_a23 u0_a23 1886027776 2012-01-01 18:56 core-droid.gallery3d-29585@1325444196
    -rw-------  1 u0_a47 u0_a47     144492 2012-01-01 18:56 maps_28841
        '''
        cmd = "adb -s " +device.mDeviceID + " shell ls -1 " + self.mParam
        logging.info("list files in "+self.mParam)
        output = os.popen(cmd)
        for line in output.readlines():
            logging.info(line)
        for name in self.mNeedPullFileList:
            file_name = replace_invalid_word(name)
            self.pull( device, self.mParam+"/"+name, self.desPath, result, file_name)

    def excute(self,device, topDir, result):
        deviceConnected = device.waitForDeviceConnected(60)
        if deviceConnected == False:
            self.error = 1
            result.writeResult("pull " + self.mParam + "failed ,device not connected\n")
            return
        self.topDir = topDir
        if  "external_storage" in self.nOldParam:
            sdcardPath = device.getSdcardPath()
            if len(sdcardPath) <= 0:
                result.writeResult("no sdcard insert," + self.mParam + "\n")
                return
            if len(sdcardPath)>0:
                self.mParam = self.nOldParam.replace("external_storage",sdcardPath)
        if self.isCmd == False:
            res = self.prePull(device)
            if res == 0:
                '''corefile need to pull only  the first four and the last four'''
                self.desPath = topDir + "/" + self.desDirInPc
                if "corefile" in self.mParam:
                    logging.info("pull corefile")
                    self.pullCorefile(device,  result)
                else:
                    self.pull(device,self.mParam, self.desPath,result,"")
            elif res == 1:
                logging.warning( "No such file or directory :"+self.mParam )
                result.writeResult("No such file or directory:"+self.mParam+"\n")
                return
            elif res == 2:
                logging.warning("no file in "+self.mParam)
                result.writeResult("no file in "+self.mParam+"\n")
                return
            self.afterPull(device,result)
        else:
            self.executeCmd(device)

    def prePull(self, device):
        """1:dir is not exist 2:dir exsit,but there is no file in the dir  0: ok"""
        corefileList = []
        coreFileEntryList = []
        res,fileList = device.getFileList(self.mParam)
        if  res != 0:
            return res
        logging.info("list file in "+self.mParam)
        for file in fileList:
            logging.info(file)
        if "corefile" in self.mParam:
            for fileName in fileList:
                if "core" in fileName and "@" in fileName:
                    corefileList.append(fileName)
                    tmp = fileName.split("@")
                    time_stam = tmp[-1]
                    pid = tmp[0].split("-")[-1]
                    coreFileInfo = CoreFileInfo(fileName, pid, int(time_stam))
                    coreFileEntryList.append(coreFileInfo)
                else:
                    self.mNeedPullFileList.append(fileName)
            if len(coreFileEntryList) > 0:
                sort_log_entry_list_by_time(coreFileEntryList)
                if len(coreFileEntryList) > 8:
                    needPullCorefileList = coreFileEntryList[0:4] + coreFileEntryList[-4:]
                else:
                    needPullCorefileList = coreFileEntryList[:]
                for corefile in needPullCorefileList:
                    self.mNeedPullFileList.append(corefile.name)
        else:
            self.mNeedPullFileList = fileList[:]
        logging.info(str(len(self.mNeedPullFileList)) + " files need to pull .")
        return  res

    def pull(self,device,srcFile,desFile,result, fileName=""):
        res = -1
        error = ""
        if os.path.exists(desFile) is False:
            os.makedirs(desFile )
        if len(fileName) > 0:
            desPath = os.path.join(desFile,fileName)
        else:
            desPath = desFile
        logging.info("start pull "+srcFile+",if pull failed,will try to pull less than 3 times")
        for i in range(self.RETRY_TIMES):
            logging.info("pull " + srcFile + " for "+ str(i+1)+ " time..... ")
            res = device.pullFile(srcFile, desPath)
            logging.info("pull " + srcFile + " end, res = "+str(res)+",0 means succusefull,other error")
            if res != 0:
                logging.error("pull "+ srcFile +" failed")
                logging.error("try to pull for another time")
                if i >= self.RETRY_TIMES -1:
                    logging.error("pull failed although try for " + str(i +1) + " times")
                    result.writeResult("when pull " + srcFile + " error happened \n")
                    self.error = 1
            else:
                break

    def afterPull(self, device,result):
        '''maybe do something after pull,compare the log files before and after,but the log files in the phone changed when pulling  out'''
        pass

    def removeOldCmdResult(self):
        cmdResultPath = os.path.join(self.topDir, self.desDirInPc)
        if os.path.exists(cmdResultPath):
            os.remove(cmdResultPath)

    def writeCmdResult(self, result):
        cmdResultPath = os.path.join(self.topDir, self.desDirInPc)
        fp = mopen(cmdResultPath, 'a+', encoding='utf8', errors='replace')
        fp.write(result)
        fp.flush()
        fp.close()

    def executeCmd(self,  device):
        logging.info("start run command :" + self.mParam)
        timeout,output,error = device.runCmdTimeout(self.mParam,300)
        #self.removeOldCmdResult()
        self.writeCmdResult("run command :"+self.mParam+"\n")
        if timeout == True:
            self.writeCmdResult("run command timeout\n")
        if len(output) > 0:
            self.writeCmdResult(output+"\n")
        if len(error) > 0:
            self.writeCmdResult(error+"\n")


