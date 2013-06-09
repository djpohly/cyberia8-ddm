local t = Def.ActorFrame{};

for i = 1, 18 do
	local function sleepwait()
		local wait = 0.035 * i;
		return wait
	end;
	local function xset()
		local x = SCREEN_WIDTH / 6;
		if i <= 6 then
			x = SCREEN_WIDTH / 6 * i
		elseif i > 6 and i <= 12 then
			x = SCREEN_WIDTH / 6 * (i - 6)
		else
			x = SCREEN_WIDTH / 6 * (i - 12)
		end;
		return x
	end;
	local function yset()
		local y = SCREEN_HEIGHT / 3;
		if i <= 6 then
			y = SCREEN_HEIGHT / 3 * 1
		elseif i > 6 and i <= 12 then
			y = SCREEN_HEIGHT / 3 * 2
		else
			y = SCREEN_HEIGHT / 3 * 3
		end;
		return y
	end;
	local function zoomxset()
		local zx = SCREEN_WIDTH / 6;
		return zx
	end;
	local function zoomyset()
		local zy = SCREEN_HEIGHT / 3;
		return zy
	end;

	t[#t+1] = Def.Quad{
			OnCommand=cmd(horizalign,right;vertalign,bottom;x,xset();y,yset();zoomtowidth,0;zoomtoheight,0;diffuse,color("1,0,0,1");
						addx,60;sleep,sleepwait();decelerate,0.2;addx,-60;zoomtowidth,zoomxset();zoomtoheight,zoomyset();diffuse,color("0.25,0,0,1"););
	};
end;

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(sleep,4);

	LoadActor( "sound_failed" )..{
		StartTransitioningCommand=cmd(play);
	};
	
	Def.ActorFrame{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;addy,-20;linear,4;addy,20;);
		LoadActor( "under" )..{
			OnCommand=cmd(diffusealpha,1;cropbottom,1;linear,1;cropbottom,0;
						linear,0.05;glow,color("1,0,0,1");linear,0.05;glow,color("0,0,0,0");linear,0.05;glow,color("1,0,0,1");linear,0.05;glow,color("0,0,0,0"););
		};
	};
	
	Def.ActorFrame{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+10;addx,-20;linear,5;addx,20;);
		LoadActor( "fback" )..{
			OnCommand=cmd(diffusealpha,1;cropleft,1;sleep,0.5;decelerate,0.5;cropleft,0;);
		};
	};
	
	Def.ActorFrame{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;addx,20;linear,4;addx,-20;);
		LoadActor( "ff" )..{
			OnCommand=cmd(diffuse,color("1,0.5,0,1");diffusealpha,0;zoom,2;sleep,0.75;diffusealpha,1;accelerate,0.5;zoom,1;
						linear,0.05;glow,color("1,1,0,1");linear,0.05;glow,color("0,0,0,0");linear,0.05;glow,color("1,1,0,1");
						linear,0.05;glow,color("0,0,0,0");linear,0.05;diffusealpha,0;);
		};

		LoadActor( "failed" )..{
			OnCommand=cmd(cropleft,1;sleep,0.5;sleep,0.5;decelerate,0.5;cropleft,0;
						sleep,0.5;linear,0.05;glow,color("1,1,0,1");linear,0.05;glow,color("0,0,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.05;glow,color("0,0,0,0"););
		};
	};

	LoadActor( THEME:GetPathB("","_black") )..{
		BeginCommand=cmd(FullScreen;);
		OnCommand=cmd(diffusealpha,0;sleep,2;linear,2;diffusealpha,1;);
	};
};

return t;