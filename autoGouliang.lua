require("TSLib")
local sz = require("sz")--写 showUI 前必须插入这一句
local json = sz.json--写 showUI 前必须插入这一句
--适配定义
local w,h = getScreenSize()
local sdw,sdh= 1536,2048
local rx,ry= w/sdw,h/sdh
nLog(rx .. ":" .. ry)

math.randomseed(tostring(os.time()):reverse():sub(1, 6))


function string.split(str, delimiter)
	if str==nil or str=='' or delimiter==nil then
		return nil
	end
	
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end



function coverRegin(s)
	local tab = string.split(s,",")
	local reginstr= ""
	for _,v in pairs(tab) do
		local pointTab = string.split(v,"|")
		local pstr = ""
		for k,j in pairs(pointTab) do
			if k==1 then
				pstr= pstr .. math.ceil(j*rx)
				
			elseif k==2 then
				pstr= pstr .. "|" .. math.ceil(j*ry) .. "|"
				
			elseif k==3 then
				pstr=pstr .. j
			end
			
		end
		if reginstr ~= "" then
			reginstr= reginstr .. "," .. pstr
		else
			reginstr= pstr
		end
		
	end
	return reginstr
end

function converTab(tab)
	local t = {}
	if #tab == 7 and type(tab[2]) == "string" and type(tab[1]) == "number" then 
		for k,v in pairs(tab) do
			if k==1 or k==3 then
				table.insert(t,v)
			elseif k==2 then
				table.insert(t,coverRegin(v)) 
			
			elseif k==4 or k==6 then
				table.insert(t,math.ceil(v*rx))
			elseif k==5 or k==7 then
				table.insert(t,math.ceil(v*ry))
			end
		end
		
		return t
		
	end
	
	
	for k,v in pairs(tab) do
		local _type = type(v) 
		if  _type~= "table"  then
			if (k == 1) and _type == "number" then
				if v<3000 then
					t[k]=math.ceil(v*rx)
				else
					t[k]=v
				end
				
			elseif (k == 2) and _type == "number" then
				if v<3000 then
					t[k]=math.ceil(v*ry)
				else
					t[k]=v
				end
				
				
			else
				t[k]=v
			end
		end
		
		if _type== "table" then
			t[k]=converTab(v)
		end
		
	end

	return t

end

local _pointList={
	
	["acceptGroup"]={
		{  406, 1973, 0xdc705f},
		{  410, 1936, 0x856c57},
		{  429, 1850, 0x87705c},
		{  414, 1822, 0x53b05e},
	},
	["tupoDetail"]={
		{ 380, 1534, 0xd2c4b2 },
		--["attackOffset"]={235,89},
		["attackOffset"]={205,60},
		["offsetx"]=216,
		["offsety"]=569,
	},
	
	["feeded"]={
		["status"]={
			{  287,  991, 0x12100c},
			{  309,  993, 0xe7cfaf},
			{  336,  991, 0x272420},
			{  358, 1006, 0xac9b82},
		},
		["y"]={ 1020,  863, 0xf3b25e },
		["heroListIndexPoint"]={
			{ 1373, 1746, 0xefc9b3 },
			["offset"] = 237,
		},
		
		
	},
	["standard"]={1235,93},
	["mid"]={369,940},
	["right"]={431,686},
	
	["heroChange"]={
		["littleConfig"]={
			["spend"]=15,
			["offset"]=100,
		},
	
		["mainChange"]={
			{ 1004,  546, 0x120d30 },
			["short3"]={ 0xfc9d19, "24|2|0xffea03,7|-15|0xf8ae14,23|-25|0xffe805", 90, 637, 1378, 911, 1555},
			["short1"]={  0xfc9d19, "24|2|0xffea03,7|-15|0xf8ae14,23|-25|0xffe805", 90, 594, 414, 885, 568},
		},
		["besideChange"]={
			{  550, 1506, 0x5c7c9c },
			["short1"]={ 0xfc9d19, "24|2|0xffea03,7|-15|0xf8ae14,23|-25|0xffe805", 90, 559, 1646, 781, 1843},
			["short2"]={  0xfc9d19, "24|2|0xffea03,7|-15|0xf8ae14,23|-25|0xffe805", 90, 338, 1553, 580, 1761},
			
		},
		["sort7"]={{  585, 1539, 0xf5cd28 },{0xfe9d1a, "26|2|0xf4e303,16|-10|0xffd00b", 90, 314, 1629, 769, 1824}},
		["sort8"]={{  591,  628, 0xe7c7b1 },{0xfd9f19, "20|-6|0xffe006,20|-25|0xffe006", 90,273, 213, 775, 433}},
		
		["sort3"]={{761,288,0xa69fa1},{0xfe9d1a, "26|2|0xf4e303,16|-10|0xffd00b", 90, 314, 1629, 769, 1824}},
		["sort1"]={{730,1754,0xa398bd},{0xfd9f19, "20|-6|0xffe006,20|-25|0xffe006", 90,273, 213, 775, 433}},
		["ncard"]={
			{ 1281, 1954, 0xdbdada},
			{ 1253, 1940, 0x8e8d91},
			{ 1280, 1926, 0xdad8d9},
		},
		["ignoreExp"]={
			2836351,3354929,
		},
		["ignoreExp1"]={
			2836351,3354929,
		},
		["selectedn"]={  905, 1932, 0x505050 },
		
		["search"]={["begin"]={ 1389, 1602, 0xac6d59 },["endd"]={ 1355,  519, 0xfeffee },["level"]={0xd9d7d6, "-1|-1|0xe3e1e0,-2|-2|0xd2d0cf,-2|-5|0xf7f7f7,6|-5|0xf7f7f7,16|-5|0xf7f7f6,7|-12|0x603f20,7|-15|0x603f20,7|-21|0x603f20", 90, 1202, 584, 1262, 1661}},
	},
	["break"]={
		["great"]={105,1966},
		["normal"]={54, 1984, 0x584c34 },
	},
	["isGroupA"]={{218,1944,0xffffff},{254,2007,0xffffff},{261,1975,0xffebdf}},
	["isGroupB"]={{395,1948,0xffffff},{426,2004,0xffffff},{444,1975,0xffebdf}},
	["fuben"]={
		{ 1300,  451, 0xf2eddb},
		{ 1424,  267, 0x1a1613},
		{ 1298,  396, 0xf8f3e0},
		{ 1299,  260, 0xff842d},
		{ 1302,  252, 0xf76a32},
		{ 1305,  226, 0xf8f3e0},
	},
	["confirm"]={["y"]={837,803},["n"]={832,1250}}, 
	["map"]={
		{ 1457, 1897, 0x59bfef},
		{ 1415, 1732, 0x422daf},
		{ 1451, 1579, 0x613ee3},
		{ 1452, 1368, 0x467ae2},
		{ 1476, 1906, 0xf8f3e0},
		{ 1513, 1829, 0x48111a},
	},
	
	["index"]={
		{ 1343, 1923, 0x8299c1},
		{ 1323, 1889, 0xccc3c5},
		{ 1411, 1702, 0x6a3a9e},
		{ 1327, 1437, 0xa71f19},
		{ 1401, 1240, 0xcf7c11},
	},
	
	["standby"]={
		{ 1433, 1689, 0x301e1e},
		{ 1460, 1692, 0x33264a},
		{ 1434, 1419, 0x5d566e},
		{ 1434, 1269, 0x5d4040},
		{ 1437, 1027, 0x595269},
		{ 1434,  629, 0x635e7d},
	},
	["fight"]={
		
		{ 1258, 1978, 0x221d26},
		{ 1307, 1971, 0x9b355c},
		{ 1381, 2022, 0x544c75},
		{ 1499, 1836, 0x836a56},
		{ 1470, 1832, 0xefead7},
		{ 1492, 1853, 0xf2edda},
	},
	["tupo"]={
		{ 1199, 1727, 0xf3b25e},
		{ 1062,  285, 0xf3b25e},
		{ 1181,  257, 0xde2f3c},
		{ 1071,  555, 0xd52c22},
	},
	["buyExp"]={
		--厕纸
		{  659, 1190, 0x4c4b5c },
		--exp
		{ 742,  365, 0x5c534b},
		{  941,  993, 0x393125},
		{  742,  365, 0x5c534b},
	},
	["UISize"]={
		{0,250,200,350},
		{0,0,250,250},
		{100,0,300,250},
	},
	
}

local pointList = converTab(_pointList)

nLog(pointList["index"][1][1] .. "," .. pointList["index"][1][2])

local eventListener={
	
}

local enum = {
		["activyStatus_fuben"]="fuben",
		["activyStatus_standby"]="standby",
		["activyStatus_fight"]="fight",
		["activyStatus_tupo"]="tupo",
		["activyStatus_map"]="map",
		["activyStatus_index"]="index",
		
		["runTask_gouliang"]="gouliang",
		["runTask_yuhun"]="yuhun",
		["runTask_buy"]="buy",
	}
	
local globalVariable ={
		["activyStatus"]=enum["activyStatus_index"],
		["debug"]=true,
}

local debugToast = function(arg)
	if globalVariable.debug then
		toast(arg)
	end
end


function animation(pos1,pos2,spend)
	if spend==nil then
		spend=pointList["heroChange"]["littleConfig"]["spend"]
	end
    local zx = pos2[1] - pos1[1]
    local zy = pos2[2] - pos1[2]
    
    local tx = 0
    if zx>0 then
        tx = spend
    else 
        tx = -spend
    end
    
    local ty = 0
    if zy>0 then
        ty = spend
    else 
        ty = -spend
    end
    
    local cx,cy = pos1[1],pos1[2]
    
     local xtest, ytest = false,false
	touchDown(pos1[1], pos1[2]) 
    repeat
        
        if not xtest then
            cx = cx+tx
        end
        
        if not ytest then
           cy = cy+ty
        end
         mSleep(10)
         touchMove(cx,cy)
         
         if tx >0  and cx>=pos2[1] then
             xtest = true
                
         end
         
         if tx <0  and cx<=pos2[1]then
             xtest = true
                
         end
         
         if ty >0  and cy>=pos2[2] then
             ytest = true
                
         end
         
         if ty <0  and cy<=pos2[2] then
             ytest = true
                
         end
         
         
    until(xtest and ytest)   
	
	touchUp(cx, cy) 
        
    
end

MyTable = {
    ["style"]        =  "default",
    ["width"]        =  w*6/7,
    ["height"]       =  h/2,
    ["config"]       =  "save_01.dat",
	["rettype"]		 =  "table",
    ["timer"]        =  99,
    ["orient"]       =  2,
    ["pagetype"]     =  "multi",
    ["title"]        =  "YYS配置",
    ["cancelname"]   =  "取消",
    ["okname"]       =  "开始",
    pages            =
    {
        {
			{
                ["type"] = "Label",
                ["text"] = "全局设置",
                ["size"] = 30,
                ["align"] = "left",
                ["color"] = "0,0,0",
            },
            {
                ["type"] = "Label",
                ["text"] = "模式选择",
                ["size"] = 10,
                ["align"] = "left",
                ["color"] = "0,0,0",
            },
            {
                ["type"] = "ComboBox",
                ["list"] = "狗粮模式,御魂模式,购买达摩,结界抢坑,自动挂机突破",
                ["select"] = "1",
                ["source"] = "test",
				["id"] = "model"
            }
        },
		 {
			{
                ["type"] = "Label",
                ["text"] = "狗粮设置",
                ["size"] = 30,
                ["align"] = "left",
                ["color"] = "0,0,0",
            },
        },
		 {
			{
                ["type"] = "Label",
                ["text"] = "结界抢坑设置",
                ["size"] = 30,
                ["align"] = "left",
                ["color"] = "0,0,0",
            },
			{
                ["type"] = "Label",
                ["text"] = "选择坑位",
                ["size"] = 20,
                ["align"] = "left",
                ["color"] = "0,0,0",
            },
            {
                ["type"] = "ComboBox",
                ["list"] = "1,2,3,4,5,6,7",
                ["select"] = "1",
                ["source"] = "test",
				["id"] = "feedIndex",
            }
        },
		{
			
			{
                ["id"] = "autoTupo",
                ["type"] = "CheckBoxGroup",
                ["list"] = "是否自动挂机突破",
                ["select"] = "",
				["size"] = 50,
            },
			
			{
                ["type"] = "Label",
                ["text"] = "勋章购买设置",
                ["size"] = 30,
                ["align"] = "left",
                ["color"] = "0,0,0",
            },
			{
                ["type"] = "Label",
                ["text"] = "购买物品",
                ["size"] = 20,
                ["align"] = "left",
                ["color"] = "0,0,0",
            },
            {
                ["type"] = "ComboBox",
                ["list"] = "草纸,经验达摩",
                ["select"] = "1",
                ["source"] = "test",
				["id"] = "buyGoods",
            }
        }
    }   
}
local MyJsonString = json.encode(MyTable)
local frame1 = pointList["UISize"][1]
local frame2 = pointList["UISize"][2]
local frame3 = pointList["UISize"][3]
fwShowWnd("wid",frame1[1],frame1[2],frame1[3],frame1[4],1)
fwShowButton("wid","config","",nil,nil,"lua.png",15,frame2[1],frame2[2],frame2[3],frame2[4])




local registor =function(event,func,delay)
		eventListener[event]={}
		eventListener[event].func = func
		if delay==nil then
			delay=-1
		end 
		eventListener[event].delay = delay
end

local touchPos=function(pos)
	local pos1 = {pos[1]+math.random(10),pos[2]+math.random(10)}
	touchDown(6,pos1[1],pos1[2])
	touchUp(6,pos1[1],pos1[2])
	mSleep(10+math.random(50));
end

function isColor(x,y,c,s)   --封装函数，函数名 isColor
    local fl,abs = math.floor,math.abs
    s = fl(0xff*(100-s)*0.01)
    local r,g,b = fl(c/0x10000),fl(c%0x10000/0x100),fl(c%0x100)
    local rr,gg,bb = getColorRGB(x,y)
    if abs(r-rr)<s and abs(g-gg)<s and abs(b-bb)<s then
        return true
    end
end

local mutilColorInRegionCover = function(tab)
	local xp,yp = findMultiColorInRegionFuzzy(tab[1], tab[2], tab[3], tab[4], tab[5],tab[6], tab[7])
	if xp ==-1 and yp==-1 then
		return nil
	end
	return xp,yp
end



local searchLevel1 = function()
	local spend = pointList["heroChange"]["littleConfig"]["spend"]
	local offset = pointList["heroChange"]["littleConfig"]["offset"]

	repeat
		keepScreen(true)
		local x,y = mutilColorInRegionCover(pointList.heroChange.search.level)
		if x~=nil then
			spend = pointList["heroChange"]["littleConfig"]["spend"]
			local status = 0
			for _,v in ipairs(pointList.heroChange.ignoreExp) do
				local p = {x+offset,y,v}
				
				if isColor(p[1],p[2],p[3],90) then
					status=1
					break
				end
			end
			
			if status ==0 then
				nLog("@@@" .. 100 ..":".. 0 ..":color:" .. getColor(x+offset, y))
				keepScreen(false)
				return x,y
			end
			
		end
		keepScreen(false)
		animation(pointList.heroChange.search.endd,pointList.heroChange.search.begin,spend)
		mSleep(100)
	until (false)
			
			
end

local init = function(tab)
eventListener={}

local model = tab["model"]
--******************事件注册*********************************

registor("standardEvent",function(arg) 
			touchPos(pointList["standard"]);
			globalVariable.activyStatus = enum.activyStatus_fight
		end);



registor("acceptGroupEvent",function(arg) 
			touchPos(pointList["acceptGroup"][4])
		end,3);
	
	--狗粮模式
	if model == "0" then
--******************司机退出 退出副本*********************************	
		registor("isGroupEvent",function(arg) 
				touchPos(pointList["break"]["great"]);
				mSleep(800);
				touchPos(pointList.confirm.y);
			end,15);
		
		
		registor("autoChangeExpGoodsEvent",function(arg) 
				
			end);



		registor("clickRightEvent",function(arg) 
					touchPos(pointList["right"]);
				end,2);

				
			end
	
	--御魂模式
	if model =="1" then
				
		registor("clickMidEvent",function(arg) 
					touchPos(pointList["mid"]);
				end,3);
		
	end
	
	
	--购买模式模式
	if model =="2" then
		local buyGoods = tab["buyGoods"]
		local pos =nil
		if buyGoods == "0" then
			pos = pointList["buyExp"][1]
		else
			pos = pointList["buyExp"][2]
		end
		
				
		registor("buyExpEvent",function(arg) 
				touchPos(pos)
				mSleep(300)
				touchPos(pointList["buyExp"][3])
				mSleep(300)
				touchPos(pointList["buyExp"][4])
				end,2);
		
	end
	
	--抢坑模式
	if model =="3" then
		waitBase =10
		local index =  tonumber(tab["feedIndex"])
		local _pos = pointList["feeded"]["heroListIndexPoint"][1]
		local offset = pointList["feeded"]["heroListIndexPoint"]["offset"]
		local pos = {_pos[1],_pos[2]-index*offset}
				
		registor("feedStatusEvent",function(arg)
				while(true) do
					if multiColor(pointList["feeded"]["status"]) then
						touchPos(pointList["feeded"]["status"][3])
						mSleep(550)
						touchPos(pos)
						mSleep(300)
						touchPos(pointList["feeded"]["y"])
					end
				end
				end);
		
	end
	
	
	--结界挂机模式
	if model =="4" then
		local is_status = tab["autoTupo"] 
		if is_status == "0" then
			local _pos = pointList["tupoDetail"][1]
			local offsetx = pointList["tupoDetail"]["offsetx"]
			local offsety = pointList["tupoDetail"]["offsety"]
			local attackOffset = pointList["tupoDetail"]["attackOffset"]
			
				
			registor("autoTupoEvent",function(arg)
					local index = arg[1]
					
					local pos = nil
					if index ==0 then
						pos = {_pos[1],_pos[2]}
					elseif index==1 then 
						pos = {_pos[1],_pos[2]-offsety}
					elseif index==2 then 
						pos = {_pos[1],_pos[2]-2*offsety}
					elseif index==3 then 
						pos = {_pos[1]+offsetx,_pos[2]}
					elseif index==4 then 
						pos = {_pos[1]+offsetx,_pos[2]-offsety}
					elseif index==5 then 
						pos = {_pos[1]+offsetx,_pos[2]-2*offsety}
					elseif index==6 then 
						pos = {_pos[1]+2*offsetx,_pos[2]}
					elseif index==7 then 
						pos = {_pos[1]+2*offsetx,_pos[2]-offsety}
					elseif index==8 then 
						pos = {_pos[1]+2*offsetx,_pos[2]-2*offsety}
					end
					
					touchPos(pos)
					mSleep(3000)
					nLog(pos[1]+attackOffset[1] .. ":" .. pos[2]-attackOffset[2])
					touchPos({pos[1]+attackOffset[1],pos[2]-attackOffset[2]})
			end);
			
		end
		
		
		
	end
	
	
			
end


local winStatus = 0
local calcCount = 0 
waitBase = 200

repeat
	local x, y;
	local arg={}
	--******************状态检测*********************************
	
	if multiColor(pointList["map"]) then
		globalVariable.activyStatus = enum.activyStatus_map
	elseif multiColor(pointList["index"]) then
		globalVariable.activyStatus = enum.activyStatus_index
	elseif multiColor(pointList["fuben"]) then
		globalVariable.activyStatus = enum.activyStatus_fuben
	elseif multiColor(pointList["standby"]) then
		globalVariable.activyStatus = enum.activyStatus_standby
	elseif multiColor(pointList["tupo"]) then
		globalVariable.activyStatus = enum.activyStatus_tupo
	elseif multiColor(pointList["fight"]) then
		globalVariable.activyStatus = enum.activyStatus_fight
	end
	
	--******************************************************************************************************
	if globalVariable.debug and calcCount%5==0  then 
		toast(globalVariable.activyStatus)
	end
	local listener;
	if globalVariable.activyStatus == enum.activyStatus_standby then
		
		listener = eventListener["autoChangeExpGoodsEvent"]
		
--*************************************主狗粮切换****************************************************************
		
		if listener~=nil  then
			local rx,ry
			local targetExp={}

			rx = mutilColorInRegionCover(pointList.heroChange.mainChange.short1)
			
			if rx~=nil then
				table.insert(targetExp,1)
			end
			
			rx = mutilColorInRegionCover(pointList.heroChange.mainChange.short3)
			
			if rx~=nil then
				table.insert(targetExp,3)
			end
			if #targetExp~=0 then 
				
				touchPos(pointList.heroChange.mainChange[1])
				mSleep(10)
				touchPos(pointList.heroChange.mainChange[1])
				mSleep(2000)
				if multiColor(pointList.heroChange.ncard)~=true then
					touchPos(pointList.heroChange.ncard[1])
					mSleep(900)
					touchPos(pointList.heroChange.selectedn)
				end
				for i = 1,#targetExp do
					local x,y = searchLevel1()
					local v= targetExp[i]
					local point = pointList.heroChange["sort"..v][1]
					local expExpress = pointList.heroChange["sort"..v][2]
					animation({x,y},point)
					mSleep(1000)
					animation(pointList.heroChange.search.endd,pointList.heroChange.search.begin)
				end
				touchPos(pointList["break"]["normal"])
				
			end
			
--*************************************副狗粮切换****************************************************************			
			targetExp={}

			rx = mutilColorInRegionCover(pointList.heroChange.besideChange.short1)
			
			if rx~=nil then
				table.insert(targetExp,7)
			end
			
			rx = mutilColorInRegionCover(pointList.heroChange.besideChange.short2)
			
			if rx~=nil then
				table.insert(targetExp,8)
			end
			
			if #targetExp~=0 then
				touchPos(pointList.heroChange.besideChange[1])
				mSleep(70)
				touchPos(pointList.heroChange.besideChange[1])
				mSleep(2000)
				if multiColor(pointList.heroChange.ncard)~=true then
					touchPos(pointList.heroChange.ncard[1])
					mSleep(900)
					touchPos(pointList.heroChange.selectedn)
				end
				
				for i = 1,#targetExp do
					local x,y = searchLevel1()
					local v= targetExp[i]
					local point = pointList.heroChange["sort"..v][1]
					local expExpress = pointList.heroChange["sort"..v][2]
					animation({x,y},point)
					mSleep(1000)
					animation(pointList.heroChange.search.endd,pointList.heroChange.search.begin)
				end
				touchPos(pointList["break"]["normal"])
			end
			
				
		end
		local listener = eventListener["standardEvent"]
		if listener~=nil then
			listener.func(arg)
		end
		
	elseif globalVariable.activyStatus == enum.activyStatus_fight then
		
	
		listener = eventListener["clickMidEvent"]
		if listener~=nil and calcCount%listener.delay==0 then
				listener.func(arg)
		end
		
		listener = eventListener["clickRightEvent"]
		if listener~=nil and calcCount%listener.delay==0 then
				listener.func(arg)
		end
		
	elseif globalVariable.activyStatus==enum.activyStatus_fuben  then
		--******************--是否在组队状态*********************************
	
		listener = eventListener["isGroupEvent"]
		if listener~=nil and calcCount%listener.delay==0 then
			local groupAStatus =1;
			local groupBStatus =1;
			 for _,v in ipairs(pointList["isGroupA"]) do
				if v[3] ~= getColor(v[1],v[2]) then
					groupAStatus =0
				end
			 end
		
			for _,v in ipairs(pointList["isGroupB"]) do
				if v[3] ~= getColor(v[1],v[2]) then
					groupBStatus =0
				end
			end
			
			if groupAStatus==0 and groupBStatus==0 then
				listener.func(arg)
			end
		end
	elseif globalVariable.activyStatus==enum.activyStatus_tupo then
		
		listener = eventListener["autoTupoEvent"]
		if listener~=nil  then
			local index = calcCount%9
			listener.func({index})
		end
		
		
	
	end
	
	
	listener = eventListener["feedStatusEvent"]
	if listener~=nil  then
		listener.func()
	end
	
	listener = eventListener["buyExpEvent"]
	if listener~=nil and calcCount%listener.delay==0 then
		
		listener.func()
	end
	
	--******************-- 接受组队*********************************
	listener = eventListener["acceptGroupEvent"]
	
	if listener~=nil and calcCount%listener.delay==0 and  multiColor(pointList["acceptGroup"]) then
			listener.func()
	end
	
	
	local vid = fwGetPressedButton()
	
	if vid == "showWin" then
		if winStatus==0 then
			winStatus=1
			fwShowButton("wid","config","",nil,nil,"lua.png",15,frame3[1],frame3[2],frame3[3],frame3[4])
		else
			winStatus=0
			fwCloseView("wid","config");
		end
		
    end
    if vid == "config" then
		retTable = {showUI(MyJsonString)};
		
		if retTable[1] then
			init(retTable[2])
		end
		
    end
	
	mSleep(waitBase);
	calcCount=calcCount+1
	if calcCount==100000 then calcCount=0 end
	
	
	
until(false)
	





