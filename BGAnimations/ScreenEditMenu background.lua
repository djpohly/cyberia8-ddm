--[[ScreenSelectCourse background]]
local t = Def.ActorFrame{};
local bUse3dModels = GetAdhocPref("Enable3DModels");

if bUse3dModels == 'On' then
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(fov,100);

	--back
		Def.Quad {
			InitCommand=cmd(FullScreen;diffuse,color("0,0.7,1,0.5");diffuserightedge,color("0,0.7,1,0.35"));
		};

	--3dmodel
		Def.ActorFrame{
			InitCommand=cmd(x,SCREEN_CENTER_X-100;y,SCREEN_CENTER_Y+50;);
			OnCommand=cmd(addx,-10;addy,10;decelerate,0.5;addx,10;addy,-10;zoomx,0.75;zoomy,0.75;queuecommand,"Repeat";);
			RepeatCommand=cmd(spin;effectmagnitude,0,0,6;);

			LoadActor( THEME:GetPathB("_shared","models/_08_wall") )..{
				InitCommand=cmd(rotationz,-100;blend,'BlendMode_Add';diffuse,color("0.8,0.9,0,0.15"););
			};
		};

		Def.ActorFrame{
			InitCommand=cmd(x,SCREEN_LEFT+160;y,SCREEN_CENTER_Y+50;rotationx,-120;rotationz,-90;);
			OnCommand=cmd(addx,300;zoom,1.1;decelerate,1;addx,-300;zoom,0.8;rotationx,0;rotationz,90;queuecommand,"Repeat";);
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
	t[#t+1] = LoadActor( THEME:GetPathB("","_movie/_default_back") )..{
		InitCommand=cmd(Center;FullScreen);
	};

	t[#t+1] = Def.Quad {
		InitCommand=cmd(FullScreen;diffuse,color("0,0.7,1,0.5");diffuserightedge,color("0,0.7,1,0.35"));
	};
end;
--etc
t[#t+1] = Def.ActorFrame{
	LoadActor( THEME:GetPathB("","underlay") )..{
	};
};

return t;