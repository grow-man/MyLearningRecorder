1. run.bat：主入口
功能：调用statistics.bat

2. statistics.bat: 功能入口
功能：调用statistics.exe，从指定文件中抽取目标数据
脚本调用样例1（指定.logel文件）         ："%~dp0\Statistics.exe" -f "D:\LapStatistics\in_folder\1.logel" -o "D:\LapStatistics\out_folder" -l "D:\LapStatistics\xlog_unilog\Bin\Logel.exe" -r "1000,2000" -d
脚本调用样例2（指定文件夹）             ："%~dp0\Statistics.exe" -f "D:\LapStatistics\in_folder" -o "D:\LapStatistics\out_folder" -l "D:\LapStatistics\xlog_unilog\Bin\Logel.exe"
脚本调用样例3（指定.trace以及.msgd文件）："%~dp0\Statistics.exe" -f "D:\LapStatistics\in_folder\1.trace,D:\LapStatistics\in_folder\1.msgd," -o "D:\LapStatistics\out_folder"

脚本参数说明：
参数1：必需，程序入口
参数<-f>：必需，指定数据文件路径，可指定文件夹或者文件，指定文件夹时只按照文件名升序依次加载文件夹下所有.logel/.log文件，指定文件时可支持.logel/.log/.trace/.msgd类型文件，其中.trace和.msgd需同时指定，参照<脚本调用样例3>
参数<-o>：可选，指定成果物Excel文件保存目录，缺省条件下默认为<-f>指定的数据文件路径同一目录
参数<-l>：指定Logel工具可执行文件路径，当<-f>参数指定为.logel/.log场合为必须，当<-f>参数指定为.trace及.msgd场合为可选
参数<-r>：可选，指定SN过滤范围，默认为不进行SN过滤
参数<-d>：可选，指定是否为Debug模式，True:是，False：否。默认为否。Debug模式下，通过回放.logel/.log文件并导出的.msgd/.trace不会在程序执行完以后删除，方便用户校对输出的正确性
参数<-all>/<-sa>/<-nsa>：可选，指定导出场景，默认为<-all>，既分别导出SA和NSA场景的相关报告


↓↓↓↓↓↓↓↓↓↓↓ NOTICE: ↓↓↓↓↓↓↓↓↓↓↓
1. 请先自行确认Logel工具当前配置的解析库是否正确，如果不正确，解析结果很有可能完全不正确