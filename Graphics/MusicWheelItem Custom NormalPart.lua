
local limit = getenv("Timer");
setenv("csflag",0);
local ac = 1;

local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame {
	OnCommand=cmd(linear,0.4;playcommand,"Flag";);
	FlagCommand=function(self) ac = 0;
	end;
	SetMessageCommand=function(self, params)
		local items = math.floor((SCREEN_WIDTH/150)*2) + 2;
		if ac == 1 then
			if params.DrawIndex > math.floor(items / 2) then
				(cmd(addx,400;zoomx,0;decelerate,(items -1 - params.DrawIndex)*0.02;addx,-400;zoomx,1;))(self)
			elseif params.DrawIndex < math.floor(items / 2) then
				(cmd(addx,-400;zoomx,0;decelerate,params.DrawIndex*0.02;addx,400;zoomx,1;))(self)
			elseif params.DrawIndex == math.floor(items / 2) then
				(cmd(zoomy,0;decelerate,0.2;zoomy,1;))(self)
			end;
		end;
	end;
	--back
	LoadActor(THEME:GetPathG("_MusicWheelItem","parts/csc_jacket"))..{
		InitCommand=cmd(diffusealpha,1;y,100;rotationy,180;rotationz,180;zoomtowidth,160;zoomtoheight,160/4;
					diffusetopedge,color("0,0,0,0");diffusebottomedge,color("0.4,0.4,0.4,0.7"););
	};

	LoadActor(THEME:GetPathG("_MusicWheelItem","parts/csc_jacket"))..{
		InitCommand=cmd(diffusealpha,1;zoomtowidth,160;zoomtoheight,160;);
	};

	--white
	LoadActor(THEME:GetPathG("","bannercover1"))..{
		InitCommand=cmd(vertalign,bottom;y,SCREEN_CENTER_Y-220;zoomtowidth,160;zoomtoheight,40;diffusealpha,0.6;blend,'BlendMode_Add';);
	};
	
	--selcustom
	Def.ActorFrame{
		CodeMessageCommand=function(self,params)
			local musicwheel = SCREENMAN:GetTopScreen():GetMusicWheel();
			local song = GAMESTATE:GetCurrentSong();
			if not song then
				if musicwheel:GetSelectedType() == 'WheelItemDataType_Custom' then
					if params.Name == "Start" then
						if limit > 2 then
							setenv("csflag",1);
							--SCREENMAN:SetNewScreen("ScreenCSOpen");
							SCREENMAN:AddNewScreenToTop("ScreenMiniMenuCSC");
						end;
					end;
				end;
			end;
		end;
	};
	
	LoadFont("_shared2")..{
		InitCommand=cmd(zoomy,0.9;maxwidth,225;y,90;shadowlength,0;diffuse,color("1,1,0.1,1"));
		SetMessageCommand=function(self,params)
			self:visible(false);
			local csctext = THEME:GetString("MusicWheel","CustomItemCSCText");
			if params.HasFocus then
				local musicwheel = SCREENMAN:GetTopScreen():GetMusicWheel();
				if musicwheel:GetSelectedType() == 'WheelItemDataType_Custom' then
					self:visible(true);
					setenv("wheelsectioncsc",csctext);
				end;
			end;
		end;
	};
};

return t;