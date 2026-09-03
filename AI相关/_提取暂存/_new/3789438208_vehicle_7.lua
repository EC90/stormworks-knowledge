-- source: steam id 3789438208 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3789438208
clamp=function(x,a,b)if x<a then return a end;if x>b then return b end;return x end

function slew_limit(c,t,ru,rd,dt)
    local d=t-c
    local mu=ru*dt
    local md=rd*dt
    if d>mu then d=mu end
    if d<-md then d=-md end
    return c+d
end

function lpf(p,x,tau,dt)
    if tau<=0 then return x end
    local a=dt/(tau+dt)
    return p+a*(x-p)
end

CC={
    Kp=0.08,
    Ki=0.02,
    sp_rate_up=0.8,
    sp_rate_down=1.2,
    thr_rate_up=0.35,
    thr_rate_down=1.2,
    thr_min=0.0,
    thr_max=1.0,
    use_D=true,
    Kd=0.03,
    d_tau=0.15,
    i_term=0.0,
    sp_ramped=0.0,
    last_v=0.0,
    d_filt=0.0,
    last_thr=0.0,
    initialized=false
}

function CC:reset(v,thr)
    self.i_term=0.0
    self.sp_ramped=v or 0.0
    self.last_v=v or 0.0
    self.d_filt=0.0
    self.last_thr=thr or 0.0
    self.initialized=true
end

function CC:update(v_sp,v,dt)
    if not self.initialized then
        self:reset(v,self.last_thr)
    end

    self.sp_ramped=slew_limit(self.sp_ramped,v_sp,self.sp_rate_up,self.sp_rate_down,dt)

    local e=self.sp_ramped-v

    local d_term=0.0
    if self.use_D then
        local dv=(v-self.last_v)/math.max(dt,1e-6)
        self.d_filt=lpf(self.d_filt,dv,self.d_tau,dt)
        d_term=-self.Kd*self.d_filt
    end
    self.last_v=v

    local u_unsat=self.Kp*e+self.i_term+d_term
    local u_sat=clamp(u_unsat,self.thr_min,self.thr_max)

    local at_max=(u_sat>=self.thr_max-1e-9)
    local at_min=(u_sat<=self.thr_min+1e-9)

    local allow_i=true
    if at_max and e>0 then allow_i=false end
    if at_min and e<0 then allow_i=false end

    if allow_i then
        self.i_term=self.i_term+(self.Ki*e*dt)
        self.i_term=clamp(self.i_term,-1.0,1.0)
    end

    u_unsat=self.Kp*e+self.i_term+d_term
    u_sat=clamp(u_unsat,self.thr_min,self.thr_max)

    local thr=slew_limit(self.last_thr,u_sat,self.thr_rate_up,self.thr_rate_down,dt)
    self.last_thr=thr

    return thr
end



function onTick()

	active = input.getBool(1)
	
	if not active then return end



	speed_set = input.getNumber(1)
	process_variable = input.getNumber(2)

	output.setNumber(1, CC:update(speed_set, process_variable, 1/60))

end
