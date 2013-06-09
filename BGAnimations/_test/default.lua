local t = Def.ActorFrame{};
local bUse3dModels = GetAdhocPref("Enable3DModels");

if bUse3dModels == 'On' then
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd();
		Def.ActorFrame{
			InitCommand=cmd(fov,100;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+50;);
			OnCommand=cmd(rotationz,-100;zoomx,0.75;zoomy,1;queuecommand,"Repeat";);
			RepeatCommand=cmd(spin;effectmagnitude,12,0,0;);

			LoadActor( THEME:GetPathB("_shared","models/_08_wall") )..{
				InitCommand=cmd(blend,'BlendMode_Add';diffuse,color("0.8,0.9,0,0.4"););
			};
		};

		Def.ActorFrame{
			InitCommand=cmd(fov,130;x,SCREEN_LEFT+160;y,SCREEN_CENTER_Y+50;);
			OnCommand=cmd(zoom,0.8;rotationx,0;rotationz,90;queuecommand,"Repeat";);
			RepeatCommand=cmd(spin;effectmagnitude,0,24,0;);

			LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
				InitCommand=cmd(blend,'BlendMode_Add';x,-100;diffuse,color("0.6,0.6,0.6,0.3"););
			};
			
			LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
				InitCommand=cmd(blend,'BlendMode_Add';x,100;diffuse,color("0.6,0.6,0.6,0.4"););
			};
		};
	};
end
return t;