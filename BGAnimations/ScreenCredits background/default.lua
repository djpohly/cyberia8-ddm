--[[ScreenCredits background]]
local bUse3dModels = GetAdhocPref("Enable3DModels");

local t = Def.ActorFrame{};

t[#t+1] = Def.Quad {
	InitCommand=cmd(Center;FullScreen;diffuse,color("0,1,1,1");diffuserightedge,color("0,0.7,1,0.35"););
};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(fov,100;);

	Def.ActorFrame{
		Def.ActorFrame{
			InitCommand=cmd(x,SCREEN_CENTER_X-200;y,SCREEN_CENTER_Y+80;rotationx,-120;rotationz,-90;);
			OnCommand=cmd(zoom,0.4;rotationx,0;rotationz,90;queuecommand,"Repeat";);
			RepeatCommand=cmd(spin;effectmagnitude,16,2,-20;);

			LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
				InitCommand=cmd(blend,'BlendMode_Add';x,-100;diffuse,color("0.6,0.6,0.6,0.1"););
			};
			
			LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
				InitCommand=cmd(blend,'BlendMode_Add';x,100;diffuse,color("0.6,0.6,0.6,0.2"););
			};
		};
	};

	LoadActor("_particleLoader") .. {
		InitCommand=cmd(fov,170;x,SCREEN_CENTER_X+120;y,-SCREEN_CENTER_Y-240;zoom,2;rotationx,50;rotationy,30;rotationz,40;);
	};
};

return t;
