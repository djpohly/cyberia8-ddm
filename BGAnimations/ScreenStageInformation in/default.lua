local t = Def.ActorFrame{};

setenv("sortflag",0);

-------------------------------------------------------------------------------------------------------------------------
if getenv("omsflag") == 1 and GAMESTATE:IsExtraStage2() then
	if GAMESTATE:GetNumPlayersEnabled() == 1 then
		--expoints_reset
		local psStats = STATSMAN:GetPlayedStageStats(1);
		local sys_group = "";
		local cscpoint = 0;

		local ccstpoint = getenv("ccstpoint");

		if psStats then
			sys_group = psStats:GetPlayedSongs()[1]:GetGroupName();
		end;

		local txt_folders = GetGroupParameter(sys_group,"Extra1List");
		local chk_folders = split(":",txt_folders);
		local songst = getenv("songst");
		local pn;
		if GAMESTATE:IsHumanPlayer(PLAYER_1) then pn = PLAYER_1;
		else pn = PLAYER_2;
		end;
		local playername = GAMESTATE:GetPlayerDisplayName(pn);
		local cs_path = "CSDataSave/"..playername.."_Save/0000_co "..sys_group.."";
		function GetCSCCount()
			local pointtext = {};
			local sys_songc = split(":",GetCSCParameter(sys_group,"Status",playername));
			local sys_spoint;
			for k=1, #chk_folders do
				if File.Read( cs_path ) then
					if chk_folders[k] == songst then
						pointtext[#pointtext+1] = { ""..songst..",0:" };
					else
						pointtext[#pointtext+1] = { ""..chk_folders[k]..",0:" };
					end;
				else
					if chk_folders[k] == songst then
						pointtext[#pointtext+1] = { ""..songst..",0:" };
					else
						pointtext[#pointtext+1] = { ""..chk_folders[k]..",0:" };
					end;
				end;
			end;
			return pointtext;
		end;
		
		local CSCList = GetCSCCount();
		local csctext = "#Status:";

		for i=1, #chk_folders do
			if CSCList[i] then
				csctext = csctext..""..table.concat(CSCList[i]);
			else
				csctext = csctext;
			end;
		end;
		csctext = string.sub(csctext,1,-2);
		csctext = csctext..";\r\n";
		File.Write( cs_path , csctext );

		local pn;
		if GAMESTATE:IsHumanPlayer(PLAYER_1) then pn = 1;
		else pn = 2;
		end;

		local bExtra2 = GAMESTATE:IsExtraStage2();
		local style = GAMESTATE:GetCurrentStyle();
		local song, steps = SONGMAN:GetExtraStageInfo( bExtra2, style );

		-- [ja] 楽曲情報文字列（#ExtraXSongsの中身）
		local txt_folders = GetGroupParameter(sys_group,"Extra2List");
		chk_folders = split(":",txt_folders);
		local gsong = GetFolder2Song(sys_group,chk_folders[1]);
		if gsong then
			if chk_folders[1] ~= "" then
				song = gsong;
			end;
			GAMESTATE:SetCurrentSong(song);

			local sys_difficulty = split(":",string.lower(GetGroupParameter(sys_group,"Extra2Difficulty")));
			if sys_difficulty[1] ~= "" then
				local diffset = "";
				if sys_difficulty[1] == "beginner" then diffset = "Beginner";
				elseif sys_difficulty[1] == "easy" then diffset = "Easy";
				elseif sys_difficulty[1] == "medium" then diffset = "Medium";
				elseif sys_difficulty[1] == "hard" then diffset = "Hard";
				elseif sys_difficulty[1] == "challenge" then diffset = "Challenge";
				else diffset = "";
				end;

				if diffset ~= "" then
					local newstep = song:GetOneSteps(style:GetStepsType(),"Difficulty_"..diffset);
					GAMESTATE:SetCurrentSteps('PlayerNumber_P'..pn,newstep);
				else
					GAMESTATE:SetCurrentSteps('PlayerNumber_P'..pn,steps);
				end;
			else
				GAMESTATE:SetCurrentSteps('PlayerNumber_P'..pn,steps);
			end;
		else
			GAMESTATE:SetCurrentSong(song);
			GAMESTATE:SetCurrentSteps('PlayerNumber_P'..pn,steps);
		end;
		
		-- [ja] omsフラグの時のライフ設定
		-- [ja] ゲージの状態を指定（この時点では定義だけで、実際には反映されない） 
		local exlife = GetGroupParameter(sys_group,"Extra2LifeLevel");

		if string.lower(exlife)=="hard" then
			setenv("ExLifeLevel","Hard");
		elseif string.lower(exlife)=="1" then
			setenv("ExLifeLevel","1");
		elseif string.lower(exlife)=="2" then
			setenv("ExLifeLevel","2");
		elseif string.lower(exlife)=="3" then
			setenv("ExLifeLevel","3");
		elseif string.lower(exlife)=="4" then
			setenv("ExLifeLevel","4");
		elseif string.lower(exlife)=="5" then
			setenv("ExLifeLevel","5");
		elseif string.lower(exlife)=="6" then
			setenv("ExLifeLevel","6");
		elseif string.lower(exlife)=="7" then
			setenv("ExLifeLevel","7");
		elseif string.lower(exlife)=="8" then
			setenv("ExLifeLevel","8");
		elseif string.lower(exlife)=="9" then
			setenv("ExLifeLevel","9");
		elseif string.lower(exlife)=="10" then
			setenv("ExLifeLevel","10");
		elseif string.lower(exlife)=="pfc" or string.lower(exlife)=="w2fc" then
			setenv("ExLifeLevel","PFC");
		elseif string.lower(exlife)=="mfc" or string.lower(exlife)=="w1fc" then
			setenv("ExLifeLevel","MFC");
		elseif string.lower(exlife)=="hardnorecover" or string.lower(exlife)=="hex1" then
			setenv("ExLifeLevel","HardNoRecover");
		elseif string.lower(exlife)=="norecover" or string.lower(exlife)=="ex1" then
			setenv("ExLifeLevel","NoRecover");
		elseif string.lower(exlife)=="suddendeath" or string.lower(exlife)=="ex2" then
			setenv("ExLifeLevel","Suddendeath");
		else
			setenv("ExLifeLevel","Normal");
		end;
		-- [ja] 強制的に現在の設定を反映させることでEXステージでもプレイヤーオプションが初期化されない
		for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
			local ps = GAMESTATE:GetPlayerState(pn);
			local modstr = "default, " .. ps:GetPlayerOptionsString("ModsLevel_Stage");
			ps:SetPlayerOptions("ModsLevel_Stage", modstr);
			MESSAGEMAN:Broadcast( "PlayerOptionsChanged", {PlayerNumber = pn} )
		end
		EXFolderLifeSetting();
	end;
end;

-- [ja] CSフラグの時のライフ設定
if getenv("exflag") == "csc" then
	-- [ja] 強制的に現在の設定を反映させることでEXステージでもプレイヤーオプションが初期化されない
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		local ps = GAMESTATE:GetPlayerState(pn);
		local modstr = "default, " .. ps:GetPlayerOptionsString("ModsLevel_Stage");
		ps:SetPlayerOptions("ModsLevel_Stage", modstr);
		MESSAGEMAN:Broadcast( "PlayerOptionsChanged", {PlayerNumber = pn} )
	end
	EXFolderLifeSetting();
end;

-------------------------------------------------------------------------------------------------------------------------
local coursemode = GAMESTATE:IsCourseMode();
local songorcourse;
local sjacketPath ,sbannerpath ,scdimagepath, cbannerpath;
if coursemode then
	songorcourse = GAMESTATE:GetCurrentCourse();
	cbannerpath = songorcourse:GetBannerPath();
else
	songorcourse = GAMESTATE:GetCurrentSong();
	sbannerpath = songorcourse:GetBannerPath();
	sjacketpath = songorcourse:GetJacketPath();
	scdimagepath = songorcourse:GetCDImagePath();
end;

t[#t+1] = Def.ActorFrame{
	Def.Sound {
		OnCommand=function(self)
			if getenv("omsflag") == 0 then
				if getenv("exflag") == "csc" then
					self:load(THEME:GetPathS("","_csstagedecide"));
				else
					self:load(THEME:GetPathS("","_stagedecide"));
				end;
				self:stop();
				self:play();
			end
		end;
	};

	LoadActor("stagesongback_effect")..{
	};
	LoadActor("stageback_effect")..{
	};
};

local showjacket = GetAdhocPref("ShowJackets");
if showjacket == "On" then
	if coursemode then
		if cbannerpath then
			if string.find(cbannerpath,"jacket") then
				t[#t+1] = LoadActor("jacket")..{};
			else
				t[#t+1] = LoadActor("banner")..{};
			end;
		else
			t[#t+1] = LoadActor("jacket")..{};
		end;
	else
		if (not sbannerpath and (sjacketpath or scdimagepath)) then
			t[#t+1] = LoadActor("jacket")..{};
		elseif sbannerpath and (sjacketpath or scdimagepath) then
			t[#t+1] = LoadActor("plus")..{};
		elseif sbannerpath and not sjacketpath and not scdimagepath then
			t[#t+1] = LoadActor("banner")..{};
		else
			t[#t+1] = LoadActor("jacket")..{};
		end;
	end;
else
	t[#t+1] = LoadActor("banner")..{};
end;
	
t[#t+1] = LoadActor("songtitle")..{
};

--[[
t[#t+1] = LoadFont("Common Normal")..{
	OnCommand=function(self)
		self:settext(cbannerpath);
	end;
};
]]

if not IsNetConnected() then
	t[#t+1] = LoadActor("stageregular_effect")..{
	};
end;

t[#t+1] = Def.ActorFrame{
	LoadActor("mode")..{
	};

	LoadActor("style")..{
	};
	
	LoadActor("difficulty")..{
	};

	Def.Quad{
		OnCommand=cmd(FullScreen;diffuse,color("1,1,1,1");accelerate,0.5;diffuse,color("0,0,0,0"););
	};
	
	Def.Quad{
		OnCommand=cmd(diffuse,color("1,1,0,0.4");vertalign,top;x,SCREEN_CENTER_X;y,SCREEN_TOP;
					zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT*0.5;decelerate,0.4;fadebottom,0.4;zoomtoheight,0;);
	};

	Def.Quad{
		OnCommand=cmd(diffuse,color("1,1,0,0.4");vertalign,bottom;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM;
					zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT*0.5;decelerate,0.4;fadetop,0.4;zoomtoheight,0;);
	};
	
	Def.Quad{
		OnCommand=cmd(blend,'BlendMode_Add';diffuse,color("0,0,1,1");x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;
					zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;fadetop,0.2;fadebottom,0.2;accelerate,0.4;
					zoomtoheight,SCREEN_HEIGHT*0.6;diffusealpha,0;);
	};
	
	Def.Quad{
		OnCommand=cmd(blend,'BlendMode_Add';diffuse,color("0.6,0.3,0,1");x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;
					zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;fadetop,0.2;fadebottom,0.2;accelerate,0.25;
					zoomtoheight,SCREEN_HEIGHT*0.4;diffusealpha,0;);
	};
};

if getenv("omsflag") == 1 and GAMESTATE:IsExtraStage2() then
	local co = getenv("cpoint");
	t[#t+1] = Def.ActorFrame{
		OnCommand=cmd(x,SCREEN_LEFT+60;y,SCREEN_TOP+60;zoom,2.5;sleep,2.5;linear,0.2;zoomy,0;);
		LoadFont("CourseEntryDisplay","number") .. {
			OnCommand=cmd(blend,'BlendMode_Add';horizalign,left;diffuse,color("0,1,1,0");skewx,-0.125;
					maxwidth,80;sleep,0.5;linear,0.2;diffuse,color("0,1,1,0.5");playcommand,"Count";);
			CountCommand=function(self)
				local ccount = getenv("cpoint")
				self:sleep(1.4/ccount);
				self:settext(co);
				co = co - 1;
				if co >= 0 then
					self:queuecommand("Count");
				end;
			end;
		};
	};
end;

return t;