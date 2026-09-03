# 游戏中数据获取到电脑本地

Python3.5+ Flask框架后端  
读入输入后写入csv：

```python
from flask import Flask, request

app = Flask(__name__)

@app.route("/send")
def get_info():
	value = request.args.get("value")	
	print(f"{value}",file=open("data.csv", "a"))
	return "done"
```

## 直接发送数据

lua代码中发送数据，设30ticks的间隔，使用5000端口

```lua
INTV=30

function onTick()
	-- csv格式每行字符串，英文逗号分隔，里面随便夹东西
	value="1,1,1"

	if INTV==0 then
		async.httpGet(5000, string.format("/send?value=%s", value))
		INTV=30
	else
		INTV=INTV-1
	end
end

-- 不带任何回调
function httpReply(port, request_body, response_body) end
```

## 发送JSON数据

table转json发送，因为lua的table没有明确的array概念，所以统一转成字符串表达

```lua
function dumpJson(b)if type(b)=='table'then local d='{'for e,f in pairs(b)do if type(e)~='number'then e='"'..e..'"'end;d=d..'"'..e..'":'..dumpJson(f)..','end;return d..'}'else return tostring(b)end end

async.httpGet(5000, string.format("/send?value=%s", dumpJson(value)))

-- 不带任何回调
function httpReply(port, request_body, response_body) end
```
