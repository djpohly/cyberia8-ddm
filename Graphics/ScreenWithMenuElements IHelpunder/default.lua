
local t = Def.ActorFrame{};
local screen = SCREENMAN:GetTopScreen();

t[#t+1] = Def.ActorFrame {
	OnCommand=function(self)
		if THEME:GetMetric( Var "LoadingScreen","ScreenType") == 2 then self:playcommand("NoAnim");
		else self:playcommand("Anim");
		end;
	end;

	LoadActor("frame")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+56;zoomtowidth,SCREEN_WIDTH;);
		AnimCommand=function(self)
			if getenv("exflag") == "csc" then
				(cmd(zoomtoheight,40;cropleft,1;diffusealpha,0;sleep,0.4;linear,0.15;cropleft,0;glow,color("0,1,1,1");diffusealpha,1;linear,0.15;
				glow,color("0,1,1,0");zoomtoheight,28;diffuse,color("0.8,0.8,0.8,0.7");diffusetopedge,color("0,1,1,0.65");diffuserightedge,color("0,0.5,0.7,0.5");))(self)
			else
				(cmd(zoomtoheight,40;cropleft,1;diffusealpha,0;sleep,0.4;linear,0.15;cropleft,0;glow,color("0,1,1,1");diffusealpha,1;linear,0.15;
				glow,color("0,1,1,0");zoomtoheight,28;diffuse,color("0.8,0.8,0.8,0.7");diffusetopedge,color("1,1,0,0.65");diffuserightedge,color("0.5,0.7,0,0.5");))(self)
			end;
		end;
		NoAnimCommand=cmd(cropleft,0;diffuse,color("0.8,0.8,0.8,0.7");diffusetopedge,color("1,1,0,0.65");diffuserightedge,color("0.5,0.7,0,0.5");zoomtoheight,28;);
	};

	LoadActor("information")..{
		InitCommand=function(self)
			if GetScreenAspectRatio() >= 1.6 then
				self:x(SCREEN_WIDTH*0.25-58);
			else
				self:x(SCREEN_LEFT+114-58);
			end;
			self:y(SCREEN_TOP+52);
		end;
		AnimCommand=cmd(cropright,1;diffusealpha,0;sleep,0.2;accelerate,0.6;cropright,0;diffusealpha,1;);
		NoAnimCommand=cmd(cropright,0;diffusealpha,1;);
	};
};

return t;

