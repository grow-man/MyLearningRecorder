1. run.bat�������
���ܣ�����statistics.bat

2. statistics.bat: �������
���ܣ�����statistics.exe����ָ���ļ��г�ȡĿ������
�ű���������1��ָ��.logel�ļ���         ��"%~dp0\Statistics.exe" -f "D:\LapStatistics\in_folder\1.logel" -o "D:\LapStatistics\out_folder" -l "D:\LapStatistics\xlog_unilog\Bin\Logel.exe" -r "1000,2000" -d
�ű���������2��ָ���ļ��У�             ��"%~dp0\Statistics.exe" -f "D:\LapStatistics\in_folder" -o "D:\LapStatistics\out_folder" -l "D:\LapStatistics\xlog_unilog\Bin\Logel.exe"
�ű���������3��ָ��.trace�Լ�.msgd�ļ�����"%~dp0\Statistics.exe" -f "D:\LapStatistics\in_folder\1.trace,D:\LapStatistics\in_folder\1.msgd," -o "D:\LapStatistics\out_folder"

�ű�����˵����
����1�����裬�������
����<-f>�����裬ָ�������ļ�·������ָ���ļ��л����ļ���ָ���ļ���ʱֻ�����ļ����������μ����ļ���������.logel/.log�ļ���ָ���ļ�ʱ��֧��.logel/.log/.trace/.msgd�����ļ�������.trace��.msgd��ͬʱָ��������<�ű���������3>
����<-o>����ѡ��ָ���ɹ���Excel�ļ�����Ŀ¼��ȱʡ������Ĭ��Ϊ<-f>ָ���������ļ�·��ͬһĿ¼
����<-l>��ָ��Logel���߿�ִ���ļ�·������<-f>����ָ��Ϊ.logel/.log����Ϊ���룬��<-f>����ָ��Ϊ.trace��.msgd����Ϊ��ѡ
����<-r>����ѡ��ָ��SN���˷�Χ��Ĭ��Ϊ������SN����
����<-d>����ѡ��ָ���Ƿ�ΪDebugģʽ��True:�ǣ�False����Ĭ��Ϊ��Debugģʽ�£�ͨ���ط�.logel/.log�ļ���������.msgd/.trace�����ڳ���ִ�����Ժ�ɾ���������û�У���������ȷ��
����<-all>/<-sa>/<-nsa>����ѡ��ָ������������Ĭ��Ϊ<-all>���ȷֱ𵼳�SA��NSA��������ر���


���������������������� NOTICE: ����������������������
1. ��������ȷ��Logel���ߵ�ǰ���õĽ������Ƿ���ȷ���������ȷ������������п�����ȫ����ȷ