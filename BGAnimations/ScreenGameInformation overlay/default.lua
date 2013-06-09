
local playModeToGraphic = {
	PlayMode_Regular = "_regular",
	PlayMode_Nonstop = "_nonstop",
	PlayMode_Oni = "_challenge",
	PlayMode_Endless = "_endless",
	PlayMode_Rave = "_rave",
};
local playMode = GAMESTATE:GetPlayMode();

local t = Def.ActorFrame{
	InitCommand=cmd(fov,100;);
	
	Def.ActorFrame{
		OnCommand=cmd(addy,30;rotationx,30;rotationy,90;rotationz,-20;decelerate,0.8;addy,-30;rotationx,0;rotationy,0;rotationz,0;);

		LoadActor( THEME:GetPathB("","ScreenInstructions_back") )..{
			OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+20;zoom,0;sleep,0.35;linear,0.1;zoom,1;
						diffusealpha,0.4;decelerate,0.3;zoomx,1.2;zoomy,2;diffusealpha,0;);
			OffCommand=cmd(finishtweening;);
		};

		LoadActor( THEME:GetPathB("","ScreenInstructions_back") )..{
			OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+20;diffusealpha,0.8;zoomy,0;sleep,0.4;decelerate,0.3;zoomy,1;);
			OffCommand=cmd(finishtweening;);
		};

		LoadActor( playModeToGraphic[playMode] )..{
			InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+20);
			OnCommand=cmd(diffusealpha,0;sleep,0.5;decelerate,0.2;diffusealpha,1);
			OffCommand=cmd(finishtweening;);
		};
	};
};

return t;