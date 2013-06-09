--[[ScreenSelectMusicExtra2 background]]
local bUse3dModels = GetAdhocPref("Enable3DModels");

local t = Def.ActorFrame{};

if bUse3dModels == 'On' then
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(fov,100);
		
		Def.Quad {
			InitCommand=cmd(Center;FullScreen;diffuse,color("1,1,1,1");diffusebottomedge,color("0,0,0,1"););
		};

		Def.ActorFrame{
			InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;rotationx,-120;rotationz,-90;);
			OnCommand=cmd(addx,300;zoom,1.5;decelerate,1;addx,-300;zoom,0.8;rotationx,0;rotationz,90;queuecommand,"Repeat";);
			RepeatCommand=cmd(spin;effectmagnitude,16,2,-20;);

			LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
				InitCommand=cmd(blend,'BlendMode_Add';x,-100;diffuse,color("0.6,0.6,0.6,0.1"););
			};
			
			LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
				InitCommand=cmd(blend,'BlendMode_Add';x,100;diffuse,color("0.6,0.6,0.6,0.2"););
			};
		};
	};
else
	t[#t+1] = LoadActor( THEME:GetPathB("","_movie/_back_1") )..{
		InitCommand=cmd(Center;FullScreen);
	};
	t[#t+1] = Def.Quad {
		InitCommand=cmd(Center;FullScreen;diffuse,color("1,1,1,1");diffusebottomedge,color("0,0,0,1"););
	};
end;

t[#t+1] = Def.ActorFrame{
	Def.ActorFrame{
		LoadActor("_particleLoader") .. {
			InitCommand=cmd(fov,100;x,SCREEN_LEFT+50;y,-SCREEN_CENTER_Y;rotationz,40;rotationy,30;);
		};
	};

	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X;zoomx,10;zoomy,0;y,SCREEN_CENTER_Y+30;);
		OnCommand=cmd(sleep,0.2;decelerate,0.3;zoom,1;);
		LoadActor(THEME:GetPathB("ScreenSelectMusic","background/_bannerback2"))..{
			CurrentSongChangedMessageCommand=cmd(stoptweening;diffusealpha,0;accelerate,0.1;diffusealpha,1;zoomy,1.1;glow,color("1,1,0,0.75");decelerate,0.3;glow,color("1,1,0,0");zoomy,1;);
		};
	};

	LoadActor( THEME:GetPathB("","underlay") )..{
	};
};
return t;