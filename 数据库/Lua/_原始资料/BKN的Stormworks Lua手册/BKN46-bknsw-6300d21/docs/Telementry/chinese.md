# 中文字符渲染

```lua
function ChnText(a,b,c)registChn(c)local d=CHN[c]for e=1,#d do for f=1,#d[e],2 do local g=a+tonumber(d[e][f])local h=a+tonumber(d[e][math.min(f+1,#d[e])])+1;screen.drawLine(g,b+e,h,b+e)end end end
function split(a,b) if a==nil then return {} end if b==nil then b="%s"end;local c={}for d in string.gmatch(a,"([^"..b.."]+)")do table.insert(c,d)end;return c end
function chnBreak(a)local b,c={},split(a,'|')for d=1,#c-1 do table.insert(b,split(c[d],','))end;return b end
function registChn(a)if not CHN[a]then async.httpGet(5000,string.format("/swchr?text=%s",a))CHN[a]=""end;return CHN[a]end
function httpReply(a,b,c)local d=split(c,'|')CHN[d[#d]]=chnBreak(c)end
```

使用示例：

```lua
-- 输入unicode要把所有"\u"替换成"uni"，因为这游戏不支持"\"
-- 打印"操你妈傻逼游戏" 👇
ChnText(5,5,"uni64cduni4f60uni5988uni50bbuni903cuni6e38uni620f")
```

后端地址(python3+flask)：

> https://github.com/BKN46/stormworks-translate-chn/tree/main/others/unicode-backend
