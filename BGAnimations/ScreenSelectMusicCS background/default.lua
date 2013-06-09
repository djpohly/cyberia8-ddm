--[[ScreenSelectMusicCS background]]

local ssStats = STATSMAN:GetPlayedStageStats(1);
local group = ssStats:GetPlayedSongs()[1]:GetGroupName();

local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	Def.Quad {
		InitCommand=cmd(FullScreen;diffuse,color("0,1,1,0.5");diffuserightedge,color("0,1,1,0"););
	};
};

local bg = GetGroupParameter(group,"Extra1BackGround");
local fn = split("%.",bg);

if bg~="" and FILEMAN:DoesFileExist("/Songs/"..group.."/"..bg)  then
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(fov,100;);
		LoadActor("/Songs/"..group.."/"..bg) .. {
			InitCommand=cmd(x,SCREEN_WIDTH*0.5;y,SCREEN_CENTER_Y;rotationx,200;rotationy,-130;rotationz,-150;
						diffusealpha,0.7;diffuserightedge,color("0.7,0.7,0.7,0"));
			OnCommand=cmd(zoom,1.5;sleep,0.2;decelerate,0.5;zoom,0.75;);
		};
	};
elseif bg~="" and FILEMAN:DoesFileExist("/AdditionalSongs/"..group.."/"..bg) then
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(fov,100;);
		LoadActor("/AdditionalSongs/"..group.."/"..bg) .. {
			InitCommand=cmd(x,SCREEN_WIDTH*0.5;y,SCREEN_CENTER_Y;rotationx,200;rotationy,-130;rotationz,-150;
						diffusealpha,0.7;diffuserightedge,color("0.7,0.7,0.7,0"));
			OnCommand=cmd(zoom,1.5;sleep,0.2;decelerate,0.5;zoom,0.75;);
		};
	};
end;

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(fov,100;x,SCREEN_CENTER_X+300;y,SCREEN_CENTER_Y;rotationx,-10;rotationy,-10;rotationz,10;);
	OnCommand=cmd(zoom,1.5;decelerate,0.5;zoom,1;);
	LoadActor("cs_o")..{
		InitCommand=function(self)
			(cmd(fadeleft,0.2;faderight,0.2;diffuseshift;effectcolor1,color("0,0.3,0.4,0.8");effectcolor2,color("0,0.8,0.9,0.8");effectperiod,12))(self)
		end;
	};
};

t[#t+1] = Def.ActorFrame{
	LoadActor("11")..{
		InitCommand=cmd(x,SCREEN_RIGHT-50;CenterY;diffusealpha,0.7;zoomto,14,SCREEN_HEIGHT;customtexturerect,0,0,1,SCREEN_HEIGHT/self:GetHeight());
		OnCommand=cmd(texcoordvelocity,0,0.05;);
	};

	LoadActor("12")..{
		InitCommand=cmd(x,SCREEN_RIGHT-56;CenterY;diffusealpha,0.5;zoomto,14,SCREEN_HEIGHT;customtexturerect,0,0,1,SCREEN_HEIGHT/self:GetHeight());
		OnCommand=cmd(texcoordvelocity,0,0.2;);
	};

	LoadActor("13")..{
		InitCommand=cmd(x,SCREEN_RIGHT-30;CenterY;diffusealpha,0.8;zoomto,14,SCREEN_HEIGHT;customtexturerect,0,0,1,SCREEN_HEIGHT/self:GetHeight());
		OnCommand=cmd(texcoordvelocity,0,-0.15;);
	};
};

t[#t+1] = LoadActor( THEME:GetPathB("","underlay") )..{
};



return t;