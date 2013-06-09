local t = Def.ActorFrame{};

if not GAMESTATE:IsCourseMode() then
--[ja] 難易度ソート
	local mt = GetAdhocPref("UserMeterType");
	local st = GAMESTATE:GetCurrentStyle():GetStepsType();
	local mplayer = GAMESTATE:GetMasterPlayerNumber();
	local allSongs = SONGMAN:GetAllSongs();

	local diff = {
		'Difficulty_Beginner',
		'Difficulty_Easy',
		'Difficulty_Medium',
		'Difficulty_Hard',
		'Difficulty_Challenge'
	};
	
	local diffset = {
		'BeginnerMeter',
		'EasyMeter',
		'MediumMeter',
		'HardMeter',
		'ChallengeMeter'
	};
	
	local mtset =  {
		'CSStyle',
		'Default',
	};
	
	local gpTier = {
		Tier01		= THEME:GetMetric("PlayerStageStats", "GradePercentTier01"),
		Tier02		= THEME:GetMetric("PlayerStageStats", "GradePercentTier02"),
		Tier03		= THEME:GetMetric("PlayerStageStats", "GradePercentTier03"),
		Tier04		= THEME:GetMetric("PlayerStageStats", "GradePercentTier04"),
		Tier05		= THEME:GetMetric("PlayerStageStats", "GradePercentTier05"),
		Tier06		= THEME:GetMetric("PlayerStageStats", "GradePercentTier06"),
		Tier07		= THEME:GetMetric("PlayerStageStats", "GradePercentTier07"),
	};

	for n=1, 2 do
		for i=1, #diff do
			local dmpath = THEME:GetCurrentThemeDirectory().."/Other/SongManager "..ToEnumShortString(st).."_"..mtset[n].."_"..diffset[i].."_New.txt";
			--if not File.Read( dmpath ) or (File.Read( dmpath ) and (not getenv("reloadstate") or getenv("reloadstate") == 1)) then
				local dstr = {};
				for k=1, #allSongs do
					local songDir = allSongs[k]:GetSongDir();
					local sDir = string.sub( songDir,8,-2 );
					isNew = true;
					if allSongs[k]:HasStepsTypeAndDifficulty(st,diff[i]) then
						local dnmeter;
						if n == 1 then dnmeter = tonumber(GetConvertDifficulty(allSongs[k],diff[i]));
						else dnmeter = tonumber(allSongs[k]:GetOneSteps(st,diff[i]):GetMeter());
						end;
						local tmeter = string.format( "%02i", dnmeter );
						for l=1, #dstr do
							-- [ja] 曲
							if ("--- "..tmeter.."\r\n") == dstr[l][1] then
								dstr[l][2] = dstr[l][2]..""..sDir.."\r\n";
								isNew = false;
								break;
							end;
						end;
						if isNew then
							if tmeter then
								-- [ja] セクションと曲
								dstr[#dstr+1] = { "--- "..tmeter.."\r\n", ""..sDir.."\r\n"  };
							end;
						end;
					end;
				end;
				local DiffMusicList = dstr;

				for m=1, 2 do
					table.sort(DiffMusicList,
						function(a, b)
							for j=1, #a do
								for i=1, string.len(a[j]) do
									aCharNum = a[j]:byte(i,i)
									bCharNum = b[j]:byte(i,i)
									if bCharNum == nil then
										return false
									end
									if aCharNum < bCharNum then
										return true
									elseif aCharNum > bCharNum then
										return false
									end;
								end;
								return true;
							end;
						end
					);
				end;

				local sorttext = ""
				-- [ja] メーターの飛びを確認
				for o=1, #DiffMusicList do
					if DiffMusicList[o] then
						sorttext = sorttext..""..table.concat(DiffMusicList[o]);
					else
						sorttext = sorttext;
					end;
				end;
				File.Write( dmpath , sorttext );
			--end;
		end;
	end;

--[ja] グレードソート
	--if GAMESTATE:GetNumPlayersEnabled() == 1 then
		for p=1, #diff do
			local grpath = THEME:GetCurrentThemeDirectory().."/Other/SongManager "..ToEnumShortString(st).."_Grade_"..diffset[p].."_New.txt";
			local gstr = {};
			for q=1, #allSongs do
				local steps = allSongs[q]:GetOneSteps(st, diff[p]);
				if allSongs[q] and steps then
					local profile;
					if PROFILEMAN:IsPersistentProfile(mplayer) then
						-- player profile
						profile = PROFILEMAN:GetProfile(mplayer);
					else
						-- machine profile
						profile = PROFILEMAN:GetMachineProfile();
					end;
					local scorelist = profile:GetHighScoreList(allSongs[q],steps);
					assert(scorelist);
					local scores = scorelist:GetHighScores();
					local topscore = scores[1];
					local gradet = "Grade_None";
					if topscore then
						gradet = topscore:GetGrade();
						local pscore = topscore:GetPercentDP();
						local aliveseconds = topscore:GetSurvivalSeconds();
						local stepseconds = allSongs[q]:GetLastSecond();

						if gradet ~= "Grade_None" and gradet ~= "Grade_Failed" then
							if aliveseconds >= stepseconds then
								if pscore >= gpTier["Tier01"] then gradet = "Grade_Tier01";
								elseif pscore >= gpTier["Tier02"] then gradet = "Grade_Tier02";
								elseif pscore >= gpTier["Tier03"] then gradet = "Grade_Tier03";
								elseif pscore >= gpTier["Tier04"] then gradet = "Grade_Tier04";
								elseif pscore >= gpTier["Tier05"] then gradet = "Grade_Tier05";
								elseif pscore >= gpTier["Tier06"] then gradet = "Grade_Tier06";
								else gradet = "Grade_Tier07";
								end;
							else
								gradet = "Grade_Tier09";
							end;
						end;
						if gradet == "Grade_Failed" then gradet = "Grade_Tier09";
						end;
					end;
					if gradet == "Grade_None" then gradet = "Grade_Tier21";
					end;

					local songDir = allSongs[q]:GetSongDir();
					local sDir = string.sub( songDir,8,-2 );
					isNew = true;

					for r=1, #gstr do
						-- [ja] 曲
						if ("--- "..gradet.."\r\n") == gstr[r][1] then
							gstr[r][2] = gstr[r][2]..""..sDir.."\r\n";
							isNew = false;
							break;
						end;
					end;
					if isNew then
						if gradet then
							-- [ja] セクションと曲
							gstr[#gstr+1] = { "--- "..gradet.."\r\n", ""..sDir.."\r\n"  };
						end;
					end;
				end;
			end;

			local GradeMusicList = gstr;
		
			for m=1, 2 do
				table.sort(GradeMusicList,
					function(a, b)
						for j=1, #a do
							for i=1, string.len(a[j]) do
								aCharNum = a[j]:byte(i,i)
								bCharNum = b[j]:byte(i,i)
								if bCharNum == nil then
									return false
								end
								if aCharNum < bCharNum then
									return true
								elseif aCharNum > bCharNum then
									return false
								end;
							end;
							return true;
						end;
					end
				);
			end;

			local gradetext = ""
			-- [ja] グレードの飛びを確認
			for t=1, #GradeMusicList do
				if GradeMusicList[t] then
					if GradeMusicList[t][1] then
						if GradeMusicList[t][1] == "--- Grade_Tier01".."\r\n" then
							GradeMusicList[t][1] = "--- "..THEME:GetString("Grade","Tier01").."\r\n"
						elseif GradeMusicList[t][1] == "--- Grade_Tier02".."\r\n" then
							GradeMusicList[t][1] = "--- "..THEME:GetString("Grade","Tier02").."\r\n"
						elseif GradeMusicList[t][1] == "--- Grade_Tier03".."\r\n" then
							GradeMusicList[t][1] = "--- "..THEME:GetString("Grade","Tier03").."\r\n"
						elseif GradeMusicList[t][1] == "--- Grade_Tier04".."\r\n" then
							GradeMusicList[t][1] = "--- "..THEME:GetString("Grade","Tier04").."\r\n"
						elseif GradeMusicList[t][1] == "--- Grade_Tier05".."\r\n" then
							GradeMusicList[t][1] = "--- "..THEME:GetString("Grade","Tier05").."\r\n"
						elseif GradeMusicList[t][1] == "--- Grade_Tier06".."\r\n" then
							GradeMusicList[t][1] = "--- "..THEME:GetString("Grade","Tier06").."\r\n"
						elseif GradeMusicList[t][1] == "--- Grade_Tier07".."\r\n" then
							GradeMusicList[t][1] = "--- "..THEME:GetString("Grade","Tier07").."\r\n"
						elseif GradeMusicList[t][1] == "--- Grade_Tier09".."\r\n" then
							GradeMusicList[t][1] = "--- "..THEME:GetString("Grade","Failed").."\r\n"
						elseif GradeMusicList[t][1] == "--- Grade_Tier21".."\r\n" then
							GradeMusicList[t][1] = "--- "..THEME:GetString("Grade","NoneSectionText").."\r\n"
						end;
					end;
					gradetext = gradetext..""..table.concat(GradeMusicList[t]);
				else
					gradetext = gradetext;
				end;
			end;
			File.Write( grpath , gradetext );
		end;
	--end;
	setenv("reloadstate",0);
end;

return t;
