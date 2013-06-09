--[[ScreenOptionsFrameSet Scroller]]

local name = Var("GameCommand"):GetName();
local setname = "";

if name == "Default" then setname = "Regular";
elseif name == "Challenge" then setname = "Oni"
elseif name == "Cyan" then setname = "CSC"
elseif name == "Cyan_Special" then setname = "CSC_Special"
else setname = name;
end;

local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_LEFT+(SCREEN_WIDTH*0.125);y,SCREEN_CENTER_Y+14;);
	GainFocusCommand=cmd(zoom,1;);
	LoseFocusCommand=cmd(zoom,0.8;);

	Def.Quad{
		InitCommand=cmd(x,-30;y,4;zoomtowidth,72;zoomtoheight,28;diffuse,color("0,0,0,0.5"););
	};
	
	Def.Sprite{
		InitCommand=function(self)
			(cmd(x,-32;y,5;))(self)
			if name == "Cyan" or name == "Cyan_Special" then
				self:Load(THEME:GetPathG("ScreenGameplay","LifeFrame/"..setname.."_LifeFrame/lifeframe_thum"));
			else
				self:Load(THEME:GetPathG("ScreenGameplay","LifeFrame/"..setname.."_LifeFrame/lifeframe_up_left"));
			end;
		end;
	};

	LoadFont("_Shared2") .. {
		Text=name;
		InitCommand=function(self)
			(cmd(x,12;horizalign,left;zoom,0.95;))(self)
			if name == "Default" then self:diffuse(color("0,1,1,1"));
			else self:diffuse(color("1,1,0,1"));
			end;
		end;
		OnCommand=cmd(cropright,1;sleep,0.001;decelerate,0.2;cropright,0;diffusealpha,1;);
		GainFocusCommand=cmd(finishtweening;visible,true;cropright,1;sleep,0.001;decelerate,0.2;cropright,0;diffusealpha,1;y,-4;);
		LoseFocusCommand=cmd(y,0;);
	};
	LoadFont("Common Normal") .. {
		InitCommand=function(self)
			if name == "Default" then self:diffuse(color("0,1,1,1"));
			else self:diffuse(color("1,1,0,1"));
			end;
			(cmd(visible,true;x,12;horizalign,left;maxwidth,SCREEN_WIDTH;zoom,0.5;y,12;strokecolor,color("0,0,0,1");))(self)
		end;
		OnCommand=cmd(cropright,1;sleep,0.001;decelerate,0.2;cropright,0;diffusealpha,1;);
		GainFocusCommand=function(self)
			self:diffusealpha(1);
			if name == "Default" then self:settext( THEME:GetString("ScreenOptionsFrameSet","InfoDefault") );
			else self:settext(string.format( THEME:GetString("ScreenOptionsFrameSet","InfoOther"),name ));
			end;
			(cmd(finishtweening;cropright,1;sleep,0.001;decelerate,0.2;cropright,0;diffusealpha,1;))(self)
			setenv("setname",name);
		end;
		LoseFocusCommand=cmd(diffusealpha,0;);
	};
};

return t;