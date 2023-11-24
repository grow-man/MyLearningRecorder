from  entry import  Entry
import logging
import re
import os
class Config:
    def __init__(self, path, manager):
        self.mPath = path
        self.mManager = manager

    def parse(self):

            with open(self.mPath, 'rb') as fd:
                lines = fd.readlines()
                for line in lines:
                    line = line.strip()
                    if line:
                        entry = self.parseLine(line)
                        if entry is not None:
                            self.mManager.addEntry(entry)
                    else:
                        logging.info("read blank line, continue")

    def parseLine(self, line):
        SEPRATOR = ","
        param = ""
        des_dir = ""
        isCmd = True
        if line[0] == "/":
            isCmd = False
        if line[0] == "#":
            logging.info("remark line,continue")
            return
        temp = line.split(SEPRATOR)
        if len(temp) == 2:
            param = temp[0].strip()
            des_dir = temp[1].strip()
        elif len(temp) == 1:
            param = temp[0].strip()
            if isCmd == False:
                des_dir = param[1:].strip()
            else:
                des_dir = "cmd_result.log"
        else:
            logging.info(line+" is not correct format")
        if param and des_dir:
            rstr = r"[\\\:\*\?\"\<\>\|]"
            des_dir = re.sub(rstr, "_", des_dir)
            entry = Entry(param, des_dir, isCmd)
            return  entry
        else:
            return  None
