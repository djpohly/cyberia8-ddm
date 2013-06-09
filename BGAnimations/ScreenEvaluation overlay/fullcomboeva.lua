local pn = ...
assert(pn);

local t = Def.ActorFrame{};

local pm = GAMESTATE:GetPlayMode();

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:visible(false);
		if pn == PLAYER_1 then
			self:x(SCREEN_CENTER_X * 0.55 - 20);
		else
			self:x(SCREEN_CENTER_X * 1.55 - 20);
		end;
		if THEME:GetMetric( Var "LoadingScreen","Summary" ) == false then
			if pn == PLAYER_1 then
				if getenv("fullcjudgep1") == 1 then self:visible(true);
				end;
			else
				if getenv("fullcjudgep2") == 1 then self:visible(true);
				end;
			end;
		end;
	end;

	LoadActor("lineeffect")..{
	};

	LoadActor(THEME:GetPathG("","combo01"))..{
		InitCommand=cmd(y,SCREEN_CENTER_Y;diffuse,color("0.8,1,0,1");zoom,0;);
		OnCommand=function(self)
			if pm ~= 'PlayMode_Battle' and pm ~= 'PlayMode_Rave' then
				(cmd(linear,0.1;zoomx,5;zoomy,0.3;decelerate,0.6;zoomx,1;accelerate,0.2;zoomy,1;sleep,0.8;linear,0.2;glowshift;effectperiod,0.2;
				effectcolor1,color("1,1,1,0");effectcolor2,color("0.8,0.3,0,1");linear,0.3;zoom,0.35;x,76;y,SCREEN_CENTER_Y-43+16))(self);
			else
				(cmd(linear,0.1;zoomx,5;zoomy,0.3;decelerate,0.6;zoomx,1;accelerate,0.2;zoomy,1;sleep,0.8;linear,0.2;glowshift;effectperiod,0.2;
				effectcolor1,color("1,1,1,0");effectcolor2,color("0.8,0.3,0,1");linear,0.3;zoom,0.35;x,76;y,SCREEN_CENTER_Y-43-20))(self);
			end;
		end;
	};

	LoadActor(THEME:GetPathB("","graph"))..{
		InitCommand=function(self)
			if pm ~= 'PlayMode_Battle' and pm ~= 'PlayMode_Rave' then
				self:x(-108);
			else self:x(-58);
			end;				
			(cmd(y,SCREEN_CENTER_Y-94+16;zoom,0;))(self)
		end;
		OnCommand=cmd(linear,1;zoom,0.4;rotationy,-30;rotationx,70;rotationz,100;spin;effectmagnitude,0,0,-200);
	};
		
	LoadActor(THEME:GetPathB("","graph"))..{
		InitCommand=function(self)
			if pm ~= 'PlayMode_Battle' and pm ~= 'PlayMode_Rave' then
				self:x(-108);
			else self:x(-58);
			end;	
			(cmd(y,SCREEN_CENTER_Y-104+16;diffuse,color("1,0.8,0,1");zoom,0;))(self)
		end;
		OnCommand=cmd(linear,1;zoom,0.4;rotationy,30;rotationx,70;rotationz,100;spin;effectmagnitude,60,100,-200);
	};

	Def.Sprite {
		InitCommand=function(self)
			if pm ~= 'PlayMode_Battle' and pm ~= 'PlayMode_Rave' then
				self:y(SCREEN_CENTER_Y-43+16);
			else
				self:y(SCREEN_CENTER_Y-43-20);
			end;
			(cmd(x,36;horizalign,right;zoom,0.35;zoomy,0;sleep,1.6;linear,0.2;zoomy,0.375;
			glowshift;effectperiod,0.2;effectcolor1,color("1,1,1,0");effectcolor2,color("0.8,0.3,0,1");))(self)
		end;
		OnCommand=function(self)
			local hp = GAMESTATE:IsHumanPlayer(pn);
			local ss = STATSMAN:GetCurStageStats();
			local pss = ss:GetPlayerStageStats(pn);
			if hp then
				if pss:FullComboOfScore('TapNoteScore_W1') == true then
					self:visible(true);
					self:Load(THEME:GetPathB("ScreenEvaluation","overlay/Award FullComboMarvelous"));
				elseif pss:FullComboOfScore('TapNoteScore_W2') == true then
					self:visible(true);
					self:Load(THEME:GetPathB("ScreenEvaluation","overlay/Award FullComboPerfects"));
				elseif pss:FullComboOfScore('TapNoteScore_W3') == true then
					self:visible(true);
					self:Load(THEME:GetPathB("ScreenEvaluation","overlay/Award FullComboGreates"));
				else
					self:visible(false);
				end;
			end;
		end;
	};
};

return t;