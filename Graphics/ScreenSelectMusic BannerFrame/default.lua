--[[ScreenSelectMusic BannerFrame]]
local coursemode = GAMESTATE:IsCourseMode();
local t = Def.ActorFrame{}


if not IsNetConnected() then
	t[#t+1] = Def.Sprite{
		OnCommand=function(self)
			if coursemode then
				self:Load(THEME:GetPathG("ScreenSelectMusic","BannerFrame/musicnumframe"));
				self:x(SCREEN_CENTER_X-200+60-30);
				self:y(SCREEN_CENTER_Y-144+220);
			else
				self:Load(THEME:GetPathG("ScreenSelectMusic","BannerFrame/stageframe"));
				self:x(SCREEN_CENTER_X+180);
				self:y(SCREEN_CENTER_Y-168);
			end;
			(cmd(diffusealpha,0;zoom,2;addx,15;addy,15;sleep,0.7;accelerate,0.4;addx,-15;addy,-15;diffusealpha,1;zoom,1;
			glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");decelerate,0.4;glow,color("1,1,0,0");queuecommand,"Repeat";))(self)
		end;
		RepeatCommand=cmd(sleep,19.5;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,0.5");decelerate,1;glow,color("1,1,0,0");queuecommand,"Repeat";);
		OffCommand=cmd(stoptweening;);
	};
end;

if getenv("exflag") == "csc" then
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(zoomx,10;zoomy,0;x,SCREEN_CENTER_X+60;y,SCREEN_CENTER_Y+40);
		OnCommand=cmd(sleep,0.2;decelerate,0.3;zoom,1;);
		LoadActor( THEME:GetPathB("ScreenSelectMusic","background/_bannerback2") )..{
			CurrentSongChangedMessageCommand=cmd(stoptweening;diffusealpha,0;accelerate,0.1;diffusealpha,1;zoomy,1.1;glow,color("0,1,1,0.75");decelerate,0.3;glow,color("0,1,1,0");zoomy,1;);
		};
	};
	
	t[#t+1] = LoadActor("fpointframe")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-146;y,SCREEN_CENTER_Y-110;);
		OnCommand=cmd(diffusealpha,0;zoom,2;addx,15;addy,15;sleep,0.7;accelerate,0.4;addx,-15;addy,-15;diffusealpha,1;zoom,1;
					glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");decelerate,0.4;glow,color("1,1,0,0");queuecommand,"Repeat";);
		RepeatCommand=cmd(sleep,19.5;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,0.5");decelerate,1;glow,color("1,1,0,0");queuecommand,"Repeat";);
		OffCommand=cmd(stoptweening;);
	};
end;

if coursemode then
	t[#t+1] = LoadActor("songinfoframe")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-150;y,SCREEN_CENTER_Y-158+280;);
		OnCommand=cmd(diffusealpha,0;zoom,2;addx,15;addy,15;sleep,0.7;accelerate,0.4;addx,-15;addy,-15;diffusealpha,1;zoom,1;
					glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");decelerate,0.4;glow,color("1,1,0,0");queuecommand,"Repeat";);
		RepeatCommand=cmd(sleep,19.5;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,0.5");decelerate,1;glow,color("1,1,0,0");queuecommand,"Repeat";);
		OffCommand=cmd(stoptweening;);
	};
else
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;);
		LoadActor("sortframe")..{
			InitCommand=function(self)
				(cmd(x,204;y,-128;))(self)
				if getenv("exflag") == "csc" then
					self:playcommand("Hide");
				else
					self:playcommand("Set");
				end;
			end;
			SetCommand=cmd(visible,true;diffusealpha,0;zoom,2;addy,25;sleep,0.6;accelerate,0.4;addy,-25;diffusealpha,1;zoom,1;
						glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");decelerate,0.4;glow,color("1,1,0,0");queuecommand,"Repeat";);
			HideCommand=cmd(visible,false;);
			RepeatCommand=cmd(sleep,20.5;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,0.5");decelerate,1;glow,color("1,1,0,0");queuecommand,"Repeat";);
			OffCommand=cmd(stoptweening;);
		};
		
		LoadActor("musicsonginfoframe")..{
			InitCommand=function(self)
				if getenv("exflag") == "csc" then
					self:x(-116-70);
					self:y(-35);
				else
					self:x(-116-80);
					self:y(-35-90);
				end;
			end;
			OnCommand=cmd(diffusealpha,0;zoom,2;addx,30;sleep,0.8;accelerate,0.4;addx,-30;diffusealpha,1;zoom,1;
						glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");decelerate,0.4;glow,color("1,1,0,0");queuecommand,"Repeat";);
			RepeatCommand=cmd(sleep,20.75;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,0.5");decelerate,1;glow,color("1,1,0,0");queuecommand,"Repeat";);
			OffCommand=cmd(stoptweening;);
		};

		LoadActor("bpmframe")..{
			InitCommand=function(self)
				if getenv("exflag") == "csc" then
					self:x(-96-70);
					self:y(-52-10);
				else
					self:x(-96-80);
					self:y(-52-90);
				end;
			end;
			OnCommand=cmd(diffusealpha,0;zoom,2;addx,20;addy,20;sleep,0.5;accelerate,0.4;addx,-20;addy,-20;diffusealpha,1;zoom,1;
						glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");decelerate,0.4;glow,color("1,1,0,0");queuecommand,"Repeat";);
			RepeatCommand=cmd(sleep,21.25;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,0.5");decelerate,1;glow,color("1,1,0,0");queuecommand,"Repeat";);
			OffCommand=cmd(stoptweening;);
		};
	};
end;

-- songtitle
if getenv("exflag") == "csc" then
	t[#t+1] = LoadActor("cscsonginfotitle")..{
		InitCommand=function(self)
			self:stoptweening();
			self:x(SCREEN_CENTER_X-80);
			self:y(SCREEN_CENTER_Y+30);
		end;
		OffCommand=cmd(stoptweening;);
	};
else
	t[#t+1] = LoadActor("songinfotitle")..{
		InitCommand=function(self)
			self:stoptweening();
			self:y(SCREEN_CENTER_Y+26);
			if GAMESTATE:IsCourseMode() then self:x(SCREEN_CENTER_X-230);
			else self:x(SCREEN_CENTER_X-130);
			end;
			(cmd(zoomx,10;decelerate,0.4;zoomx,1;))(self)
		end;
		OnCommand=cmd(zoomx,10;decelerate,0.4;zoomx,1;);
		OffCommand=cmd(stoptweening;);
	};
end;

return t;