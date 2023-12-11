[[_TOC_]]

# 1. �������QA

## 1.1. ��: ���ʹ�� python ��ȡ excel �ļ�

```python
import pandas as pd
from tabulate import tabulate

# ��ȡ Excel �ļ�
df = pd.read_excel('input.xlsx')

# ������ת��Ϊ Markdown ���
md_table = tabulate(df, headers='keys', tablefmt='pipe')

# д�� Markdown �ļ�
with open('output.md', 'w') as f:
    f.write(md_table)
```

## 1.2. ��: python ת�� word �� md �ļ�

```python
from docx import Document

def convert_word_to_md(file_path):
    doc = Document(file_path)
    md_content = ""

    for paragraph in doc.paragraphs:
        md_content += paragraph.text + "\n\n"

    return md_content

# ����ʾ��
word_file = "xx.docx"
md_content = convert_word_to_md(word_file)

# д�� md �ļ�
with open("xx.md", "w", encoding="utf-8") as f:
    f.write(md_content)
```

## 1.3. ��: VSCode ��� `Log File Highlighter` �������

1. ��(Ctrl+P) VSCode �� `settings.json` �ļ�
2. �����������

```json
  "logFileHighlighter.customPatterns": [
    {
      /// ���󣬱��봦�������
      "pattern": "exception|ERROR|error|FATAL|fatal|critical|FAILED|bad_variant_access",
      "foreground": "#FF0000"
    },
    {
      /// ���棬����ע�����Ϣ
      "pattern": "require type: .{1,5},|SetDevInfo: |SendSnmpGetReq success!| null |since last log time|WARN|warn|warning|percent: 99.|percent: 100| \\b(?:9\\d(?:\\.\\d{1,2})?|100(?:\\.0{1,2})?)%|\\(s\\)",
      "foreground": "#FFFF00"
    },
    {
      /// ��Ϣ��ֵ��ע�����Ϣ
      "pattern": "not online, donot check dev|New devices connect to the OMC|SendTextMessage all success|(\"DCCapacityPos\":��get APP request call|INFO  |info |RUN|OK|PASSED|Send DC handle req call which have ulDCCapaCity|spPID->usInstID|spPID->usTaskID|link auth successful, client|RequestCallReq|Dialling is handle as link call.|Function Avg Time:|frequency count|get SA msg:|server_close_connect|OnServerDisconnectClient usClientID|tcp_send: send failed, Socket|SetButtonStatus|get request call|is not need save link group call|handle auto pick up group|Dialling is handle as group call.|eSDK_SendSMS|Skip not auto pick up group|is not auto pick up!|get app request call|Group Call Speaker Change:|OnRequestCallReq|\\(31\\)|\\(34\\)|\\(36\\))",
      "foreground": "#42B883"
    },
    {
      /// ���ԣ����ڵ��Գ������Ϣ
      "pattern": "debug|Debug|DEBUG|Spend Time|Memory Change|Total Time|interval_time_factory",
      "foreground": "#007FFF"
    },
    {
      /// ��ϸ��Ϣ�����Ժ��Ե���Ϣ
      "pattern": "DETAIL|detail",
      "foreground": "#2F90B9"
    },
    {
      /// ��ǰ��ע����Ϣ����Ҫÿ�θ��£�
      "pattern": "(6021102|172\\.2\\.200\\.22)",
      "foreground": "#000000",
      "background": "#19F334"
    }
  ]
```

## 1.4. ��: VSCode ��� `Doxygen Documentation Generator` �������

1. ��(Ctrl+P) VSCode �� `settings.json` �ļ�
2. �����������
```json
  "doxdocgen.generic.useGitUserEmail": true,
  "doxdocgen.generic.useGitUserName": true,
  "doxdocgen.generic.dateFormat": "YYYY-MM-DD HH:mm:ss",
  "doxdocgen.file.fileTemplate": "@file {indent:17}{name}",
  "doxdocgen.generic.briefTemplate": "@brief {indent:17}{text}",
  "doxdocgen.generic.dateTemplate": "@date {indent:17}{date}",
  "doxdocgen.generic.paramTemplate": "@param {indent:17}{param}    []",
  "doxdocgen.generic.authorTag": "@author          {author}({email})",
  "doxdocgen.file.versionTag": "",
  "doxdocgen.generic.returnTemplate": "@return {indent:17}{type} ",
  "doxdocgen.file.fileOrder": [
    "file",
    "brief",
    "author",
    /// "version",
    "date",
    "copyright"
  ],
  "doxdocgen.generic.order": [
    "brief",
    "param",
    "return",
    /// "empty",
    "custom"
  ],
  "doxdocgen.generic.customTags": [
    "@author          {author}({email})",
    "@date            {date}"
  ],
  "doxdocgen.file.copyrightTag": [
    "@copyright {indent:17}Copyright (c) 2021-{year} GBCOM"
  ],
```

## 1.5. ��: ����Զ���װpython�ű���Ҫ�Ŀ�

1. �� py �ļ���ͬĿ¼����һ��������� requirements.txt �ļ�


```shell
pipreqs ./ --encoding=utf8
```

2. �������װ������

```shell
pip install -r requirements.txt
```

## 1.6. watchdog ʹ��˵��

[WatchDogʹ��˵��.docx](uploads/f5afefa5338bce37f5732a95cc09affd/WatchDogʹ��˵��.docx)

## 1.7. SNMP Э�����

GitHub Copilot: SNMP��Simple Network Management Protocol����һ�����ڹ���ͼ�������豸�ı�׼Э�顣SNMPЭ�鶨����һ����Ϣ��ʽ��ͨ�Ź���ʹ���������ϵͳ�����������豸���н���������ȡ�豸��״̬��Ϣ�����ò����ȡ�

SNMP�ı�׼Э���ĵ��ɶ��RFC��Request for Comments���ĵ���ɡ�������һЩ��SNMP��ص���ҪRFC�ĵ���

1. RFC 1155: ������SNMP�Ļ����������ͣ����������ַ����������ʶ���ȡ�

2. RFC 1157: ������SNMP�ĵ�һ���汾��SNMPv1����������Ϣ��ʽ��������Ϣ�⣨MIB���ȡ�

3. RFC 1901-1908: ������SNMP�ĵڶ����汾��SNMPv2���������˸���Ĺ��ܺ͸Ľ�����SNMPv2c��SNMPv2u��SNMPv2p�ȡ�

4. RFC 3411-3418: ������SNMP�ĵ������汾��SNMPv3���������˰�ȫ�Ժ���֤���ƣ����û������֤����Ϣ���ܵȡ�

������Щ��Ҫ��RFC�ĵ��⣬�������������RFC�ĵ�������SNMP�ĸ������棬��MIB���塢SNMPЭ�����չ�ȡ�

������ͨ������IETF��Internet Engineering Task Force������վ`https://www.ietf.org/` ����ȡ������SNMP��׼Э���ĵ����ڸ���վ�ϣ��������������ҵ���SNMP��ص�RFC�ĵ����������Ķ����ǡ�

## 1.8. ��: CentOS7 bash ���ִ��� -bash: ����:setlocale: LC_CTYPE: �޷��ı�����ѡ�� (UTF-8): û���Ǹ��ļ���Ŀ¼

```sh
# ��װ�������԰�
sudo yum install -y langpacks-zh_CN
vim /etc/locale.conf
# ������������
LANG="zh_CN.UTF-8"
LC_CTYPE="zh_CN.UTF-8"
# ��������������Ϣ
sudo localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8
```

## 1.9. ��: snmp ���ĺ� trap ���� �ֱ���ʲô

SNMP��Simple Network Management Protocol�����ĺ� Trap �����������������صĸ��


1. SNMP ���ģ�SNMP �����������������д��������Ϣ�����ݵ�Ԫ�������԰�������Get��GetNext��Set �ȣ�����Ӧ��Response�������͵���Ϣ�����ڹ��������е��豸����Դ��SNMP ����ͨ�������������͡�OID��Object Identifier����ֵ����Ϣ���Ա����������������
2. Trap ���ģ�Trap ������һ���첽֪ͨ���ƣ������������������վ�㷢���¼�֪ͨ���������豸��������ض��¼�ʱ����˿�״̬�ı䡢�¶ȳ�����ֵ�ȣ�����������һ�� Trap ���Ĳ����͸�����վ�㣬�Ա����վ����Լ�ʱ��Ӧ�ʹ�������¼���  

��Щ������ SNMP Э���а�������Ҫ�Ľ�ɫ������ʵ�������豸�ļ�ء����ú͹��ϴ���ȹ����ܡ�

## 1.10. ��: ��β鿴CentOS���Ե��ڴ���Ϣ

```shell
free -m
```

## 1.11. ��: ��β鿴CentOS���Ե�CPU��Ϣ

```shell
cat /proc/cpuinfo |more
```

## 1.12. ��: GMT��CST��UTC �ֱ���ʲô��

1. UTC(�����׼ʱ��)

Э������ʱ���ֳ������׼ʱ�������Э��ʱ�䣬���UTC����Ӣ�ġ�Coordinated Universal Time����������������Ҫ������ʱ���׼������ԭ��ʱ�볤Ϊ��������ʱ���Ͼ����ӽ��ڸ������α�׼ʱ�䡣

2. GMT(��������ƽʱ)

��������ƽʱ���ֳƸ�������ƽ��ʱ���������α�׼ʱ�䣬����������α�׼ʱ�䣻Ӣ�Greenwich MeanTime��GMT����ָλ��Ӣ���׶ؽ����ĻʼҸ�����������̨�ı�׼ʱ�䣬��Ϊ���������߱�������ͨ������ľ��ߡ�


��������˵���������α�׼ʱ���������ָ��̫���ᴩ��������������ʱ��Ҳ�����ڸ��������Ͽ���ߵ�ʱ����ʱ�䡣���ڵ�����������Բ�������˶��ٶȲ����ȣ����ʱ�̿�����ʵ�ʵ�̫��ʱ�����������16���ӡ�


���ڵ���ÿ�����ת����Щ������ģ��������ڻ������٣���˸�������ʱ���Ѿ����ٱ���Ϊ��׼ʱ��ʹ�á����ڵı�׼ʱ�䣬����ԭ���ӱ�ʱ��Э������ʱ��UTC����

3. CST(����ʱ��)

����ʱ�䣬China Standard Time���й���׼ʱ�䡣��ʱ�������ϣ�������������Э������ʱ��8Сʱ����ΪUTC+8��

## 1.13. ��: ��ν��� docker ��ĳ����������־

```shell
docker logs <container_id_or_name>
```

## 1.14. ��: ��ν��� docker ��ĳ��������������

```shell
docker exec -it <container_id_or_name> bash
```

## 1.15. ��: ��β鿴 docker �е�ǰ���������е�����

```shell
docker ps
```

## 1.16. ��: һ���������ǰ��֧���� commit

```c++
git log --no-merges 721bfa7..HEAD --date=iso --pretty=format:'%h|%s|%an|%ad|' --shortstat | sed '/^$/d' | sed -n '1h;1!H;${g;s/|\n/,/g;p;}' > /home/commits.csv
```

## 1.17. ��: git submodule ��γ�ʼ���ض���ģ��

```c++
git submodule update --init <submodule_path>
```

## 1.18. ��: Ϊ���Ƽ�ʹ�� `nullptr` ��� `NULL` �� `0`

1. CppCoreGuidelines: [ES.47: Use nullptr rather than 0 or NULL](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines#es47-use-nullptr-rather-than-0-or-null)


## 1.19. ��: ���ʹ�� python �����ļ��в����� md ��ʽ�ļ�

```python
import os
import re

def get_directory_files(path, pattern, is_recursive):
    if not os.path.exists(path):
        return []

    vec = []
    for root, dirs, files in os.walk(path):
        for file in files:
            if not os.path.isdir(file):
                file_name = os.path.basename(file)
                if re.match(pattern, file_name):
                    vec.append(os.path.join(root, file))

        if not is_recursive:
            break

    # vec.sort()
    return vec

if __name__ == '__main__':
    vec = get_directory_files('.', r'.*\.*', True)

    record = []
    for file in vec:
        file_name = os.path.basename(file)
        record.append((file_name, file))

    # for it in record:
    #     print(f'file name: {it[0]}, file path: {it[1]}')

    # д�� md �ĵ�
    with open('file_path.md', 'w') as f:
        f.write('# �ļ�·��\n\n')
        for it in record:
            f.write(f'[{it[0]}]({it[1]}): {it[1]}\n\n')
```

## 1.20. ��: C++ Ϊ���Ƽ�ʹ�����������ռ���� static �ؼ���

1. [`Cpp Core Guideline`](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines#sf22-use-an-unnamed-anonymous-namespace-for-all-internalnon-exported-entities): SF.22: Use an unnamed (anonymous) namespace for all internal/non-exported entities
2. ���������ռ�������� class���� static �ؼ��ֲ������� class
3. ����һ������ʶ������ֻ��Ҫʹ��һ�������ռ�������������Ҫ�������static��
4. ע��: ������ .h �ļ���ʹ�����������ռ䣬����ᵼ�����Ӵ���
����:

```c++
/// xx.cpp
namespace
{
    int f();
    bool h();
    class c { /* ... */ };
}
```

�ο�:

[C++ ���������ռ�](https://www.cnblogs.com/youxin/p/4308364.html)

## 1.21. ��: C++ ��μ���ٷ���(������λС��)�ַ���

```c++
#include <sstream>  // ����ͷ�ļ���ʹ�� std::ostringstream
#include <iomanip>  // ����ͷ�ļ���ʹ�� std::setprecision
std::string calculatePercentage(int value, int all_count) {
    double result = static_cast<double>(value) / all_count;  // ������һ��������ת��Ϊ double ���ͣ��Եõ������������Ľ��

    // ʹ�� std::ostringstream ����������ʽ�����ݵ��ַ���
    std::ostringstream oss;
    oss << std::fixed << std::setprecision(2) << result * 100 << "%";

    // ���ع������ַ���
    return oss.str();
}
```

## 1.22. ��: ���ʹ��everything���������������ļ���

��everything���������-ѡ��-�ļ��У������ӣ�Ȼ�����������ҵ�����������ļ��У�Ҳ����ֱ�����������ֱ������·��; ������ɺ�����everything��������������\
ע��: һ��Ҫ�����ļ���·����ֻ�����������ַ�ǲ��е�

## 1.23. ��: ���ʹ�� C++ ���� csv �ļ�

```c++
#include <iostream>
#include <fstream>
#include <vector>
#include <string>

// ���� CSV �ļ��ĺ���
void generateCSV(const std::string& filename, const std::vector<std::vector<std::string>>& data) {
    std::ofstream file(filename);

    if (file.is_open()) {
        for (const auto& row : data) {
            for (size_t i = 0; i < row.size(); ++i) {
                file << row[i];
                if (i != row.size() - 1) {
                    file << ",";
                }
            }
            file << "\n";
        }

        file.close();
        std::cout << "CSV file " << filename << " generated successfully." << std::endl;
    } else {
        std::cerr << "Error: Unable to open file " << filename << " for writing." << std::endl;
    }
}

int main() {
    // ���ɵ� CSV ����
    std::vector<std::vector<std::string>> data = {
        {"Name", "Age", "City"},
        {"John", "30", "New York"},
        {"Alice", "25", "San Francisco"},
        {"Bob", "35", "Seattle"}
    };

    // ���� CSV �ļ�
    generateCSV("output.csv", data);

    return 0;
}
```

## 1.24. ��: C++ ����pcap�ļ��е� udp ����

��Ҫ��װ libpcap ��, ��Ҫ ��Դ�� [nlohmann/json](https://github.com/nlohmann/json) �е� json.hpp �ļ�

�����ļ� [`yyy.pcap`](uploads/9871b49db738ca21c023535ca5c1303a/yyy.pcap) �е� udp ����, �����������д�� `output.json` �ļ���

```c++
#include <iostream>
#include <fstream>
#include <pcap.h>
#include "nlohmann/json.hpp"
#include <netinet/ip.h>
#include <net/ethernet.h>
#include <netinet/udp.h>
#include <sys/socket.h>
#include <netinet/in.h>

std::vector<nlohmann::json> json_vec;

void packet_handler(u_char* user, const struct pcap_pkthdr* pkthdr, const u_char* packet)
{
    // ������̫��֡ͷ��
    struct ether_header* eth = (struct ether_header*)packet;
    /// ���� tcp/udp ͷ��
    struct ip* ip = (struct ip*)(packet + sizeof(struct ether_header));

    // Create a JSON object
    nlohmann::json json_obj;
    json_obj["source_ip"] = inet_ntoa(ip->ip_src);
    json_obj["destination_ip"] = inet_ntoa(ip->ip_dst);
    /// json_obj["protocol"] = (int)ip->ip_p;
    json_obj["version"] = (int)ip->ip_v;
    json_obj["header_length"] = (int)ip->ip_hl;
    json_obj["ttl"] = (int)ip->ip_ttl;
    json_obj["total_length"] = ntohs(ip->ip_len);
    json_obj["checksum"] = ntohs(ip->ip_sum);
    json_obj["identification"] = ntohs(ip->ip_id);
    json_obj["fragment_offset"] = ntohs(ip->ip_off);
    json_obj["type_of_service"] = ntohs(ip->ip_tos);
    json_obj["flags"] = ntohs(ip->ip_off);

    if (ip->ip_p == IPPROTO_TCP)
    {
        json_obj["protocol"] = "TCP";
    }
    else if (ip->ip_p == IPPROTO_UDP)
    {
        json_obj["protocol"] = "UDP";

        struct udphdr* udp = (struct udphdr*)(packet + sizeof(struct ether_header) + sizeof(struct ip));
        nlohmann::json udp_obj;
        udp_obj["source_port"] = ntohs(udp->uh_sport);
        udp_obj["destination_port"] = ntohs(udp->uh_dport);
        udp_obj["length"] = ntohs(udp->uh_ulen);
        udp_obj["checksum"] = ntohs(udp->uh_sum);
        std::string data;
        for (int i = 0; i < ntohs(udp->uh_ulen) - sizeof(struct udphdr); ++i)
        {
            data += (char)packet[i + sizeof(struct ether_header) + sizeof(struct ip) + sizeof(struct udphdr)];
        }
        udp_obj["data"] = data;
        json_obj["udp"] = udp_obj;
    }
    else
    {
        json_obj["protocol"] = (int)ip->ip_p;
    }

    json_vec.push_back(json_obj);
}

int main()
{
    char errbuf[PCAP_ERRBUF_SIZE];
    pcap_t* pcap_handle;

    // ������ pcap �ļ�
    pcap_handle = pcap_open_offline("yyy.pcap", errbuf);
    if (pcap_handle == NULL)
    {
        std::cerr << "Error opening pcap file: " << errbuf << std::endl;
        return 1;
    }

    // ѭ����ȡ���ݰ�
    if (pcap_loop(pcap_handle, 0, packet_handler, NULL) < 0)
    {
        std::cerr << "Error reading packets: " << pcap_geterr(pcap_handle) << std::endl;
        return 1;
    }

    // �ر� pcap �ļ�
    pcap_close(pcap_handle);

    // Write the JSON object to a file
    std::ofstream output_file("output.json");
    nlohmann::json json_array(json_vec);
    output_file <<  json_array.dump(4);
    output_file.close();

    return 0;
}
```

## 1.25. ��: google �Զ��岻�����ض���վ

1. ���� -����������-�������������棬��Ĭ���������������ҵ���Ҫ�޸ĵ��������棬�����������������Ĳ�ѯ��ַ���Ҽ����ƣ�
2. �Ը��Ƶ��ı������Ӳ���Ҫ��������վ, `+-site:blog.csdn.net -site:baike.baidu.com+`, �������λ��
```c++
{google:baseURL}search?q=%s+-site:blog.csdn.net -site:baike.baidu.com+&{google:RLZ}{google:originalQueryForSuggestion}{google:assistedQueryStats}{google:searchFieldtrialParameter}{google:iOSSearchLanguage}{google:prefetchSource}{google:searchClient}{google:sourceId}{google:contextualSearchVersion}ie={inputEncoding}
```
3. ���������������棬���ϸո����ӹ�����վ���ַ��������ø���������ΪĬ���������棬���ɡ�

## 1.26. ��: google ��������

1. ָ����ĳ����վ������

```c++
/// �� github.com ��վ������ json parser
json parser site:github.com
```

2. ָ��������ĳ��վ����

```c++
/// ����ethheader �ṹ��ͷ�ļ�, ���˵� csdn.net ��վ����
ethheader �ṹ��ͷ�ļ� -site:csdn.net
```

3. ����ָ���ļ�����

```c++
CppCoreGuidelines filetype:pdf
```

4. ��ȫƥ���ı�

```c++
/// ���������ַ���
��boost c++��
```

5. ���˹ؼ���

```c++
/// �����Ʒ�������ݣ������˴��� advertising �Ľ��
�Ʒ��� -advertising
```

6. �߼��롢��AND��OR

```c++
�ֻ� OR ��� ���� OR ��� OR ����
����ͬ�� (�ֻ� OR ���) (���� OR ��� OR ����)
```

7. ͨ�����?��*

?: ����һ���ַ�
*: ����һ���ַ���

```c++
/// �����й�ʲô����
�й�*����
```

8. Ϊ�������ʱ������

```c++
/// ����2020��֮ǰ������
BEFORE:2020
/// ����2020��֮�������
AFTER:2020
/// ����ʱ�������ڵ�����
2020..2021
```

## 1.27. ��: ���ʹ�� gperftools �鿴�������û���ͼ

1. ��װ���

```c++
apt-get install google-perftools libgoogle-perftools-dev graphviz
```

2. �����ļ� test.cc

```c++
#include <iostream>
#include <gperftools/profiler.h>
#include <regex>

int main()
{
    auto make_cpu_profiler = [](const string &filename)
    {
        ProfilerStart(filename.c_str());
        ProfilerRegisterThread();
        return std::shared_ptr<void>(nullptr, [](void *) { ProfilerStop(); });
    };

    auto cp = make_cpu_profiler("case1.perf");  // �������ܷ���
    auto str = "neir:automata"s;

    for (int i = 0; i < 1000; i++)
    {                                                // ѭ��һǧ��
        auto reg = make_regex(R"(^(\w+)\:(\w+)$)");  // ������ʽ����
        auto what = make_match();

        assert(regex_match(str, what, reg));  // ����ƥ��
    }
```

3. ���벢����

```sh
g+++ -std=c++20 -lprofiler test.cc -o a.out
```

4. �鿴���

```sh
pprof --text ./a.out case1.perf > case1.txt
��
pprof --svg ./a.out case1.perf > case1.svg
��
pprof --collapsed ./a.out case1.perf > case1.cbt
flamegraph.pl case1.cbt > flame.svg
flamegraph.pl --invert --color aqua case1.cbt > icicle.svg
```

* ע: ����Ҳ��� `pprof`, ������ȡ��������ʹ�ã� `git clone git@github.com:gperftools/gperftools.git`

* ע: ����Ҳ��� `flamegraph.pl`�� ������ȡ��������ʹ�� `git clone git@github.com:brendangregg/FlameGraph.git`

## 1.28. ��: perf �����÷�

1. �鿴 pid Ϊ 1234 �Ľ��̵� cpu ʹ�����

```sh
perf top -K -p 1234
```

## 1.29. ��: ��δ�������ssh-key

1. ���նˣ���������ʾ����ȡ������ʹ�õĲ���ϵͳ����

2. ������������������ SSH key���������У�����Ҫ�ṩ��ĵ����ʼ���ַ���⽫��Ϊ��Կ�ı�ǩ��

   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```

   `-t rsa` ָ��Ҫʹ�� RSA �㷨��`-b 4096` ָ����Կ��λ����4096 λ��һ�����õİ�ȫѡ�񣩣�`-C` �������ע�ͣ�һ����д��ĵ����ʼ���ַ��

3. ϵͳ����ʾ��ѡ����Կ�ļ��Ĵ洢λ�ú��ļ���������㲻�����κ����ݣ�ϵͳ��Ĭ�����û���Ŀ¼�µ� `.ssh` �ļ����д��� `id_rsa` �� `id_rsa.pub` �ļ�����Ҳ����Ϊ��Կ�ļ�ָ���Զ�����ļ�����·����

4. Ȼ��ϵͳ��ѯ�����Ƿ�Ҫ��������������˽Կ������һ����ѡ�Ĳ��裬�����������Ӱ�ȫ�ԣ�������Ҫ��ÿ��ʹ��˽Կʱ�������롣�������Ҫ����İ�ȫ�ԣ����������룬�������������ֱ�Ӱ��س���

5. ��ִ�������������� SSH key ���Ѿ������ˡ���Կ��`id_rsa.pub` �ļ�������Ҫ�� GitHub ������ Git �йܷ�������ӵĲ��֡�

   �����ʹ�������������鿴���ɵ� SSH key��

   ```bash
   cat ~/.ssh/id_rsa.pub
   ```

   ���ߣ������ʹ�õ��� Windows ƽ̨��

   ```bash
   type %userprofile%\.ssh\id_rsa.pub
   ```

6. ���ƹ�Կ���� `ssh-rsa` ��ͷ��һ�����ַ�����Ȼ������ӵ���� GitHub �˻������� Git �йܷ���� SSH key �����С�

## 1.30. ��:Openwrt����vlan�ķ���

һ���������ڲ�����������ͼ

![1698302551718](uploads/5507d8f0ae525172a984c01b86f91948/1698302551718.png)

����ǰ�������ڶ�Ӧ��������������eth1,port1��Ӧ���ڱ�ǩLAND��port2��ӦLAN1��prot3��ӦLAN2��port4��ӦLAN3��

ʹ��������������ʱ���Ӧ����Ҫ���õĶ˿ں�vlan��WEBҳ����Ҳ����ͨ���������ȷ�϶�Ӧ����


![1698302954470](uploads/89157a64a605fe895e4994d64d56ed84/1698302954470.png)


����WEB��ҳ���ù���

1������vlan
- ������ѡ����������-������
- �����Ӱ�ť�����vlan

![1698300153370](uploads/4d4565a034fab3ad983c12b4a08f444c/1698300153370.png)


- �µ�vlan��CPUҪ����Ϊ`����`,����˿ڸ�����Ҫ����Ӧ�˿ڻ��ֳɲ�ͬvlan����ΪĬ�����ж˿ڶ���vlan1�У�����ʱ�Ƚ�vlan1����Ӧ�˿ڹرա��˿ڵ�����ѡ�����ͣ�`������`��Accessģʽ��`����`��Trunkģʽ,`�ر�`�ǲ�ʹ�øö˿ڡ�


![1698300749459](uploads/4163699e514558822c292f2a051f004f/1698300749459.png)


��ͼ��vlan1ΪĬ��vlan���˿�1�Ͷ˿�2��Ч����δ�޸�֮ǰһ��������豸����pingͨbr-lan�ϵĵ�ַ��br-lan�Ž���eth0��eth1.1��vlan1����


vlan2�󶨵��Ƕ˿�3��vlan3�󶨵��Ƕ˿�4

2������IP
- ������ѡ����������-�ӿڣ�����½ӿ�


![1698301095540](uploads/2cac49a721cc0364b7608fa503523427/1698301095540.png)


- ����ӿ����ƣ�ѡ���·���Ӧ�����vlan�ӿڣ�����ύ


![1698301230075](uploads/f1dcec2e14670f02b9cc362e09680bea/1698301230075.png)


- �ύ��ҳ��Ϳ��Խ���IP�����ˡ����úõ�IP�ں�̨ͨ��ifconfig�鿴ʱ��eth1.1��Ӧvlan1,eth1.2��Ӧvlan2,eth1.3��Ӧvlan3��


![1698301304316](uploads/8892e46000a73b2cd08377c35bf1acf4/1698301304316.png)

3���޸�br-lan���Ž�ģʽ
- ��������web����
- ������ѡ����������-�ӿڣ�ѡ��LAN�ڣ�����޸�


![1698299882499](uploads/e06d18a215e7527b316ed4264fe7f6ce/1698299882499.png)


- �����ѡ���������ã��ӿڹ�ѡeth0��eth1.1(eth1.1��Ӧ����vlan1�Ľӿڣ������豸ǰ����ϵ�����Ĭ�϶��ǻ�����vlan1��)


![1698300000850](uploads/b6a29982bdc6bb10ad9e8bf17110e961/1698300000850.png)


- �������&Ӧ��


����ͨ���޸�network�����ļ�������vlan
1������network�����ļ�
```
vi /etc/config/network
```
2���޸�br-lan�Žӵ����磬��ԭ�����Ž�eth0��eth1�ĳ��Ž�eth0��eth1.1��


![1698301673540](uploads/75db7ac1ad9d6c3ba3a46b977701ce3f/1698301673540.png)


```
config interface 'lan'
        option type 'bridge'
        option _orig_ifname 'eth1'
        option _orig_bridge 'true'
        option proto 'static'
        option netmask '255.255.255.0'
        option gateway '192.0.1.25'
        option ipaddr '192.0.1.27'
        option ifname 'eth0 eth1.1'
```
3��vlan1�а������ж˿ڣ�����Ҫ���»���vlan�Ķ˿�ɾ����Ȼ������µ�vlan,���vlan��Ӧ����������IP��ַ��

![1698302015309](uploads/d9a234019b61dc5912c7ebf2877404d5/1698302015309.png)

```
config switch_vlan
        option device 'eth1'
        option vlan '1'
        option vid '1'
        option ports '0 2 1'

config switch_vlan
        option device 'eth1'
        option vlan '2'
        option vid '2'
        option ports '0t 3'

config interface 'test'
        option proto 'static'
        option netmask '255.255.255.0'
        option ipaddr '192.168.101.144'
        option ifname 'eth1.3'

config switch_vlan
        option device 'eth1'
        option vlan '3'
        option vid '3'
        option ports '0t 4'
```
4�������������
```
/etc/init.d/network restart
```

## 1.31. ��: ���ʹ�� clang-format ����ʽ��ĳЩ�ļ�

1. �����ļ�

```c++
// clang-format off

����Ҫ��ʽ���Ĵ���

// clang-format on
```

2. �ļ����µ��ļ�

�ڸ��ļ����´��� `.clang-format` �ļ�, ���ļ�д���������

```c++
DisableFormat: true
```

## 1.32. ��: ��μ���ĳ���ļ����£������ļ���ע��ռ���������ı���

```sh
cloc --by-percent c --quiet ./ds/thirdparty
```

## 1.33. ��: ��μ���ĳ���ļ����£������ļ��Ŀ��С�ע�ͺʹ�������

```sh
cloc ./ds/thirdparty
```

## 1.34. ��: ��β���ĳ���ļ����������ļ�������

```sh
find ./ds/thirdparty -type f -name "*" -print0 | xargs -0 wc -l
```

## 1.35. ��: cmake �ű��������һ��������ʾĳ�ļ���������Դ�ļ�

�� `CMakeLists.txt` ͬ��Ŀ¼����Ŀ¼ `common` ������Դ�ļ���ֵ������ COMMON_FILE

```c++
aux_source_directory(${CMAKE_CURRENT_LIST_DIR}/common COMMON_FILE)
```

## 1.36. ��:�����centos������telnet����
centos7������ʹ��telnet��¼ϵͳ

��CentOS7�У�Ĭ������£�telnet�Ǳ����õģ���Ϊ�����ǰ�ȫ��Э�顣���ǣ��������Ȼ��ʹ��telnet�����԰������²���������ã�

1����װtelnet�ͻ��˺ͷ�������

```
sudo yum install xinetd telnet telnet-server
```

���߰�װ��
��154������ȡrpm�����а�װ,·��:
```
\\10.1.1.154\00-����u��\������Ⱥ������Ŀ\�汾\�������\centos7_telent

rpm -ivh telnet-server-0.17-65.el7_8.x86_64.rpm
rpm -ivh telnet-0.17-65.el7_8.x86_64.rpm
rpm -ivh xinetd-2.3.15-14.el7.x86_64.rpm
```

2������telnet���񣬲���������Ϊ����������

```
sudo systemctl start telnet.socket
sudo systemctl enable telnet.socket
```

3�����÷���ǽ������telnet���ӣ�

```
sudo firewall-cmd --add-service=telnet --permanent
sudo firewall-cmd --reload
```

4������һ���µ��û����������룺

```
sudo adduser username
sudo passwd username
```

5�������û���¼��ϵͳ��

```
telnet localhost
```

6���������û����û�����������е�¼��

ע�⣺��Ȼ���������������ʹ��telnet��¼ϵͳ���������ǰ�ȫ��Э�飬����ʹ�ø���ȫ��SSHЭ��������ϵͳ��¼��

7��root�û�ֱ�ӵ�¼

Ĭ������£�ϵͳ�ǲ�����root�û�telnetԶ�̵�¼�ġ����Ҫʹ��root�û�ֱ�ӵ�¼���������������ݡ����߿������һ�����Ե�¼���û�����¼��su��root�û���������ô˷�������֤ϵͳ��ȫ�����˲����������

����root�û�ͨ��telnet��½��
�༭/etc/pam.d/login��ע�͵���������

```
vi /etc/pam.d/login
#��auth������ȥ��
#auth [user_unknown=ignore success=ok ignore=ignore default=bad] pam_securetty.so
```

����root�û�Զ�̵�½���˲��������!

```
vi /etc/pam.d/remote
#auth required pam_securetty.so
```

* ����telnet��xinetd���� ��telnet����������xinetd����

```
systemctl restart telnet.socket
systemctl restart xinetd
```

* �� 23�˿ڣ�ϵͳĬ��23Ϊtelnet�˿ڣ���ӵ�����ǽ����Ķ˿ڵ��б��С�

```
firewall-cmd --zone=public --add-port=23/tcp --permanent
```

8��ж��telnet

ִ�� rpm -qa telnet*�鿴�Ƿ��Ѿ���װ���ˡ�

```
rpm -qa telent*
```

ʹ�ã�yum remove telnet-*   ȫ��ж�ص�

```
yum remove telnet-*
```


## 1.37. ��:�����centos������ntp������
Centos7 ����NTP������

�� CentOS 7 �� RHEL 7 ϵͳ�ϣ�������ʹ�� `yum` ��������װ `ntpd`��NTP������������������ΰ�װ `ntpd` �Ĳ��裺

1. ���ն˻� SSH �����ķ�������

2. ʹ�� `yum` ��װ `ntpd` ����

   ```bash
   sudo yum install ntp
   ```

3. ��װ�����У���������Ҫȷ���Ƿ�Ҫ���������� `y` ���� Enter ����

4. ���߰�װ����154���̻�ȡRPM����

   ```
   \\10.1.1.154\00-����u��\������Ⱥ������Ŀ\�汾\�������\ntp
   rpm -ivh ntp-4.2.6p5-29.el7.centos.2.x86_64.rpm
   rpm -ivh autogen-libopts-5.18-5.el7.x86_64.rpm
   rpm -ivh net-snmp-utils-5.7.2-49.el7_9.1.x86_64.rpm
   ```

5. ��װ��ɺ����������� `ntpd` ������������ϵͳ����ʱ�Զ�������

   ```bash
   sudo systemctl start ntpd
   sudo systemctl enable ntpd
   ```

   �⽫���� NTP ������������ϵͳ�������Զ�������

6. ������ʹ������������ `ntpd` �����״̬����ȷ�����������У�

   ```bash
   sudo systemctl status ntpd
   ```

���ڣ�`ntpd` �����ѳɹ���װ���������С������Լ������� `/etc/ntp.conf` �ļ�����ָ��Ҫͬ���� NTP ��������������������������������

�� CentOS 7 �У�`ntp.conf` �ļ��������� NTP �������Ϳͻ��˵����á����ļ��ṩ���й����ͬ���ⲿʱ��Դ��������ڲ��豸�ṩ NTP ͬ��������ѡ������� `ntp.conf` �ļ�����ϸ˵����
1. ���÷�����ѡ�

   - `server`��ʹ�� `server` �ؼ���ָ���ⲿ NTP ���������Դ���Щ������ͬ��ʱ�䡣���磺

     ```
     server 0.centos.pool.ntp.org iburst
     server 1.centos.pool.ntp.org iburst
     ```

     �����ʾ���У�NTP ��������ͬ���� `centos.pool.ntp.org` ���������еķ�������

   - `iburst`��`iburst` ѡ���ʾ����ͬ����ͨ������ڷ��������ú��棬�Լ���ͬ����

2. ���������ͻ���ͬ����

   - `restrict`��`restrict` ������������� NTP �ͻ��˷������� NTP ��������Ĭ������£�`restrict` �����������Ŀͻ��˷��ʡ���������ӻ��޸� `restrict` ��Ŀ��������������

     ���磬�������ý������������еĿͻ���ͬ������ֹ�����ͻ��˵��޸ĺ� TRAP ������

     ```
     restrict 192.168.1.0 mask 255.255.255.0 nomodify notrap
     ```

3. �ṩ NTP ͬ�����ڲ��豸��

   - NTP �����������������ڲ��豸��÷���������ʱ��ͬ�������ڲ��豸�ϣ�����Ҫ���������Խ� NTP ����������Ϊ���� CentOS 7 �������� IP ��ַ���������ڲ��豸�������ķ�����ͬ��ʱ�䡣

   - ������ͨ���� NTP �������� IP ��ַ����Ϊ�ڲ��豸�� NTP ��������ʵ�֡�ͨ�����ڲ��豸���������ϵͳ���豸�������ṩ NTP ������������ѡ�

�ܵ���˵��`ntp.conf` �ļ��������� NTP �������Ϳͻ��˵���Ϊ������������ⲿ NTP ��������ͬ�����ķ�������ʱ�䣬Ȼ�������������Ŀͻ���ͬ�����ڲ��豸��Ҫ����Ϊʹ������ CentOS 7 �������� IP ��ַ��Ϊ�� NTP ����������ʵ��ʱ��ͬ�����⽫ȷ�������ڲ��豸����׼ȷ��ʱ�䡣

Ҫ���� NTP �������Բ��������ӵĿͻ��ˣ������Լ򵥵��� `ntp.conf` �ļ���ɾ����ע�͵��κ� `restrict` �С�Ĭ������£�`ntp.conf` �е� `restrict` �������������Ŀͻ��˷��ʣ���������ɾ����ע�͵���Щ�У�NTP �������������������ӵĿͻ��ˡ�

������������ò��������ӵĿͻ��˵�ʾ����

1. �� `/etc/ntp.conf` �ļ��Ա༭����

   ```bash
   sudo nano /etc/ntp.conf
   ```

2. Ѱ�� `restrict` �У���ɾ����ע�͵����ǡ�Ĭ������£�`restrict` �п���������ʾ��

   ```plaintext
   restrict 127.0.0.1
   restrict ::1
   ```

   ע�͵���ɾ����Щ�У�ʹ�ļ���������������

   ```plaintext
   #restrict 127.0.0.1
   #restrict ::1
   ```

3. ���沢�ر��ļ���

4. �������� NTP ������ʹ������Ч��

   ```bash
   sudo systemctl restart ntpd
   ```

���ڣ����� NTP �������������������ӵĿͻ��ˣ������������κ���Դ�� NTP ��������������һ�������������ڲ����� NTP ������������Ҫ�ϸ�ķ��ʿ��ơ�����ע�⣬������� NTP �������ɹ������ʣ���ôǿ�ҽ��������ʵ��İ�ȫ���Է�ֹ���á�

## 1.38. ��: ����� CMake �ű��г�ʼ�� git ��ģ��

�� `CMakeLists.txt` �� `project(xxx)` ���֮����������ָ���ִ�� cmake .. ʱ�Զ���ʼ�� git ��ģ��(��Ӧ��ģ����ļ�����Ҫ������)

```sh

execute_process(
  COMMAND git submodule update --init --recursive
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  RESULT_VARIABLE GIT_SUBMOD_RESULT)
if(NOT GIT_SUBMOD_RESULT EQUAL "0")
  message(
    FATAL_ERROR
      "git submodule update --init failed with ${GIT_SUBMOD_RESULT}, please checkout submodules"
  )
endif()
```

## 1.39. ��: ��γ�ʼ��һ������ `.gitmodules` �ļ��Ĳֿ�

```git
git submodule update --init
```

## 1.40. ��: MySQL ���ʹ�÷�ҳ��ѯ

[MySQL��ҳ��ѯ�����Ż�](https://www.w3cschool.cn/mysql/mysql-xilz2oy6.html)

[MySQL��ҳ��ѯ�Ż�](http://uusama.com/458.html)

## 1.41. ��: ����� `gitlab` ���д�����ʹ�� `issue` ģ��

1. �� gitlab ���� master ��֧�£���Ŀ¼�����ļ��� `.gitlab/issue_templates`
2. ���ڸ��ļ����´�����Ӧ���Ƶ� `.md` �ļ�
3. �ϴ� `.md` �ļ����������½� `issue` ʱ����� `Choose a template` ʹ����ģ��


## 1.42. ��: ���ʹ���ļ���Ų�ѯĳ�ļ����µ��ļ�����

```c++
#include <iostream>
#include <vector>
#include <regex>
#include <string>
#include <filesystem>

std::vector<std::string> get_directory_files(const std::string& path, const std::regex& reg, bool is_recursive)
{
    auto p = std::filesystem::path(path);
    if (!std::filesystem::exists(p))
    {
        return {};
    }

    std::vector<std::string> vec;
    auto f = [&](const auto& dir_entry)
    {
        auto fp = dir_entry.path();
        /// �����ļ���
        if (!std::filesystem::is_directory(std::filesystem::status(fp)))
        {
            auto file_name = fp.filename().string();
            /// ����ƥ��
            if (std::regex_match(file_name, reg))
            {
                vec.push_back(fp.string());
            }
        }
    };

    if (is_recursive)
    {
        /// �ݹ����
        std::ranges::for_each(std::filesystem::recursive_directory_iterator{p}, f);
    }
    else
    {
        /// �ǵݹ����
        std::ranges::for_each(std::filesystem::directory_iterator{p}, f);
    }

    std::ranges::sort(vec);
    return vec;
}

int main()
{
    auto c4 =
        get_directory_files("/Users/lijiancong/Workspace/gitlab/sz13_sil2/doc/������/", std::regex("(GBCOM.*)"), true);

    for (auto& i : c4)
    {
        auto pos = i.find_last_of("/");
        i = i.substr(pos + 1);
        std::cout << i << std::endl;
    }

    std::string str;
    while (getline(std::cin, str))
    {
        str = "GBCOM-SIL2-0" + str;

        auto it = std::find_if(c4.begin(), c4.end(), [&](const auto& file_name) { return file_name.find(str) == 0; });

        if (it == c4.end())
        {
            std::cout << "δ�ҵ�" << std::endl;
        }
        else
        {
            std::cout << "�ļ�: " << *it << std::endl;
            auto pos = it->find_last_of("V");
            std::cout << "�汾��: " << it->substr(pos, 4) << std::endl;
        }
        std::cout << std::endl;
    }

    return 0;
}
```


## 1.43. ��: �豸�����װĿ¼�淶

    �豸�����װĿ¼�淶���£��ֳ���װĿ¼�������޸ģ���

    1�����������DIS��MRS��OMC����װ��Ŀ¼��

    Linuxȱʡ��װ�� /home/gbcom

    windows ȱʡ��װ��d:/gbcomĿ¼ ��windows��װ���ֹ�����ϵͳ��������GBCOM_HOME)

   linux�������������ű�ͳһ���ã� start_gbcom.sh �ű�λ�ڸ�Ŀ¼�£��������£�

```c++
    #!/bin/bash
    shell_dir=$(dirname "$0")
    export GBCOM_HOME=$shell_dir
    cd $GBCOM_HOME
    $GBCOM_HOME/procmon &
```

    �ýű���/etc/rc.local�б����ã����÷������£�

    source /home/gbcom/start_gbcom.sh

   ע�����Ҫ��source���øýű�����֤GBCOM_HOME����������Ч

   2. dis��omc��mrs

    ��װ�ڸ�Ŀ¼��һ��Ŀ¼�У�Ŀ¼���ֱ�Ϊ dis��omc��mrs

   3. procmon

    ��װ�ڸ�Ŀ¼��  ��windows��ΪwatcgDog����

   4. pcap

   ��װ�ڸ�Ŀ¼�� ��windows��Ϊpcap����

   5. ds_chk

  ��װ�ڸ�Ŀ¼��

   6. ftps

  ��װ�ڸ�Ŀ¼��

   7. mysql

   ����ϵͳ��װ��ȱʡĿ¼����ָ��

   8��ftp������

   ��װ�ڸ�Ŀ¼��ftpĿ¼��

   ftp������Ŀ¼Ϊftp�µ�dataĿ¼��

   �û�����gbcom ���� gbcom@123

   9. dc��omt��spt

   ��װ�ڸ�Ŀ¼��һ��Ŀ¼�У�Ŀ¼���ֱ�Ϊ dc��omt��spt


## 1.44. ��: googletest ������в��Ե��Ӽ�

```text
./foo_test Has no flag, and thus runs all its tests.
./foo_test --gtest_filter=* Also runs everything, due to the single match-everything * value.
./foo_test --gtest_filter=FooTest.* Runs everything in test suite FooTest .
./foo_test --gtest_filter=*Null*:*Constructor* Runs any test whose full name contains either "Null" or "Constructor" .
./foo_test --gtest_filter=-*DeathTest.* Runs all non-death tests.
./foo_test --gtest_filter=FooTest.*-FooTest.Bar Runs everything in test suite FooTest except FooTest.Bar.
./foo_test --gtest_filter=FooTest.*:BarTest.*-FooTest.Bar:BarTest.Foo Runs everything in test suite FooTest except FooTest.Bar and everything in test suite BarTest except BarTest.Foo.
```

## 1.45. �ʣ�Centos ʹ�� yum ��ʹ�� cmake ���� libstdc++.so ���Ӵ���

```c++
rm -f /usr/lib64/libstdc++.so.6
ln -s /usr/local/lib64/libstdc++.so.6 /usr/lib64/libstdc++.so.6
```

## 1.46. �ʣ������� sa ����������ʹ�� coredump ���е���

1. sa ���������ӱ�������  `-g` ����ӵ�����Ϣ

![image](uploads/d13e9746a2335ea2fc94750d5dcb00c9/image.png)

2. ʹ����ʱ���� ������ `coredump` ����

```sh
ulimit -c unlimited
```

ͨ������ `ulimit -a | grep core` �鿴 coredump ��С��Ϊ0��ȷ�� coredump �Ѿ�����

![image](uploads/dd44697a5d663a3b49fce3b0280e33ce/image.png)

3. ���п�ִ�г��򣬲��������������� coredump �ļ�

4. ��ѯ�ҵ� coredump �ļ�����

```sh
cat /proc/sys/kernel/core_pattern
```
![image](uploads/e9cb559b0d6f09731f33bc9f90462778/image.png)

5. ��������ִ���ļ�Ŀ¼��

```sh
cp /tmp/coredump�ļ��� /sbin/
```

6. ʹ�� gdb �鿴 coredump �ļ�

```sh
gdb sa coredumpxxx
```

sa: ��ִ���ļ�

coredumpxxx: coredump �ļ���

![image](uploads/7e867d56c5d86f7b956fb7db267aca87/image.png)

## 1.47. �ʣ�ʹ�ú� yum ����� libstdc++ �������Ӵ���

```c++
rm -f /usr/lib64/libstdc++.so.6
ln -s /usr/local/lib64/libstdc++.so.6 /usr/lib64/libstdc++.so.6
```

## 1.48. �ʣ����ʹ��iperf3����
[iperf3ʹ��˵��.docx](uploads/2ec590de34a8482fc65d98a2ccc2de06/iperf3ʹ��˵��.docx)

## 1.49. �ʣ���δ�ץ���ļ�����ȡamr��Ƶ��������
[��ȡץ���ļ��е�amr��Ƶ��������.docx](uploads/85ae74617881dc1d9bb7f306ab5fcd1d/��ȡץ���ļ��е�amr��Ƶ��������.docx)

## 1.50. �ʣ���β鿴�ļ��� md5 ��ֵ

windows

```c++
certutil -hashfile �ļ� MD5
```

![image](uploads/335e551ee92dbe60b6d97d87df4c6296/image.png)

linux��

```sh
md5sum �ļ���
```

![image](uploads/ea43aec2fec914264c5d70102c52bd1f/image.png)

mac��

```sh
md5 �ļ���
```
![image](uploads/d0955984693ddb34b8198adef08812eb/image.png)

## 1.51. �ʣ������ץ���е��� rtp ��Ƶ���з���

[Wireshark����rtp��Ƶ���ݲ�ʹ��Audacity����](https://blog.csdn.net/gtychuashuiwang/article/details/128399570)

## 1.52. ��: ��� git �����ȡԶ�ֿ̲��ָ����֧

```sh
git clone -b develop http://xxxxx
```

## 1.53. �ʣ�windows �� mysql5.7 �������Զ�̷��ʣ�

[windows��mysql�������Զ������](https://blog.csdn.net/qq_43308242/article/details/104839328)

1. ʹ������ `mysql -uroot -p` ���� mysql
2. ������������

```sh
use mysql;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '�������' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

3. �رձ����� 3306 �˿ڵķ���ǽ

## 1.54. �ʣ� wireshark ץ��ʱ������ʾ failed to set hardware filter to promiscuous mode: ����ϵͳ�ϵ��豸û�з������á�  (31)

![image](uploads/eb7f03ade293a1152a7d8db2f53f5911/image.png)

����ͨ���رջ���ģʽ����ץ��

��� ���� -> ѡ�ȡ����ѡ����ģʽ����ץ��

![image](uploads/1aaf938caac08248f06cc9ff6b9807ad/image.png)

## 1.55. �ʣ�wireshark �л���ģʽָ����ʲô��˼��

ͨ����������Ϊ����ģʽ���ܲ�������������з������ݣ������ǹ㲥���ͷǷ����Լ����������ݰ���

����ѡ��ѡ����Բ��񣬹㲥�����Լ��İ���


## 1.56. ��: `error while loading shared libraries` ���ض�̬��ʧ����ν����

��̬�⻺�����⣺ Linux ʹ�ö�̬���ӿ⻺����������ܡ�������ڳ�������ǰ�����˶�̬���ļ���������Ҫˢ�¶�̬�⻺�档

���������
1. ����Ӧ�Ķ�̬���ļ����뵽`/usr/lib`Ŀ¼�¡�
2. ˢ�¶�̬�⻺�� `sudo ldconfig`
ע����������ֻ��ִ��һ�Σ�����������Ч��

## 1.57. �ʣ� `FAQ` ��ʲô��

FAQ �� Frequently Asked Questions���������⣩����д������ָ���������������һЩ����Ͷ�Ӧ�Ľ��ͨ�����ڰ����û��������������ṩ�����Ϣ��

## 1.58. �ʣ� `Q&A` ��ʲô?

`Question and Answer`��������ش� ����д

## 1.59. �ʣ� [Centos7 ���Դ����� git](https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-%E5%AE%89%E8%A3%85-Git)

1. ���Ȱ�װ gcc �� g++

```sh
yum install -y gcc gcc-c++
```

2. ��װ����

```c++
yum install -y dh-autoreconf curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel asciidoc xmlto docbook2X
```

3. ����Դ�벢��װ

```sh
curl -O https://github.com/git/git/archive/refs/tags/v2.42.0.tar.gz
tar -xzvf git-2.42.0.tar.gz
cd git-2.42.0
make configure
./configure
make all doc info -j12
yum remove git  ///< ɾ���ϰ汾 git
sudo make install
sudo make install install-doc install-html install-info
```

## 1.60. �ʣ� Centos��λ�����ļ�����

1. ���ļ����²����ļ�

```sh
find -name filename
```

2. ȫ������

```sh
find / -name filename
```

3. ʹ��������ʽ������ .cs ��׺���ļ�

```sh
find / -name "*.cs"
```

## 1.61. �ʣ� `Centos7` ���Դ����� gcc/g++

1. ��װ���빤�� gcc g++

```sh
yum install -y gcc gcc-c++
```

2. ��װ���������� 32λ��

```sh
yum install glibc-devel.i686
```

3. ����Դ�룬�� `GCC13.2` ����

```sh
curl -O http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-13.2.0/gcc-13.2.0.tar.gz
tar -xzvf gcc-13.2.0.tar.gz
cd gcc-13.2.0
```

4. �������������ñ���ѡ��

```sh
./contrib/download_prerequisites ///< ��������
./configure --enable-languages=c,c++ --enable-multilib ///< ���ñ��� 32λ �� 64λ
```

5. ���벢��װ

```sh
sudo make -j12 ///< ����

yum remove gcc gcc-c++ ///< ɾ��yum��װ��gcc

sudo make install ///< ��װ

gcc -v ///< �鿴�汾
g++ -v ///< �鿴�汾
```

6. ���� `main.cpp` ����������Ƿ�װ�ɹ�

## 1.62. �ʣ� `Centos7` ��ιرշ���ǽ

1. �鿴����ǽ״̬

```sh
systemctl status firewalld
```

2. �رշ���ǽ

```sh
systemctl stop firewalld
```

3. ֹͣ����ǽ������

```sh
systemctl disable firewalld
```

## 1.63. ��: `Centos7` ���ñʼǱ��ϸǲ�����

```sh
vim /etc/systemd/logind.conf
```

�����ļ����ҵ�����Ҫ�޸ĵ������

```sh
HandlePowerKey ���µ�Դ�������Ϊ��Ĭ��power off
HandleSleepKey ���¹���������Ϊ��Ĭ��suspend
HandleHibernateKey �������߼������Ϊ��Ĭ��hibernate
HandleLidSwitch ���ϱʼǱ��Ǻ����Ϊ��Ĭ��suspend
```

ѡ�

```sh
ignore ���ԣ�����
power off �ػ�
reboot ����
halt ����
lock �����������������������
```

����������Ч

```sh
systemctl restart systemd-logind
```

## 1.64. ��: `Centos7` ��������������� `wifi`

1. ��һ������װ��

```sh
yum install NetworkManager*
```

2. ����NetworkManager�Զ�����

```sh
chkconfig NetworkManager on
```

3. ����WiFi

```sh
nmcli r wifi on
```

4. ɨ�����wifi

```sh
nmcli dev wifi
```

5. ��4��ѯ����`wifi` `SSID`���� `wifi`

```sh
nmcli --ask dev wifi connect SSID
```

���������е�SSIDΪ���Ƶ�WiFi������

����--ask����������wifi���룬���������Ļ�

or

```sh
nmctl dev wifi con "wifi��" password "����" name "����"
```

6. ���wifiû��������

```sh
nmcli con up wifi���������ղ�nmtui���������ӣ�
```

7. ��ӳɹ���鿴�Ѵ�����wifi���ӣ�������

```sh
nmcli conn
```

8. �رտ���������̫��

```sh
cd /etc/sysconfig/network-scripts
vi ifcfg-enp4s0f2   //�������������ļ�
# ����
ONBOOT=no
```

## 1.65. �ʣ�����̨���̶�̨�ֳ������Ų�ȡ֤�ķ�����������
[20220909����̨�̶�̨�����Ų�ȡ֤����v0.5.pdf](uploads/d0d5c61fad72975f328ddd464a471288/20220909����̨�̶�̨�����Ų�ȡ֤����v0.5.pdf)

## 1.66. �ʣ�����̨�ֳ������Ų�ȡ֤�ķ���

1.  ��¼�������ʱ�䣬�����¼���⣬������������

2.  ȡ��־��·��Ϊdc.exe����Ŀ¼��log�ļ�����dc.log

3.  ����ʱץ��������̨��wireshark���ߣ�����������ץ����

    ����̨������ʹ��tcpdump �Ci ����-vvv �Cs 0 �Cw �������ʱ��.pcap

## 1.67. �ʣ�windows/linux�����Ӿ�̬·��

��

1.  windows: �һ����½�windowsͼ�꣬���windows
    powershell(����Ա)���ڴ���������������

2.  route -p�����ñ��棩 add 172.16.1.0��Ŀ���ַ�� mask 255.255.255.0
    192.168.101.1�����ص�ַ/��һ����ַ��ͨ���õ�ַ��ȥ����Ŀ���ַ��

3.  linux:ʹ��CRT�����������������������������

4.  route add -net 172.16.1.0 ��Ŀ���ַ��netmask 255.255.255.0 gw
    192.168.101.1�����ص�ַ/��һ����ַ��ͨ���õ�ַ��ȥ����Ŀ���ַ��

5.  CentOS7���þ�̬·����Ҫд�� /etc/sysconfig/network-scripts/route-������
    �ļ��У�����/etc/sysconfig/network-scripts/�£��½��ļ���Ϊroute-���������ļ�������ѯ������ifconfig���������

    vim /etc/sysconfig/network-scripts/route-������

    100.0.0.0/24 via 192.168.10.20 dev ������

## 1.68. �ʣ�windows/linux��ѯ�˿�״̬

��

1.  windows��netstat -ano \#�鿴���ж˿�

    netstat -ano \| findstr �˿� \#�鿴ָ���˿�

2.  linux��netstat -anp \#�鿴���ж˿�

    netstat -anp \| grep �˿� \#�鿴ָ���˿�


## 1.69. �ʣ���������Ƿ�ɴ�ķ���

1.  telnet����

2.  ץ��

3.  Ping

## 1.70. �ʣ�Linux��������¼����

1.  ���ȵ���IP��ַҪ�ͷ�����IP��ַ��������ͨ��

2.  CRT���ӣ�CRT�����������IPѡ��ssh���ӽ���

3.  ֱ�ӵ���cmd���ڣ�ʹ��ssh IP��ַ�����ӽ���

## 1.71. �ʣ�Linux������¼����

1.  ���ȵ���IP��ַҪ������IP��ַ��������ͨ��

2.  CRT���ӣ�CRT����������IPѡ��telnet���ӽ���

3.  ֱ�ӵ���cmd���ڣ�ʹ��telnet IP��ַ�����ӽ���


## 1.72. ��: `DELL`������`iDRAC`Զ�̿�������

[DELL������iDRACԶ�̿�������](https://www.cnblogs.com/panjianhui/p/12626185.html)


## 1.73. ��: ������� GitLab �� `Private Token`

�� GitLab ������ Private Token ��ѭ���²��裺

1. **��¼�� GitLab �ʻ���** ���ȣ���¼����� GitLab �ʻ���

2. **���������ã�** ��ҳ�����Ͻǣ���ῴ��һ�������˵���ѡ�� "Settings"��

3. **ѡ�� Access Tokens��** ����ർ�����У�ѡ�� "Access Tokens"��

4. **������ Token��** �� "Create a personal access token" ���֣���д��Ҫ����Ϣ���������ơ��������ڵȡ�

5. **ѡ��Ȩ�ޣ�** ѡ��˷������Ƶ�Ȩ�ޡ�ͨ��������Ҫѡ�� `api`���Ա���� GitLab API��

6. **���� Token��** ��� "Create personal access token"��

7. **���� Token��** һ�� Token ���ɣ��������������ڰ�ȫ�ĵط���**������Ψһ�Ļ��Ḵ��������Ϊ�������ٴ���ʾ��**


## 1.74. ��: ��θı� `Centos7` ����������

```sh
hostnamectl set-hostname host_name
```

## 1.75. ��: CentoS7����ʹ��fdisk��4T���̽��з���, ��home��������

[�ĵ���Centos7��home����.docx](uploads/44a6cda68a3bae070a717dcc71f7c784/Centos7��home����.docx)

## 1.76. ��: EN50128 �� D.52 �ᵽ�Ľṹ������

* SSADM (Structured Systems Analysis and Design Method)
* LBMS (Life Cycle Business Method Specification)
* MASCOT (Modular Approach to Software Construction, Operation and Test)
* JSD (Jackson Structured Design)
* Yourdon
* SOM (Software through Object-oriented Methodology)
* SDL (Specification and Description Language)


## 1.77. ��: ssh ������ܵ�¼

�� Centos7 Ϊ���� ���Լ����Ե� id_rsa.pub �е����ݣ�׷�ӵ���Ҫ���ܵ�¼�������� ~/.ssh/authorized_keys �У��ٴ� ssh ��¼����

�Լ��� `id_rsa.pub` �ļ�ͨ��������������ʹ�� `ssh-keygen` ����������� `C:\Users\yourname\.ssh\` �ļ�����

[�ο�](https://blog.csdn.net/jeikerxiao/article/details/84105529)

## 1.78. ��: MySQL ��α��ⳤ�����ҵ���Ӱ�죿

1. ���ȣ���Ӧ�ÿ�����������

- ȷ���Ƿ�ʹ���� set autocommit=0�����ȷ�Ϲ��������ڲ��Ի����п�չ���� MySQL �� general_log ��������Ȼ�������һ��ҵ���߼���ͨ�� general_log ����־��ȷ�ϡ�һ����������������ֵ��Ҳ�ͻ��ṩ������������Ϊ�����Ŀ����ǰ����ĳ� 1��

- ȷ���Ƿ��в���Ҫ��ֻ��������Щ��ܻ�ϰ�߲���ʲô������� begin/commit ���������Ҽ�����Щ��ҵ��û�������Ҫ������Ҳ�Ѻü��� select ���ŵ��������С�����ֻ���������ȥ����

- ҵ���������ݿ��ʱ�򣬸���ҵ�����Ԥ����ͨ�� SET MAX_EXECUTION_TIME ���������ÿ�����ִ�е��ʱ�䣬���ⵥ���������ִ��̫��ʱ�䡣��Ϊʲô�����⣿�ں����������л��ᵽ���స����

2. ��Σ������ݿ��������

- ��� information_schema.Innodb_trx �����ó�������ֵ�������ͱ��� / ���� kill��

- Percona �� pt-kill ������߲����Ƽ�ʹ�ã�

- ��ҵ���ܲ��Խ׶�Ҫ��������е� general_log��������־��Ϊ��ǰ�������⣻

- ���ʹ�õ��� MySQL 5.6 ���߸��°汾���� innodb_undo_tablespaces ���ó� 2��������ֵ���������ĳ��ִ������»ع��ι����������ú��������������㡣

## 1.79. ��: MySQL ʹ�ó����Ӻ���ʱ��Ϊ���صĽ�������󣬵����ڴ��������죬��ν��?

1. ���ڶϿ������ӡ�ʹ��һ��ʱ�䣬���߳��������ж�ִ�й�һ��ռ���ڴ�Ĵ��ѯ�󣬶Ͽ����ӣ�֮��Ҫ��ѯ��������
2. ������õ��� MySQL 5.7 ����°汾��������ÿ��ִ��һ���Ƚϴ�Ĳ�����ͨ��ִ�� mysql_reset_connection �����³�ʼ��������Դ��������̲���Ҫ������������Ȩ����֤�����ǻὫ���ӻָ����ոմ�����ʱ��״̬��

## 1.80. ��: ������ʽ, ���ƥ�� xxx (ms)

```regex
\d{3}\s\(ms\)
```

## 1.81. ��: ������ʽ�����ѡ�в������ı� 172.2.200.66 ����

```sh
��ѡ�л��з�:
^(?!.*172\.2\.200\.66).*$
ѡ�л��з�:
^(?!.*172\.2\.200\.66).*\r?\n?
```

## 1.82. ��: wireshark ������ ICMP ���ĳ��� Destination unreachable (Port unreachable),Ϊʲô������������

��һ��������ͼ���ӵ���һ�������ϵ�һ�������ڵĶ˿�ʱ���ͻ���֡�Destination unreachable (Port unreachable)��������ͨ������������ԭ��֮һ���µģ�

1. Ŀ�������ϵ�Ӧ�ó���û����ָ���Ķ˿������С����磬����㳢�����ӵ�һ��û������Web��������������80�˿ڣ��ͻ�����������

2. Ŀ�������ϵķ���ǽ��·������ֹ�����ӡ����������Ϊ����ǽ��·�������ò���ȷ��������Ϊ����������ֹδ����Ȩ�����ӡ�

3. Ŀ���������ɴ���������ΪĿ�������ѹرա�������ϻ�����ԭ���µġ�

��Wireshark����һ����Destination unreachable (Port unreachable)������ʱ����ͨ�������ICMP���ġ����ICMP������Ŀ���������ͻ����ģ�����Դ��������ʧ�ܵ�ԭ����Wireshark�У�����Բ鿴ICMP���ĵ���ϸ��Ϣ����ȷ������ʧ�ܵ�ԭ��

## 1.83. �ʣ� ��Ϊ����������װҪ��

1. �ó����û���¼��
2. �����Ҫ��װ�����ĺ��пո��Ŀ¼
3. ��������賬���û�Ȩ��
4. �رշ���ǽ

## 1.84. ��: ���ת�� md �ļ�Ϊ latex �ļ�

ʹ�� pandoc.exe �Լ� eisvogel latex ģ�� ����

[pandoc ��װ����](https://pandoc.org/installing.html)

[eisvogel ��װ����](https://github.com/Wandmalfarbe/pandoc-latex-template)

```ps
pandoc skiplist.md -o example.pdf --from markdown --template eisvogel --listings --pdf-engine=xelatex -V CJKmainfont="Microsoft YaHei"
```

## 1.85. ��: g++ ����ѡ�� `-Wl,--no-as-needed` ��ʲô��˼��

`-Wl,--no-as-needed`��һ������ѡ����ڸ���������������ʱ��Ҫ����δʹ�õĿ⡣

��Linuxϵͳ�У�������Ĭ�ϻ����δʹ�õĿ⣬����ζ��������ĳ���û��ʹ�ÿ��е��κκ�������ô�ÿ⽫���ᱻ���ӵ����ĳ����С�������Ϊ���Լ��ٳ���Ĵ�С������ʱ�䣬��Ҳ���ܵ���һЩ���⣬������ʹ��`dlopen`��̬���ؿ�ʱ��δʹ�õĿ���ܻᱻ����غ��ԡ�

ʹ��`-Wl,--no-as-needed`ѡ����Խ�����������������Ϊ��ȷ�����пⶼ�����ӵ������У������Ƿ�ʹ���˿��еĺ���������Խ��һЩ�������⣬������ʹ��`dlopen`��̬���ؿ�ʱ��ȷ�����������ⶼ����ȷ�ؼ��ء�

��Ҫע����ǣ�ʹ��`-Wl,--no-as-needed`ѡ����ܻ����ӳ���Ĵ�С������ʱ�䣬��Ϊ���пⶼ�����ӵ������У���ʹ���ĳ���û��ʹ�ÿ��е��κκ�������ˣ�ֻ������Ҫʱ��Ӧ��ʹ�ø�ѡ�

## 1.86. ��: ���ֱ��뾯�� `warning: Using 'getaddrinfo' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking`

��ϸ����:

```shell
[build] ../../../lib/libgtest.a(gtest-all.cc.o): In function `testing::internal::StreamingListener::SocketWriter::MakeConnection()':
[build] /home/lijiancong/gitlab/wz2/ds/thirdparty/googletest/googletest/src/gtest.cc:4916: warning: Using 'getaddrinfo' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
```

��������������ھ�̬����ʱʹ����`getaddrinfo`���������ú�����Ҫ������ʱʹ��������ʱʹ�õ�glibc�汾��ͬ�Ĺ���⡣��������뿴��������棬�����ڱ���ʱ���`-Wl,--no-as-needed`ѡ�

�������ڱ���ʱ���`-Wl,--no-as-needed`ѡ���ʾ����

```
g++ -o myapp myapp.cpp -lgtest -Wl,--no-as-needed
```

��ע�⣬������沢����Ӱ�����ĳ�������У�ֻ����������ʹ��`getaddrinfo`����ʱ��Ҫע�⡣������ĳ���û��ʹ��`getaddrinfo`��������ô�����Ժ���������档

## 1.87. ��: ��β鿴 centos7 ͨ�� yum ��װ����Щ���

```shell
yum list installed
```

## 1.88. ��: ����Զ�ͳ�����һ�� git �ύ�����ӻ�ɾ���Ĵ�������

����:
```git
git diff --numstat HEAD~1 HEAD
```

�����ʽ:
```shell
<����������>\t<ɾ��������>\t<�ļ���>
```

## 1.89. ��: ubuntu ��β鿴cpu�¶�

��Ubuntu�ϲ鿴CPU�¶ȣ�����ʹ��`lm-sensors`���ߡ��밴�����²��������

1. ���Ȱ�װ`lm-sensors`��

```
sudo apt update
sudo apt install lm-sensors
```

2. ����`sensors-detect`����Լ������ϵͳ�ϵĴ�������

```
sudo sensors-detect
```

������ʾ�ش����⡣���������£�������ֱ�Ӱ�Enter��ѡ��Ĭ��ѡ���ɺ���������һ�������ļ���

3. �����ں�ģ�飺

```
sudo service kmod start
```

4. ���ڣ�������ʹ��`sensors`����鿴CPU�¶ȣ�

ÿ����ˢ��һ�� sensors ����
```
watch -n 2 sensors
```

�⽫��ʾϵͳ�����д����������������CPU�¶ȡ����������Ӳ���ʹ��������Ͷ��졣

## 1.90. ��: ����ʹ�� git ��Ҫ���е�����

```shell
git config --global user.name "�������"
git config --global user.email "�������"

ssh-keygen -t rsa -C ������� // һ·�س�����ssh-key
```

## 1.91. ��: NAT ��ɶ

NAT��Network Address Translation����һ�������ַת�������������ڽ�˽�������ڵ�IP��ַת��Ϊ����IP��ַ�����ּ������Խ�����豸����һ������IP��ַ���Ӷ���һ���̶��ϻ���IPv4��ַ��������⡣

NATͨ�������ڼ�ͥ��С�Ͱ칫�����磬ʹ�ö���豸����ͨ��һ������IP��ַ�뻥��������ͨ�š���NAT�����У�˽�������е�ÿ���豸��������һ��˽��IP��ַ����Щ��ַͨ���ڱ�����������Ψһ�ģ����ڹ����в���Ψһ�ġ�����Щ�豸��Ҫ���ʻ�����ʱ��NAT����˽��IP��ַת��Ϊ����IP��ַ���Ӷ�ʵ���뻥����ͨ�š�

���⣬NAT���������ڰ�ȫĿ�ģ����罫����ǽ����������豸��ʹ��һ������IP��ַ���Ӷ����������ߵĹ����档

## 1.92. ��: IPSec ��ɶ

IPSec��Internet Protocol Security����һ����Internet Protocol��IP�������ṩ���ݼ��ܡ�����������У��������֤��Э�顣���ṩ��һ�ְ�ȫ��ͨ�ŷ�ʽ�����ڱ����ڹ������磨��Internet���ϴ�������ݡ�IPSec��һ�����ŵı�׼�����㷺����VPN��Virtual Private Network����������ȫ�������ӵ�ʵ���С�

IPSecʹ��һϵ�м����㷨����֤���ƺ���Կ����Э����ȷ�����ݵı����ԡ������ԺͿɿ��ԡ�������Ϊ���������ṩ�˵��˵İ�ȫ�ԣ��Ӷ�ʹ�û����԰�ȫ��Զ�̷���˽��������Դ�������ص����������ݱ������߽ػ�ʹ۸ġ�IPSec���������ڱ���VoIP��Voice over IP������Ƶ����ʵʱӦ�ó�������ݴ��䣬�Ӷ���֤���ݵ�ʵʱ�ԺͰ�ȫ�ԡ�

IPSecЭ����һ�����ӵ�Э�飬��Ҫ�������豸�Ͻ������ú͹������ǣ��ִ��������豸ͨ����֧��IPSecЭ�飬���ṩ������ʹ�õĹ�����棬ʹ�����ú͹����ø������ס�

## 1.93. ��: mysql ���ʵ����������

MySQL ֧�ֶ��ֲ�ͬ�ĸ��Ʒ�ʽ�����а������Ӹ��ƺ��������ơ����Ӹ���������ĸ��Ʒ�ʽ������һ�� MySQL ��������Ϊ����������������պʹ���д��������������Ǹ��Ƶ�һ�������ӷ������ϡ��ӷ�����ֻ�ܶ�ȡ���ݣ�����д�����ݡ�

���֮�£����������������� MySQL ������ͬʱ�䵱����������ÿ���������������Խ��պʹ���д���������������ͬ�����������������ϡ����ָ��Ʒ�ʽ�������ϵͳ�Ŀ����Ժ��ݴ���������Ϊ��ʹһ�������������ֹ��ϣ���������������Ȼ���Լ����ṩ����

Ҫʵ�� MySQL ���������ƣ�����Ҫִ�����²��裺

1. ��ÿ�����������ϴ���һ�� MySQL ʵ�������ֱ��������ǵ����������ʹӷ�������Ϣ����Щ��Ϣ���������� ID����־�ļ����ƺ�λ�á��Լ�Ҫ���Ƶ����ݿ�ͱ���б�ȵȡ�

2. ��ÿ���������������ö�������־��¼��binary logging�����Ա��¼����д��������������Ǵ������������������ʹӷ������ϡ�������ʹ�� MySQL �������ļ���������ѡ�������ö�������־��¼��

3. ��ÿ���������������ø��ƹ�������replication filters�����Ա���˵�����Ҫ���Ƶ����ݡ����磬������ѡ��ֻ����ĳЩ���ݿ��������ų�ĳЩ�������ͣ��� DROP TABLE �� DELETE��

4. ��ÿ�����������������������ƣ����������ӵ��������������ϡ�������ʹ�� MySQL �� CHANGE MASTER TO ����������ļ���ָ����������������������Ϣ����ע�⣬����ҪΪÿ��������������һ�������ĸ������ӡ�

5. ��ÿ�������������������ƽ��̣����ȴ�����ͬ����ɡ����һ����������Ӧ���ܹ���ÿ�����������Ͽ���ͬ�������ݡ�

��Ҫע����ǣ�MySQL ������������Ҫ����һЩ��������ú�ά����������ȷ�����ݵ�һ���ԺͿɿ��ԡ����磬����Ҫ���ڼ����޸�������ͻ���������ͬ���ӳٺͳ�ͻ���Լ����ݺͻָ����ݵȵȡ���ˣ����������Ϥ MySQL �ĸ��ƺ͹������������Ƚ���һЩ���Ժ�ʵ�飬��ȷ������ϵͳ�ܹ���ȷ�ش�����Ϻ��쳣�����


## 1.94. �ʣ��������ɾ����־�ļ��еĿ���

1. ����Ҫ�����ı�������ļ���
2. �� Ctrl + H ���滻��塣
3. ���滻����У�������ģʽ�л�Ϊ������ʽģʽ���������Ҳ�� .* ͼ�꼴���л�����
4. ��������������������ʽ ^\s*$\n?����ʾ�������С����У�^ ��ʾ�еĿ�ͷ��$ ��ʾ�еĽ�β��\s ��ʾ�հ��ַ��������ո��Ʊ���ȣ���* ��ʾƥ�����������\n ��ʾƥ����β���з���
5. ���滻���в������κ����ݣ���ʾ�������������Ŀ����滻Ϊ�ա�
6. ��� Replace All ��ť����ɾ�����п��С�

## 1.95. ��: ��ΰ���־�д����ظ���־ɾ��

VSCode ��

1. ����Ҫ�����ı�������ļ���
2. �� Ctrl + H ���滻��塣
3. ���滻����У�������ģʽ�л�Ϊ������ʽģʽ���������Ҳ�� .* ͼ�꼴���л�����
4. ��������������������ʽ
```text
^.*����Ҫƥ����ַ���.*\r?\n?

��:
^.*retry send app msg failed.*\r?\n?
^.*Find no position.*\r?\n?
^.*SetRegisterStatus: strLongNum.*\r?\n?
```
��ʾ���������ض��ַ��������У�ͬʱƥ�� Windows �� Unix �Ļ��з������У�^ ��ʾ�еĿ�ͷ��$ ��ʾ�еĽ�β��\[��\]��\s ���ַ���Ҫ�÷�б�ܽ���ת�塣

5. ���滻�������� \r\n����ʾ�� Windows ���з��滻ƥ����С������ʹ�õ��� Unix ϵͳ���������� \n��
6. ��� Replace All ��ť����ɾ�����а����ض��ַ������в��Ҳ����¿��С�

## 1.96. ��: ʲô�� SQA ?

SQA��Software Quality Assurance��������ָ������������������ж�����������й���ͱ��ϵĹ�����SQA ����ּ��ȷ�������Ʒ�ܹ������û������������ͬʱҲ������֯��������׼�ͷ���Ҫ��

SQA �����������·��棺

1. �滮�͹���������ȷ�����������е�������׼��Ŀ�꣬��ȷ����Ŀ�Ŷ���ѭ��Щ��׼��Ŀ�ꡣ

2. ������֤���ƶ���ִ�и���������֤�����ȷ�������Ʒ������������֯�ı�׼���û���������

3. ���Թ����滮����ƺ͹�����Ի���������Լƻ����������������Գ����Ͳ��Ա��档

4. ȱ�ݹ�������������������з��ֵ������ȱ�ݣ����������¼��ȱ�ݸ��ٺ�ȱ���޸��Ȼ��

5. �˲����ˣ����������������еĸ����ĵ�������������ļ�����ȷ���������������ԡ�

6. ���̸Ľ���ͨ��������������̽��з��������������������ƿ����������Ľ����飬������������Ч�ʺ�������

SQA �������������Ʒ�ĳɹ��������û������������Ҫ�������԰�����֯������������ɱ��ͷ��գ�����������Ч�ʺ��������Ӷ���ǿ��֯�ľ�������

## 1.97. ��: ʲô�� 8D ����

8D������Eight Disciplines�����8D����һ�����ڽ������͸Ľ����̵�������������8D��һ��ϵͳ�ԡ������Եķ�����ͨ�����ڽ���������⣬��Ҳ����Ӧ�����������͵����⡣

8D�����ɰ˸�������ɣ�ÿ�����趼���ض��������Ŀ�ꡣ��Щ�����ǣ�

1. ȷ�����ⷶΧ����ȷ��������ʡ�Ӱ�췶Χ��Ӱ��̶ȡ�
2. �齨�Ŷӣ�ѡ��߱����֪ʶ�ͼ��ܵ���Ա����Ŷӣ�ȷ���ŶӸ����ˡ�
3. �������⣺�����������ϸ����������������ķ���ʱ�䡢�ص㡢Ƶ�ʡ������Եȡ�
4. �ƶ���ʱ��ʩ����ȡ��Ҫ�Ĵ�ʩ����������ķ�������ɢ��ȷ�����ⲻ���һ���񻯡�
5. ȷ������ԭ��ʹ�ó��õ�����������ߺͼ�����ȷ������ĸ���ԭ��
6. �ƶ����ڴ�ʩ�����ڶԸ���ԭ��ķ������ƶ����еĳ��ڴ�ʩ��������⡣
7. ʵʩ����֤��ʩ��ʵʩ���ڴ�ʩ������֤����Ч�ԡ�
8. Ԥ����ʩ��ͨ��ѧϰ���ܽᾭ�飬��ȡԤ����ʩ����ֹ�����ٴη�����

8D������һ�ֳ��õ������������������԰�����֯���õ�������⣬��ͨ���ƶ����еĽ�����������ƺ��Ż����̣������֯�ļ�Ч��Ч�ʡ�

## 1.98. ��: �������Ժ� docker desktop һֱ����������

1. ɱ�����˳� docker desktop
2. ����Աģʽ���� command line ����
```shell
net stop com.docker.service
wsl --unregister docker-desktop
wsl --unregister docker-desktop-data
net start com.docker.service
```

## 1.99. ��: CSDN ��β���½���ƴ���?

1. F12 ���뿪����ģʽ

2. ����������
```log
document.designMode='on'
```

## 1.100. ��: MySQL ��β鿴���ݿ������б������

```sql
SELECT table_name, table_rows FROM information_schema.tables WHERE table_schema = 'your_database_name';
```

## 1.101. ��: Centos7 ��β�ѯ���̹�����ռ�����

```sh
* df -T  ֻ���Բ鿴�Ѿ����صķ������ļ�ϵͳ����

* fdisk -l ������ʾ�����й��غ�δ���صķ�����������ʾ�ļ�ϵͳ����

* parted -l ���Բ鿴δ���ص��ļ�ϵͳ���ͣ��Լ���Щ������δ��ʽ��

* lsblk -f ���Բ鿴δ���ص��ļ�ϵͳ����

* df -h �鿴����ʹ����

* du -h �鿴�ļ��д���ռ�����

* sudo fdisk -l ����ϵͳ�����п��÷�������Ϣ
```

## 1.102. ��: git ���ͨ�������ָ��ʱ��� commit ��Ϣ

1. ͨ����ǩ�ţ���ѯ�ñ�ǩ��(V2.0.56)�� ����ǰ���ύ��Ϣ
```sh
git log V2.0.0.58-P4..HEAD --pretty=format:"* %ad %an [%h](%H) : %s %b" --date=short --no-merges
```

2. ͨ��ʱ���ѯ����ʱ�䵽���ڵ��ύ��Ϣ

```sh
git log  --after="2023-3-6 16:20" --pretty=format:"* %ad %an [%h](%H) : %s %b" --date=short --no-merges
```

## 1.103. ��: wsl ������ε����뵼��

```cmd
/// ����
wsl --export <ϵͳ����> <����λ��//��������.tar>

wsl --export Ubuntu F://desktop//ubuntu.tar

/// ����
wsl --import <ϵͳ����> <Ҫ�ᵽ��λ��> <֮ǰ��������λ��>

wsl --import Ubuntu D://WSLUbuntu F://desktop//ubuntu.tar
```

## 1.104. ��: centos �鿴ϵͳ�汾

```shell
cat /etc/centos-release
```

## 1.105. ��: openEuler �鿴ϵͳ�汾

```shell
cat /etc/openEuler-release
```

## 1.106. ��: ubuntu ��װ 32 λ libmysql

```shell
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install libmysqlclient-dev:i386
```

## 1.107. ��: ubuntu �鿴�Ѱ�װ���

```sh
dpkg -l | grep -i "mysql"
```

## 1.108. ��: mysql �����������

```sql
BEGIN
	DECLARE i INT DEFAULT 0;
    WHILE i < for_time * 10000 DO
		INSERT INTO operation_log(UUID, Time, UserType, UserID, LogInfo) VALUES(i, 1671612154, "123456789", "123456789", "123456789");
         SET i = i + 1;
    END WHILE;
END
```

## 1.109. ��: centos7 �� �����������еĶ˿�

```sh
netstat -ano
```

## 1.110. ��: �鿴��ռ�ö˿ڶ�Ӧ�� PID

```sh
netstat -aon|findstr "<pid>"
```

## 1.111. ��: �鿴ָ�� PID �Ľ���

```sh
tasklist | findstr "<pid>"
```

## 1.112. ��: �滻 sh �ű��е� window �ַ� ^M

```sh
sed -i -e 's/\r$//' compress_log.sh
```

## 1.113. ��: �鿴��ִ���ļ������� ��̬��

```cmd
dd /sbin/ftpd
```

## 1.114. ��: ��ȡ GitLab ָ���������� open ״̬�µ� issue

```cmd
curl.exe --header "Private-Token: ojWG5DPUbmRSGqMxZs1s" "http://gitlab.gbcom.com.cn/api/v4/projects/701/issues"
```

## 1.115. ��: ��ȡ GitLab ָ������ӵ�� Bug ��ǩ�� issue ���������ļ� bug.json

```cmd
curl.exe -o bug.json --header "Private-Token: ojWG5DPUbmRSGqMxZs1s" "http://gitlab.gbcom.com.cn/api/v4/projects/701/issues?labels=Bug&state=opened&per_page=1000"
```

## 1.116. ��: google/benchmark ִ�ж�Ӧ�����ܲ���

```cmd
/// ִ�ж�Ӧ�����ܲ���
.\gos_benchmark.exe --benchmark_filter=BM_LogStream
/// ��ָ���ĵ�Ԫ���Ժ�ִ���ظ�
./build/ds/cp4_filesystem/cp4_filesystem_tests --gtest_filter=vector.for_erase  --gtest_repeat=1000 --gtest_break_on_failure
```

## 1.117. ��: cmake ȫ������

1. windows ��
```cmd
cmake --build ./build/ --config=Debug
```

2. linux ��
```sh
sudo cmake --build ./build/ --target all --clean-first -- -j $(nproc)
```

## 1.118. ��: cmake ���� gos ��Ԫ����

1. windows
```cmd
cmake --build ./build/ds/gos --target gos_tests
```
2. linux
```sh
cmake --build ./build/ds/gos --target gos_tests -- -j$(nproc)
```

## 1.119. ��: cmake ��������

windows

```cmd
cmake -E chdir "build" cmake .. -A Win32
```

## 1.120. ��: CMake ���в���

windows

```cmd
cmake --build ./build/ --target RUN_TESTS --config=Debug

# ���ɡ����롢���в���
cmake -E chdir "build" cmake .. -A Win32 ; cmake --build ./build/ ; cmake -E chdir "build" ctest .. -C Debug
```

## 1.121. ��:CMakeָ��MSVC����ʱ��
```
��CMake 3.15�汾������MSVC_RUNTIME_LIBRARY Ŀ����������޸�MSVC����ʱ��
�����÷�Ϊ����д��cmake_minimum_required��project֮����������MSVC���п⣬������Ӱ�����е�����Ŀ�꣬���磺
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>") ///��DEBUGģʽ��ʹ��/MT ��
MultiThreaded�ؼ��ֱ�ʾMT��
��������ؼ��ֿ��Բ��չ�����https://runebook.dev/zh/docs/cmake/variable/cmake_msvc_runtime_library
```

## 1.122. ��:Ϊ�ι������ص�googleTest��ܵ�����ʱ��ȱʡΪ/MT �����޸�

��string(REPLACE "/MD" "-MT" ${flag_var} "${${flag_var}}")ע�ͺ�����޸�
![image](uploads/84716b5788e299be105c1b3d1c5d012c/image.png)


## 1.123. ��: ubuntu �滻�廪Դ

```cmd
sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
```

## 1.124. �ʣ�����̨����޷���¼����ʾ���Ӽ�Ⱥ������ʧ��

��

1.  �鿴����IP��ַ��ping����Ƿ���Ժͼ�Ⱥ��������ַ����ͨ�š�

2.  �鿴dc.ini��mdc_ip =��ַ�Ƿ����

3.  ����SDK����δ������ע�⣺��һ�ΰ�װ����ʱҪ�Թ���Ա������У���װ��ɺ���Ҫ�������ԡ�

![7cc8192f462e3add3a76bec5f87b2dbc](uploads/4e5d9c318e41ffed56bc783c1daf3d27/7cc8192f462e3add3a76bec5f87b2dbc.png)

![5704f4b6d46cf6b793b1e65ed5170db0](uploads/a92e0e1cf2f1a2e479c76427869a009c/5704f4b6d46cf6b793b1e65ed5170db0.png)

## 1.125. �ʣ�����̨����޷���¼����ʾ���Ӷ������ȷ�����ʧ��

��

1.  �鿴����IP��ַ��ping����Ƿ���ԺͶ������ȷ���������ͨ�ţ�����ɴ

2.  �鿴dc.ini��dis_ip = ��ַ�Ƿ����

![45eeadaa9aebaaa5bb6ccad8599c4fbc](uploads/3e07d5e6ca8089ea85b15fe98922a932/45eeadaa9aebaaa5bb6ccad8599c4fbc.png)

![0991c896ca4cb82d666fd6bac158a791](uploads/e91a25f72c3e8edfcceeed3ca3d2806b/0991c896ca4cb82d666fd6bac158a791.png)

## 1.126. �ʣ�����̨�����¼ʱ����ʾ��Ƶ����ʧ��

��

1.  �鿴�Ƿ�û�н���Ƶ�豸��

2.  �鿴��Ƶ�豸�Ƿ񱻽��ã��������½��Ҽ������������С���ȣ�ѡ���������鿴���ź�¼������Ƶ�豸�Ƿ�������

    ע�����Ǹհ�װ��Ϊ�����п�����û��ʹ�ù���ԱȨ�ް�װ��Ϊ�����¡�

![6c9d31d5213cfee592f363fcc967ecd9](uploads/edad2e31aee6dcf2759e54b288ca64a3/6c9d31d5213cfee592f363fcc967ecd9.png)

![fb58e934250485e584478beed75d4768](uploads/650e6afdda52049933db22503838a5a9/fb58e934250485e584478beed75d4768.png)

![56acc30d0c0f34ad95e112029246d1e5](uploads/91cc9d3da94455ef2f0a590118c085e1/56acc30d0c0f34ad95e112029246d1e5.png)

![079b13a7c06dcb36e94496c95fd9fa26](uploads/4a923f3f3fe0389e55d6bfbbcb446062/079b13a7c06dcb36e94496c95fd9fa26.png)

![eadc88fec0ae625cd8a0367573f643e4](uploads/e18cd81cba1e6fd1877bcee5c7b3b6be/eadc88fec0ae625cd8a0367573f643e4.png)

## 1.127. �ʣ���¼����̨���ʱ�����ּ�������ʧ��

��

1.  �鿴��־���Ƿ������Դ����ӡ���磺[error]�������������ݿ�

2.  ���dis��dc�汾�Ƿ�ƥ�䡣

���磺Dis.log����[DTP]socker error����dis�����µ�¼dc���ܷ�ָ���

![68aebdc3c7a85c3f000f90221705cebe](uploads/cc6827aa0be06f046f4969ce0e1b7168/68aebdc3c7a85c3f000f90221705cebe.png)

![85f416692db158ac069a090cb01b2536](uploads/5617352e683c2deeee52f9edb3a32ad6/85f416692db158ac069a090cb01b2536.png)  


## 1.128. �ʣ�����̨�͵��ȷ�������������ʱ������̨��ʾ���Ӷ������ȷ�����ʧ��

��

1.  Զ�����Ӷ������ȷ������鿴dis�����Ƿ��������У��Ƿ��н��̺š���־�Ƿ���error��ӡ����

2.  Dis�ǲ����ڷ�������

3.  Dis���������ݿ��Ƿ���������

![30d24228bd83ccba93b54f86cd2f59d5](uploads/a124c457610e117d8e2f70d7225d1a96/30d24228bd83ccba93b54f86cd2f59d5.png)

## 1.129. �ʣ�����̨����򿪺󣬵�¼���棬��¼���˳���ť��λ��

�𣺲鿴����̨���Եķֱ��ʣ���ϵͳ�����Ҽ�ѡ����ʾ���ã��鿴�����벼�ֽ��ֱ������ó�����ġ�

![5db1671b4bc044a4b65917a56c1e2f85](uploads/e4c52316e52ae1cdef1b889174e9481c/5db1671b4bc044a4b65917a56c1e2f85.png)

## 1.130. �ʣ�����̨������½�ָʾ�ƣ�LTE���졢CAD���졢ATS���졢NTP����

��**LTE����**ʱ��ping������MDC��ַ���Ƿ��������ͨ�ţ�������о��Ų��������⡣����pingͨ�Ļ����鿴sdk�����������С�

CAD���죬ping����������dis�ĵ�ַ���Ƿ��������ͨ�š�

ATS���죬�������̨�������鿴ATS�ӿ��Ƿ��������鿴��־�Ƿ��й���ATS�ı�������pingATS�ӿڵ�ַ�ܷ�ͨ�š�

NTP���죬�鿴���ӵ�NTP��������NTP״̬�Ƿ�����

![19f965039b5c6db3420a35a6986ae23e](uploads/e552d575ca0f926a0cc00b0c9df449b1/19f965039b5c6db3420a35a6986ae23e.png)

![aef467b18441f00b2fec2982b689d221](uploads/62734ee3af90a111681a82c34742435c/aef467b18441f00b2fec2982b689d221.png)


## 1.131. �ʣ������վ�����г�û��������ڳ���

��

��һ�֣��ó�վ/�г�û���飬��Ҫͨ��ά������̨���г�/��վ����顣

�ڶ��֣��������̨�Ϸ�ϵͳ����-\>ҵ�����������ʾ���е�����Ҫ��ѡ��

![c001eee06ccc826c50eb630cd3d13538](uploads/7a1676237f8f98be88dff391bd67b9af/c001eee06ccc826c50eb630cd3d13538.png)

![60ca55f2e988265f4d87fe7279d2fa33](uploads/f9b028aaa0bda2ea7782a8c660d88e4c/60ca55f2e988265f4d87fe7279d2fa33.png)

![3c1f0c64428fd849b77312bb5a844b98](uploads/4c220c90f6b80be299e6d0f54ead3fbd/3c1f0c64428fd849b77312bb5a844b98.png)

## 1.132. �ʣ��˹��㲥�����û�з��ع㲥״̬���޷���ʼ�㲥��

��

1.  �����ǵ���˹��㲥��ťʱ���򿪴��ڣ���ʱ�ͻ����˹��㲥�����͸�PAϵͳ��������г��ϵ������㲥��Ӧ������ǵ���̨���Կ�ʼ�Ĺ㲥״̬��

2.  �鿴����������SA��־��tail -f
    /mnt/emmc/logsave/sa.log���Ȳ鿴�͹㲥�ӿ��Ƿ��������ӣ�������������Ļ�������̨�˹��㲥�����ʱ��sa����־Ҳ���з����˹��㲥�Ĵ�ӡ

3.  ���û�����Ų������ڲ�����鿴����̨��־���Ƿ��з����˹��㲥������

4.  ����У�����Ҫ�㲥�����Ų����⣬���Խ���ץ����ͨ�����Ľ�һ��ȷ�������Ƿ񷢳���


## 1.133. �ʣ��˹��㲥����󣬰���PTT˵������û�������㲥������

��

1.  ��������ץ���鿴�Ƿ���PCM���ķ���

2.  �鿴����̨��־�����Ƿ��з���PCM�Ĵ�ӡ���ڵ���̨�����ϰ�װWireshark����ץ�����ߣ������˹��㲥ҵ��ʱ�鿴�Ƿ���UDP���ķ���

## 1.134. �ʣ�Ԥ¼���㲥�����û���յ��㲥״̬��

��

1.  ȷ�ϰ���û�з��͵��㲥ϵͳ

2.  ��Ҫȷ��Ԥ¼���㲥�Ƿ�ɹ����ų���������г��ϳɹ����ţ����ǹ㲥ϵͳû������Ӧ�����Ϣ���п������ǵ������ǲ�����ɺ�Ÿ�����Ӧ�𣬵������������һ�����⣬���ǵ���̨��Ԥ¼���㲥����󣬴����Ǵ�״̬ʱ������̨û�յ��㲥��Ӧ�𣬾ͻ��ظ�ȥ��㲥ϵͳ������ͬԤ¼���㲥���㲥ϵͳû�����жϵĻ���Ԥ¼���㲥�ͻ��ڳ���һֱ�ظ����ţ��㲥ϵͳӦ���յ�Ԥ¼����Ϣ�����̸�����̨Ӧ����Ϣ��

3.  �������û�в���Ԥ¼���㲥�����Ų����̨���͵���Ϣ������̨����SA�Ƿ��յ���ת�����鿴sa.log�Ϳ��Կ�����

## 1.135. �ʣ�Ԥ¼���㲥�����ʵ�ʲ��Ŵ����͵���̨ѡ�����������

��Ԥ¼���㲥�����Ǻ�Ԥ¼���㲥����һ���͸��㲥ϵͳ�ģ�����ͨ���鿴sa����־���������Ԥ¼���㲥�������ţ��Ǵ������ԣ�������ǹ㲥ϵͳ�������⣬��������������վ�ȹ㲥���š�

## 1.136. �ʣ�IPH�����������󣬵���̨û����ʾIPH����

�𣺲鿴sa��־��ȷ��IPH������û�з������ǣ����û����Ҫ�㲥ϵͳ�Ų飬�еĻ����Ų������ڲ���

��һ�֣��Ų��г��Ƿ���λ����Ϣ�����û�У��鿴dis��ATS�ӿ��Ƿ���������ʱ���ԵĻ�����ʹ���ֶ�ת�飬���г�һ��λ�á�

�ڶ��֣��Ų������Ƿ�������sa�Ƿ���Ϣ���͸�dis���鿴dis����־���鿴dc����־��

![14e84b756de9211a94dcd6e6e4db6534](uploads/9d9ca33bc9d8239bb63a48a86a3ad7f2/14e84b756de9211a94dcd6e6e4db6534.png)

## 1.137. �ʣ�IPH����������������̨�����󣬱�����������δ��ͨ״̬

��

1.  �鿴sa��־������̨�����������Ϣ���͸�dis��dis�ٷ��͸�sa��sa��־���е���̨��������Ϣ

2.  ��������ץ���鿴��Ϣ��û�з��͸��㲥���ң�������˾���Ҫ�㲥�����Ų����⡣

## 1.138. �ʣ�IPH�����������󣬵���̨������û����Ƶ��

��

1.  ʹ�õ���̨ping�㲥�����ĵ�ַ��ping��ͨ�Ļ��Ƚ���������⣬

2.  �����pingͨ���ڵ���̨�ĵ�����ʹ��VLC�������������Բ鿴dc.log������н���IPH����ƵURL��Ϣ�����Ƶ�VLC�����������ܷ�鿴����Ƶ�����磺"VideoURL":"rtsp://192.0.1.27:55404/h264/ch1/sub/av_stream"

3.  ������ܿ�����Ƶ������Ҫ�㲥�����Ų�����ͷ��IP�Ͷ˿ڵ��Ƿ�������ȷ��

4.  ����ܿ�����Ƶ������Ҫ�Ų����̨������⡣


## 1.139. �ʣ�IPH�����������󣬵���̨������������������������������

��

1.  ����̨��������������������ֱ�ӵ���̨ץ����������̨���ܷ��յ�����������������

2.  ���û�У��ڳ���̨�����Ͻ���ץ�����������Ƿ���ץ����������������

3.  �����ץ�������Ų��ڲ�����

4.  �������ץ����������Ҫ�㲥ϵͳ�Ų鱨���������Ƿ��ͳ���

5.  ����������������ˣ����Ų��м䳵�ط���ǽ�Ƿ�ѱ��������ˡ�

## 1.140. �ʣ�����̨��������δ������δ֪��ŵ����

��

1.  �Ȳ鿴�õ���̨���½Ǻ��м�¼�����Ǹ�Ⱥ����е������

2.  ����˵���Ļ��л�Ȩ����ʾ�����������ƺ���������ж����������͡�

3.  ����Ǿ�̬�飬�ھ�̬���б���һ��ʼû�ҵ���Ⱥ�飬�Ҽ�ѡ��鿴�����飬�����ҵ�����飬��״̬Ӧ���ǶԽ���������̨����ͨ����,�˳�Ⱥ���������ͨ���ˣ�

4.  ����Ƕ�̬��������ɽ��飬����ͨ��dc.exe -t
    �򿪲��ԣ����ҵ����������̬����ɽ���ĵ���̨��Ȼ��ѯ���Ƿ��Ⱥ���Ƿ����ã�û�еĻ����ͷŵ���

![dc4f3a0920d9b14edeef3790ceb8e9e4](uploads/2ab89f19098629ca1035a09d23b52b50/dc4f3a0920d9b14edeef3790ceb8e9e4.png)

![2d97a8d4e84f8a5cb5fce43047098d17](uploads/ca9699e8b744af10a953af5c1f13ce07/2d97a8d4e84f8a5cb5fce43047098d17.png)

## 1.141. �ʣ� ��Ⱥ��������ʱ������Ȩʧ�ܣ�������Ȩ��ʾ����

��

1.  �鿴����̨�Ƿ���������LTE���硣

2.  �鿴��Ⱥ������Ա��û���������̨

3.  �����Ӧ������������̨ͬʱ��˵������������Ȩ��ʾ

4.  ���û�У���Ҫ�������ѵ���̨����þ�̬�顣

## 1.142. �ʣ����ų�����ʾ��ʾ����û�ж��ż�¼

�𣺲鿴dc.log��û���½����ŵĴ�ӡ�����ſ��Ե�sdkĿ¼��������û��������ݡ�

## 1.143. �ʣ�����̨��Ƶ����ʱ��ѡ����Ҫȷ��ֱ����ȡʱ�ֳ�̨����Ҫ����ȷ��

����Ҫ�ֳ�̨����Ƶ�ش������ñ����ش���ȷ�ϵĹ�ѡȥ����

# 2. ���ȷ�����FAQ

## 2.1. �ʣ����ݿ��޷�Զ��ͨ��root����

�𣺷����������ݿ�δ��rootԶ�̷��ʡ�

����Զ��Ȩ�޵ķ�����

mysql\> use mysql;

mysql\> show databases��  \#��ѯ��ǰ���ݿ�

mysql\> select user,host from user; \#��ѯ�Ƿ�ֻ����localhost��¼

mysql\> grant all privileges on \*.\* to root\@'%' identified by '��¼������';
\#����Զ�̵�¼

mysql\> select user,host from user; �ٴβ�ѯ�Ƿ�����Զ�̵�¼

mysql\> flush  privileges; \#ˢ��ϵͳȨ����ر�

![cd0e682c8153dde53975d8d1fcff9de0](uploads/5a3d9ce6efa2ba8e4b8c129718ea08cc/cd0e682c8153dde53975d8d1fcff9de0.png)

## 2.2. �ʣ����ݿ⿪�������Զ�����

��ͨ������鿴һ�����ݿ��Ƿ���������

chkconfig//�鿴mysql�Ƿ񿪻�������

![4d37653ae19989ddb679d53e0159c1dc](uploads/e8191f02074b3fb066aefd1ac08b6e20/4d37653ae19989ddb679d53e0159c1dc.png)

�������mysql�ķ��񣬲���3,4,5����on�Ļ���ɹ��������off��������

chkconfig --level 345 mysql on

## 2.3. �ʣ�dis���̴򿪺����ˣ�dis.log��ʾ���ݿ����Ӵ���

��

1.  �鿴dis.ini�����ݿ��ַ�����Ƿ���ȷ

2.  ͨ��Navicat�������ݿ⣬�鿴���ݿ��Ƿ��ѵ��롣

## 2.4. �ʣ�dis������dis.log����ʾ���ݿ����ֶ��Ҳ���

��

1.  Զ��Navicat�������ݿ⣬�鿴�����ֶ������ݿ����Ƿ����

2.  ��������ڣ��Ҽ�ѡ�и����ݿ���Ȼ����Ʊ��հ汾�ĵ�˵���������ֶ����

3.  ������ڣ�dis.log�л��ǳ��ִ����ӡ����Ҫ�Ų�һ�����ݿ��Ƿ������˲������˴�Сд���鿴/etc/my.cnf�ļ������Ƿ�������lower_case_table_names=1//�����������ִ�Сд��

## 2.5. �ʣ�����̨�ͳ���̨ATSָʾ�ƶ�����

��

1.  ͨ��dis�ķ�����ȥping ATS�ĵ�ַ��ping��ͨ�����Ų���������

2.  pingͨ�鿴dis.log����û�й���ATS�ı�����Ϣ

3.  ץȡ��ATS��ҵ�񽻻����������ģ�ͨ�������������ӿ��Ƿ������������Ƿ�������ATSʵʱ�����г�λ����Ϣ��û�С�

## 2.6. �ʣ�dis��һЩȫ��������û��Ч

��

1.  ���dis.ini�����ļ�������������Ƿ���ȷ�����ƴд�Ƿ�����������֮��Ҫ����dis������Ч��

2.  ����������󣬿���ͨ��dis.log���������dis.ini���Ƿ�һ�¡�

3.  Dis.ini�������������дλ���Ƿ���ȷ��

## 2.7. �ʣ���β鿴�����Ƿ���������������

��

1.  ����ͨ����������pidof dis���鿴dis�����Ƿ��ڷ���������

2.  �鿴dis.log��־�Ƿ�������ӡ��û�б���

## 2.8. �ʣ����������ݿⱸ�����ã�����ֶ���ԭ���ݿ�����

��

1.  ��Ҫ��backup_db.sh�ű����õ�dis�ļ�ͬ��Ŀ¼�£��޸Ľű�����Ϊ�ֳ�ʵ�����ݿ�����

2.  disͬ��Ŀ¼����bakĿ¼����Ŀ¼�������ݿⱸ���ļ�����ѹ���ݿ��ļ�

3.  ���뱾��mysql���ݿ��У�mysql -uroot -p����

4.  ���롰source ���ݿⱸ���ļ��ľ���·��;���س������ɽ����ݿ��ļ��ָ�

# 3. ����̨FAQ

## 3.1. �ʣ�18���߳���̨�ն��ŵ����Լ��ͨ��������޸���

��

1.  �鿴������־�����лָ����ò���

2.  ��������ҳ��鿴�ŵ������ò�ȷ������������̨app����̨������

## 3.2. �ʣ�18�����ֱ�һֱ����ժ��״̬

�𣺲鿴�����Ƿ����ҵ���ȷ��λ�ã������·��Ƿ����ڵ����ڲ���app�в鿴PTT��ť�Ƿ���Ч��

## 3.3. �ʣ�18���߳���̨�ն������Լ��ͨ��

��ʹ���������ӳ���̨������CRT�����������鿴dba��sa��־����־���Ƿ������Ա���������־��ʾ�����޸������޷��޸�����ϵ������Ա��

## 3.4. �ʣ�����̨�����ŵ����Լ첻����PLMN��ȡ����

��

1.  �ֳ����ٴ���ʽ��������

2.  ������������������ص�ַ��751��ַ�����������Ȼ��������

3.  ��������У����¶Գ���̨�����������á�

## 3.5. �ʣ�����̨��¼����ȥ��һֱ���ڵ�¼����

��

1.  һֱ��¼�����ǳ���̨�ͺ�����ͨ�Ź��ϣ�ͨ�����������豸δ����������������¼�������ü�鿪�����ú������Ƿ���ȷ��

2.  �������ȷ�����½����������ã�

3.  ���û�������ô��󣬿����Ҹ���̨������������̨����ͬС������λ�ô�����ͬ�ĵط������ܷ��������������������Ҫ�������Ų����⡣

4.  ���ַ�����¼�˳�����Ҫ�鿴����IMSI�Ƿ��ظ���

5.  �ն�ϵͳʱ���Ƿ�����

6.  ���������Գ���̨�ŵ�����·�ɿ���ʱ�Ƿ���ȷ

7.  ������udc����ʱ����һ��ҪΪ�գ�����Ҳ�޷����е�¼

![b7dac8153cef12c11c9bb2b0180b1565](uploads/189d7261ae5480ba361abc40063ef0e0/b7dac8153cef12c11c9bb2b0180b1565.jpg)

![8b7a09c94f69d8d8e89636ab32568da2](uploads/e2b37a654f22077216b350dad2f3714b/8b7a09c94f69d8d8e89636ab32568da2.jpg)

## 3.6. �ʣ�����̨�ն˻�������

1.  ����δ�һ���

2.  ��������δ�Ӻã���Ҫ��黰��������ߺͳ���̨�������

## 3.7. �ʣ�����̨�ն����Ͻ�������dis״̬����

1.  ���������D�����Ƿ��ɶ�

2.  ��鳵��̨�ն˱����D�����Ƿ��ɶ�

3.  ������������Ƿ���ȷ

4.  ͨ��web��ҳ����������ַ��������������Ƿ���ȷ

5.  CRT�����������鿴����dba.log�Ƿ��д����ӡ

## 3.8. �ʣ�����̨�ն����Ͻ�IPH/PA����

1.  ���㲥�ӿ������Ƿ��ɶ�

2.  �������web��������������IPH/PA��ַ�Ƿ���ȷ

3.  CRT����������ping�Է��㲥������ַ���ܷ�pingͨ

4.  �鿴����sa.log�Ƿ��д����ӡ��������ʱ����־��ץ���ļ�

## 3.9. �ʣ�����̨�ն˴�������

1.  �����豸���鿴�ܷ�ָ�

2.  �����ն��豸

## 3.10. �ʣ�����̨�ն�������û����

1.  ����̨APP���ý��棬����ص�����

2.  ʹ�ò���APP�������֣���������̨�������Ƿ���������ժ�»������������Ƿ�ӻ����д�����

3.  ������������������������

4.  ����������

## 3.11. �ʣ�����̨�ն˳��ֺ���

1.  ����̨�����Ƿ���������

2.  ����ն�����rst��ť�޸�

3.  ��������̨�������鿴�ܷ�ָ�

4.  �����豸


## 3.12. �ʣ�18���߹̶�̨��վ�㲥�������

��

1.  �������������IP��ַ��������������ҳ��
 
2.  �����������-IP�ض������ã�����IP��ַ�����磺

    ��ͷվ�̶�̨�㲥IP��10.18.101.10

    �㲥ͨ���ն�IP��10.18.101.21

    ��ɳվ�̶�̨�㲥IP��10.18.102.10

    �㲥ͨ���ն�IP��10.18.102.21���������ö���ͬ��

![b7dd2cd3005bafafffd4cf580868042b](uploads/f266fcb266f2b935fb9646e17ae3936c/b7dd2cd3005bafafffd4cf580868042b.jpg)

![1d3e7d149cd6e737b00382e8fb3c697f](uploads/41c053ce69b7c1389df6eb759d6e0928/1d3e7d149cd6e737b00382e8fb3c697f.jpg)

## 3.13. �ʣ������֤18���߹̶�̨�ĳ�վ�㲥����

��

1.  ʹ���ֳ�̨�ֶ��л�����վ���л����й㲥�� 

2.  �ֳ�̨����������̶�̨��⵽��վ���㲥ͨ��ʱ�����Զ��л����㲥�飬ͨ�������ӳ�վ�㲥ϵͳ�в���

3.  �㲥����֮�󣬹̶�̨Ⱥ����Զ��л�����ǰͨ����

## 3.14. �ʣ�18���߹̶�̨��վ�㲥���ֹ��ϣ��������ų�

��

1.  ��ǰ�̶�̨��LTE�����Ƿ�����

2.  ���������·�����Ƿ�������1��3��������ɫ���ͷ�Ƿ����ӹ㲥ϵͳ

3.  ���������Ƿ�����������ping�㲥�豸��ip��ַ

## 3.15. �ʣ��̶�̨�ն˰忨E210�������忨TA30-72�����ĵ�

[�̶�̨�ն˰忨E210����.docx](uploads/9a4dca68fa11c06a957c8f7bf3b6c767/�̶�̨�ն˰忨E210����.docx)

[�̶�̨�����忨TA30-72����.docx](uploads/995d0aa51217f70941afc3bd9bb858f2/�̶�̨�����忨TA30-72����.docx)

# 4. ����FAQ

## 4.1. �ʣ����ܷ�����vsftp�����޷���������

��

1.  ʹ������systemctl status vsftpd�鿴��ǰ����״̬

2.  systemctl start vsftpd�����������������д�����ʾ�������������ļ�����

3.  �����ļ����ݣ�ʹ��ԭ�������ļ�vsftpd.conf,�����н�������

4.  ��������vsftpd����

## 4.2. �ʣ�ftp�޷���½��������ls�޷������ļ�

��

1.  �鿴������vsftpd�������Ƿ����������С�systemctl status vsftpd

2.  ����������ǽ�Ƿ�رա�systemctl disable firewalld.service \#���ùرշ���ǽ

3.  SELinux�Ƿ�ر�

![bbe035fd587cfbd2dc0cd43a24a9386f](uploads/6fda28a0822c0f6c2361d22541745741/bbe035fd587cfbd2dc0cd43a24a9386f.jpg)

## 4.3. �ʣ��豸��α������ɹ�

��

1.  omc.ini������allow_auto_online=true�������Զ����ߣ����豸�������ܵ�ַΪomc��������ַʱ���豸���Զ��������ɹܡ�

2.  omc.ini������allow_auto_online=false�ǲ������Զ����ߣ����豸�������ܵ�ַ����Ҫ��omt�ͻ�������Ҫ����豸�����ɹܡ�

3.  �豸��mac��ַҪ�ǲ�����Ļ���������omc.log�п��Կ���δ���ɹ��豸��IP��MAC��ַ��

![a8fb4ece24368f44bb6f856fa16575d3](uploads/786508a029764ecc877f017f65962119/a8fb4ece24368f44bb6f856fa16575d3.png)

## 4.4. �ʣ�ϵͳ״̬��CAD��������¼��¼�������ͼ��һֱ�ɻ�ɫ���豸����Ҳ�ǻ�ɫ״̬�������豸�б��е���̨�豸������Ϊ�հ�

��

1.  ��Ҫ���豸�������ļ���[oma]������dev_name=XXX�ֶ�

2.  CAD��������¼��¼�������Ҫ��װϵͳ״̬�е�ͼ����dev_name���ó���ͬ�����ƣ�ϵͳ״̬�е�ͼ��������豸ʵ�����������ɫ�仯��

## 4.5. �ʣ���ο��ٲ鿴�����豸�İ汾��Ϣ���ݺ�ͳ��

��

1.  ��½omt�ͻ��ˣ����豸�б�

2.  ѡ����̨��̶�̨���Ҽ���ʾȫ��������Ϣ����Բ鿴����׿�汾���ŵ����汾��

3.  �Ҽ����Խ���ȫ���������ɽ��豸�б����嵼�������ڽ����豸�汾ͳ��

## 4.6. �ʣ���ε�����Ծ�澯����ʷ�澯

>   ��

1.  ѡ�����ܸ澯�¼�

2.  ��������Ը澯����ɸѡ��ѯ

3.  ���Ͻǵ�����ť���Ҽ���������Ե�ǰ��ѯ�����б���е�������ǰ����

## 4.7. �ʣ�ʹ�����ܶ������汾��������

1.  omt�ͻ��˵�ϵͳ����-�汾��������������汾

2.  ����������ѡ��Ҫ�������豸�Ͱ汾���������

## 4.8. �ʣ���ν��и澯���ã����ƹ̶�̨��PA����ʧ�ܸ澯����Ϊ�̶�̨����Ҫ��PA���жԽӣ�����澯û��Ҫ���֡�

��

1.  ѡ��ϵͳ����-�澯����

2.  ѡ���豸��ѡ����ظ澯

3.  ����޸ģ�ѡ����Ըø澯

# 5. ¼��¼��FAQ

## 5.1. �ʣ�¼��¼�����������

��

[How_to_use_MdcProxy_RECServer-CN.doc](/uploads/bf6eaee60188f76431f90ee485a4df81/How_to_use_MdcProxy_RECServer-CN.doc)

1.  ��Ҫ��������¼��¼��ڵ�

![734537cb6d498eb1d3316e0e14a507cd](uploads/d342054035a909a5393dbc120990fbe4/734537cb6d498eb1d3316e0e14a507cd.jpg)

2.  mrs.ini�ļ����ã�user��pwd�Ȱ��պ���������ʱ������

![39e665636875bb2076ce414694848663](uploads/52c13035443f643bfe5e1b042ac6bf30/39e665636875bb2076ce414694848663.jpg)

## 5.2. �ʣ�¼��¼����ļ���ô����

��

1.  ��spt�ͻ�����ֱ��ѡ���ļ��Ҽ�������ѡ�񵼳��ļ���Ŀ���ļ���

2.  ֱ�Ӵ�mrs���������ҵ��ļ��洢Ŀ¼���ֶ���mrs��������ֱ�ӿ�������