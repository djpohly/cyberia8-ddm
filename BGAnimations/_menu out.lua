local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathB("","_delay"),0.8);

	LoadActor( THEME:GetPathS("","_swoosh" ) )..{
		StartTransitioningCommand=cmd(play);
	};

	Def.Quad{
		BeginCommand=cmd(FullScreen);
		OnCommand=cmd(diffuse,color("0,0,0,0");sleep,0.3;linear,0.1;diffuse,color("0,0,0,1"););
	};

	Def.Quad{
		OnCommand=cmd(diffuse,color("0,0,0,1");vertalign,top;x,SCREEN_CENTER_X;y,SCREEN_TOP;zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;
				decelerate,0.4;diffuse,color("0,0.7,1,0.4");zoomtoheight,SCREEN_HEIGHT*0.5;);
	};

	Def.Quad{
		OnCommand=cmd(diffuse,color("0,0,0,1");vertalign,bottom;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM;zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;
				decelerate,0.2;diffuse,color("0,0.7,1,0.4");zoomtoheight,SCREEN_HEIGHT*0.5;);
	};
	
	LoadActor( THEME:GetPathB("","back_effect/left_effect" ) )..{
		OnCommand=cmd(horizalign,left;zoomtoheight,SCREEN_HEIGHT;x,SCREEN_LEFT*0.1;y,SCREEN_CENTER_Y+100;zoom,1.5;
				diffusealpha,0;addy,20;linear,0.8;addy,-20;diffusealpha,1;);
	};
	
	Def.Quad{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT*0.6;
				diffuse,color("0,0.6,0.6,0");sleep,0.2;diffuse,color("0,0.6,0.6,0.5");glow,color("0,0,1,0.5");accelerate,0.25;glow,color("0,0,1,0");
				zoomtoheight,SCREEN_HEIGHT*0.45;accelerate,0.15;zoomtoheight,0;diffusealpha,0;);
	};
	
	Def.Quad{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT*0.4;
				diffuse,color("1,1,0,0");sleep,0.25;diffuse,color("1,1,0,0.2");glow,color("0,1,1,0.3");accelerate,0.3;glow,color("0,1,1,0");
				zoomtoheight,SCREEN_HEIGHT*0.2;accelerate,0.1;zoomtoheight,0;diffusealpha,0;);
	};

	Def.Quad{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("1,0,0.5,0.5");
				zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT;decelerate,0.4;zoomtoheight,0;diffusealpha,0);
	};

	Def.Quad{
		OnCommand=cmd(horizalign,left;vertalign,bottom;x,SCREEN_LEFT;y,SCREEN_CENTER_Y;diffuse,color("1,0.5,0,0.7");
				zoomtoheight,SCREEN_HEIGHT*0.5;zoomtowidth,SCREEN_WIDTH;fadetop,0.2;
				accelerate,0.4;zoomtoheight,10;diffuse,color("1,0.5,0,0.5");linear,0.3;zoomtowidth,0;zoomtoheight,5;diffuse,color("1,0.5,0,0.3"););
	};

	Def.Quad{
		OnCommand=cmd(horizalign,right;vertalign,top;x,SCREEN_RIGHT;y,SCREEN_CENTER_Y;diffuse,color("1,0.5,0,0.7");
				zoomtoheight,SCREEN_HEIGHT*0.5;zoomtowidth,SCREEN_WIDTH;fadebottom,0.2;
				accelerate,0.4;zoomtoheight,10;diffuse,color("1,0.5,0,0.5");linear,0.3;zoomtowidth,0;zoomtoheight,5;diffuse,color("1,0.5,0,0.3"););
	};
};

--_dline_1
for i = 1, 3 do
	local function sleepwait()
		local wait = 0.15 * i;
		return wait
	end;
	local function yset()
		local y = 180 * i;
		return y
	end;
	local function pload()
		local picload = "_background_parts/_dline_1";
		return picload
	end;

	t[#t+1] = Def.ActorFrame{
		BeginCommand=cmd(rotationz,-90;x,SCREEN_LEFT;y,SCREEN_CENTER_Y+30;);
		LoadActor(THEME:GetPathB("",pload()))..{
			OnCommand=cmd(y,yset();diffuse,color("0.1,1,1,0.6");cropbottom,1;sleep,0.1+sleepwait();decelerate,0.2;cropbottom,0;);
		};
	};
end;

t[#t+1] = Def.ActorFrame{
	LoadActor( THEME:GetPathB("","back_effect/ver8" ) )..{
		OnCommand=cmd(horizalign,left;x,SCREEN_WIDTH*0.11;y,SCREEN_CENTER_Y+14;diffuse,color("0,0.5,1,0.7");
				zoomx,3;zoomy,0;accelerate,0.4;zoom,0.5;diffuse,color("0,1,1,0.7"););
	};
	
	LoadActor( THEME:GetPathB("","back_effect/cs8" ) )..{
		OnCommand=cmd(horizalign,left;x,SCREEN_WIDTH*0.11;y,SCREEN_CENTER_Y;diffuse,color("1,0.5,0,0.7");diffuseleftedge,color("1,1,0,0.7");
				zoomx,3;zoomy,0;accelerate,0.4;zoom,0.75;);
	};

	Def.Quad{
		OnCommand=cmd(x,SCREEN_LEFT;y,SCREEN_CENTER_Y-34;horizalign,left;vertalign,bottom;addy,-40;zoomtoheight,20;zoomtowidth,0;fadetop,0.2;fadebottom,0.2;
				diffuse,color("1,1,0,0.2");sleep,0.2;zoomtowidth,SCREEN_WIDTH;decelerate,0.5;zoomtoheight,1;zoomtowidth,0;addy,40;diffuse,color("1,1,0,0.4"););
	};

	Def.Quad{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y+32;horizalign,right;vertalign,top;addy,40;zoomtoheight,20;zoomtowidth,0;fadetop,0.2;fadebottom,0.2;
				diffuse,color("1,1,0,0.2");sleep,0.3;zoomtowidth,SCREEN_WIDTH;decelerate,0.2;zoomtoheight,1;zoomtowidth,0;addy,-40;diffuse,color("1,1,0,0.4"););
	};
	
	Def.Quad{
		OnCommand=cmd(x,SCREEN_LEFT;y,SCREEN_CENTER_Y-38;horizalign,left;vertalign,bottom;addy,-30;zoomtoheight,20;zoomtowidth,0;fadetop,0.2;fadebottom,0.2;
				diffuse,color("0,1,1,0.2");sleep,0.4;zoomtowidth,SCREEN_WIDTH;accelerate,0.1;zoomtoheight,1;zoomtowidth,0;addy,30;diffuse,color("0,1,1,0.4"););
	};

	Def.Quad{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y+40;horizalign,right;vertalign,top;addy,30;zoomtoheight,20;zoomtowidth,0;fadetop,0.2;fadebottom,0.2;
				diffuse,color("0,1,1,0.2");sleep,0.1;zoomtowidth,SCREEN_WIDTH;accelerate,0.6;zoomtoheight,1;zoomtowidth,0;addy,-30;diffuse,color("0,1,1,0.4"););
	};
};

return t;