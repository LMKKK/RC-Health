# RC-Health
荣成市健康管理平台，基于SpringBoot + Vue3实现

## 提示

如果要运行本项目，要保证环境：

- JDK 1.8
- Node.js V16.16.0



## 功能模块展示

| 序号 | 功能名称     | 系统角色               | 功能描述                                                     |
| ---- | ------------ | ---------------------- | ------------------------------------------------------------ |
| 01   | 权限管理     | 系统管理员             | 一个功能就是一个权限，管理系统权限，包括新增、修改、删除     |
| 02   | 角色管理     | 系统管理员             | 为角色分配权限、新增系统角色                                 |
| 03   | 用户管理     | 系统管理员、用户、医生 | 为用户分配角色、新增用户、编辑用户信息、用户查询、用户个人信息页面、用户信息批量导入、批量导出、用户地址管理、用户区域统计、用户登录、注册 |
| 04   | 检查项管理   | 系统管理员             | 新增检查项、修改检查项、删除检查项                           |
| 05   | 检查组管理   | 系统管理员             | 新增检查组、编辑检查组信息、分配检查项、删除检查组、分配负责医生 |
| 06   | 检查套餐管理 | 系统管理员             | 新增套餐、编辑套餐信息、分配检查组、删除套餐                 |
| 07   | 预约管理     | 系统管理员             | 设置每日预约规则、查看每日预约信息                           |
| 08   | 用户预约     | 用户                   | 预约时间校验、套餐选择、用户自定义检查组、生成预约凭证、取消预约、医生查看用户的预约信息、预约列表筛选 |
| 09   | 体检报告     | 用户、医生             | 医生录入检查项数据、生成体检报告、打印体检报告               |
| 10   | 健康档案     | 用户、医生、管理员     | 用户生成健康档案、用户医生查看监看档案、用户个人信息校验     |
| 11   | 健康资讯管理 | 用户、管理员、医生     | 医生、管理员发布健康资讯文章，所有人可以查看发布的文章、管理员和医生可以对文章做出编辑、删除 |



- 用户管理
  - 用户批量导出、导出
  - 用户增删改查
  - 用户筛选
  - 用户数据统计
  - 角色分配
- 权限管理
- 角色管理
  - 角色增删改查
  - 为角色分配权限

- 检查项管理
- 检查组管理
  - 增删改查
  - 分配医生
  - 分配检查项
- 检查套餐
  - 增啥改查
  - 分配检查组
- 预约管理
  - 设置每日预约规则
  - 查看每日预约信息

- 体检报告生成
  - 录入体检报告数据
  - 体检报告导出
- 健康资讯管理
  - 增删改查





## 项目展示

![image-20230630111953053](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630111953053.png)

![image-20230630111939979](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630111939979.png)



### 用户管理

新增用户

![image-20230630112029636](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630112029636.png)

![image-20230630112042632](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630112042632.png)



用户数据统计



![image-20230630112050514](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630112050514.png)

个人信息页面

![image-20230630114947666](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630114947666.png)

用户信息导出为Excel

![image-20230630115028347](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115028347.png)







### 权限管理

![image-20230630115111871](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115111871.png)

新增权限

![image-20230630115144326](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115144326.png)





### 角色管理

![image-20230630115213533](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115213533.png)



为角色分配权限

![image-20230630115238172](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115238172.png)







### 检查项管理

![image-20230630115255060](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115255060.png)

新增检查项

![image-20230630115312979](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115312979.png)





### 检查组管理

![image-20230630115333819](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115333819.png)



新增检查组

![image-20230630115407346](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115407346.png)

分配检查项

![image-20230630115354913](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115354913.png)



分配医生

![image-20230630115448048](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115448048.png)





### 检查套餐管理

![image-20230630115502883](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115502883.png)

新增检查套餐

![image-20230630115514709](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115514709.png)

分配检查组

![image-20230630115536667](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115536667.png)







### 预约管理

设置预约规则

![image-20230630115612129](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115612129.png)



预约信息查看

![image-20230630115630242](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115630242.png)

用户预约页面

某用户的所有预约

![image-20230630115909965](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115909965.png)

用户预约

![image-20230630115953965](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115953965.png)

![image-20230630120005637](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630120005637.png)



### 体检报告

医生录入体检数据

![image-20230630120212902](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630120212902.png)

生成体检报告

![image-20230630120240109](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630120240109.png)

打印体检报告

![image-20230630120312573](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630120312573.png)



### 健康资讯管理

![image-20230630115700424](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115700424.png)





新增健康资讯文章

![image-20230630115713453](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115713453.png)

![image-20230630115726824](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115726824.png)



文章查看

![image-20230630115807109](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630115807109.png)



用户浏览 

![image-20230630120346490](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630120346490.png)

![image-20230630120407358](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630120407358.png)





### 健康档案管理

![image-20230630121430575](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630121430575.png)







![image-20230630121722721](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230630121722721.png)



















































































