
local sctext = getenv("SortCh");

local t = Def.ActorFrame {
	Def.Sprite{
		BeginCommand=cmd(playcommand,"SetGraphic");
		InitCommand=cmd(horizalign,left);
		OnCommand=cmd(addx,15;addy,15;diffusealpha,0;sleep,0.9;decelerate,0.4;addx,-15;addy,-15;diffusealpha,1);
		SetGraphicCommand=function(self)
			local so = GAMESTATE:GetSortOrder();
			if so ~= nil then
				local sort = ToEnumShortString(so);
				if so == "SortOrder_Preferred" then
					if sctext == "BeginnerMeter" or sctext == "EasyMeter" or sctext == "MediumMeter" or
					sctext == "HardMeter" or sctext == "ChallengeMeter" or sctext == "TopGrades" then
						self:Load(THEME:GetPathG("","_SortDisplay/_"..sctext));
					else
						self:Load(THEME:GetPathG("","_SortDisplay/_"..sort));
					end;
				else
					self:Load(THEME:GetPathG("","_SortDisplay/_"..sort));
				end;
			end;
		end;
		SortOrderChangedMessageCommand=cmd(playcommand,"SetGraphic";);
	};
};

return t;