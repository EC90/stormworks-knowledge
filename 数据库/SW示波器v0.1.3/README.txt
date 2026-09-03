如何使用：
1. 将DataRecord.xml文件放到SW的微控目录下
   （C:\Users\[用户名]\AppData\Roaming\Stormworks\data\microprocessors\DataRecord.xml）
2. 将微控放到载具上，并连接上想要记录的混合信号。在微控参数中调整想要输出的端口，用英文逗号分隔
3. 打开main.exe，点击开始记录，看到下方提示已经开始监听端口
   勾选仅监听，可以不记录所有数据，保证记录文件不会太大
4. 生成载具，看到main.exe同目录下出现了一个data.csv文件，即为输出数据
5. 如果想要看到实时数据变化，打开render.exe，会自动渲染近300ticks的数据变化情况，方便分析
   打开render.exe后，会出现四轮选项
   第一个是数据文件、第二个是显示采样周期、第三个是是否为布尔模式、第四个为监控模式
   如果不做更改的话，直接按下回车即可
   布尔模式是为了区分不同布尔信号通道，将呈现分行展示
   监控模式和main.exe的仅监控都同时开启才有效

如何退出：
1. 停止记录，直接关闭main.exe
2. 在render.exe界面，按下q或者esc
3. 在render.exe界面，按下c可清除数据缓存
