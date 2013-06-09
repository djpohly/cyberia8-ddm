--[[ScreenSelectMusicExtra background]]

local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(fov,100);
	
	Def.Quad {
		InitCommand=cmd(FullScreen;diffuse,color("0.5,0,0,1");diffuserightedge,color("0,0.7,1,0.35"););
	};

--3dmodel
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_RIGHT-100;y,SCREEN_CENTER_Y+50;rotationy,-30;);
		OnCommand=cmd(addx,300;zoom,3;decelerate,1;addx,-300;zoom,2.5;rotationx,0;rotationz,40;rotationy,30;);
		
		LoadActor( THEME:GetPathB("_shared","models/_08_line") )..{
			InitCommand=cmd(diffuse,color("0,0,0,0.5");queuecommand,"Repeat";);
			RepeatCommand=cmd(spin;effectmagnitude,-11,-8,4;);
		};
		
		LoadActor( THEME:GetPathB("_shared","models/_08_line") )..{
			InitCommand=cmd(zoom,0.8;diffuse,color("0,0,0,0.6");queuecommand,"Repeat";);
			RepeatCommand=cmd(spin;effectmagnitude,6,-8,-5;);
		};
	};
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_LEFT+160;y,SCREEN_CENTER_Y+50;rotationx,-120;rotationz,-90;);
		OnCommand=cmd(addx,300;zoom,1.1;decelerate,1;addx,-300;zoom,0.8;rotationx,0;rotationz,90;queuecommand,"Repeat";);
		RepeatCommand=cmd(spin;effectmagnitude,16,2,-20;);

		LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
			InitCommand=cmd(x,-100;diffuse,color("0,0,0,0.1"););
		};
		
		LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
			InitCommand=cmd(x,100;diffuse,color("0,0,0,0.2"););
		};
	};
};
--under
--over
t[#t+1] = LoadActor( THEME:GetPathB("","_focus_gra/extra_gra") )..{
};

--etc
t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		if GAMESTATE:IsCourseMode() then self:x(SCREEN_CENTER_X-100);
		else self:x(SCREEN_CENTER_X);
		end;
		(cmd(zoomx,10;zoomy,0;y,SCREEN_CENTER_Y+30;))(self)
	end;
	OnCommand=cmd(sleep,0.2;decelerate,0.3;zoom,1;);
	LoadActor( THEME:GetPathB("ScreenSelectMusic","background/_bannerback2") )..{
		CurrentSongChangedMessageCommand=cmd(stoptweening;diffusealpha,0;accelerate,0.1;diffusealpha,1;zoomy,1.1;glow,color("1,1,0,0.75");decelerate,0.3;glow,color("1,1,0,0");zoomy,1;);
	};
};

t[#t+1] = LoadActor( THEME:GetPathB("","underlay") )..{
};

return t;