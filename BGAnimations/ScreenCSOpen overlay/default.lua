local t = Def.ActorFrame{};
--GAMESTATE:SetCurrentSong(getenv("csinitialsong"));

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathS("","_csopen music")) .. {
		OnCommand=function(self)
			self:stop();
			self:play();
		end;
	};
};

t[#t+1] = Def.Quad{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;);
	OnCommand=cmd(diffuse,color("0,0.5,0.5,1");faderight,1;linear,0.75;faderight,0;diffuse,color("0,1,1,1"););
};

t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(addx,-60;decelerate,0.75;addx,60;);
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("#021113"););
		OnCommand=cmd(faderight,1;decelerate,1;faderight,0;);
	};
	LoadActor(THEME:GetPathB("ScreenCSOpen", "overlay/csc_back"))..{
		InitCommand=function(self)
			local gw = self:GetWidth();
			(cmd(x,SCREEN_RIGHT-(gw/2);y,SCREEN_CENTER_Y;))(self)
		end;
		OnCommand=cmd(diffusealpha,0;faderight,1;decelerate,0.75;diffusealpha,1;faderight,0;);
	};
};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(y,SCREEN_TOP+120;);
	Def.Quad{
		InitCommand=cmd(x,SCREEN_CENTER_X;zoomto,SCREEN_WIDTH,60;);
		OnCommand=cmd(diffuse,color("0,1,1,1");fadeleft,1;accelerate,0.35;fadeleft,0;diffuse,color("0,0.5,0.5,0.5");diffuserightedge,color("0,1,1,0.8"););
	};

	LoadActor( "csc_title" )..{
		InitCommand=cmd(x,SCREEN_LEFT+170;);
		OnCommand=cmd(diffusealpha,0;addx,20;zoomx,10;zoomy,3;sleep,0.15;accelerate,0.2;diffusealpha,1;addx,-20;zoomx,1;linear,0.1;zoomy,1;);
	};
};

return t;