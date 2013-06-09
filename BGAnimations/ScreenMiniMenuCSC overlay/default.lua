local t = Def.ActorFrame{};

local selection = "No";
local sflag = "Yes";

t[#t+1] = Def.ActorFrame {
	CodeCommand=function(self,params)
		if sflag == "Yes" and ( params.Name == "Back" or params.Name == 'Start' or params.Name == 'Center' ) then
			sflag = "No";
			self:queuecommand("Off");
		end;
		if sflag == "Yes" and ( params.Name == "Left" or params.Name == "Left2" or params.Name == "Right" or params.Name == "Right2" ) then
			self:queuecommand("Change");
		end;
	end;
	LoadActor(THEME:GetPathS("ScreenTitleMenu","change")) .. {
		ChangeCommand=function(self)
			self:stop();
			self:play();
		end;
	};
	LoadActor(THEME:GetPathS("","_swoosh")) .. {
		OnCommand=function(self)
			self:stop();
			self:play();
		end;
		OffCommand=function(self)
			self:stop();
			self:play();
		end;
	};
};

t[#t+1] =Def.ActorFrame{
	InitCommand=cmd(y,SCREEN_CENTER_Y+120;);
	LimitCommand=function(self)
		self:stoptweening();
		SCREENMAN:GetTopScreen():PostScreenMessage('SM_GoToPrevScreen',0);
	end;
	CodeMessageCommand=function(self,params)
		if params.Name == "Back" or params.Name == 'Start' or params.Name == 'Center' then
			self:playcommand("Off");
			SCREENMAN:GetTopScreen():PostScreenMessage('SM_GoToPrevScreen',1);
		end;
	end;
	Def.Quad{
		InitCommand=cmd(CenterX;diffuse,color("0,0,0,1");diffusebottomedge,color("0,0.5,0.5,1");diffusealpha,0;zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;);
		OnCommand=cmd(zoomtoheight,0;accelerate,0.2;zoomtoheight,120;diffusealpha,0.85;);
		OffCommand=cmd(finishtweening;zoomtoheight,140;decelerate,0.3;zoomtoheight,SCREEN_HEIGHT/2;diffusealpha,0;);
	};
	LoadActor("t_line")..{
		InitCommand=cmd(CenterX;y,-60;diffuse,color("1,0.75,0,1");diffusebottomedge,color("1,1,0,1");diffusealpha,0;zoomtowidth,0;);
		OnCommand=cmd(accelerate,0.2;zoomtowidth,SCREEN_WIDTH;diffusealpha,1;);
		OffCommand=cmd(finishtweening;decelerate,0.3;zoomtowidth,0;diffusealpha,0;);
	};
	LoadActor("u_line")..{
		InitCommand=cmd(CenterX;y,60;diffuse,color("1,0.75,0,1");diffusetopedge,color("1,1,0,1");diffusealpha,0;zoomtowidth,0;);
		OnCommand=cmd(accelerate,0.2;zoomtowidth,SCREEN_WIDTH;diffusealpha,1;);
		OffCommand=cmd(finishtweening;decelerate,0.3;zoomtowidth,0;diffusealpha,0;);
	};
	LoadActor("attention")..{
		InitCommand=cmd(CenterX;y,-60;diffusealpha,0;zoomy,1;);
		OnCommand=cmd(zoomx,10;decelerate,0.2;zoomx,1;diffusealpha,1;glow,color("1,0.5,0,1");linear,0.3;glow,color("0,0,0,0"););
		OffCommand=cmd(finishtweening;linear,0.2;zoomy,0;);
	};
	
	Def.ActorFrame{
		InitCommand=cmd(y,-22;);
		LoadFont("_Shared2")..{
			InitCommand=cmd(zoom,0.9;x,SCREEN_CENTER_X-10;y,-13;diffuse,color("1,0.5,0,1");diffusetopedge,color("1,1,0.2,1");strokecolor,color("0,0,0,1");maxwidth,SCREEN_WIDTH*0.95;
						settext,""..THEME:GetString("MusicWheel","CustomItemCSCText").." "..THEME:GetString("MusicWheel","Att1Text").."";);
			OnCommand=cmd(diffusealpha,0;visible,true;decelerate,0.3;x,SCREEN_CENTER_X;diffusealpha,1;);
			OffCommand=cmd(finishtweening;visible,false;diffusealpha,0;);
		};
		
		LoadFont("_Shared2")..{
			InitCommand=cmd(zoom,0.9;x,SCREEN_CENTER_X+10;y,13;diffuse,color("1,1,1,1");strokecolor,color("0,0,0,1");maxwidth,SCREEN_WIDTH*0.95;
						settext,""..THEME:GetString("MusicWheel","Att2Text").."";);
			OnCommand=cmd(diffusealpha,0;visible,true;decelerate,0.3;x,SCREEN_CENTER_X;diffusealpha,1;);
			OffCommand=cmd(finishtweening;visible,false;diffusealpha,0;);
		};
	};
--Yes
	Def.ActorFrame{
		InitCommand=function(self,params)
			self:y(34);
			if selection == "Yes" then
				self:playcommand("GainFocus");
			else
				self:playcommand("LoseFocus");
			end;
		end;
		CodeMessageCommand=function(self,params)
			if selection == "Yes" then
				if getenv("csflag") == 1 then
					if params.Name == 'Start' or params.Name == 'Center' then
						MESSAGEMAN:Broadcast("StartButton");
						--SCREENMAN:SetNewScreen("ScreenCSOpen");
						--SCREENMAN:GetTopScreen():PostScreenMessage('SM_GoToNextScreen',0);
						--SCREENMAN:ReloadOverlayScreens();
						setenv("csflag",2);
						SCREENMAN:GetTopScreen():PostScreenMessage('SM_GoToPrevScreen',0);
					end;
				end;
			end;
			if params.Name == "Back" then
				setenv("csflag",0);
				self:playcommand("Off");
				SCREENMAN:GetTopScreen():PostScreenMessage('SM_GoToPrevScreen',1);
			elseif params.Name == "Right" or params.Name == "Right2" then
				self:playcommand("LoseFocus");
				selection = "No";
			elseif params.Name == "Left" or params.Name == "Left2" then
				self:playcommand("GainFocus");
				selection = "Yes";
			end;
		end;
		LoadActor("cursor_high")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-100;blend,'BlendMode_Add';diffuseshift;effectcolor1,color("1,0.5,0,0.5");effectcolor2,color("1,1,0,1");effectperiod,2.5;);
			GainFocusCommand=cmd(diffusealpha,1;);
			LoseFocusCommand=cmd(diffusealpha,0;);
			OnCommand=cmd(diffusealpha,0;visible,true;decelerate,0.3;diffusealpha,0;);
			OffCommand=cmd(finishtweening;visible,false;diffusealpha,0;);
		};
		
		LoadActor("cursor_back")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-100;diffuse,color("0,0,0,0.75"););
			GainFocusCommand=cmd(diffuse,color("0.7,0.5,0,0.75"););
			LoseFocusCommand=cmd(diffuse,color("0,0,0,0.75"););
			OnCommand=cmd(diffusealpha,0;visible,true;decelerate,0.3;diffuse,color("0,0,0,0.75"););
			OffCommand=cmd(finishtweening;visible,false;diffusealpha,0;);
		};

		LoadFont("_Shared2")..{
			InitCommand=cmd(zoom,0.9;x,SCREEN_CENTER_X-100;diffuse,color("0.75,0.35,0,1");strokecolor,color("0,0,0,1");
						settext,""..THEME:GetString("MusicWheel","YesText").."";);
			GainFocusCommand=cmd(diffuse,color("0,1,1,1"););
			LoseFocusCommand=cmd(diffuse,color("1,0.5,0,1"););
			OnCommand=cmd(diffusealpha,0;visible,true;sleep,0.1;decelerate,0.3;diffusealpha,1;);
			OffCommand=cmd(finishtweening;visible,false;diffusealpha,0;);
		};
	};
--No
	Def.ActorFrame{
		InitCommand=function(self,params)
			self:y(34);
			if selection == "No" then
				self:playcommand("GainFocus");
			else
				self:playcommand("LoseFocus");
			end;
		end;
		CodeMessageCommand=function(self,params)
			if selection == "No" then
				if params.Name == 'Start' or params.Name == 'Center' then
					setenv("csflag",0);
					self:playcommand("Off");
					SCREENMAN:GetTopScreen():PostScreenMessage('SM_GoToPrevScreen',1);
				end;
			end;
			if params.Name == "Back" then
				setenv("csflag",0);
				self:playcommand("Off");
				SCREENMAN:GetTopScreen():PostScreenMessage('SM_GoToPrevScreen',1);
			elseif params.Name == "Left" or params.Name == "Left2" then
				self:playcommand("LoseFocus");
				selection = "Yes";
			elseif params.Name == "Right" or params.Name == "Right2" then
				self:playcommand("GainFocus");
				selection = "No";
			end;

		end;
		LoadActor("cursor_high")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+100;blend,'BlendMode_Add';diffuseshift;effectcolor1,color("1,0.5,0,0.5");effectcolor2,color("1,1,0,1");effectperiod,2.5;);
			GainFocusCommand=cmd(diffusealpha,1;);
			LoseFocusCommand=cmd(diffusealpha,0;);
			OnCommand=cmd(diffusealpha,0;visible,true;decelerate,0.3;diffusealpha,1;);
			OffCommand=cmd(finishtweening;visible,false;diffusealpha,0;);
		};
		
		LoadActor("cursor_back")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+100;diffuse,color("0.7,0.5,0,0.75"););
			GainFocusCommand=cmd(diffuse,color("0.7,0.5,0,0.75"););
			LoseFocusCommand=cmd(diffuse,color("0,0,0,0.75"););
			OnCommand=cmd(diffusealpha,0;visible,true;decelerate,0.3;diffuse,color("0.7,0.5,0,0.75"););
			OffCommand=cmd(finishtweening;visible,false;diffusealpha,0;);
		};

		LoadFont("_Shared2")..{
			InitCommand=cmd(zoom,0.9;x,SCREEN_CENTER_X+100;diffuse,color("0,1,1,1");strokecolor,color("0,0,0,1");
						settext,""..THEME:GetString("MusicWheel","NoText").."";);
			OnCommand=cmd(diffusealpha,0;visible,true;sleep,0.1;decelerate,0.3;diffusealpha,1;);
			GainFocusCommand=cmd(diffuse,color("0,1,1,1"););
			LoseFocusCommand=cmd(diffuse,color("1,0.5,0,1"););
		
			OffCommand=cmd(finishtweening;visible,false;diffusealpha,0;);
		};
	};
};

local function update(self)
	local limit = getenv("Timer");
	if limit <= 3 then
		self:playcommand("Limit");
	else
		SCREENMAN:GetTopScreen():PostScreenMessage( 'SM_MenuTimer', ( string.format("%2i", getenv("Timer") ) ) );	
	end;
end;

t.InitCommand=cmd(SetUpdateFunction,update;);

return t;