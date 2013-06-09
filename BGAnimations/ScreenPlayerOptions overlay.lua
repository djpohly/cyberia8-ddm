local t = Def.ActorFrame{};

if getenv("exflag") == "csc" and not GAMESTATE:IsEventMode() then
	local ssStats = STATSMAN:GetPlayedStageStats(1);
	local group = ssStats:GetPlayedSongs()[1]:GetGroupName();

	t[#t+1] = Def.Sound {
		InitCommand=function(self)
			local bgm = GetGroupParameter(group,"Extra1SelectBGM");
			if bgm ~= "" and FILEMAN:DoesFileExist("/Songs/"..group.."/"..bgm) then
				self:load("/Songs/"..group.."/"..bgm);
			elseif bgm ~= "" and FILEMAN:DoesFileExist("/AdditionalSongs/"..group.."/"..bgm) then
				self:load("/AdditionalSongs/"..group.."/"..bgm);
			else
				self:load(THEME:GetPathS("","_csc_type1"));
			end;
			self:stop();
			self:play();
		end;
	};
end;

return t;