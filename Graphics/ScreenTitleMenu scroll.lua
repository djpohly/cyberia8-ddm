local gc = Var("GameCommand");
local s = THEME:GetString( 'ScreenTitleMenu', gc:GetText() );
local t = Def.ActorFrame {
	LoadFont("_titleMenu_scroller") ..{
		InitCommand=cmd(uppercase,true;settext,s;horizalign,right;shadowlength,2;zoom,0.8;);
		GainFocusCommand=cmd(stoptweening;diffuseshift;effectperiod,0.4;effectcolor1,color("1,1,0,1");effectcolor2,color("1,0.4,0,1");linear,0.15;zoomx,0.8;zoomy,1;);
		LoseFocusCommand=cmd(stoptweening;stopeffect;linear,0.15;zoom,0.8;diffuse,color("0.75,0.75,0.75,1"));
		DisabledCommand=cmd(diffuse,color("0.5,0.5,0.5,1"));
	};
	
	LoadFont("Common Normal") ..{
		InitCommand=function(self)
			if s == "Credits" then
				if GetAdhocPref("CSCreditFlag") == 1 or getenv("CSCreditFlag") == 1 then
					(cmd(visible,true;uppercase,true;settext,"New!";addx,2;addy,-6;horizalign,left;
					shadowlength,2;diffuse,color("1,0,1,1");strokecolor,color("1,1,0,1");zoom,0.45;))(self)
				else self:visible(false);
				end;
			end;
		end;
		DisabledCommand=cmd(diffuse,color("0.5,0.5,0.5,1"));
	};
	
	LoadFont("Common Normal") ..{
		InitCommand=function(self)
			if s == "Options" then
				if GetAdhocPref("CSFrameFlag") == 1 or getenv("CSFrameFlag") == 1 then
					(cmd(visible,true;uppercase,true;settext,"New!";addx,2;addy,-6;horizalign,left;
					shadowlength,2;diffuse,color("1,0,1,1");strokecolor,color("1,1,0,1");zoom,0.45;))(self)
				else self:visible(false);
				end;
			end;
		end;
		DisabledCommand=cmd(diffuse,color("0.5,0.5,0.5,1"));
	};
};

return t;
