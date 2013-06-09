
local t = Def.ActorFrame {};

local pm = GAMESTATE:GetPlayMode();

if pm == 'PlayMode_Battle' or pm == 'PlayMode_Rave' then
	-- Winner p1
	t[#t+1] = Def.Sprite{
		InitCommand=function(self)
			self:x(SCREEN_CENTER_X*0.45);
			local pm = GAMESTATE:GetPlayMode()
			if GAMESTATE:IsWinner(PLAYER_1) then
				self:Load(THEME:GetPathG("ScreenEvaluation","WinDisplay/win"));
			elseif GAMESTATE:IsDraw() then
				self:Load(THEME:GetPathG("ScreenEvaluation","WinDisplay/draw"));
			else
				self:Load(THEME:GetPathG("ScreenEvaluation","WinDisplay/lose"));
			end;
		end;
		OnCommand=cmd(horizalign,center;vertalign,bottom;zoom,0;sleep,2;zoomx,1;zoomy,5;accelerate,0.15;zoomy,1;);
	};

	-- Winner p2
	t[#t+1] = Def.Sprite{
		InitCommand=function(self)
			self:x(SCREEN_CENTER_X*1.55);
			if GAMESTATE:IsWinner(PLAYER_2) then
				self:Load(THEME:GetPathG("ScreenEvaluation","WinDisplay/win"));
			elseif GAMESTATE:IsDraw() then
				self:Load(THEME:GetPathG("ScreenEvaluation","WinDisplay/draw"));
			else
				self:Load(THEME:GetPathG("ScreenEvaluation","WinDisplay/lose"));
			end;
		end;
		OnCommand=cmd(horizalign,center;vertalign,bottom;zoom,0;sleep,2;zoomx,1;zoomy,5;accelerate,0.15;zoomy,1;);
	};
end;

return t;
