# table转换为字符串

Debug的时候很有用

```lua
function dump(o)
   if type(o) == 'table' then
	  local s = '{\n'
	  for k,v in pairs(o) do
		 if type(k) ~= 'number' then k = '"'..k..'"' end
		 s = s .. ''..k..' = ' .. dump(v) .. ',\n'
	  end
	  return s .. '} '
   else
	  return tostring(o)
   end
end
```

简化版:

```lua
function dump(b)if type(b)=='table'then local d='{\n'for e,f in pairs(b)do if type(e)~='number'then e='"'..e..'"'end;d=d..''..e..' = '..dump(f)..',\n'end;return d..'} 'else return tostring(b)end end
```
