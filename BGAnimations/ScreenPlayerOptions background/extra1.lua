
local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(fov,100);
--under
--back
	Def.Quad {
		InitCommand=cmd(FullScreen;diffuse,color("0.5,0,0,1");diffuserightedge,color("0,0.7,1,0.35"););
	};
};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(fov,130);
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+50;);
		OnCommand=cmd(addx,-10;addy,10;rotationz,-60;decelerate,0.5;addx,10;addy,-10;rotationz,-100;zoomx,0.75;zoomy,1;queuecommand,"Repeat";);
		RepeatCommand=cmd(spin;effectmagnitude,6,0,2;);

		LoadActor( THEME:GetPathB("_shared","models/_08_wall") )..{
			InitCommand=cmd(blend,'BlendMode_Add';diffuse,color("0.8,0.9,0,0.15"););
		};
	};
};

--over
t[#t+1] = LoadActor( THEME:GetPathB("","_focus_gra/extra_gra") )..{
};

--under
--etc
t[#t+1] = Def.ActorFrame{
	LoadActor( THEME:GetPathB("","underlay") )..{
	};
};

return t;