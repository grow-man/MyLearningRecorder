from  config import Config
from pull_manager import  LogGetManager
from device import  Device
import sys
import datetime
import os
import re
import logging
import getopt
import  pull_manager

CONFIG_FILE_NAME = "pull.conf"
#CONFIG_FILE_NAME = "test.conf"
def initLogging(logFilename):
  """Init for logging
  """
  logging.basicConfig(level=logging.DEBUG,
                      format='[%(asctime)s] %(levelname)s [%(funcName)s: %(filename)s, %(lineno)d] %(message)s',
                      datefmt='%Y-%m-%d %H:%M:%S',
                      filename=logFilename,
                      filemode='w')

  console = logging.StreamHandler()
  console.setLevel(logging.INFO)
  formatter = logging.Formatter('%(asctime)s %(levelname)s %(message)s')
  console.setFormatter(formatter)
  logging.getLogger('').addHandler(console)

def startAdbServer():
    output = os.popen("adb start-server")
    for line in output.readlines():
        param = line.strip().split("\t")
        if param.length != 2:
            continue
            if param[1] == "device":
                pass

def getDevice():
    deviceList = []
    output = os.popen("adb devices")
    for line in output.readlines():
        param = line.strip().split()
        if len(param) == 2:
            if param[1].strip() == "device":
                device = Device(param[0].strip())
                deviceList.append(device)
    return  deviceList

def getInputNum(message,max):
    numberList = []
    numbers = message.split(",")
    if len(numbers) > 1:
        for num in numbers:
            isNum = num.isdigit()
            if isNum :
                numberList.append(int(num))
    else:
        if message.strip().isdigit():
            numberList.append(int(message.strip()))
    if len(numberList) == 0:
        numbers = message.split()
        if len(numbers) > 1:
            for num in numbers:
                isNum = num.isdigit()
                if isNum:
                    numberList.append(int(num))
        else:
            if message.strip().isdigit():
                numberList.append(int(message.strip()))
    if numberList:
        for num in numberList:
            if num >= max:
                numberList.remove(num)
    return  numberList

def processUserInput(max, deviceList):
    selectDeviceList = []
    prompt = "please select which device to pull(only input number,for ex:2,3,will pull NO.2 and NO.3 device):"
    prompt += "\n0.all"
    for i in range(0, len(deviceList)):
        prompt += '\n%d.%s' % (i + 1, deviceList[i].getDeviceID())
    prompt += '\n%d.%s' % (i + 2, "cancel" + "\n")
    CANCEL = i + 2
    message = ""
    numberList = []
    while len(numberList) == 0:
        message = raw_input(prompt)
        numberList = getInputNum(str(message), max)
        if len(numberList) == 0:
            print("input error,please input again")
        else:
            print("selecet " + str(message))
            for num in numberList:
                if num == SELECT_ALL:
                    print("you select all")
                    selectDeviceList = deviceList
                    break
                elif num == CANCEL:
                    print("user cancel")
                    exit(0)
                else:
                    print("you select device :" + deviceList[num - 1].getDeviceID())
                    selectDeviceList.append(deviceList[num - 1])
            break
    return  selectDeviceList

def contain_zh(word):
    zh_pattern = re.compile(u'[\u4e00-\u9fa5]+')
    word = word.decode()
    match = zh_pattern.search(word)
    return  match

if __name__ == "__main__":
    os.chdir(os.path.dirname(os.path.abspath(sys.argv[0])))
    currentPath = '.' + os.sep
    versionFile = os.path.join(currentPath, "version")
    version = ""
    nowTime = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
    initLogging("pulllog.log")
   # initLogging("pulllog"+nowTime+".log")
    print(os.path.dirname(os.path.abspath(sys.argv[0])))
    toolsPath = os.path.dirname(os.path.abspath(sys.argv[0]))
    if(len(toolsPath)>50):
        logging.warn("the tools placed path is too long")
        #exit(0)
    if contain_zh(toolsPath):
        logging.warn("there is some chinese character in the tools placed path")
        # exit(0)
    with open(versionFile, 'rb') as fd:
        lines = fd.readlines()
        for line in lines:
            line = line.strip()
            if line:
                logging.info("tools version is " + line)
                version = line.strip()
    opts, args = getopt.getopt(sys.argv[1:], "s:o:")
    deviceID = ""
    desPath = ""
    selectDeviceList = []
    for op, value in opts:
        if op == "-s":
            deviceID = value
        elif op == "-o":
             desPath = value
    if not deviceID:
        deviceList = getDevice()
        SELECT_ALL = 0

        if len(deviceList) == 0:
            logging.warn("no devices connected")
            exit(0)
        elif len(deviceList) > 1:
            selectDeviceList = processUserInput(len(deviceList) + 2, deviceList)
        else:
            selectDeviceList = deviceList
        for device in selectDeviceList:
            logging.info("need get log from device :"+ device.getDeviceID())
    else:
        device = Device(deviceID)
        selectDeviceList.append(device)
    if not desPath:
        desPath = currentPath
    configPath = currentPath + CONFIG_FILE_NAME
    manager = LogGetManager(desPath, selectDeviceList,version)
    config = Config(configPath , manager)
    config.parse()
    manager.start()
    logging.info("get all the devices log end,num is :"+str(len(selectDeviceList)))
    nowTime = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
    #os.makedirs(currentPath)


