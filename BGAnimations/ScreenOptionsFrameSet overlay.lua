local t = Def.ActorFrame{};
local key_open = 0;

t[#t+1] = Def.ActorFrame {
	CodeCommand=function(self,params)
		if (params.Name=="Start" or params.Name=="Center") then
			if key_open == 1 then
				self:playcommand("Start");
			end;
		end;
	end;
	LoadActor(THEME:GetPathS("Common","start")) .. {
		StartCommand=function(self)
			self:stop();
			self:play();
		end;
	};
};

t[#t+1] = Def.ActorFrame{
	--InitCommand=cmd(playcommand,"On");
	OnCommand=function(self)
		(cmd(stoptweening;linear,0.5;playcommand,"Key"))(self)
	end;
	KeyCommand=function(self)
		key_open = 1;
	end;
	CodeMessageCommand = function(self, params)
		if (params.Name=="Start" or params.Name=="Center") then
			if key_open == 1 then
				self:queuecommand("SelectN");
				key_open = 2;
			end;
		end;
	end;
	SelectNCommand=cmd(stoptweening;linear,0.5;queuecommand,"NextScreen");
	NextScreenCommand=function(self)
		SetAdhocPref("FrameSet", getenv("setname"));
		SCREENMAN:SetNewScreen("ScreenOptionsService");
	end;
	
	Def.Quad{
		SelectNCommand=cmd(Center;diffuse,color("0,1,1,0.4");zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;fadetop,0.2;fadebottom,0.2;
				decelerate,0.2;fadetop,0;fadebottom,0;zoomtoheight,SCREEN_HEIGHT;linear,0.2;diffuse,color("0,0,0,0"););
	};

	Def.Quad{
		SelectNCommand=cmd(diffuse,color("0,0,0,0");x,SCREEN_CENTER_X;y,SCREEN_TOP;vertalign,top;zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;
				accelerate,0.2;diffuse,color("0,0,0,1");zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT/2+10);
	};

	Def.Quad{
		SelectNCommand=cmd(diffuse,color("0,0,0,0");x,SCREEN_CENTER_X;y,SCREEN_BOTTOM;vertalign,bottom;zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;
				accelerate,0.2;diffuse,color("0,0,0,1");zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT/2+10);
	};
};


return t;