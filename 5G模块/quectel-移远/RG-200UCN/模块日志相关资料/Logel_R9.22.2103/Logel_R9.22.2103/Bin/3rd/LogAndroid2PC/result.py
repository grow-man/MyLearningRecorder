import sys
import os
ver = sys.version_info
if ver[0] == 3:
    mopen = open;
else:
    def mopen(file, mode='rb', buffering=-1, encoding=None, errors=None, newline=None, closefd=True, opener=None):
        return open(file, mode+'b')
class Result:
    def __init__(self,topDir,deviceID):
        self.mPath = os.path.join(topDir, "pull_result_"+deviceID+".log")
        self.mDeviceID = deviceID
        if os.path.exists(self.mPath):
            os.remove(self.mPath)
        self.fp = mopen(self.mPath, 'a+', encoding='utf8', errors='replace')

    def writeResult(self, strResult):
        if self.fp is None:
            self.fp = mopen(os.path.join(self.mPath, "pull_result_"+self.mDeviceID+".log"), 'a+', encoding='utf8', errors='replace')
        self.fp.write(strResult)
    def save(self):
        if self.fp is not None:
            self.fp.flush()
            self.fp.close()