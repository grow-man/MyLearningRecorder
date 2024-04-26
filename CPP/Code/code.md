# 数组  

## 合并数据中的重叠区间  

### 描述  
给出一组区间，请合并所有重叠的区间。  
请保证合并后的区间按区间起点升序排列。  
数据满足 start < end  

### 示例1  
输入  [[10,30],[20,60],[80,100],[150,180]]   
输出  [[10,60],[80,100],[150,180]]  

### 示例2  
输入  [[0,10],[10,20]]  
输出  [[0,20]]  

### C++代码

```
struct Value{
  int iStart;
  int iEnd;
};

static cmp(Value &stValue1, Value stValue2)
{
    return stValue1.iStart < stValue2.iStart;
}

vectory<Value> merge(vectory<Value> vInValue)
{
      if (vInValue.size() == 0)
      {
          return vInValue;
      }

      vectory<Value> vRetValue;
      sort(vInValue.begin(), vInValue.end(), cmp);

      vRetValue.push_back(vInValue[0]);

      for (int i=1; i<vInValue.size(); i++)
      {
          if (vRetValue.back().end >= vInValue[i].iStart)
          {
              vRetValue.back().end = max(vRetValue.back().end, vInValue[i].end);
          }
          else
          {
              vRetValue.push_back(vInValue[i]);
          }
      }

    return vRetValue;
}

```

### 解题思路

1.将数据按照start升序排序,此时输入数据的第一组数作为最小参照     
2.取出vRetValue的最后一组数据的end与vInValue中的数据的start相比较，如果end >= start 表示重叠  
3.如果end < start，表示没有重叠，且由于排序过与后面的数据也不会重叠，直接保存  
