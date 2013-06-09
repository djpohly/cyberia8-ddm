function SelectMusicOrCourse()
	if IsNetSMOnline() then
		return "ScreenNetSelectMusic";
	elseif GAMESTATE:IsCourseMode() then
		local pm = GAMESTATE:GetPlayMode();
		if pm == "PlayMode_Nonstop" then return "ScreenSelectCourseNonstop"; end;
		if pm == "PlayMode_Oni" then return "ScreenSelectCourseOni"; end;
		if pm == "PlayMode_Endless" then return "ScreenSelectCourseEndless"; end;
		return "ScreenSelectCourse";
	elseif GAMESTATE:HasEarnedExtraStage() then
		if GAMESTATE:IsExtraStage() then
			if getenv("exflag") == "csc" then return "ScreenSelectMusicCS";
			else return "ScreenSelectMusicExtra"; end;
		end;
		if GAMESTATE:IsExtraStage2() then
			if getenv("omsflag") == 1 then return Branch.TitleMenu();		
			else return "ScreenSelectMusicExtra2"; end;
		end;
		return "ScreenSelectMusic";
	else
		return "ScreenSelectMusic";
	end;
end;

function SelectMusicExtra()
	if GAMESTATE:IsExtraStage() then return "ScreenSelectMusicExtra"; end;
	if GAMESTATE:IsExtraStage2() then return "ScreenSelectMusicExtra2"; end;
	return "ScreenSelectMusic";
end;

function SelectEndingScreen()
	local psStats = STATSMAN:GetPlayedStageStats(1)
	local stagestats = STATSMAN:GetCurStageStats()
	local p1stats = stagestats:GetPlayerStageStats(PLAYER_1)
	local p2stats = stagestats:GetPlayerStageStats(PLAYER_2)
	local stepseconds = psStats:GetPlayedSongs()[1]:GetLastSecond()
	local aliveseconds = getenv("aseconds")
	if psStats:GetStage() == "Stage_Extra2" then
		if not stagestats:AllFailed() and aliveseconds + 1 >= stepseconds then
			return "ScreenCredits"
		end
	elseif GAMESTATE:IsCourseMode() then
		local ccourse = GAMESTATE:GetCurrentCourse();
		local co_stage = ccourse:GetEstimatedNumStages();
		local stindex = getenv("coursestindex");
		if co_stage >= 5 then
			if p1stats:GetSongsPassed() >= co_stage and not stagestats:AllFailed() then
				return "ScreenCredits"
			elseif p2stats:GetSongsPassed() >= co_stage and not stagestats:AllFailed() then
				return "ScreenCredits"
			end
		end
	end
	return NextRanking()
end;

function NextRanking()
	local pm = GAMESTATE:GetPlayMode()
	local stepstype = GAMESTATE:GetCurrentStyle():GetStepsType()
	if GAMESTATE:AnyPlayerHasRankingFeats() then
		if stepstype == 'StepsType_Dance_Single' then
			if pm == 'PlayMode_Regular' then return "ScreenRanking"
			elseif pm == 'PlayMode_Nonstop' then return "ScreenRankingNonstop"
			elseif pm == 'PlayMode_Oni' then return "ScreenRankingChallenge"
			elseif pm == 'PlayMode_Rave' then return "ScreenGameOver"
			else return "ScreenGameOver"
			end
		elseif stepstype == 'StepsType_Dance_Solo' then
			if pm == 'PlayMode_Regular' then return "ScreenRankingSolo"
			elseif pm == 'PlayMode_Nonstop' then return "ScreenRankingNonstopSolo"
			elseif pm == 'PlayMode_Oni' then return "ScreenRankingChallengeSolo"
			else return "ScreenGameOver"
			end
		elseif stepstype == 'StepsType_Dance_Double' then
			if pm == 'PlayMode_Regular' then return "ScreenRankingDouble"
			elseif pm == 'PlayMode_Nonstop' then return "ScreenRankingNonstopDouble"
			elseif pm == 'PlayMode_Oni' then return "ScreenRankingChallengeDouble"
			else return "ScreenGameOver"
			end
		end
	else
		return "ScreenGameOver"
	end
end;

function DemoNextRanking()
	local screen = {
		"ScreenRankingDemo",
		"ScreenRankingNonstopDemo",
		"ScreenRankingChallengeDemo",
		"ScreenRankingSoloDemo",
		"ScreenRankingNonstopSoloDemo",
		"ScreenRankingChallengeSoloDemo",
		"ScreenRankingDoubleDemo",
		"ScreenRankingNonstopDoubleDemo",
		"ScreenRankingChallengeDoubleDemo",
	}
	return screen[math.random(#screen)]
end

function AfterScreenRanking()
	local prevscreen = SCREENMAN:GetTopScreen():GetPrevScreenName()
	if prevscreen == "ScreenRankingDemo" then
		return "ScreenCompany2"
	end
	return "ScreenGameOver"
end;

function ScreenNetSelectPlayMode()
	if IsNetSMOnline() then return SMOnlineScreen() end
	if IsNetConnected() then return "ScreenNetSelectMusic" end
	return "ScreenSelectMusic"
end;

function SMOnlineScreen()
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if not IsSMOnlineLoggedIn(pn) then
			return "ScreenSMOnlineLogin"
		end
	end
	return "ScreenNetRoom"
end

function GetGameInformationScreen()
	return PREFSMAN:GetPreference("ShowInstructions") and "ScreenGameInformation" or Branch.AfterGameInstructions();
end;

Branch = {
	StartGame = function()
		-- Check to see if there are 0 songs installed. Also make sure to check
		-- that the additional song count is also 0, because there is
		-- a possibility someone will use their existing StepMania simfile
		-- collection with sm-ssc via AdditionalFolders/AdditionalSongFolders.
		if SONGMAN:GetNumSongs() == 0 and SONGMAN:GetNumAdditionalSongs() == 0 then
			return "ScreenHowToInstallSongs"
		end
		if PROFILEMAN:GetNumLocalProfiles() >= 2 then
			return "ScreenSelectProfile"
		else
			if THEME:GetMetric("Common","AutoSetStyle") == false then
				return "ScreenSelectStyle"
			else
				return "ScreenProfileLoad"
			end
		end
	end,
	AfterInit = function()
		return "ScreenCompany2"
	end,
	TitleMenu = function()
		-- home mode is the most assumed use of sm-ssc.
		if GAMESTATE:GetCoinMode() == "CoinMode_Home" then
			return "ScreenTitleMenu"
		end
		if beta_vcheck() == false then
			-- arcade junk:
			if GAMESTATE:GetCoinsNeededToJoin() > GAMESTATE:GetCoins() then
				-- if no credits are inserted, don't show the Join screen. SM4 has
				-- this as the initial screen, but that means we'd be stuck in a
				-- loop with ScreenInit. No good.
				return "ScreenTitleJoin"
			else
				return "ScreenTitleJoin"
			end
		else
			return "ScreenTitleJoin"
		end
	end,
	AfterScreenLogo = function()
		-- HowToPlay only works in dance mode; causes crashes on others.
		if GAMESTATE:GetCurrentGame():GetName() == "dance" then
			return "ScreenHowToPlay";
			--return "ScreenDemonstration";
		else
			return "ScreenDemonstration";
		end;
	end,
	GameStartScreen = function()
		if SONGMAN:GetNumSongs() == 0 and SONGMAN:GetNumAdditionalSongs() == 0 then
			return "ScreenHowToInstallSongs"
		end
		if IsNetConnected() then return Branch.SelectStyle() end
		if PREFSMAN:GetPreference("ShowCaution") then return "ScreenCaution" end
		return Branch.SelectStyle()
	end,
	SelectStyle = function()
		return IsNetConnected() and "ScreenSelectStyle2" or "ScreenSelectStyle";
	end,
	AfterSelectDifficulty = function()
		if IsNetConnected() then
			ReportStyle();
			return SMOnlineScreen();
		else
			return SelectMusicOrCourse();
		end;
	end,
	AfterGameInstructions = function()
		if IsNetSMOnline() then return "ScreenNetSelectMusic" end
		local pm = GAMESTATE:GetPlayMode()
		if( pm == "PlayMode_Regular" ) or ( pm == "PlayMode_Rave" ) then return "ScreenSelectMusic" end
		if( pm == "PlayMode_Nonstop" ) then return "ScreenSelectCourseNonstop" end
		if( pm == "PlayMode_Oni" ) then return "ScreenSelectCourseOni" end
		if( pm == "PlayMode_Endless" ) then return "ScreenSelectCourseEndless" end
		--return "ScreenSelectMusic";
	end,
	PlayerOptions = function()
		local pm = GAMESTATE:GetPlayMode()
		local restricted = { "PlayMode_Oni" };
		local restrictedrave = { "PlayMode_Rave" };
		local optionScreen = "ScreenPlayerOptions";
		
		local bSSetting = GetAdhocPref("CustomSpeed");
		for i=1,#restricted do
			if restricted[i] == pm then
				if bSSetting == 'Custom' then
					optionScreen = "ScreenPlayerOptionsRestrictedCT"
				elseif bSSetting == 'CS6' then
					optionScreen = "ScreenPlayerOptionsRestricted"
				else
					optionScreen = "ScreenPlayerOptionsRestricted"
				end;
			end;
			if restrictedrave[i] == pm then
				if bSSetting == 'Custom' then
					optionScreen = "ScreenPlayerOptionsRestrictedRaveCT"
				elseif bSSetting == 'CS6' then
					optionScreen = "ScreenPlayerOptionsRestrictedRave"
				else
					optionScreen = "ScreenPlayerOptionsRestrictedRave"
				end;
			end;
			if restricted[i] ~= pm and restrictedrave [i] ~= pm then
				if bSSetting == 'Custom' then
					optionScreen = "ScreenPlayerOptionsCT"
				elseif bSSetting == 'CS6' then
					optionScreen = "ScreenPlayerOptions"
				else
					optionScreen = "ScreenPlayerOptions"
				end;
			end;
		end
		if SCREENMAN:GetTopScreen():GetGoToOptions() then
			return optionScreen;
		else
			return "ScreenStageInformation";
		end
	end,
	BackOutOfPlayerOptions = function()
		return SelectMusicOrCourse()
	end,
	GameplayScreen = function()
		if GAMESTATE:IsCourseMode() then return "ScreenGameplayCourse" end;
		if GAMESTATE:GetPlayMode() == "PlayMode_Rave"  then return "ScreenGameplayRave" end;
		if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then return "ScreenGameplayExtra" end;
		if IsRoutine() then return "ScreenGameplayShared" end;
		return "ScreenGameplay"
	end,
	AfterGameplay = function()
		-- pick an evaluation screen based on settings.
		if IsNetSMOnline() then
			return "ScreenNetEvaluation"
		else
			local pm = GAMESTATE:GetPlayMode()
			local curstage = STATSMAN:GetCurStageStats():GetStage()
			if( pm == "PlayMode_Rave" ) then return "ScreenEvaluationRave" end;
			if( pm == "PlayMode_Nonstop" ) then return "ScreenEvaluationNonstop" end;
			if( pm == "PlayMode_Oni" ) then return "ScreenEvaluationOni" end;
			if( pm == "PlayMode_Endless" ) then return "ScreenEvaluationEndless" end;
			if curstage == 'Stage_Extra1' then return "ScreenEvaluationExtra" end;
			if curstage == 'Stage_Extra2' then return "ScreenEvaluationExtra2" end;
			return "ScreenEvaluationStage"
		end
	end,
	Network = function()
		return IsNetConnected() and "ScreenOptionsService" or "ScreenOptionsService"
	end,
	AfterSelectStyle = function()
		if IsNetConnected() then
			ReportStyle()
			GAMESTATE:ApplyGameCommand("playmode,regular");
		end
		if IsNetSMOnline() then
			return SMOnlineScreen()
		end
		if IsNetConnected() then
			return "ScreenNetRoom"
		end
		return "ScreenSelectMode"

		--return CHARMAN:GetAllCharacters() ~= nil and "ScreenSelectCharacter" or "ScreenGameInformation"
	end,
	AfterSelectMode = function()
		if PREFSMAN:GetPreference("ShowInstructions") then return "ScreenGameInformation" end
		return Branch.AfterGameInstructions()
		--if pm == "PlayMode_Regular" then return Character() end
		--if pm == "PlayMode_Rave" then return Character() end
		--if pm == "PlayMode_Regular" or pm == "PlayMode_Rave" then return Character() end
	end,
	Character = function()
		return CHARMAN:GetAllCharacters() ~= nil and "ScreenSelectCharacter" or "ScreenGameInformation"
	end,
	AfterSMOLogin = SMOnlineScreen(),

	AfterSelectProfile = function()
		if ( THEME:GetMetric("Common","AutoSetStyle") == true ) then
			-- use SelectStyle in online...
			return IsNetConnected() and "ScreenSelectStyle" or "ScreenSelectPlayMode"
		else
			return "ScreenSelectStyle"
		end
	end,
	AfterProfileLoad = function()
		-- if online, ignore character check and move straight to online
		if IsNetConnected() then ReportStyle() end;
		if IsNetSMOnline() or IsNetConnected() then
			return ScreenNetSelectPlayMode()
		end
		return Branch.AfterSelectMode()
	end,
	AfterProfileSave = function()
		if GAMESTATE:IsEventMode() then
			return SelectMusicOrCourse();
		else
			local bLastStage = GAMESTATE:GetSmallestNumStagesLeftForAnyHumanPlayer() <= 0
			if getenv("omsflag") == 1 then
				return "ScreenStageInformation";
			else
				if GAMESTATE:HasEarnedExtraStage() then
					return SelectMusicOrCourse();
				end;
				if GAMESTATE:IsCourseMode() then
					return "ScreenNameEntry";
				end;
				if not bLastStage then
					return SelectMusicOrCourse();
				end;
			end;
		end;

		return SelectEndingScreen()
	end,
	SongOptions = function()
		if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
			return "ScreenStageInformation"
		elseif SCREENMAN:GetTopScreen():GetGoToOptions() then
			return "ScreenSongOptions"
		else
			return "ScreenStageInformation"
		end
	end,
	BackOutOfStageInformation = function()
		return SelectMusicOrCourse()
	end,
	AfterEvaluation = function()
		local maxsteges = PREFSMAN:GetPreference("SongsPerPlay")
		local curstage = STATSMAN:GetCurStageStats():GetStage()
		local remainstages = GAMESTATE:GetSmallestNumStagesLeftForAnyHumanPlayer()
		local failed = STATSMAN:GetCurStageStats():AllFailed()
		local song = GAMESTATE:GetCurrentSong()
		local psStats = STATSMAN:GetPlayedStageStats(1)

		if GAMESTATE:IsEventMode() then
			return "ScreenProfileSave"
		elseif psStats:GetStage() == "Stage_Extra1" then
			if remainstages < 1 then
				return "ScreenEvaluationSummary"
			else
				return "ScreenProfileSave"
			end
		elseif psStats:GetStage() == "Stage_Extra2" then
			return "ScreenEvaluationSummary"
		elseif remainstages >= 1 then
			return "ScreenProfileSave"
		elseif maxsteges == 1 and remainstages < 1 then
			return "ScreenProfileSaveSummary"
		elseif curstage == 'Stage_1st' and failed then
			return "ScreenProfileSaveSummary"
		elseif song:IsLong() and maxsteges <= 2 and remainstages < 1 then
			return "ScreenProfileSaveSummary"
		elseif song:IsMarathon() and maxsteges <= 3 and remainstages < 1 then
			return "ScreenProfileSaveSummary"	
		elseif maxsteges >= 2 and remainstages < 1 and failed then
			return "ScreenEvaluationSummary"
		else
			return "ScreenEvaluationSummary"
		end
	end,
	AfterSummary = function()
		return "ScreenProfileSaveSummary"
	end,
 	AfterSaveSummary = function()
		if GAMESTATE:AnyPlayerHasRankingFeats() then
			return "ScreenNameEntry"
		else
			return SelectEndingScreen()
		end
	end,
	AfterTextEntry = function()
		for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
			if IsSMOnlineLoggedIn(pn) then
				return "ScreenNetRoom"
			end
		end
	end,
};