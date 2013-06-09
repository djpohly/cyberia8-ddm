local t = Def.ActorFrame{};
local bUse3dModels = GetAdhocPref("Enable3DModels");

if bUse3dModels == 'On' then
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(fov,100);
		--back
		Def.Quad {
			InitCommand=cmd(FullScreen;diffuse,color("0,0.7,1,1");diffuserightedge,color("0,0.7,1,0.35"););
		};
		
		Def.ActorFrame{
			InitCommand=cmd(fov,100;);
			Def.ActorFrame{
				InitCommand=cmd(Center;);
				--OnCommand=cmd(zoom,10;addx,-10;addy,10;rotationz,-60;sleep,28.5-14.75+0.3;decelerate,0.5;addx,10;addy,-10;rotationz,-100;zoom,0.75;queuecommand,"Repeat";);
				OnCommand=cmd(zoom,10;addx,-10;addy,10;rotationz,-60;sleep,0.4+0.3;decelerate,0.5;addx,10;addy,-10;rotationz,-100;zoom,0.75;queuecommand,"Repeat";);
				RepeatCommand=cmd(spin;effectmagnitude,6,0,0;);

				LoadActor( THEME:GetPathB("_shared","models/_08_wall") )..{
					InitCommand=cmd(blend,'BlendMode_Add';diffuse,color("0.8,0.9,0,0.2"););
				};
			};

			Def.ActorFrame{
				InitCommand=cmd(x,SCREEN_RIGHT-160;y,SCREEN_CENTER_Y;);
				--OnCommand=cmd(zoom,10;sleep,28.5-14.75+0.3;decelerate,0.5;zoom,0.4;rotationx,-120;rotationz,-90;queuecommand,"Repeat";);
				OnCommand=cmd(zoom,10;sleep,0.4+0.3;decelerate,0.5;zoom,0.4;rotationx,-120;rotationz,-90;queuecommand,"Repeat";);
				RepeatCommand=cmd(spin;effectmagnitude,16,2,-20;);

				LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
					InitCommand=cmd(blend,'BlendMode_Add';x,-100;diffuse,color("0.6,0.6,0.6,0.3"););
				};
				
				LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
					InitCommand=cmd(blend,'BlendMode_Add';x,100;diffuse,color("0.6,0.6,0.6,0.4"););
				};
			};
		};
	};
else
	t[#t+1] = LoadActor( THEME:GetPathB("","_movie/_default_back") )..{
		InitCommand=cmd(Center;FullScreen;rotationz,180;);
	};
	t[#t+1] = Def.Quad {
		InitCommand=cmd(FullScreen;diffuse,color("0,0.7,1,1");diffuserightedge,color("0,0.7,1,0.35"););
	};
end;

t[#t+1] = Def.ActorFrame{
	Def.Quad{
		--OnCommand=cmd(FullScreen;diffuse,color("0.2,0,0,1");sleep,28.7-14.75;diffuse,color("1,1,1,1");linear,1;diffuse,color("0,0,0,0"););
		OnCommand=cmd(FullScreen;diffuse,color("0,0.2,0.2,1");sleep,0.6;diffuse,color("1,1,1,1");linear,1;diffuse,color("0,0,0,0"););
	};

	Def.Quad{
		InitCommand=cmd(CenterX;vertalign,top;y,SCREEN_TOP;zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;diffuse,color("0,0,0,0"););
		--OnCommand=cmd(sleep,28.7-14.75;accelerate,0.5;diffuse,color("0,0.7,1,0.35");diffusetopedge,color("0,1,1,1");zoomtoheight,SCREEN_HEIGHT*0.35;);
		OnCommand=cmd(sleep,0.6;accelerate,0.5;diffuse,color("0,0.7,1,0.35");diffusetopedge,color("0,1,1,1");zoomtoheight,SCREEN_HEIGHT*0.35;);
	};
	
	Def.Quad{
		InitCommand=cmd(CenterX;vertalign,bottom;y,SCREEN_BOTTOM;zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;diffuse,color("0,0,0,0"););
		--OnCommand=cmd(sleep,28.7-14.75;accelerate,0.5;diffuse,color("0,0.7,1,0.35");diffusebottomedge,color("0,1,1,1");zoomtoheight,SCREEN_HEIGHT*0.35;);
		OnCommand=cmd(sleep,0.6;accelerate,0.5;diffuse,color("0,0.7,1,0.35");diffusebottomedge,color("0,1,1,1");zoomtoheight,SCREEN_HEIGHT*0.35;);
	};
	
	Def.Quad{
		InitCommand=cmd(Center;zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;diffuse,color("0,0,0,0"););
		--OnCommand=cmd(sleep,28.7-14.75;accelerate,0.5;diffuse,color("0,0.7,1,0.35");zoomtoheight,SCREEN_HEIGHT-((SCREEN_HEIGHT*0.35)*2);queuecommand,"Repeat";);
		OnCommand=cmd(sleep,0.6;accelerate,0.5;diffuse,color("0,0.7,1,0.35");zoomtoheight,SCREEN_HEIGHT-((SCREEN_HEIGHT*0.35)*2);queuecommand,"Repeat";);
		RepeatCommand=cmd(sleep,4.8;diffuse,color("1,1,0,1");linear,0.6;diffuse,color("0,0.7,1,0.35");sleep,1.2;queuecommand,"Repeat";);
	};
};

return t;