require("TSLib")

--适配定义
local w,h = getScreenSize()
local sdw,sdh= 1536,2048
local rx,ry= w/sdw,h/sdh
nLog(rx)
--

local pointList={
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
	}
}

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
			if k==1 then
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

local t = converTab(pointList)
print(1)
print(1)
