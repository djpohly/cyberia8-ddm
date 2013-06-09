local index = Var("GameCommand"):GetIndex();
local text = Var("GameCommand"):GetText();
local stext = THEME:GetString( 'ScreenSort', text );

setenv("sortflag",1);

local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	LimitCommand=function(self)
		self:stoptweening();
		GAMESTATE:SetPreferredSongGroup("---Group All---");
		GAMESTATE:SetCurrentSong( newsong );
		GAMESTATE:ApplyGameCommand("sort,Group");
		SCREENMAN:SetNewScreen("ScreenSelectMusic");
	end;

	LoadActor( THEME:GetPathG("_MusicWheelItem","parts/sortsection_jacket") )..{
		InitCommand=cmd(diffusealpha,1;y,100;rotationy,180;rotationz,180;
					diffusetopedge,color("0,0,0,0");diffusebottomedge,color("1,1,1,0.7");zoomto,160,160/4);
	};
	
	LoadActor( THEME:GetPathG("_MusicWheelItem","parts/sortsection_jacket") )..{
		InitCommand=cmd(diffusealpha,1;zoomto,160,160;);
	};

	Def.Quad {
		InitCommand=cmd(y,-70;zoomtowidth,160;zoomtoheight,20;diffuse,color("0,0,0,0.9"););
	};

	LoadActor(THEME:GetPathG("","bannercover1"))..{
		InitCommand=cmd(vertalign,bottom;y,SCREEN_CENTER_Y-220;zoomtowidth,160;zoomtoheight,40;diffusealpha,0.8;blend,'BlendMode_Add';);
	};

	Def.ActorFrame{
		InitCommand=cmd(x,-46;y,-84;zoomy,0;sleep,0.05;accelerate,0.3;zoomy,1;diffuse,color("0.5,1,0.1,0.8"););

		LoadActor(THEME:GetPathG("_MusicWheelItem","parts/down_folder"))..{
			InitCommand=cmd(diffusetopedge,color("0.5,1,0.1,0.8");diffusebottomedge,color("0.5,1,0.1,0"););
		};

		LoadActor(THEME:GetPathG("_MusicWheelItem","parts/up_folder"))..{
		};
	};

	-- title
	LoadFont("_shared2")..{
		InitCommand=cmd(settext,stext;diffuse,GetSortColor(stext);zoom,0.65;maxwidth,225;x,-74;horizalign,left;);
		GainFocusCommand=function(self)
			setenv("SSort",stext);
			setenv("POSort",text);
		end;
		LoseFocusCommand=function(self)
			setenv("CSort",stext);
		end;
	};
	
	LoadActor(THEME:GetPathG("_MusicWheelItem","parts/sort_label"))..{
		InitCommand=cmd(shadowlength,0;x,-42;y,-68;diffuse,color("0.5,1,0.1,0.4"););
	};
};

local function update(self)
	local limit = getenv("Timer");
	if limit <= 10 then
		self:playcommand("Limit");
	end;
end;

t.InitCommand=cmd(SetUpdateFunction,update;);

return t;