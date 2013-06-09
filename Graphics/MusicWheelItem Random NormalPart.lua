local ac = 1;

local t = Def.ActorFrame{
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
	LoadActor(THEME:GetPathG("_MusicWheelItem","parts/random_jacket"))..{
		InitCommand=cmd(diffusealpha,1;y,100;rotationy,180;rotationz,180;zoomtowidth,160;zoomtoheight,160/4;
					diffusetopedge,color("0,0,0,0");diffusebottomedge,color("0.4,0.4,0.4,0.7"););
	};

	LoadActor(THEME:GetPathG("_MusicWheelItem","parts/random_jacket"))..{
		InitCommand=cmd(diffusealpha,1;zoomtowidth,160;zoomtoheight,160;);
	};
	
	LoadActor(THEME:GetPathG("","bannercover1"))..{
		InitCommand=cmd(vertalign,bottom;y,SCREEN_CENTER_Y-220;zoomtowidth,160;zoomtoheight,40;diffusealpha,0.8;blend,'BlendMode_Add';);
	};

	
	LoadActor(THEME:GetPathG("_MusicWheelItem","parts/que"))..{
		InitCommand=cmd(zoomto,148,24;fadeleft,0.15;faderight,0.15;texcoordvelocity,-0.25,0;diffuse,color("1,0.1,0.4,1"));
	};
	
	LoadFont("_shared2")..{
		InitCommand=cmd(zoomy,0.9;maxwidth,225;y,90;shadowlength,0;diffuse,color("1,0.1,0.4,1"));
		SetMessageCommand=function(self,params)
			self:visible(false);
			local randomtext = THEME:GetString("MusicWheel","Random")
			if params.HasFocus then
				self:visible(true);
				setenv("wheelsectionrandom",randomtext);
			end;
		end;
	};
};

return t;