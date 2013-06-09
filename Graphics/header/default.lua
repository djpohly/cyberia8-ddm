--[[header]]

local t = Def.ActorFrame{};
local screen = SCREENMAN:GetTopScreen();

t[#t+1] = Def.ActorFrame {
	OnCommand=function(self)
		if THEME:GetMetric( Var "LoadingScreen","ScreenType") == 2 then self:playcommand("NoAnim");
		else self:playcommand("Anim");
		end;
	end;
--left
	LoadActor("top_left")..{
		InitCommand=cmd(x,SCREEN_LEFT+36;y,SCREEN_TOP;horizalign,left;vertalign,top;);
		AnimCommand=cmd(visible,true;diffusealpha,0;sleep,0.3;diffusealpha,1;linear,0.5;zoom,1.25;diffusealpha,0;);
		NoAnimCommand=cmd(visible,false;);
		OffCommand=cmd(finishtweening;);
	};

	LoadActor("top_left")..{
		InitCommand=cmd(x,SCREEN_LEFT+36;y,SCREEN_TOP;horizalign,left;vertalign,top;);
		AnimCommand=cmd(diffusealpha,0;zoomy,0;addx,-SCREEN_WIDTH*0.05;sleep,0.4;accelerate,0.2;addx,SCREEN_WIDTH*0.05;diffusealpha,1;zoomy,1;queuecommand,"Repeat1";);
		NoAnimCommand=cmd(diffusealpha,1;zoomy,1;queuecommand,"Repeat1";);
		Repeat1Command=cmd(linear,2;diffuse,color("0,0.8,1,0.8");linear,2;diffuse,color("1,1,1,1");queuecommand,"Repeat2";);
		Repeat2Command=cmd(sleep,7.25;glow,color("0,0.8,1,0");linear,0.05;glow,color("0,0.8,1,0.8");decelerate,0.8;glow,color("0,1,1,0");queuecommand,"Repeat1";);
		OffCommand=cmd(finishtweening;);
	};

	LoadActor("leftlight")..{
		InitCommand=cmd(x,SCREEN_LEFT+12;y,SCREEN_TOP-2;horizalign,left;vertalign,top;);
		AnimCommand=cmd(zoom,2.5;diffusealpha,0;sleep,0.25;decelerate,0.25;zoom,1;diffusealpha,1;queuecommand,"Repeat";);
		NoAnimCommand=cmd(zoom,1;diffusealpha,1;queuecommand,"Repeat1";);
		RepeatCommand=cmd(diffusealpha,1;glow,color("0,1,1,1");decelerate,2.5;glow,color("0,1,1,0");sleep,2.45;queuecommand,"Repeat";);
		OffCommand=cmd(finishtweening;);
	};

	LoadActor("cyberia8_mini")..{
		InitCommand=cmd(shadowlength,1;horizalign,left;x,SCREEN_LEFT+184/2;y,SCREEN_TOP+34;);
		AnimCommand=cmd(addx,-40/2;diffusealpha,0;sleep,0.5;decelerate,0.6;addx,40/2;diffusealpha,1;);
		NoAnimCommand=cmd(diffusealpha,1;);
		OffCommand=cmd(finishtweening;);
	};

--_left_title
	Def.Sprite {
		InitCommand=cmd(horizalign,left;x,SCREEN_LEFT+82;y,SCREEN_TOP+25;);
		BeginCommand=function(self)
			local screen = SCREENMAN:GetTopScreen();
			if screen then
				local sclassname = screen:GetName();
				if sclassname ~= "ScreenTextEntry" then
					local HeaderTitle = THEME:GetMetric( sclassname , "HeaderTitle" );
					self:Load(THEME:GetPathG("","_title/"..HeaderTitle));
				else return
				end;
			end;
		end;
		AnimCommand=cmd(cropright,1;diffusealpha,0;sleep,0.2;accelerate,0.6;cropright,0;diffusealpha,1;);
		NoAnimCommand=cmd(cropright,0;diffusealpha,1;);
		OffCommand=cmd(finishtweening;);
	};

--right	
	Def.ActorFrame {
		InitCommand=function(self)
			local HeaderR = THEME:GetMetric(Var "LoadingScreen","ShowHeaderRight");
			self:visible(HeaderR);
		end;
		LoadActor("top_right")..{
			InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_TOP;horizalign,right;vertalign,top;);
			AnimCommand=cmd(visible,true;diffusealpha,0;sleep,0.6;diffusealpha,1;linear,0.4;zoom,1.25;diffusealpha,0;);
			NoAnimCommand=cmd(visible,false;);
			OffCommand=cmd(finishtweening;);
		};

		LoadActor("top_right")..{
			InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_TOP;horizalign,right;vertalign,top;);
			AnimCommand=cmd(diffusealpha,0;addx,SCREEN_WIDTH*0.05;sleep,0.5;accelerate,0.2;addx,-SCREEN_WIDTH*0.05;diffusealpha,1;queuecommand,"Repeat1";);
			NoAnimCommand=cmd(diffusealpha,1;queuecommand,"Repeat1";);
			Repeat1Command=cmd(linear,2.25;diffuse,color("0,0.8,1,0.8");linear,2;diffuse,color("1,1,1,1");queuecommand,"Repeat2";);
			Repeat2Command=cmd(sleep,7;glow,color("0,0.8,1,0");linear,0.05;glow,color("0,0.8,1,0.8");decelerate,0.8;glow,color("0,1,1,0");queuecommand,"Repeat1";);
			OffCommand=cmd(finishtweening;);
		};
	};

	LoadActor("timeremain")..{
		InitCommand=cmd(x,SCREEN_RIGHT-30;y,SCREEN_TOP+46;horizalign,right;vertalign,top;);
		BeginCommand=function(self)
			if not IsNetConnected() then
				local TimeR = THEME:GetMetric(Var "LoadingScreen","ShowHeaderTimeR");
				self:visible(TimeR);
			else
				self:visible(false);
			end;
		end;
		AnimCommand=cmd(addx,20;diffusealpha,0;sleep,0.6;linear,0.4;addx,-20;diffusealpha,1;queuecommand,"Repeat";);
		NoAnimCommand=cmd(diffusealpha,1;queuecommand,"Repeat";);
		RepeatCommand=cmd(glow,color("0,0,0,0");linear,2;glow,color("1,0.5,0,1");linear,2;glow,color("0,0,0,0");queuecommand,"Repeat";);
		OffCommand=cmd(finishtweening;);
	};
	
--[[
	LoadFont("Common Normal")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,0.75;strokecolor,color("0,0,0,1"););
		OnCommand=function(self)
			if screen then
				local Class = screen:GetName();
				local fallback = THEME:GetMetric( Class , "Fallback" );
				self:settext("failback :"..fallback);
			end;
		end;
	};

	LoadFont("Common Normal")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+20;zoom,0.75;strokecolor,color("0,0,0,1"););
		OnCommand=function(self)
			if screen then
				local Class = screen:GetName();
				self:settext("class :"..Class);
			end;
		end;
	};
]]
};

return t

