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
	["standard"]={1235,93},
	["mid"]={369,940},
	["right"]={431,686},
	
	["heroChange"]={
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
		{ 1512, 1079, 0xd8d2c0},
		{ 1517, 1074, 0x407293},
		{ 1526, 1075, 0x332eb0},
		{ 1512, 1057, 0xf8f3e0},

	},
	["tupo"]={
		{ 1199, 1727, 0xf3b25e},
		{ 1062,  285, 0xf3b25e},
		{ 1181,  257, 0xde2f3c},
		{ 1071,  555, 0xd52c22},
	},
	["buyExp"]={
		{ 742,  365, 0x5c534b},
		{  941,  993, 0x393125},
		{  742,  365, 0x5c534b},
	},
	["UISize"]={
		{0,250,400,516},
		{0,0,200,266},
	},
	
}

local pointList = converTab(_pointList)

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
		["activyStatus"]=enum["activyStatus_standby"],
		["debug"]=true,
}

local debugToast = function(arg)
	if globalVariable.debug then
		toast(arg)
	end
end


function animation(pos1,pos2,spend)
	if spend==nil then
		spend=15
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
    ["width"]        =  w/2,
    ["height"]       =  h/2,
    ["config"]       =  "save_01.dat",
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
                ["text"] = "模式选择",
                ["size"] = 10,
                ["align"] = "left",
                ["color"] = "0,0,0",
            },
            {
                ["type"] = "ComboBox",
                ["list"] = "index0,狗粮模式,御魂模式,购买达摩",
                ["select"] = "1",
                ["source"] = "test"
            }
        }
    }   
}
local MyJsonString = json.encode(MyTable)
local frame1 = pointList["UISize"][1]
local frame2 = pointList["UISize"][2]
fwShowWnd("wid",frame1[1],frame1[2],frame1[3],frame1[4],1)
fwShowButton("wid","showWin","",nil,nil,"lua.png",15,frame2[1],frame2[2],frame2[3],frame2[4])




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
	local spend = 15
	repeat
		keepScreen(true)
		local x,y = mutilColorInRegionCover(pointList.heroChange.search.level)
		if x~=nil then
			spend = 15
			local status = 0
			for _,v in ipairs(pointList.heroChange.ignoreExp) do
				local p = {x+100,y,v}
				
				if isColor(p[1],p[2],p[3],90) then
					status=1
					break
				end
			end
			
			if status ==0 then
				nLog("@@@" .. 100 ..":".. 0 ..":color:" .. getColor(x+100, y))
				keepScreen(false)
				return x,y
			end
			
		end
		keepScreen(false)
		animation(pointList.heroChange.search.endd,pointList.heroChange.search.begin,spend)
		mSleep(100)
	until (false)
			
			
end

local init = function(model)
eventListener={}
--******************事件注册*********************************

registor("standardEvent",function(arg) 
			touchPos(pointList["standard"]);
			globalVariable.activyStatus = enum.activyStatus_fight
		end);



registor("acceptGroupEvent",function(arg) 
			touchPos(arg);
		end);
	if model == "1" then
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
	
	if model =="2" then
				
		registor("clickMidEvent",function(arg) 
					touchPos(pointList["mid"]);
				end,3);
		
	end
	
	if model =="3" then
				
		registor("buyExpEvent",function(arg) 
				touchPos(pointList["buyExp"][1])
				mSleep(300)
				touchPos(pointList["buyExp"][2])
				mSleep(300)
				touchPos(pointList["buyExp"][3])
				end,2);
		
	end
	
	
			
end


local winStatus = 0
local calcCount = 0 

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
--	if globalVariable.debug and calcCount%2==0  then 
--		toast(globalVariable.activyStatus)
--	end
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
	end
	
	
	listener = eventListener["buyExpEvent"]
	if listener~=nil and calcCount%listener.delay==0 then
		
		listener.func()
	end
	
	--******************-- 接受组队*********************************
	x, y = findImageInRegionFuzzy("accpet.png",10,366,1776,452,1868, 0); 
	if x~=-1 and y~=-1 then
		local listener = eventListener["acceptGroupEvent"]
		if listener~=nil then
			arg[1],arg[2]=x,y
			listener.func(arg)
		end
	end
	
	
	
	local vid = fwGetPressedButton()
	
	if vid == "showWin" then
		if winStatus==0 then
			winStatus=1
			fwShowButton("wid","config","",nil,nil,"lua.png",15,100,0,300,266)
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
	
	mSleep(200);
	calcCount=calcCount+1
	if calcCount==100000 then calcCount=0 end
	
	
	
until(false)
	





