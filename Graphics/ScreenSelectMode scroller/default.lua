--[[ScreenSelectMode scroller]]

local gc = Var "GameCommand";

local t = Def.ActorFrame{
	InitCommand=cmd(fov,100;);
	
	Def.ActorFrame{
		OnCommand=cmd(addy,30;rotationx,-30;rotationy,-90;rotationz,20;decelerate,0.45;addy,-30;rotationx,0;rotationy,0;rotationz,0;);

		Def.ActorFrame{
			LoadActor(THEME:GetPathG("","stylemodeback/label_back"))..{
				InitCommand=cmd(x,SCREEN_CENTER_X-14;y,SCREEN_CENTER_Y+42;horizalign,left;vertalign,bottom;);
				OnCommand=cmd(diffusealpha,0;addx,100;zoomx,3;decelerate,0.2;addx,-100;zoomx,1;diffusealpha,1;linear,0.01;glow,color("1,1,0,1");linear,0.2;glow,color("1,1,0,0"););
				GainFocusCommand=cmd(finishtweening;visible,true;diffusealpha,0;addx,100;zoomx,3;decelerate,0.2;addx,-100;zoomx,1;diffusealpha,1;linear,0.01;glow,color("1,1,0,1");linear,0.2;glow,color("1,1,0,0"););
				LoseFocusCommand=cmd(finishtweening;visible,false;cropright,0);
				OffFocusedCommand=cmd(finishtweening;visible,false);
			};
	
			LoadActor(THEME:GetPathG("","stylemodeback/info_back"))..{
				InitCommand=cmd(x,SCREEN_CENTER_X-108;y,SCREEN_CENTER_Y-19+10;);
				OnCommand=cmd(cropright,1;sleep,0.3;linear,0.3;cropright,0;);
				GainFocusCommand=cmd(finishtweening;visible,true;cropright,1;linear,0.3;cropright,0;);
				LoseFocusCommand=cmd(finishtweening;visible,false;cropright,0;);
				OffFocusedCommand=cmd(finishtweening;visible,false);
			};
	
			LoadActor(THEME:GetPathG("","stylemodeback/name_back"))..{
				InitCommand=cmd(x,SCREEN_CENTER_X-134;y,SCREEN_CENTER_Y-74+10;);
				OnCommand=cmd(diffusealpha,0;zoom,1.5;sleep,0.475;accelerate,0.4;diffusealpha,1;zoom,1;);
				GainFocusCommand=cmd(finishtweening;visible,true;diffusealpha,0;zoom,1.5;sleep,0.075;accelerate,0.4;diffusealpha,1;zoom,1;);
				LoseFocusCommand=cmd(finishtweening;visible,false);
				OffFocusedCommand=cmd(finishtweening;visible,false);
			};
		};

		LoadActor("_"..gc:GetName().."_label")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+150;y,SCREEN_CENTER_Y+10+10;vertalign,bottom;);
			OnCommand=cmd(diffusealpha,0.8;cropbottom,1;croptop,-0.3;sleep,0.2;decelerate,0.6;cropbottom,-0.3;glow,color("0.6,0.25,0.1,1");linear,0.025;glow,color("1,0.5,0,0"););
			OffCommand=cmd(linear,0.1;diffusealpha,0);
			GainFocusCommand=cmd(finishtweening;visible,true;diffusealpha,0.8;cropbottom,1;croptop,-0.3;sleep,0.6;decelerate,0.2;cropbottom,-0.3;glow,color("0.6,0.25,0.1,1");linear,0.025;glow,color("1,0.5,0,0"););
			LoseFocusCommand=cmd(finishtweening;visible,false);
			OffFocusedCommand=cmd(finishtweening;visible,false);
		};
	
		LoadActor("_"..gc:GetName().."_explain1")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-34;y,SCREEN_CENTER_Y-88+10);
			OnCommand=cmd(addx,20;diffusealpha,0;zoomx,210;zoomy,1.5;linear,0.45;zoomx,1.75;glow,color("0.6,0.25,0.1,1");addx,-20;zoomx,1.25;linear,0.05;glow,color("1,1,0,1");diffusealpha,1;zoom,1;linear,0.1;glow,color("0.6,0.25,0.1,0"));
			OffCommand=cmd(linear,0.1;diffusealpha,0);
			GainFocusCommand=cmd(finishtweening;visible,true;addx,20;diffusealpha,0;zoomx,210;zoomy,1.5;linear,0.45;zoomx,1.75;glow,color("0.6,0.25,0.1,1");addx,-20;zoomx,1.25;linear,0.05;glow,color("1,1,0,1");diffusealpha,1;zoom,1;linear,0.1;glow,color("0.6,0.25,0.1,0"));
			LoseFocusCommand=cmd(finishtweening;visible,false);
			OffFocusedCommand=cmd(finishtweening;visible,false);
		};

		LoadActor("_"..gc:GetName().."_explain2")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-118;y,SCREEN_CENTER_Y-29+10;);
			OnCommand=cmd(diffusealpha,0;addx,-10;addy,10;sleep,0.5;decelerate,0.3;addx,10;addy,-10;diffusealpha,1;glow,color("0.6,0.25,0.1,0");linear,0.05;glow,color("0.6,0.25,0.1,1");linear,0.05;glow,color("0.6,0.25,0.1,0"););
			OffCommand=cmd(linear,0.1;diffusealpha,0);
			GainFocusCommand=cmd(finishtweening;visible,true;diffusealpha,0;addx,-10;addy,10;sleep,0.1;decelerate,0.3;addx,10;addy,-10;diffusealpha,1;glow,color("0.6,0.25,0.1,0");linear,0.05;glow,color("0.6,0.25,0.1,1");linear,0.05;glow,color("0.6,0.25,0.1,0"););
			LoseFocusCommand=cmd(finishtweening;visible,false);
			OffFocusedCommand=cmd(finishtweening;visible,false);
		};

		LoadFont("Common Normal") .. {
			Text= "Which GameMode matches you?";
			InitCommand=cmd(x,SCREEN_CENTER_X-218;y,SCREEN_CENTER_Y-120+10;diffuse,color("1,1,0,1");strokecolor,color("0.85,0,0,1");shadowlength,1;zoom,0.45;);
			OnCommand=cmd(cropright,1;sleep,0.1;decelerate,0.4;cropright,0;diffusealpha,1;);
			GainFocusCommand=cmd(finishtweening;visible,true;cropright,1;sleep,0.1;decelerate,0.4;cropright,0;diffusealpha,1;);
			LoseFocusCommand=cmd(finishtweening;visible,false);
			OffFocusedCommand=cmd(finishtweening;visible,false);
		};
	
		Def.ActorFrame{
			InitCommand=cmd(x,SCREEN_CENTER_X+10;y,SCREEN_CENTER_Y+4;);
			LoadActor(THEME:GetPathG("","stylemodeback/styleinfo_back"))..{
				OnCommand=cmd(diffusealpha,0;glow,color("1,1,0,1");zoomy,1;accelerate,0.025;diffusealpha,1;accelerate,0.2;glow,color("1,1,0,0");zoomy,1.2;linear,0.025;diffusealpha,0;);
				OffCommand=cmd(linear,0.1;diffusealpha,0);
				GainFocusCommand=cmd(finishtweening;visible,true;diffusealpha,0;glow,color("1,1,0,1");zoomy,1;accelerate,0.2;diffusealpha,1;accelerate,0.05;glow,color("1,1,0,0");zoomy,1.2;linear,0.025;diffusealpha,0;zoom,1;);
				LoseFocusCommand=cmd(finishtweening;visible,false);
				OffFocusedCommand=cmd(finishtweening;visible,false);
			};
		};
	
		--explanation
		Def.ActorFrame{
			InitCommand=cmd(x,SCREEN_CENTER_X-198;y,SCREEN_CENTER_Y-148+10;);
			LoadActor(THEME:GetPathG("","stylemodeback/explanationunder"))..{
				OnCommand=cmd(diffusealpha,0;glow,color("0,1,1,0");zoomy,1.5;addy,-10;sleep,0.3;glow,color("0,1,1,1");decelerate,0.5;zoomy,1;diffusealpha,1;addy,10;glow,color("0,1,1,0"););
				OffCommand=cmd(stoptweening;);
			};
	
			LoadActor(THEME:GetPathG("","stylemodeback/explanationunder"))..{
				OnCommand=cmd(zoomx,0.2;zoom,3;decelerate,1.2;zoom,1;diffusealpha,0);
			};

			LoadActor(THEME:GetPathG("","stylemodeback/explanationmode"))..{
				InitCommand=cmd(x,-6;y,-2;);
				OnCommand=cmd(diffusealpha,0;glow,color("0,1,1,0");zoomy,1.5;addx,-10;sleep,0.3;glow,color("0,1,1,1");decelerate,0.5;zoomy,1;diffusealpha,1;addx,10;glow,color("0,1,1,0");queuecommand,"Repeat";);
				RepeatCommand=cmd(diffusealpha,1;sleep,8;glow,color("0,1,1,0");linear,0.05;glow,color("0,1,1,1");decelerate,0.5;glow,color("0,1,1,0");queuecommand,"Repeat";);
			};
		};
	};
};
return t;