# 卡尔曼滤波

A=1，H=1情况下的卡尔曼滤波器。注意针对不同用途调整超参数  
Q: 过程激励噪声协方差; R: 测量噪声协方差

```lua
KF,Q,R={},0.01,0.001

function kalmanFilter(data)
	if #KF==0 then
		for key,value in pairs(data) do
			pminus=1+Q
			k=pminus/(pminus+R)
			p=(1-k)*pminus
			KF[key]={xhatminus=0,pminus=pminus,k=k,xhat=k*value,p=p}
		end
	else
		for key,value in pairs(data) do
			xhatminus=KF[key].xhat
			pminus=KF[key].p+Q
			k=pminus/(pminus+R)
			xhat=xhatminus+k*(value-xhatminus)
			p=(1-k)*pminus
			KF[key]={xhatminus=xhatminus,pminus=pminus,k=k,xhat=xhat,p=p}
		end
	end
end
```

使用例:

```lua
data = {x=x,y=y,z=z} -- 获取到的原始数据
kalmanFilter(data) -- 获取滤波估计值
-- 滤波结果如下
KF.x.xhat
KF.y.xhat
KF.z.xhat
```
