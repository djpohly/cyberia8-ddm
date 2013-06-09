--[[_background_parts]]

local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(fov,100);

--over
--lefttopblackline
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X-320;y,SCREEN_CENTER_Y-140;rotationz,45;diffuse,color("0,0,0,0.7");diffusetopedge,color("0,0,0,0.5"););
		Def.Quad {
			InitCommand=cmd(zoomtowidth,30;zoomtoheight,SCREEN_HEIGHT*2.3;);
			OnCommand=cmd(cropbottom,1;croptop,0;sleep,0.15;linear,0.25;cropbottom,0;);
			OffCommand=cmd(finishtweening;);
		};
		
		Def.Quad {
			InitCommand=cmd(x,40;zoomtowidth,30;zoomtoheight,SCREEN_HEIGHT*2.2;);
			OnCommand=cmd(cropbottom,1;croptop,0;sleep,0.2;linear,0.25;cropbottom,0;);
			OffCommand=cmd(finishtweening;);
		};
	};
--rightbottomblackline
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X+639;y,SCREEN_CENTER_Y-140;rotationz,45;);
		Def.Quad {
			InitCommand=cmd(zoomtowidth,30;zoomtoheight,SCREEN_HEIGHT*2.4;diffuse,color("0,0,0,0.6");diffusetopedge,color("0,0,0,0.4"););
			OnCommand=cmd(cropbottom,1;croptop,-0.3;sleep,0.1;linear,0.25;cropbottom,-0.3;);
			OffCommand=cmd(finishtweening;);
		};
		
		Def.Quad {
			InitCommand=cmd(x,60;y,-120;zoomtowidth,60;zoomtoheight,SCREEN_HEIGHT*2.65;diffuse,color("0,0,0,0.6");diffusetopedge,color("0,0,0,0.4"););
			OnCommand=cmd(cropbottom,1;croptop,0;sleep,0.05;linear,0.25;cropbottom,0;);
			OffCommand=cmd(finishtweening;);
		};
	};
--_dline_3
	Def.ActorFrame{
		InitCommand=cmd(rotationz,45;x,SCREEN_CENTER_X+387;y,SCREEN_CENTER_Y+198;);
		LoadActor(THEME:GetPathB("","_background_parts/_dline_3"))..{
			InitCommand=cmd(diffuse,color("0,1,1,0.6");cropbottom,1;croptop,0;sleep,0.4;decelerate,0.2;cropbottom,-0;);
			OffCommand=cmd(finishtweening;);
		};
	};
};
--_vline
for i = 1, 3 do
	local function sleepwait()
		local wait = 0.1 * i;
		return wait
	end;
	local function yset()
		local y = 180 * i;
		return y
	end;
	local function pload()
		local picload = "_background_parts/_vline_1";
		if i == 2 then
			picload = "_background_parts/_vline_2";
		else
			picload = "_background_parts/_vline_1";
		end;
		return picload
	end;

	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(fov,100;rotationz,45;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-300;);
		LoadActor(THEME:GetPathB("",pload()))..{
			InitCommand=cmd(blend,'BlendMode_Add';y,yset();addx,60;diffusealpha,0;sleep,sleepwait();decelerate,0.15;addx,-60;diffusealpha,0.6;);
			OffCommand=cmd(finishtweening;);
		};
	};
end;
--_dline_1
for i = 1, 3 do
	local function sleepwait()
		local wait = 0.1 * i;
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
		InitCommand=cmd(fov,100;rotationz,45;x,SCREEN_CENTER_X-62;y,SCREEN_CENTER_Y-340;);
		LoadActor(THEME:GetPathB("",pload()))..{
			InitCommand=cmd(y,yset();diffuse,color("0.1,1,1,0.6");cropbottom,1;croptop,-0.3;sleep,0.3+sleepwait();decelerate,0.15;cropbottom,-0.3;);
			OffCommand=cmd(finishtweening;);
		};
	};
end;
--_dline_2_lefttop
for i = 1, 5 do
	local function sleepwait()
		local wait = 0.1 * i;
		return wait
	end;
	local function yset()
		local y = 60 * i;
		return y
	end;
	local function pload()
		local picload = "_background_parts/_dline_2";
		return picload
	end;

	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(fov,100;rotationz,45;x,SCREEN_CENTER_X-200;y,SCREEN_CENTER_Y-260;);
		LoadActor(THEME:GetPathB("",pload()))..{
			InitCommand=cmd(y,yset();diffuse,color("0.2,1,1,0.7");cropbottom,1;croptop,-0.3;sleep,0.2+sleepwait();decelerate,0.15;cropbottom,-0.3;);
			OffCommand=cmd(finishtweening;);
		};
	};
end;
--_dline_2_rightbottom
for i = 1, 4 do
	local function sleepwait()
		local wait = 0.1 * i;
		return wait
	end;
	local function yset()
		local y = 60 * i;
		return y
	end;
	local function pload()
		local picload = "_background_parts/_dline_2";
		return picload
	end;

	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(fov,100;rotationx,180;rotationy,180;rotationz,45;x,SCREEN_CENTER_X+228;y,SCREEN_CENTER_Y+272;);
		LoadActor(THEME:GetPathB("",pload()))..{
			InitCommand=cmd(y,yset();diffuse,color("0.3,1,1,0.5");cropbottom,1;croptop,-0.3;sleep,0.3+sleepwait();decelerate,0.15;cropbottom,-0.3;);
			OffCommand=cmd(finishtweening;);
		};
	};
end;
--over

return t;