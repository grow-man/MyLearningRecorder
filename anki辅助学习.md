# 软件下载  
[官网]https://apps.ankiweb.net/  

# 使用  
详细教程https://zhuanlan.zhihu.com/p/21328602  

# 优点 
自定义程度高，几乎可以覆盖任何场景，常见的有问答卡、填空卡、看图填空，特殊的还可以对图片进行遮盖、添加音频等  

# 缺点  
功能繁杂，上手困难。调整模板UI风格需要额外学习Html以及CSS  

## 导入 
在主页->文件->导入(或者首页底部的导入文件按钮) 如下图所示：  
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/48ed1b56-3e33-4b17-854c-e26af947c495)  

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/4ca57986-6774-4383-ba5c-0be7fbb72b7d)  
支持的文件格式有：*.txt *.csv *.apkg 等  
需要注意anki只支持`utf-8`格式的文件，文件格式不对会报错(转换下格式即可)，如下图所示：  
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/f1bbe238-9f44-4bbf-a62a-6440b36be9f1)  

## 制作牌组 
点击主页牌组->创建牌组->在弹窗中输入牌组名称->点击确认即可  
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/6d9c693c-fdff-40bb-8070-3bbf97b7daaf)  

## 牌组设置  
首页点击牌组->选择牌组->点击右侧齿轮按钮->选择选项：  
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/36c5b030-345d-40cf-ba7c-7a7591ae04e7)  

牌组选项： 
可以点击帮助按钮获取选项详细信息：  
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/f2370396-ab40-492c-a603-dc5fedc2ec5a)  

## 制作填空类型的卡片  
点击首页的添加按钮，选择你需要制作的卡片模板(这里我们选择填空题)以及卡组，如下图所示：  
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/a749d5d1-ae1e-49cd-87bf-2685bace47ad)  

将你需要制作成卡片的文本信息拷贝到文字栏，选中需要挖空的文字，然后再顶部工具栏点击`[···]`图标即可  
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/f2638fb6-b522-486d-8be6-63a04ab6d262)  

效果预览：  
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/9d0a27e6-a268-4302-9c37-757df5ede9e6)

## 制作问答题类型的卡片  
点击首页添加按钮，选择你需要制作的卡片模板(这里我们选择问答题)以及卡组，如下图所示：  
在正面一栏填写问题描述，在背面一栏填写问题答案即可  
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/88b1f27c-67ab-43ad-b782-053c2f76cdd8)   
预览效果：  
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/afb39d35-4dc5-45a8-b8af-da9a06c5af62)

## 制作带图片的问答卡

## 使用chatGPT生成问答类的卡片  
感谢https://zhuanlan.zhihu.com/p/609413004提供的Prompt  
```
请根据我提供的文本，制作一套抽认卡。

在制作抽认卡时，请遵循下述要求：
- 保持抽认卡的简单、清晰，并集中于最重要的信息。
- 确保问题是具体的、不含糊的。
- 使用清晰和简洁的语言。使用简单而直接的语言，使卡片易于阅读和理解。
- 答案应该只包含一个关键的事实/名称/概念/术语。

制作抽认卡时，让我们一步一步来：
第一步，使用简单的中文改写内容，同时保留其原来的意思。
第二步，将内容分成几个小节，每个小节专注于一个要点。
第三步，利用小节来生成多张抽认卡，对于超过 15 个字的小节，先进行拆分和概括，再制作抽认卡。

文本：
衰老细胞的特征是细胞内的水分减少，结果使细胞萎缩，体积变小，细胞代谢的速率减慢。细胞内多种酶的活性降低。细胞核的体积增大，核膜内折，染色质收缩、染色加深。细胞膜通透性改变，使物质运输功能降低。
一套卡片：
| 问题 | 答案 |
|---|---|
|衰老细胞的体积会怎么变化？|变小。|
|衰老细胞的体积变化的具体表现是什么？|细胞萎缩。|
|衰老细胞的体积变化原因是什么？|细胞内的水分减少。|
|衰老细胞内的水分变化对细胞代谢的影响是什么？|细胞代谢的速率减慢。 |
|衰老细胞内的酶活性如何变化？|活性降低。|
|衰老细胞的细胞核体积如何变化？|体积变大。|
|衰老细胞的细胞核的核膜如何变化？|核膜内折。 |
|衰老细胞的细胞核的染色质如何变化？|染色质收缩。|
|衰老细胞的细胞核的染色质变化对细胞核形态的影响是？|染色加深。|
|衰老细胞的物质运输功能如何变化？|物质运输功能降低。|
|衰老细胞的物质运输功能为何变化？|细胞膜通透性改变。|

请帮我生成一套30条关于linux基础知识的 问题|答案的卡片
```
使用效果如图所示：  
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/15bf7b4f-fba2-41cd-9f62-cdae0b2adaa7)  
将chatGPT的截图拷贝粘贴到execl文件并另存为.csv文件即可导入到anki制作为卡牌。  
生成的卡片如下图所示：  
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/c826aed0-85f4-4289-b80c-39283ba204c1)  




