local t = Def.ActorFrame{};

local count = tonumber(GetAdhocPref("CSFrameFlag"));

if getenv("evacheckflag") == 1 then
	local cc_path = "CSDataSave/0001_cc CSCountExt";
	local cf_flag = split(":",GetCCParameter("Status"));
	local k = 0;
	local text = {};
	local ccpoint = {};
	local cf_point;
	for l = 1, 9 do
		if File.Read( cc_path ) then
			cf_point = split(",",cf_flag[l]);
			if tonumber(cf_point[2]) then
				if tonumber(cf_point[3]) then
					if cf_point[1] == "Sco" then
						if tonumber( math.floor( cf_point[2] ) ) >= 1 and tonumber(cf_point[3]) == 0 then
							if GetAdhocPref("CSSetApp") ~= "00000001" then
								text[1] = "Regular"
							end;
							cf_point[3] = 1;
						elseif tonumber( math.floor( cf_point[2] ) ) >= 20 and tonumber(cf_point[3]) == 1 then
							text[1] = "White"
							cf_point[3] = 2;
						elseif tonumber( math.floor( cf_point[2] ) ) >= 50 and tonumber(cf_point[3]) == 2 then
							text[1] = "Black"
							cf_point[3] = 3;
						elseif tonumber( math.floor( cf_point[2] ) ) >= 100 and tonumber(cf_point[3]) == 3 then
							text[1] = "Gold"
							cf_point[3] = 4;
						elseif tonumber( math.floor( cf_point[2] ) ) >= 200 and tonumber(cf_point[3]) == 4 then
							text[1] = "Metal"
							cf_point[3] = 5;
						end;
					elseif cf_point[1] == "Ecco" then
						if tonumber( math.floor( cf_point[2] ) ) >= 5 and tonumber(cf_point[3]) == 0 then
							if text[1] ~= nil then text[2] = "Extra";
							else text[1] = "Extra";
							end;
							cf_point[3] = 1;
						end;
					elseif cf_point[1] == "Esco" then
						if tonumber( math.floor( cf_point[2] ) ) >= 5 and tonumber(cf_point[3]) == 0 then
							if text[1] ~= nil then text[2] = "Special";
							else text[1] = "Special";
							end;
							cf_point[3] = 1;
						end;
					elseif cf_point[1] == "Ccco" then
						if tonumber( math.floor( cf_point[2] ) ) >= 5 and tonumber(cf_point[3]) == 0 then
							if text[1] ~= nil then text[2] = "Cyan";
							else text[1] = "Cyan";
							end;
							cf_point[3] = 1;
						end;
					elseif cf_point[1] == "Csco" then
						if tonumber( math.floor( cf_point[2] ) ) >= 5 and tonumber(cf_point[3]) == 0 then
							if text[1] ~= nil then text[2] = "Cyan_Special";
							else text[1] = "Cyan_Special";
							end;
							cf_point[3] = 1;
						end;
					elseif cf_point[1] == "Non" then
						if tonumber( math.floor( cf_point[2] ) ) >= 3 and tonumber(cf_point[3]) == 0 then
							if GetAdhocPref("CSSetApp") ~= "00000001" then
								if text[1] ~= nil then text[2] = "Nonstop";
								else text[1] = "Nonstop";
								end;
							end;
							cf_point[3] = 1;
						end;
					elseif cf_point[1] == "Cha" then
						if tonumber( math.floor( cf_point[2] ) ) >= 3 and tonumber(cf_point[3]) == 0 then
							if GetAdhocPref("CSSetApp") ~= "00000001" then
								if text[1] ~= nil then text[2] = "Challenge";
								else text[1] = "Challenge";
								end;
							end;
							cf_point[3] = 1;
						end;
					elseif cf_point[1] == "End" then
						if tonumber( math.floor( cf_point[2] ) ) >= 1 and tonumber(cf_point[3]) == 0 then
							if GetAdhocPref("CSSetApp") ~= "00000001" then
								if text[1] ~= nil then text[2] = "Endless";
								else text[1] = "Endless";
								end;
							end;
							cf_point[3] = 1;
						end;
					elseif cf_point[1] == "Rav" then
						if tonumber( math.floor( cf_point[2] ) ) >= 10 and tonumber(cf_point[3]) == 0 then
							if GetAdhocPref("CSSetApp") ~= "00000001" then
								if text[1] ~= nil then text[2] = "Rave";
								else text[1] = "Rave";
								end;
							end;
							cf_point[3] = 1;
						end;
					end;
					ccpoint[#ccpoint+1] = { ""..cf_point[1]..","..tonumber(cf_point[2])..","..cf_point[3]..":" };
				else
					ccpoint[#ccpoint+1] = { ""..cf_point[1]..","..tonumber(cf_point[2])..",0:" };
				end;
			end;
		end;
	end;

	local ccptext = "#Status:";

	for m=1, 9 do
		if ccpoint[m] then
			ccptext = ccptext..""..table.concat(ccpoint[m]);
		else
			ccptext = ccptext;
		end;
	end;
	ccptext = string.sub(ccptext,1,-2);
	ccptext = ccptext..";\r\n";
	File.Write( cc_path , ccptext );

	for i = 1, #text do
		t[#t+1] = Def.ActorFrame{
			InitCommand=cmd(y,SCREEN_TOP);
			OnCommand=cmd(sleep,5;linear,0.2;zoomy,0;);
			Def.Quad{
				InitCommand=cmd(horizalign,left;y,36*i;cropright,1;cropbottom,1;zoomtowidth,SCREEN_WIDTH;zoomtoheight,38*0.8;
							diffuse,color("0,0,0,0.8");diffuserightedge,color("0,0.5,0.5,0.8"););
				OnCommand=cmd(sleep,0.5+(i*0.25);linear,0.1;cropright,0;cropbottom,0;);
			};
			Def.Quad{
				InitCommand=cmd(x,(SCREEN_WIDTH*0.1)-20;y,36*i;zoomtowidth,72*0.8;zoomtoheight,28*0.8;diffuse,color("0,1,1,0.3");croptop,1;);
				OnCommand=cmd(sleep,0.5+(i*0.25);linear,0.25;croptop,0;);
			};
			Def.Sprite{
				InitCommand=function(self)
					(cmd(x,(SCREEN_WIDTH*0.1)-22;y,36*i;zoom,0.8;cropleft,1;))(self)
					if text[i] == "Cyan" then
						self:Load(THEME:GetPathG("ScreenGameplay","LifeFrame/Csc_LifeFrame/lifeframe_thum"));
					elseif text[i] == "Cyan_Special" then
						self:Load(THEME:GetPathG("ScreenGameplay","LifeFrame/Csc_LifeFrame/lifeframe_thum"));
					elseif text[i] == "Challenge" then
						self:Load(THEME:GetPathG("ScreenGameplay","LifeFrame/Oni_LifeFrame/lifeframe_up_left"));
					else
						self:Load(THEME:GetPathG("ScreenGameplay","LifeFrame/"..text[i].."_LifeFrame/lifeframe_up_left"));
					end;
				end;
				OnCommand=cmd(sleep,0.5+(i*0.25);linear,0.25;cropleft,0;);
			};
			LoadFont("_Shared2") .. {
				InitCommand=function(self)
					(cmd(x,(SCREEN_WIDTH*0.1)+20;horizalign,left;zoom,0.8;y,(36*i)-(2*i);diffuse,color("1,1,0,1")))(self)
					self:settext(string.format( THEME:GetString("ScreenEvaluation","Added1"),THEME:GetString("OptionTitles","Select Game Frame"),text[i] ));
				end;
				OnCommand=cmd(maxwidth,SCREEN_WIDTH*1.05;cropright,1;sleep,0.5+(i*0.25);decelerate,0.35;cropright,0;diffusealpha,1;);
			};
		};
	end;
	if text[1] ~= nil or text[2] ~= nil then
		if count < 2 then
			setenv("CSFrameFlag",tonumber(GetAdhocPref("CSFrameFlag")));
			if tonumber(getenv("CSFrameFlag")) == 0 then
				setenv("CSFrameFlag",count + 1);
			end;
			SetAdhocPref("CSFrameFlag",count + 1);
		end;
	end;
	setenv("evacountupflag",0);
	setenv("evacheckflag",0);
end;

return t;
