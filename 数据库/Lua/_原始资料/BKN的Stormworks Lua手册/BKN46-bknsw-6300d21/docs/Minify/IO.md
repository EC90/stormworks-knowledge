# Lua组件的输入输出

输入输出的简化，目的是压缩字数，方便调用

```lua
I,O=input,output
GN,GB=I.getNumber,I.getBool
SN,SB=O.setNumber,O.setBool

P=property
PN,PB,PT=P.getNumber,P.getBool,P.getText
```
