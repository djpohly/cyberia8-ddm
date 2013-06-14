
local st = GAMESTATE:GetCurrentStyle():GetStepsType();
local CustomDifficultyToState = {
	Beginner	= 0,
	Easy		= 1,
	Medium	= 2,
	Hard		= 3,
	Challenge	= 4,
	Edit		= 5
};

local t = Def.ActorFrame{
	LoadActor(THEME:GetPathG("", "_difftable"))..{
		InitCommand=cmd(animate,false);
		SetCommand=function(self,params)
			local cdiff = params.CustomDifficulty;
			local ccdiff = CustomDifficultyToState[cdiff];
			self:stoptweening();
			self:setstate(ccdiff);
		end;
	};
	
	LoadFont("StepsDisplay meter")..{
		InitCommand=cmd(x,14;y,-32;shadowlength,0;rotationz,90;horizalign,left;maxwidth,60;zoom,1.2;skewx,-0.175);
		SetCommand=function(self,params)
			self:stoptweening();
			local song = GAMESTATE:GetCurrentSong();
			if song then
				local cdiff = params.CustomDifficulty;
				if song:HasStepsTypeAndDifficulty(st,"Difficulty_"..cdiff) then
					local meter = params.Meter;
					if GetAdhocPref("UserMeterType") == "CSStyle" and cdiff ~= "Edit" then
						meter = GetConvertDifficulty(song,"Difficulty_"..cdiff);
					end;
					self:settextf("%d",meter);
					self:diffuse(CustomDifficultyToColor(cdiff));
				end;
			end;
		end;
	};
};

return t;