# GIF渲染

```lua
function drawGif(a,b,c,d)registGif(c)local e=GIF[c]if e==''then return end;local f=e[math.floor(NOW_FRAME/d)+1]NOW_FRAME=(NOW_FRAME+1)%(TOTAL_FRAME*d)DEBUG=TOTAL_FRAME;for g,h in ipairs(f)do local i=0;for j=1,#h,2 do local k,l,m,n=bdecode(string.sub(h,j,j)),code_to_rgb(string.sub(h,j+1,j+1))screen.setColor(l,m,n)screen.drawLine(i+a,g+b,k+a,g+b)i=k end end end
function decodeGif(a)local b,c,d={},{},split(a,'/')TOTAL_FRAME=#d;for e,f in ipairs(d)do local g,h={},split(f,'|')for i,j in ipairs(h)do table.insert(g,j)end;table.insert(c,g)end;return c end
function bdecode(x) return string.byte(x) - 48 end
function code_to_rgb(a)local b,c,a=3,4,bdecode(a)return 256/c*(a/c/c%c)/b,256/c*(a/c%c)/b,256/c*(a%c)/b end
function registGif(a)if not GIF[a]then async.httpGet(5000,string.format("/swgif?gif=%s",a))GIF[a]=""end;return GIF[a]end
function httpReply(a,b,c)local d=split(b,'=') GIF[d[#d]]=decodeGif(c) end
function split(a,b)if b==nil then b="%s"end;local c={}for d in string.gmatch(a,"([^"..b.."]+)")do table.insert(c,d)end;return c end
```

使用例：

```lua
-- 以2倍放慢的速度渲染test64.vm这张图片（存在后端）
drawGif(0,0,"test64",2)
```

后端地址(python3+flask)：

> https://github.com/BKN46/stormworks-translate-chn/tree/main/others/gif-backend
