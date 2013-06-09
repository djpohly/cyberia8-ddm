local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{

	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0.7,1,0.4"););
	};
	
	LoadActor( THEME:GetPathB("","back_effect/left_effect" ) )..{
		InitCommand=cmd(horizalign,left;zoomtoheight,SCREEN_HEIGHT;x,SCREEN_LEFT*0.1;y,SCREEN_CENTER_Y+100;zoom,1.5;);
		OnCommand=cmd(addy,20;linear,0.8;addy,-20;);
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
		InitCommand=cmd(rotationz,-90;x,SCREEN_LEFT;y,SCREEN_CENTER_Y+30;);
		LoadActor(THEME:GetPathB("",pload()))..{
			InitCommand=cmd(y,yset();diffuse,color("0.1,1,1,0.6"););
		};
	};
end;

t[#t+1] = Def.ActorFrame{
	LoadActor( THEME:GetPathB("","back_effect/ver8" ) )..{
		InitCommand=cmd(horizalign,left;x,SCREEN_WIDTH*0.11;y,SCREEN_CENTER_Y+14;zoom,0.5;diffuse,color("0,1,1,0.7"););
	};
	
	LoadActor( THEME:GetPathB("","back_effect/cs8" ) )..{
		InitCommand=cmd(horizalign,left;x,SCREEN_WIDTH*0.11;y,SCREEN_CENTER_Y;diffuse,color("1,0.5,0,0.7");diffuseleftedge,color("1,1,0,0.7");zoom,0.75;);
	};
};

return t;