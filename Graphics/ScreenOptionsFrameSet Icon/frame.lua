local frame = {
	"Regular",
	"Nonstop",
	"Oni",
	"Endless",
	"Rave",
};

local name = Var("GameCommand"):GetName();
local newname = "";
local setname = "";

if name == "Default" then setname = frame[math.random(#frame)];
elseif name == "Challenge" then setname = "Oni"
elseif name == "Cyan" then setname = "CSC"
elseif name == "Cyan_Special" then setname = "CSC_Special"
else setname = name;
end;

local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	--scoreframe_player1
	Def.ActorFrame{
		InitCommand=cmd(y,SCREEN_BOTTOM-30-70;);
		GainFocusCommand=cmd(addx,SCREEN_WIDTH*0.4;zoomx,0;zoomy,0.3;decelerate,0.4;addx,-SCREEN_WIDTH*0.4;zoomx,1;accelerate,0.125;zoomy,1;);

		LoadActor(THEME:GetPathG("ScreenGameplay","ScoreFrame/"..setname.."_ScoreFrame/scoreframe_width"))..{
			GainFocusCommand=cmd(y,2;zoomx,1;zoomtowidth,SCREEN_WIDTH/2-257-59;horizalign,left;x,SCREEN_LEFT+188;sleep,0.5;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
		LoadActor(THEME:GetPathG("ScreenGameplay","ScoreFrame/"..setname.."_ScoreFrame/scoreframe_left"))..{
			GainFocusCommand=cmd(horizalign,left;zoomx,1;x,SCREEN_LEFT/2;sleep,0.5;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
		LoadActor(THEME:GetPathG("ScreenGameplay","ScoreFrame/"..setname.."_ScoreFrame/scoreframe_right"))..{
			GainFocusCommand=cmd(y,-2;horizalign,right;zoomx,1;x,SCREEN_CENTER_X-52;sleep,0.5;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
	};

	--scoreframe_player2
	Def.ActorFrame{
		InitCommand=cmd(y,SCREEN_BOTTOM-30-70;);
		GainFocusCommand=cmd(addx,SCREEN_WIDTH*0.6;zoomx,0;zoomy,0.3;decelerate,0.4;addx,-SCREEN_WIDTH*0.6;zoomx,1;accelerate,0.125;zoomy,1;);

		LoadActor(THEME:GetPathG("ScreenGameplay","ScoreFrame/"..setname.."_ScoreFrame/scoreframe_width"))..{
			GainFocusCommand=cmd(y,2;zoomx,-1;zoomtowidth,SCREEN_WIDTH/2-257-59;horizalign,right;x,SCREEN_RIGHT-188;sleep,0.5;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
		LoadActor(THEME:GetPathG("ScreenGameplay","ScoreFrame/"..setname.."_ScoreFrame/scoreframe_left"))..{
			GainFocusCommand=cmd(horizalign,left;zoomx,-1;x,SCREEN_RIGHT+2/2-1;sleep,0.5;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
		LoadActor(THEME:GetPathG("ScreenGameplay","ScoreFrame/"..setname.."_ScoreFrame/scoreframe_right"))..{
			GainFocusCommand=cmd(y,-2;horizalign,right;zoomx,-1;x,SCREEN_CENTER_X+52;sleep,0.5;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
	};

	--bpmframe_player1
	LoadActor(THEME:GetPathG("ScreenGameplay","ScoreFrame/"..setname.."_ScoreFrame/bpmframe"))..{
		GainFocusCommand=cmd(x,SCREEN_CENTER_X-66-38;y,SCREEN_BOTTOM-9-70;zoom,1;addx,40;diffusealpha,0;sleep,0.6;decelerate,0.3;addx,-40;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
	};
	LoadActor(THEME:GetPathG("ScreenGameplay","ScoreFrame/bpm_dis"))..{
		GainFocusCommand=cmd(x,SCREEN_CENTER_X-80;y,SCREEN_BOTTOM-8-70;zoom,1;diffusealpha,0;sleep,0.65;linear,0.3;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
	};

	--bpmframe_player2
	LoadActor(THEME:GetPathG("ScreenGameplay","ScoreFrame/"..setname.."_ScoreFrame/bpmframe"))..{
		GainFocusCommand=cmd(rotationy,180;x,SCREEN_CENTER_X+66+38;y,SCREEN_BOTTOM-9-70;zoom,1;addx,-40;diffusealpha,0;sleep,0.6;decelerate,0.3;addx,40;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
	};
	LoadActor(THEME:GetPathG("ScreenGameplay","ScoreFrame/bpm_dis"))..{
		GainFocusCommand=cmd(x,SCREEN_CENTER_X+80;y,SCREEN_BOTTOM-8-70;zoom,1;diffusealpha,0;sleep,0.65;linear,0.3;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
	};

	--songmeter_banner
	LoadActor(THEME:GetPathG("ScreenGameplay","ScoreFrame/"..setname.."_ScoreFrame/bannerframe"))..{
		GainFocusCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-15-70;diffusealpha,0;addy,-30;sleep,0.5;decelerate,0.3;addy,30;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
	};

	--ramp
	LoadActor(THEME:GetPathG("ScreenGameplay","ScoreFrame/scoreframe_ramp"))..{
		InitCommand=cmd(diffuse,color("1,0,0,0.5");horizalign,left;x,SCREEN_LEFT+18;y,SCREEN_BOTTOM-31-70;);
		GainFocusCommand=cmd(diffusealpha,0;sleep,0.8;linear,0.2;diffusealpha,1;queuecommand,"Repeat";);
		RepeatCommand=cmd(diffuse,color("1,0,0,0.5");linear,0.5;diffuse,PlayerColor(PLAYER_1);linear,4.5;diffuse,color("1,0,0,0.5");queuecommand,"Repeat";);
	};

	LoadActor(THEME:GetPathG("ScreenGameplay","ScoreFrame/scoreframe_ramp"))..{
		InitCommand=cmd(diffuse,color("1,0,0,0.5");horizalign,left;zoomx,-1;x,SCREEN_RIGHT-18;y,SCREEN_BOTTOM-31-70;);
		GainFocusCommand=cmd(diffusealpha,0;sleep,0.8;linear,0.2;diffusealpha,1;queuecommand,"Repeat";);
		RepeatCommand=cmd(diffuse,color("1,0,0,0.5");linear,0.5;diffuse,PlayerColor(PLAYER_2);linear,4.5;diffuse,color("1,0,0,0.5");queuecommand,"Repeat";);
	};

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	Def.ActorFrame{
		InitCommand=cmd(y,SCREEN_TOP+35+65;);
		Def.Quad{
			InitCommand=cmd(x,SCREEN_CENTER_X-60;zoomtowidth,SCREEN_WIDTH/2-80;diffuse,color("0,0,0,0.5"));
			GainFocusCommand=cmd(horizalign,right;zoomtoheight,0;sleep,0.8;linear,0.2;zoomtoheight,12;);
		};
		Def.Quad{
			InitCommand=cmd(x,SCREEN_CENTER_X+60;zoomtowidth,SCREEN_WIDTH/2-80;diffuse,color("0,0,0,0.5"));
			GainFocusCommand=cmd(horizalign,left;zoomtoheight,0;sleep,0.8;linear,0.2;zoomtoheight,12;);
		};
	};
	
	--percentcover
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+15+65;);
		LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/"..setname.."_LifeFrame/percentframe_cover"))..{
			GainFocusCommand=cmd(horizalign,right;x,-54;diffusealpha,0;addx,30;sleep,0.5;accelerate,0.4;diffusealpha,1;addx,-30;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
		LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/"..setname.."_LifeFrame/percentframe_cover"))..{
			GainFocusCommand=cmd(horizalign,right;zoomx,-1;x,54;diffusealpha,0;addx,-30;sleep,0.5;accelerate,0.4;diffusealpha,1;addx,30;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
	};

	LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/"..setname.."_LifeFrame/stageframe"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+21+65;);
		GainFocusCommand=cmd(cropbottom,1;addy,-60;zoomy,0;sleep,0.3;decelerate,0.3;cropbottom,0;addy,120/2;zoomy,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
	};

	--lifeframe_player1
	Def.ActorFrame{
		GainFocusCommand=function(self)
			if name == "Cyan" or name == "Cyan_Special" then self:y(SCREEN_TOP+35+65-8);
			else self:y(SCREEN_TOP+35+65);
			end;
			(cmd(addx,SCREEN_WIDTH*0.6;zoomx,0;zoomy,0.3;accelerate,0.6;addx,-SCREEN_WIDTH*0.6;zoomx,1;decelerate,0.1;zoomy,1;))(self)
		end;
		
		LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/"..setname.."_LifeFrame/lifeframe_up_width"))..{
			GainFocusCommand=cmd(zoomtowidth,SCREEN_WIDTH/2-183-138;horizalign,left;x,SCREEN_LEFT+76;sleep,0.7;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};

		LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/"..setname.."_LifeFrame/lifeframe_up_left"))..{
			GainFocusCommand=cmd(horizalign,left;x,SCREEN_LEFT/2;sleep,0.7;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};

		LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/"..setname.."_LifeFrame/lifeframe_down_right"))..{
			GainFocusCommand=cmd(horizalign,right;x,SCREEN_CENTER_X-41;sleep,0.7;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
	};

	--lifeframe_player2
	Def.ActorFrame{
		GainFocusCommand=function(self)
			if name == "Cyan" or name == "Cyan_Special" then self:y(SCREEN_TOP+35+65-8);
			else self:y(SCREEN_TOP+35+65);
			end;
			(cmd(addx,SCREEN_WIDTH*0.4;zoomx,0;zoomy,0.3;accelerate,0.6;addx,-SCREEN_WIDTH*0.4;zoomx,1;decelerate,0.1;zoomy,1;))(self)
		end;
		
		LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/"..setname.."_LifeFrame/lifeframe_up_width"))..{
			GainFocusCommand=cmd(zoomx,-1;zoomtowidth,SCREEN_WIDTH/2-183-137;horizalign,right;x,SCREEN_RIGHT-75;sleep,0.7;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};

		LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/"..setname.."_LifeFrame/lifeframe_up_left"))..{
			GainFocusCommand=cmd(horizalign,left;zoomx,-1;x,SCREEN_RIGHT-2/2+1;sleep,0.7;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};

		LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/"..setname.."_LifeFrame/lifeframe_down_right"))..{
			GainFocusCommand=cmd(horizalign,right;zoomx,-1;x,SCREEN_CENTER_X+41;sleep,0.7;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
	};

	--stage
	LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/stage"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+24;y,SCREEN_TOP+38+65;);
		GainFocusCommand=cmd(diffusealpha,0;addx,-20;sleep,0.5;accelerate,0.4;diffusealpha,1;addx,20;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
	};

	--ramp
	LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/lifeframe_ramp"))..{
		InitCommand=cmd(diffuse,color("1,0,0,0.5");horizalign,left;x,SCREEN_LEFT-1;y,SCREEN_TOP+33+65;);
		GainFocusCommand=cmd(diffusealpha,0;sleep,0.8;linear,0.2;diffusealpha,1;queuecommand,"Repeat";);
		RepeatCommand=cmd(diffuse,color("1,0,0,0.5");linear,0.5;diffuse,PlayerColor(PLAYER_1);linear,4.5;diffuse,color("1,0,0,0.5");queuecommand,"Repeat";);
	};

	LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/lifeframe_ramp"))..{
		InitCommand=cmd(diffuse,color("1,0,0,0.5");horizalign,left;zoomx,-1;x,SCREEN_RIGHT+1;y,SCREEN_TOP+33+65;);
		GainFocusCommand=cmd(diffusealpha,0;sleep,0.8;linear,0.2;diffusealpha,1;queuecommand,"Repeat";);
		RepeatCommand=cmd(diffuse,color("1,0,0,0.5");linear,0.5;diffuse,PlayerColor(PLAYER_2);linear,4.5;diffuse,color("1,0,0,0.5");queuecommand,"Repeat";);
	};
};


t.InitCommand=cmd(SetUpdateFunction,update;);
t.GainFocusCommand=cmd(visible,true;);
t.LoseFocusCommand=cmd(finishtweening;visible,false;);

return t;
