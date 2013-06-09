
local t = Def.ActorFrame {};

local mStages = STATSMAN:GetStagesPlayed();
local v = mStages;
local showbanner = PREFSMAN:GetPreference('ShowBanners');
local showjacket = GetAdhocPref("ShowJackets");
local extracolor = THEME:GetMetric("MusicWheel","SongRealExtraColor");

PREFSMAN:SetPreference("AllowExtraStage",getenv("envAllowExtraStage"));

while v > 0 do
	local i;
	if v == 7 then i = 7;
	elseif v == 6 then i = 6;
	elseif v == 5 then i = 5;
	elseif v == 4 then i = 4;
	elseif v == 3 then i = 3;
	elseif v == 2 then i = 2;
	elseif v == 1 then i = 1;
	end;
	
	local w;
	if i == mStages then w = 1;
	elseif i == mStages - 1 then w = 2;
	elseif i == mStages - 2 then w = 3;
	elseif i == mStages - 3 then w = 4;
	elseif i == mStages - 4 then w = 5;
	elseif i == mStages - 5 then w = 6;
	elseif i == mStages - 6 then w = 7;
	end;

	t[#t+1] = Def.ActorFrame {
		InitCommand=function(self)
			self:Center();
			if mStages == 2 then
				self:addy(40 + ((mStages - i) * 50) - 52);
			elseif mStages == 4 then
				self:addy(-10 + ((mStages - i) * 50) - 52);
			elseif mStages == 5 then
				self:addy(-30 + ((mStages - i) * 50) - 52);
			elseif mStages == 6 then
				self:addy(-50 + ((mStages - i) * 50) - 52);
			elseif mStages == 7 then
				self:addy(-70 + ((mStages - i) * 50) - 52);
			else
				self:addy(((mStages - i) * 50) - 52);
			end;
		end;
--back
		LoadActor( "center" ) .. {
			OnCommand=cmd(zoomy,0;sleep,(w / 5);linear,0.2;zoomy,1;);
		};

		LoadActor( "players" ) .. {
			InitCommand=cmd(addx,-218;);
			OnCommand=cmd(cropright,1;sleep,(w / 5);linear,0.2;cropright,0;);
		};
		
		LoadActor( "players" ) .. {
			InitCommand=cmd(rotationy,180;addx,218;);
			OnCommand=cmd(cropright,1;sleep,(w / 5);linear,0.2;cropright,0;);
		};
	};

	local ssStats = STATSMAN:GetPlayedStageStats( i );
	local iStage = ssStats:GetStageIndex();
	iStage = iStage + 1;
	local pStage = ssStats:GetStage();
	local maxStages = PREFSMAN:GetPreference("SongsPerPlay");

	for pn in ivalues(PlayerNumber) do
		local pStageStats = ssStats:GetPlayerStageStats(pn);
		local failed = pStageStats:GetFailed();
		local ppercentsc = pStageStats:GetPercentDancePoints();
		local hs = {
			"Grade",
			"PercentScore",
			"Score",
			"TotalSteps",
			"TapNoteScore_W1",
			"TapNoteScore_W2",
			"TapNoteScore_W3",
			"TapNoteScore_W4",
			"TapNoteScore_W5",
			"TapNoteScore_Miss",
			"TapNoteScore_HitMine",
			"TapNoteScore_CheckpointMiss",
			"HoldNoteScore_Held",
			"HoldNoteScore_LetGo";
		};

		local gpTier = {
			Tier01	= THEME:GetMetric("PlayerStageStats", "GradePercentTier01"),
			Tier02	= THEME:GetMetric("PlayerStageStats", "GradePercentTier02"),
			Tier03	= THEME:GetMetric("PlayerStageStats", "GradePercentTier03"),
			Tier04	= THEME:GetMetric("PlayerStageStats", "GradePercentTier04"),
			Tier05	= THEME:GetMetric("PlayerStageStats", "GradePercentTier05"),
			Tier06	= THEME:GetMetric("PlayerStageStats", "GradePercentTier06"),
			Tier07	= THEME:GetMetric("PlayerStageStats", "GradePercentTier07"),
		};
		if ssStats then
			hs["TotalSteps"]						= pStageStats:GetRadarPossible():GetValue('RadarCategory_TapsAndHolds');
		else
			hs["TotalSteps"]						= 0;
		end;
		if pStageStats then
			hs["Grade"]							= pStageStats:GetGrade();
			hs["PercentScore"]					= pStageStats:GetPercentDancePoints();
			hs["Score"]							= pStageStats:GetScore();
			hs["TapNoteScore_W1"]				= pStageStats:GetTapNoteScores("TapNoteScore_W1");
			hs["TapNoteScore_W2"]				= pStageStats:GetTapNoteScores("TapNoteScore_W2");
			hs["TapNoteScore_W3"]				= pStageStats:GetTapNoteScores("TapNoteScore_W3");
			hs["TapNoteScore_W4"]				= pStageStats:GetTapNoteScores("TapNoteScore_W4");
			hs["TapNoteScore_W5"]				= pStageStats:GetTapNoteScores("TapNoteScore_W5");
			hs["TapNoteScore_Miss"]				= pStageStats:GetTapNoteScores("TapNoteScore_Miss");
			hs["TapNoteScore_HitMine"]				= pStageStats:GetTapNoteScores("TapNoteScore_HitMine");
			hs["TapNoteScore_CheckpointMiss"]		= pStageStats:GetTapNoteScores("TapNoteScore_CheckpointMiss");
			hs["HoldNoteScore_Held"]				= pStageStats:GetHoldNoteScores("HoldNoteScore_Held");
			hs["HoldNoteScore_LetGo"]				= pStageStats:GetHoldNoteScores("HoldNoteScore_LetGo");
			
			if failed then hs["Grade"] = "Grade_Failed"
			end;
		
			if hs["Grade"] ~= "Grade_None" and hs["Grade"] ~= "Grade_Failed" then
				if hs["PercentScore"] >= gpTier["Tier01"] then hs["Grade"] = "Grade_Tier01"
				elseif hs["PercentScore"] >= gpTier["Tier02"] then hs["Grade"] = "Grade_Tier02"
				elseif hs["PercentScore"] >= gpTier["Tier03"] then hs["Grade"] = "Grade_Tier03"
				elseif hs["PercentScore"] >= gpTier["Tier04"] then hs["Grade"] = "Grade_Tier04"
				elseif hs["PercentScore"] >= gpTier["Tier05"] then hs["Grade"] = "Grade_Tier05"
				elseif hs["PercentScore"] >= gpTier["Tier06"] then hs["Grade"] = "Grade_Tier06"
				else hs["Grade"] = "Grade_Tier07"
				end;
			end;
			--[ja] 意図的にFailedさせた時の対策
			if iStage == mStages then
				if pStage == "Stage_Extra1" or pStage == "Stage_Extra2" then
					if getenv("onpurposefailgrade") == "Grade_Failed" then
						hs["Grade"] = getenv("onpurposefailgrade");
					end;
				end;
			end;

			local difficultyStates = {
				Difficulty_Beginner	= 0,
				Difficulty_Easy		= 2,
				Difficulty_Medium		= 4,
				Difficulty_Hard		= 6,
				Difficulty_Challenge	= 8,
				Difficulty_Edit		= 10,
			};

			t[#t+1] = Def.ActorFrame {
				InitCommand=function(self)
					(cmd(player,pn;Center))(self)
					if mStages == 2 then
						self:addy(40 + ((mStages - i) * 50) - 42);
					elseif mStages == 4 then
						self:addy(-10 + ((mStages - i) * 50) - 42);
					elseif mStages == 5 then
						self:addy(-30 + ((mStages - i) * 50) - 42);
					elseif mStages == 6 then
						self:addy(-50 + ((mStages - i) * 50) - 42);
					elseif mStages == 7 then
						self:addy(-70 + ((mStages - i) * 50) - 42);
					else
						self:addy(((mStages - i) * 50) - 42);
					end;
				end;
		--score 
				LoadFont( "ScreenEvaluation ScoreNumber" ) .. {
					InitCommand=function(self)
						self:visible(false);
						self:zoom(0.4);
						self:y(-4);
						if GAMESTATE:GetPlayMode() ~= "PlayMode_Rave" and GAMESTATE:GetPlayMode() ~= "PlayMode_Battle" then
							self:visible(true);
							local score_length = string.len(tostring( hs["Score"] ));
							local target_length = 9;
							local text = string.rep('0', clamp(target_length - score_length, 0, 9));
							local pX = 0;
							if pn == PLAYER_1 then
								self:addx(-188);
								self:diffuse(PlayerColor(PLAYER_1));
							else
								self:addx(188);
								self:diffuse(PlayerColor(PLAYER_2));
							end;
							if hs["Score"] >= 0 and hs["Score"] <= 9 then
								self:settext( string.format("        ".."%i",hs["Score"]) );
							elseif hs["Score"] >= 10 and hs["Score"] <= 99 then
								self:settext( string.format("       ".."%02i",hs["Score"]) );
							elseif hs["Score"] >= 100 and hs["Score"] <= 999 then
								self:settext( string.format("      ".."%03i",hs["Score"]) );
							elseif hs["Score"] >= 1000 and hs["Score"] <= 9999 then
								self:settext( string.format("     ".."%04i",hs["Score"]) );
							elseif hs["Score"] >= 10000 and hs["Score"] <= 99999 then
								self:settext( string.format("    ".."%05i",hs["Score"]) );
							elseif hs["Score"] >= 100000 and hs["Score"] <= 999999 then
								self:settext( string.format("   ".."%06i",hs["Score"]) );
							elseif hs["Score"] >= 1000000 and hs["Score"] <= 9999999 then
								self:settext( string.format("  ".."%07i",hs["Score"]) );
							elseif hs["Score"] >= 10000000 and hs["Score"] <= 99999999 then
								self:settext( string.format(" ".."%08i",hs["Score"]) );
							else
								self:settext( string.format("%09i",hs["Score"]) );
							end;
						end;
					end;
					OnCommand=cmd(zoomy,0;sleep,(w / 5) + 0.15;linear,0.2;zoomy,0.4;);
				};
		--percentscore
				LoadFont( "ScreenEvaluation percent text" ) .. {
					InitCommand=function(self)
						self:visible(false);
						self:addy(-16);
						self:zoom(0.25);
						if GAMESTATE:GetPlayMode() ~= "PlayMode_Rave" and GAMESTATE:GetPlayMode() ~= "PlayMode_Battle" then
							self:visible(true);
							if hs["PercentScore"] == 1 then self:settext("100%");
							elseif hs["PercentScore"] == 0 then self:settext("0%");
							else self:settext(string.format("%.2f%%", hs["PercentScore"] * 100 ));
							end;

							if pn == PLAYER_1 then
								self:addx(-132);
								self:horizalign(right);
							else
								self:addx(132);
								self:horizalign(left);
							end
						end;
					end;
					OnCommand=cmd(zoomy,0;sleep,(w / 5) + 0.15;linear,0.2;zoomy,0.25;);
				};

		--fullcombo
				LoadActor(THEME:GetPathG("","graph_mini"))..{
					InitCommand=function(self)
						self:visible(false);
						if not pStageStats:GetFailed() and pStageStats:FullCombo() then
							if hs["Grade"] ~= "Grade_None" and hs["Grade"] ~= "Grade_Failed" then
								if tonumber( hs["TotalSteps"] ) > 0 then
									if hs["TapNoteScore_W4"] + hs["TapNoteScore_W5"] + hs["TapNoteScore_Miss"] + 
									hs["TapNoteScore_HitMine"] + hs["TapNoteScore_CheckpointMiss"] == 0 then
										self:visible(true);
										if pn == PLAYER_1 then
											self:addx(-258);
											if hs["Grade"] == "Grade_Tier01" then self:x(-258+6);
											elseif hs["Grade"] == "Grade_Tier02" then self:x(-258+1);
											end;
										else
											self:addx(258);
											if hs["Grade"] == "Grade_Tier01" then self:x(-258+6);
											elseif hs["Grade"] == "Grade_Tier02" then self:x(-258+1);
											end;
										end;
										
										if hs["TapNoteScore_W2"] + hs["TapNoteScore_W3"] == 0 and hs["PercentScore"] == 1 then
											self:diffuse(color("1,1,1,1"));
											self:glowshift();
										elseif hs["TapNoteScore_W3"] == 0 then
											self:diffuse(color("1,0.8,0,1"));
											self:glowshift();
										else
											self:diffuse(color("0.2,1,0.6,1"));
											self:stopeffect();
										end;
									end;
								end;
							end;
						end;
					end;
					OnCommand=cmd(zoom,0;sleep,(w / 5) + 0.05;linear,1;zoom,0.3;rotationy,-30;rotationx,70;rotationz,100;spin;effectmagnitude,0,0,-200;);
				};
				LoadActor(THEME:GetPathG("","graph_mini"))..{
					InitCommand=function(self)
						self:visible(false);
						if not pStageStats:GetFailed() and pStageStats:FullCombo() then
							if hs["Grade"] ~= "Grade_None" and hs["Grade"] ~= "Grade_Failed" then
								if tonumber(hs["TotalSteps"]) > 0 then
									if hs["TapNoteScore_W4"] + hs["TapNoteScore_W5"] + hs["TapNoteScore_Miss"] + 
									hs["TapNoteScore_HitMine"] + hs["TapNoteScore_CheckpointMiss"] == 0 then
										self:visible(true);
										if pn == PLAYER_1 then
											self:addx(-258);
											if hs["Grade"] == "Grade_Tier01" then self:x(-258+6);
											elseif hs["Grade"] == "Grade_Tier02" then self:x(-258+1);
											end;
										else
											self:addx(258);
											if hs["Grade"] == "Grade_Tier01" then self:x(-258+6);
											elseif hs["Grade"] == "Grade_Tier02" then self:x(-258+1);
											end;
										end;
										
										if hs["TapNoteScore_W2"] + hs["TapNoteScore_W3"] == 0 and hs["PercentScore"] == 1 then
											self:diffuse(color("1,1,1,1"));
											self:glowshift();
										elseif hs["TapNoteScore_W3"] == 0 then
											self:diffuse(color("1,0.8,0,1"));
											self:glowshift();
										else
											self:diffuse(color("0.2,1,0.6,1"));
											self:stopeffect();
										end;
									end;
								end;
							end;
						end;
					end;
					OnCommand=cmd(zoom,0;sleep,(w / 5) + 0.05;linear,1;zoom,0.3;rotationy,30;rotationx,70;rotationz,100;spin;effectmagnitude,60,100,-200;);
				};
		--grade
				Def.Sprite{
					InitCommand=function(self)
						self:visible(false);
						self:zoom(0.45);
						self:addy(-10);
						if hs["Grade"] ~= "Grade_None" then
							self:visible(true);
							self:Load(THEME:GetPathG("GradeDisplayEval",ToEnumShortString( hs["Grade"] )));
							if pn == PLAYER_1 then self:addx(-273);
							else self:addx(273);
							end;
						end;
					end;
					OnCommand=cmd(zoomy,0;sleep,(w / 5) + 0.15;linear,0.2;zoomy,0.45;);
				};
		--difficulty
				LoadActor(THEME:GetPathG("DiffDisplay","frame/frame"))..{
					InitCommand=function(self)
						(cmd(animate,false;setstate,0;zoom,0.65;addy,-18))(self)
						local pDifficulty = pStageStats:GetPlayedSteps()[1]:GetDifficulty();
						local state = difficultyStates[pDifficulty];
						if pn == PLAYER_2 then
							state = state + 1;
							self:horizalign(right);
							self:addx(241);
						else
							self:horizalign(left);
							self:addx(-241);
						end;
						self:setstate(state);
					end;
					OnCommand=cmd(zoomy,0;sleep,(w / 5) + 0.175;linear,0.2;zoomy,0.65;);
				};
			};
		end;
	end;

	local sssong = ssStats:GetPlayedSongs()[1];
	local jacketPath ,sbannerpath ,cdimagepath ,sbackgroundpath;

	local function GetSongImage(song)
		if song then
			jacketpath = song:GetJacketPath()
			sbannerpath = song:GetBannerPath()
			cdimagepath = song:GetCDImagePath()
			sbackgroundpath = song:GetBackgroundPath()
			
			if showbanner then
				if showjacket == "On" then
					if jacketpath then return jacketpath
					elseif sbannerpath then return sbannerpath
					elseif cdimagepath then return cdimagepath
					elseif sbackgroundpath then return backgroundpath
					end
				elseif sbannerpath then return sbannerpath
				end
			end
		end
		return THEME:GetPathG("Common","fallback jacket");
	end;
	
	local function ImgSizeX(song)
		if song then
			jacketpath = song:GetJacketPath()
			sbannerpath = song:GetBannerPath()
			cdimagepath = song:GetCDImagePath()
			sbackgroundpath = song:GetBackgroundPath()
			
			if showbanner then
				if showjacket == "On" then
					if jacketpath then return 36
					elseif sbannerpath then return 96
					elseif cdimagepath then return 36
					elseif sbackgroundpath then return 36
					end
				elseif sbannerpath then return 30
				end
			end
		end
		return 36;
	end;
	
	local function ImgSizeY(song)
		if song then
			jacketpath = song:GetJacketPath()
			sbannerpath = song:GetBannerPath()
			cdimagepath = song:GetCDImagePath()
			sbackgroundpath = song:GetBackgroundPath()
			
			if showbanner then
				if showjacket == "On" then
					if jacketpath then return 36
					elseif sbannerpath then return 30
					elseif cdimagepath then return 36
					elseif sbackgroundpath then return 36
					end
				elseif sbannerpath then return 36
				end
			end
		end
		return 36;
	end;
	
	local function Imgaddy(song)
		if song then
			jacketpath = song:GetJacketPath()
			sbannerpath = song:GetBannerPath()
			cdimagepath = song:GetCDImagePath()
			sbackgroundpath = song:GetBackgroundPath()
			
			if showbanner then
				if showjacket == "On" then
					if jacketpath then return -2
					elseif sbannerpath then return 0
					elseif cdimagepath then return -2
					elseif sbackgroundpath then return -2
					end
				elseif sbannerpath then return -2
				end
			end
		end
		return -2;
	end;

	t[#t+1] = Def.ActorFrame {
		InitCommand=function(self)
			self:Center();
			if mStages == 2 then
				self:addy(40 + ((mStages - i) * 50) - 50);
			elseif mStages == 4 then
				self:addy(-10 + ((mStages - i) * 50) - 50);
			elseif mStages == 5 then
				self:addy(-30 + ((mStages - i) * 50) - 50);
			elseif mStages == 6 then
				self:addy(-50 + ((mStages - i) * 50) - 50);
			elseif mStages == 7 then
				self:addy(-70 + ((mStages - i) * 50) - 50);
			else
				self:addy(((mStages - i) * 50) - 50);
			end;
		end;
--banner
		Def.Banner {
			InitCommand=function(self)
				local sssong = ssStats:GetPlayedSongs()[1];
				self:addx(-112);
				self:horizalign(left);
				self:Load(GetSongImage(sssong));
				if GetSongImage(sssong) == sssong:GetBannerPath() then
					self:diffuserightedge(color("0,0,0,0"));
				end;
				(cmd(zoomtowidth,ImgSizeX(sssong);zoomtoheight,0;sleep,(w / 5) + 0.1;linear,0.2;addy,Imgaddy(sssong);zoomtoheight,ImgSizeY(sssong)))(self)
			end;
		};
--title
		Def.TextBanner {
			InitCommand=cmd(Load,"EvaluationTextBanner";SetFromString,"", "", "", "", "", "";);
			OnCommand=function(self)
				(cmd(zoom,0.65;addx,-50;zoomy,0;sleep,(w / 5) + 0.125;linear,0.2;zoomy,0.65))(self)
				if sssong then
					self:visible(true);
					self:SetFromSong( sssong );
					local bExtra2 = GAMESTATE:IsExtraStage2();
					local style = GAMESTATE:GetCurrentStyle();
					local extrasong, extrasteps = SONGMAN:GetExtraStageInfo( bExtra2, style );

					local groupcolor = SONGMAN:GetSongColor( sssong );
					
					self:diffuse(groupcolor);
					if mStages == maxStages + 2 then
						if pStage == 'Stage_Extra1' then
							self:diffuse(extracolor);
						elseif pStage == 'Stage_Extra2' then
							self:diffuse(extracolor);
						end;
					elseif mStages == maxStages + 1 then
						if pStage == 'Stage_Extra1' and extrasong == sssong then
							self:diffuse(extracolor);
						end;
					end;
				else self:visible(false);
				end;
			end;
		};
--stage
		Def.Sprite{
			InitCommand=function(self)
				self:shadowlength(2);
				self:zoom(0.45);
				self:addx(-120);
				self:horizalign(left);
				self:addy(-23);

				local stageStr;
				local cStsge;
				if pStage ~= 'Stage_Final' and pStage ~= 'Stage_Extra1' and pStage ~= 'Stage_Extra2' then
					if iStage == 1 then
						local firstsongStages = 1;
						cStage = 'Stage_1st';

						if sssong:IsLong() then firstsongStages = firstsongStages + 1;
						elseif sssong:IsMarathon() then firstsongStages = firstsongStages + 2;
						end;						
						if maxStages <= firstsongStages then
							cStage = 'Stage_Final';
						end;
						setenv("first",firstsongStages);
					elseif iStage == 2 then
						local secondsongStages = getenv("first") + 1;
						stageStr = FormatNumberAndSuffix( secondsongStages );
						cStage = 'Stage_'..stageStr;

						if sssong:IsLong() then secondsongStages = secondsongStages + 1;
						elseif sssong:IsMarathon() then secondsongStages = secondsongStages + 2;
						end;
						if maxStages <= secondsongStages then
							cStage = 'Stage_Final';
						end;
						setenv("second",secondsongStages);
					elseif iStage == 3 then
						local thirdsongStages = getenv("second") + 1;
						stageStr = FormatNumberAndSuffix( thirdsongStages );
						cStage = 'Stage_'..stageStr;

						if sssong:IsLong() then thirdsongStages = thirdsongStages + 1;
						elseif sssong:IsMarathon() then thirdsongStages = thirdsongStages + 2;
						end;
						if maxStages <= thirdsongStages then
							cStage = 'Stage_Final';
						end;
						setenv("third",thirdsongStages);
					elseif iStage == 4 then
						local fourthsongStages = getenv("third") + 1;
						stageStr = FormatNumberAndSuffix( fourthsongStages );
						cStage = 'Stage_'..stageStr;

						if sssong:IsLong() then fourthsongStages = fourthsongStages + 1;
						elseif sssong:IsMarathon() then fourthsongStages = fourthsongStages + 2;
						end;
						if maxStages <= fourthsongStages then
							cStage = 'Stage_Final';
						end;
						setenv("fourth",fourthsongStages);
					elseif iStage == 5 then
						local fifthsongStages = getenv("fourth") + 1;
						stageStr = FormatNumberAndSuffix( fifthsongStages );
						cStage = 'Stage_'..stageStr;

						if sssong:IsLong() then fifthsongStages = fifthsongStages + 1;
						elseif sssong:IsMarathon() then fifthsongStages = fifthsongStages + 2;
						end;
						if maxStages <= fifthsongStages then
							cStage = 'Stage_Final';
						end;
						setenv("fifth",fifthsongStages);
					elseif iStage == 6 then
						local sixthsongStages = getenv("fifth") + 1;
						stageStr = FormatNumberAndSuffix( sixthsongStages );
						cStage = 'Stage_'..stageStr;

						if sssong:IsLong() then sixthsongStages = sixthsongStages + 1;
						elseif sssong:IsMarathon() then sixthsongStages = sixthsongStages + 2;
						end;
						if maxStages <= sixthsongStages then
							cStage = 'Stage_Final';
						end;
					end;
				else
					cStage = pStage;
				end;
				self:Load(THEME:GetPathB("ScreenStageInformation","in/stageregular_effect/_label "..cStage));
			end;
			OnCommand=cmd(zoomy,0;sleep,(w / 5) + 0.15;linear,0.2;zoomy,0.45;);
		};
--[[
		LoadFont("Common Normal")..{
			InitCommand=function(self)
				local iStage = ssStats:GetStageIndex();
				(cmd(addx,-30;zoom,0.65;settext,iStage))(self)
			end;
		};
]]
	};

	v = v - 1;
end;
	

return t