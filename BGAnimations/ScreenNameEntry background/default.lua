--[[ScreenNameEntry background]]

local t = Def.ActorFrame{};
local bUse3dModels = GetAdhocPref("Enable3DModels");

if bUse3dModels == 'On' then
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(fov,100);

	--back
		Def.Quad {
			InitCommand=cmd(FullScreen;diffuse,color("0,0.7,1,1");diffuserightedge,color("0,0.7,1,0.35"););
		};

	--3dmodel
		Def.ActorFrame{
			InitCommand=cmd(x,SCREEN_RIGHT-100;y,SCREEN_CENTER_Y+50;zoom,2.5;rotationx,0;rotationz,40;rotationy,30;);

			LoadActor( THEME:GetPathB("_shared","models/_08_line") )..{
				InitCommand=cmd(blend,'BlendMode_Add';diffuse,color("0.4,0.2,0,0.5");queuecommand,"Repeat";);
				RepeatCommand=cmd(spin;effectmagnitude,-5,-4,2;);
			};
			
			LoadActor( THEME:GetPathB("_shared","models/_08_line") )..{
				InitCommand=cmd(zoom,0.8;blend,'BlendMode_Add';diffuse,color("0.4,0.2,0,0.6");queuecommand,"Repeat";);
				RepeatCommand=cmd(spin;effectmagnitude,3,-4,-2;);
			};
		};
	--[[	
		Def.ActorFrame{
			LoadActor("_particleLoader") .. {
				InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;);
			};
		};
	]]
	};
else
	t[#t+1] = LoadActor( THEME:GetPathB("","_movie/_back_1") )..{
		InitCommand=cmd(Center;FullScreen);
	};
	t[#t+1] = Def.Quad {
		InitCommand=cmd(FullScreen;diffuse,color("0,0.7,1,1");diffuserightedge,color("0,0.7,1,0.35"););
	};
end;

return t;