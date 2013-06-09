
--[[ScreenSelectMusicCS scroller]]

local index = Var("GameCommand"):GetIndex();
local text = Var("GameCommand"):GetText();

setenv("sortflag",1);

local t = Def.ActorFrame{};

local ssStats = STATSMAN:GetPlayedStageStats(1);
local pn;
if GAMESTATE:IsHumanPlayer(PLAYER_1) then pn = PLAYER_1
else  pn = PLAYER_2
end;
local playername = GAMESTATE:GetPlayerDisplayName(pn);

local st = GAMESTATE:GetCurrentStyle():GetStepsType();
local maxstage = PREFSMAN:GetPreference("SongsPerPlay");

local key_open = 0;
local song = "";
local sdif_p1 = 0;
local sdif_p2 = 0;
local cccsong = ""
---------------------------------------------------------------------------------------------------------------------------------------

-- [ja] chk_XXX … group.iniに定義されている曲用 
local chk_folders={};
local chk_songs={};

-- [ja] load_XXX … 実際に選曲できる曲用 
local load_folders={};
local load_songs={};
local load_cnt=0;
local load_jackets={};
local load_songtitle={};
local load_songartist={};

local dif_list = {
	'Difficulty_Beginner',
	'Difficulty_Easy',
	'Difficulty_Medium',
	'Difficulty_Hard',
	'Difficulty_Challenge'
};

local sys_group ="";
local sys_dif = {4,4};
-- [ja] 指定難易度が存在しないときに、 
-- 上の難易度を選択するか下の難易度を選択するか記憶用変数 
-- (移動前の番号) 
local sys_dif_old={4,4};
local sys_dif_new = {4,4};
-- [ja] ホイール移動量 
local sys_wheel=0.0;
local sys_focus=0;

-- [ja] (CS未使用) システム的にキー操作を受け付けるタイミング 
local sys_keyok=false;

-- [ja] 対象グループ
if ssStats then
	sys_group = ssStats:GetPlayedSongs()[1]:GetGroupName();
end;

-- [ja] (CS未使用)
local exstage = 1;
if GAMESTATE:GetCurrentStage() == 'Stage_Extra2' then exstage = 2;
end;

-- [ja] (CS未使用) 選曲式か、強制確定か 
local sys_extype = GetGroupParameter(sys_group,"Extra1Type");
sys_extype = string.lower(sys_extype);

-- [ja] 楽曲情報文字列（#ExtraXSongsの中身）
local sys_songunlock = split(":",string.lower(GetGroupParameter(sys_group,"Extra1Songs")));
local sys_songunlockU = split(":",GetGroupParameter(sys_group,"Extra1Songs"));
-- [ja] 難易度別条件取得（曲切り替えのたびに代入） 
local sys_songunlock_prm1;
local sys_songunlock_prm1U;
-- [ja] 取得した難易度別条件をさらにパラメータごとに分割 
local sys_songunlock_prm2;
local sys_songunlock_prm2U;

-- [ja] 難易度別解禁（曲を切り替えるたびに呼び出し）
local sys_difunlock={true,true,true,true,true,true};

-- [ja] ゲージの状態を指定（この時点では定義だけで、実際には反映されない） 
local exlife = GetGroupParameter(sys_group,"Extra1LifeLevel");

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

local rnd_base = math.round(GetStageState("PDP", "Last", "+")*10000);
local rnd_folder="";
local rnd_song;
local sp_songtitle="";
local sp_songartist="";
local sp_songjacket={"",""};
local sp_songbanner={"",""};

-- [ja] 出現条件を満たしている難易度を返す 
-- foldername = Extra1List
local function SetDifficultyFlag(groupname,foldername)
	local sdif_list={
		'$',
		'%-beginner$',
		'%-easy$',
		'%-medium$',
		'%-hard$',
		'%-challenge$'
	};
	-- [ja] 全譜面選択可能状態 
	local diflock={true,true,true,true,true};
	local expath;
	if File.Read( "/Songs/"..sys_group.."/group.ini" ) then
		expath =  "/Songs/"..sys_group.."/";
	elseif File.Read("/AdditionalSongs/"..sys_group.."/group.ini") then
		expath = "/AdditionalSongs/"..sys_group.."/";
	else
		expath = false;
	end;
	rnd_folder = "";
	sp_songtitle = "";
	sp_songartist = "";
	sp_songjacket = {"",""};
	sp_songbanner = {"",""};
	-- sys_songunlock = Extra1Songs
	-- [ja] group.iniに記載されている条件を満たさない譜面のフラグをfalseにする
	for k = 1, #sys_songunlock do 
		if string.find(sys_songunlock[k],""..string.lower(foldername).."|",1,true) then
			sys_songunlock_prm1 = split("|",sys_songunlock[k]);
			sys_songunlock_prm1U = split("|",sys_songunlockU[k]);
			if #sys_songunlock_prm1 >= 2 then	-- [ja] 曲フォルダ名,条件1...となるのでパラメータが2つ以上ないと不正 
				for l = 2, #sys_songunlock_prm1 do
					sys_songunlock_prm2 = split(">",sys_songunlock_prm1[l]);
					sys_songunlock_prm2U = split(">",sys_songunlock_prm1U[l]);
					if #sys_songunlock_prm2 > 1 then	-- [ja] パラメータが2つ以上ない場合は不正な書式として無視する 
						if sys_songunlock_prm2[1] == "random" then
							rnd_folder = sys_songunlock_prm2[(rnd_base%(#sys_songunlock_prm2-1))+2];
							rnd_song = GetFolder2Song(groupname,rnd_folder);
						elseif sys_songunlock_prm2[1] == "banner" then
							if File.Read(expath..""..sys_songunlock_prm2[2]) then
								sp_songbanner[0] = GetFolder2Song(groupname,foldername):GetSongDir();
								sp_songbanner[1] = expath..""..sys_songunlock_prm2[2];
								if load_jackets[""..foldername] == nil then
									load_jackets[""..foldername]=sp_songbanner[1];
								end;
							end;
						elseif sys_songunlock_prm2[1] == "jacket" then
							if File.Read(expath..""..sys_songunlock_prm2[2]) then
								sp_songjacket[0] = GetFolder2Song(groupname,foldername):GetSongDir();
								sp_songjacket[1] = expath..""..sys_songunlock_prm2[2];
								load_jackets[""..foldername] = sp_songjacket[1];
							end;
						elseif sys_songunlock_prm2[1] == "title" then
							sp_songtitle=sys_songunlock_prm2U[2];
							load_songtitle[""..foldername] = sp_songtitle;
						elseif sys_songunlock_prm2[1] == "artist" then
							sp_songartist=sys_songunlock_prm2U[2];
							load_songartist[""..foldername] = sp_songartist;
						elseif #sys_songunlock_prm2 == 3 then
							local chk_mode;
							if string.find(sys_songunlock_prm2[1],"^last.*") then
								chk_mode="last";
							elseif string.find(sys_songunlock_prm2[1],"^max.*") then
								chk_mode="max";
							elseif string.find(sys_songunlock_prm2[1],"^min.*") then
								chk_mode="min";
							elseif string.find(sys_songunlock_prm2[1],"^played.*") then
								chk_mode="played";
							else
								chk_mode="avg";
							end;
							-- [ja] めんどいんで数値以外を条件にした場合無視 
							local break_flag = false;
							if tonumber(sys_songunlock_prm2[2]) then
								-- [ja] 難易度別 
								for dif = 1,6 do
									if not break_flag then
										local ret = -9999999999;	--[ja] 目標数値
										if string.find(sys_songunlock_prm2[1],"^.*grade"..sdif_list[dif]) then
											ret = GetStageState("grade", chk_mode, sys_songunlock_prm2[3]);
										elseif string.find(sys_songunlock_prm2[1],"^.*pdp"..sdif_list[dif]) 
											or string.find(sys_songunlock_prm2[1],"^.*perdancepoints"..sdif_list[dif]) then	--[ja] DPより先にPDPを書いておかないと条件を満たしてしまう 
											ret = GetStageState("pdp", chk_mode, sys_songunlock_prm2[3])*100;
										elseif string.find(sys_songunlock_prm2[1],"^.*dp"..sdif_list[dif]) 
											or string.find(sys_songunlock_prm2[1],"^.*dancepoints"..sdif_list[dif]) then
											ret = GetStageState("dp", chk_mode, sys_songunlock_prm2[3]);
										elseif string.find(sys_songunlock_prm2[1],"^.*combo"..sdif_list[dif]) 
											or string.find(sys_songunlock_prm2[1],"^.*maxcombo"..sdif_list[dif]) then
											ret = GetStageState("combo", chk_mode, sys_songunlock_prm2[3]);
										elseif string.find(sys_songunlock_prm2[1],"^.*meter"..sdif_list[dif]) then
											ret = GetStageState("meter", chk_mode, sys_songunlock_prm2[3]);
										else
											ret = -9999999999;
										end;
										if ret > -9999999999 then
											if sys_songunlock_prm2[3] == "+" or sys_songunlock_prm2[3] == "over" then
												if ret < tonumber(sys_songunlock_prm2[2]) then
													if dif == 1 then
														diflock = {false,false,false,false,false};
													else
														diflock[dif-1] = false;
													end;
												else
													diflock[dif-1] = true;
												end;
												break_flag = true;
												
											elseif sys_songunlock_prm2[3] == "-" or sys_songunlock_prm2[3] == "under" then
												if ret > tonumber(sys_songunlock_prm2[2]) then
													if dif == 1 then
														diflock = {false,false,false,false,false};
													else
														diflock[dif-1] = false;
													end;
												else
													diflock[dif-1] = true;
												end;
											end;
											break_flag = true;
										end;
									end;
								end;
							else
							-- [ja] その結果バージョン1.1で苦労したっていう 
								for dif = 1,6 do
									if not break_flag then
										local ret = 0;
										if string.find(sys_songunlock_prm2[1],"^.*song"..sdif_list[dif]) then
											ret=GetStageState("song", sys_songunlock_prm2[2], sys_songunlock_prm2[3]);
										end;
										if sys_songunlock_prm2[3] == "+" or sys_songunlock_prm2[3] == "over" then
											if (chk_mode == "played" and ret == 0) or (chk_mode == "last" and ret < maxstage) then
												if dif == 1 then
													diflock = {false,false,false,false,false};
												else
													diflock[dif-1] = false;
												end;
											else
												diflock[dif-1] = true;
											end;
											break_flag = true;
										elseif sys_songunlock_prm2[3] == "-" or sys_songunlock_prm2[3] == "under" then
											if (chk_mode=="played" and ret > 0) or (chk_mode == "last" and ret == maxstage) then
												if dif == 1 then
													diflock = {false,false,false,false,false};
												else
													diflock[dif-1] = false;
												end;
											else
												diflock[dif-1] = true;
											end;
										end;
										break_flag = true;
									end;
								end;
							end;
						end;
					end;
					if diflock[1]==false or diflock[2]==false or diflock[3]==false 
					or diflock[4]==false or diflock[5]==false then
					--	break;
					end;
				end;
			end;
			break;
		end;
	end;
	return diflock;
end;


-- [ja] グローバル変数と混ざっててアレな関数 
local function GetExFolderSongList()
	local txt_folders = GetGroupParameter(sys_group,"Extra1List");
	chk_folders = split(":",txt_folders);
	-- [ja] 選択可能な曲を取得 
	--local str = "";
	--getenv("songstr")
	--for j = string.sub(getenv("songstr"),1,1), string.sub(getenv("songstr"),-1) do
	for j=1,#chk_folders do
		-- foldername = Extra1List
		local gsong = GetFolder2Song(sys_group,chk_folders[j])
		if gsong then
			-- [ja] ここで選択可能な難易度をチェックして、全難易度選択不可能なら登録しない 
			sys_difunlock = SetDifficultyFlag(sys_group,chk_folders[j]);
			-- [ja] フラグfalse or 譜面自体が存在しない場合選択不可能に設定   
			local unlock_chk = 0;
			for k = 1,5 do
				if ((not gsong:HasStepsTypeAndDifficulty(st,dif_list[k])) or sys_difunlock[k] == false) then
					-- [ja] ここではあくまでも曲の登録をするかの問題なので、フラグ自体をいじらない 
					unlock_chk = unlock_chk+1;
				end;
			end;
			if unlock_chk < 5 then 
				load_cnt=load_cnt + 1;
				load_songs[load_cnt] = gsong;
				load_folders[load_cnt] = chk_folders[j];
			end;
		end;
	end;
end;
GetExFolderSongList();

t[#t+1] = Def.ActorFrame {
	CodeCommand=function(self,params)
		if params.Name == "SetState" then
			if getenv("pointset") == 0 then
				self:playcommand("Start");
			end;
		end;
	end;
	LoadActor(THEME:GetPathS("","_prompt")) .. {
		StartCommand=function(self)
			self:stop();
			self:play();
		end;
	};
};

--[[
t[#t+1] = LoadFont("Common normal")..{
	InitCommand=cmd(shadowlength,1;strokecolor,color("0,0,0,1");horizalign,right;);
	BeginCommand=function(self)
		(cmd(settext,index+1))(self)
	end;
};

t[#t+1] = LoadFont("Common normal")..{
	InitCommand=cmd(y,-14;shadowlength,1;strokecolor,color("0,0,0,1");horizalign,right;);
	BeginCommand=function(self)
		local dif_unlock = getenv("sys_difunlock");
		if dif_unlock[0] == true then (cmd(settext,"tt"))(self)
		else (cmd(settext,"ss"))(self)
		end;
	end;
};

t[#t+1] = LoadFont("Common normal")..{
	InitCommand=cmd(y,14;shadowlength,1;strokecolor,color("0,0,0,1");horizalign,right;playcommand,"Set");
	CodeMessageCommand = function(self, params)
		if (params.Name == 'Up' or params.Name == 'Up2') then
			self:playcommand("Set");
		elseif (params.Name == 'Down' or params.Name == 'Down2') then
			self:playcommand("Set");
		end;
	end;
	SetCommand=function(self)
		(cmd(settext,THEME:GetMetric( "ScreenSelectMusicCS", "DefaultChoice" )))(self)
	end;
	GainFocusCommand=cmd(playcommand,"Set");
	LoseFocusCommand=cmd(playcommand,"Set");
};


t[#t+1] = LoadFont("Common normal")..{
	InitCommand=cmd(y,28;shadowlength,1;strokecolor,color("0,0,0,1");horizalign,right;);
	BeginCommand=function(self)
		if getenv("rnd_song") == 1 then
			(cmd(settext,"11"))(self)
		else
			(cmd(settext,"00"))(self)
		end;
	end;
	GainFocusCommand=cmd(playcommand,"Begin");
	LoseFocusCommand=cmd(playcommand,"Begin");
};
]]

t[#t+1] = Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=function(self)
			if rnd_folder ~= "" then
				setenv("rnd_song",1);
			else
				setenv("rnd_song",0);
			end;
			(cmd(stoptweening;linear,1.25;playcommand,"Key"))(self)
		end;
		OnCommand=function(self)
			if not GAMESTATE:GetCurrentSong() then
				if text == string.sub(getenv("songstr"),1,1) then
					local ssong;
					if rnd_folder ~= "" then
						ssong  = rnd_song;
						setenv("rnd_song",1);
					else
						ssong = load_songs[index+1];
						setenv("rnd_song",0);
					end;
					GAMESTATE:SetCurrentSong(ssong);
					(cmd(queuecommand,"GainFocus"))(self)
				else
					(cmd(queuecommand,"LoseFocus"))(self)
				end;
			end;
			(cmd(stoptweening;linear,1.25;playcommand,"Key"))(self)
		end;
		KeyCommand=function(self)
			key_open = 1;
			self:playcommand("CC");
		end;
		CodeMessageCommand = function(self, params)
			if GAMESTATE:IsHumanPlayer(params.PlayerNumber) then
				if (params.Name == 'Up' or params.Name == 'Up2') then
					if key_open == 1 then
						local pn=((params.PlayerNumber==PLAYER_1) and 1 or 2);
						local sys_dif_tmp=sys_dif[pn];
						sys_dif[pn]=sys_dif[pn]-1;
						if sys_dif[pn]<1 then sys_dif[pn]=1 end;
						while (sys_dif[pn]>1 and (not song:HasStepsTypeAndDifficulty(st,dif_list[sys_dif[pn]]) or sys_difunlock[sys_dif[pn]]==false)) do
							sys_dif[pn]=sys_dif[pn]-1;
						end;
						if sys_dif[pn]<1 then sys_dif[pn]=sys_dif_tmp; end;
						sys_dif_old[pn]=sys_dif[pn];
						self:playcommand("CC");
					end;
				elseif (params.Name == 'Down' or params.Name == 'Down2') then
					if key_open == 1 then
						local pn=((params.PlayerNumber==PLAYER_1) and 1 or 2);
						local sys_dif_tmp=sys_dif[pn];
						sys_dif[pn]=sys_dif[pn]+1;
						if sys_dif[pn]>#dif_list then sys_dif[pn]=#dif_list end;
						while (sys_dif[pn]<#dif_list and (not song:HasStepsTypeAndDifficulty(st,dif_list[sys_dif[pn]]) or sys_difunlock[sys_dif[pn]]==false)) do
							sys_dif[pn]=sys_dif[pn]+1;
						end;
						if sys_dif[pn]>#dif_list then sys_dif[pn]=sys_dif_tmp; end;
						sys_dif_old[pn]=sys_dif[pn];
						self:playcommand("CC");
					end;
				elseif params.Name=="Start" or params.Name == "Start2" then
					key_open = 0;
				end;
			end;
		end;
		SetCommand=cmd(playcommand,"CC");
		CCCommand=function(self)
			-- [ja] スクローラーの場合ここに全部入れてしまうと不具合が起こるので分散
			-- [ja] ここではじめて選択不可能な譜面のフラグを設定する
			sys_difunlock = SetDifficultyFlag(sys_group,load_folders[index+1]);
			-- [ja] 選択可能難易度確認 
			for pn=1,2 do
				if GAMESTATE:IsHumanPlayer('PlayerNumber_P'..pn) then
					sys_dif[pn] = sys_dif_old[pn];
					while ((not song:HasStepsTypeAndDifficulty(st,dif_list[sys_dif[pn]])) or sys_difunlock[sys_dif[pn]] == false) do
						if sys_dif_old[pn] > 3 then
							sys_dif[pn] = sys_dif[pn] - 1;
							if sys_dif[pn] < 1 then sys_dif[pn] = #dif_list end;
						else
							sys_dif[pn]=sys_dif[pn] + 1;
							if sys_dif[pn] > #dif_list then sys_dif[pn] = 1 end;
						end;
					end;
					local newstep = song:GetOneSteps(st,dif_list[sys_dif[pn]]);
					GAMESTATE:SetCurrentSteps('PlayerNumber_P'..pn,newstep);
				end;
			end;
		end;
		GainFocusCommand=function(self)
			setenv("songst",load_folders[index+1]);
			if rnd_folder ~= "" then
				song  = rnd_song;
				setenv("rnd_song",1);
			else
				song = load_songs[index+1];
				setenv("rnd_song",0);
			end;
			GAMESTATE:SetCurrentSong(song);
			setenv("difunlock_flag",SetDifficultyFlag(sys_group,load_folders[index+1]));
			setenv("sys_difunlock",sys_difunlock);
			setenv("ctext",text);
			setenv("load_index",index);
			setenv("choiceindex",index+1);
			setenv("cs_song",song);
			setenv("load_jackets",load_jackets);
			setenv("load_songs",load_songs);
			setenv("load_folders",load_folders[index+1]);
			setenv("load_cnt",load_cnt);
			setenv("load_songtitle",load_songtitle[load_folders[index+1]]);
			setenv("load_songartist",load_songartist[load_folders[index+1]]);
			(cmd(stoptweening;linear,1.25;playcommand,"Key"))(self)
		end;
		LoseFocusCommand=function(self)
			song = "";
			(cmd(finishtweening;visible,false))(self)
		end;
	};
};

---------------------------------------------------------------------------------------------------------------------------------------

t[#t+1] = Def.ActorFrame {
	OnCommand=function(self)
		if text == THEME:GetMetric( "ScreenSelectMusicCS", "DefaultChoice" ) then
			(cmd(zbuffer,true;queuecommand,"GainFocus"))(self)
		else
			(cmd(zbuffer,true;queuecommand,"LoseFocus"))(self)
		end;
	end;
	GainFocusCommand=cmd(diffusealpha,0.3;zoom,0.75;linear,0.02;zoom,1.15;diffusealpha,0.9;queuecommand,"Repeat";);
	LoseFocusCommand=cmd(diffusealpha,0.8;zoom,1.15;linear,0.02;zoom,0.75;diffusealpha,0.3;queuecommand,"Repeat";);
	RepeatCommand=cmd(spin;effectmagnitude,0,-30,0;);

	LoadActor( THEME:GetPathB("_shared","models/_08_sq") )..{
		OnCommand=function(self)
			local mstr = string.sub(getenv("songstr"),-1)
			local cstr = (360/mstr)*(text-1);
			(cmd(zoom,1.2;glow,(HSVA( cstr,1,1,0.3 ))))(self)
		end;
	};

};

t[#t+1] = Def.ActorFrame {
	OnCommand=function(self)
		if text == THEME:GetMetric( "ScreenSelectMusicCS", "DefaultChoice" ) then
			(cmd(queuecommand,"GainFocus"))(self)
		else
			(cmd(queuecommand,"LoseFocus"))(self)
		end;
	end;
	GainFocusCommand=cmd(diffusealpha,0.3;zoom,0.75;linear,0.02;zoom,1.15;diffusealpha,0.9;queuecommand,"Repeat";);
	LoseFocusCommand=cmd(diffusealpha,0.8;zoom,1.15;linear,0.02;zoom,0.75;diffusealpha,0.3;queuecommand,"Repeat";);
	RepeatCommand=cmd(spin;effectmagnitude,0,-30,0;);

	Def.Banner {
		OnCommand=function(self)
			local song;
			if rnd_folder ~= "" then
				song  = rnd_song;
			else
				song = load_songs[index+1];
			end;
			if song then
				if load_jackets[load_folders[index+1]] ~= nil then
					self:Load(load_jackets[load_folders[index+1]]);
				else
					self:Load(song:GetJacketPath());
				end;
			else
				self:Load( THEME:GetPathG("Common","fallback jacket") );
			end;
			self:zoomtowidth(100);
			self:zoomtoheight(100);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"On");
	};
};

local stateset;
stateset = Def.ActorFrame{
	LoadFont("CourseEntryDisplay","number") .. {
		OnCommand=cmd(x,50;y,30;rotationz,-10;diffuse,color("1,1,0,0.75");zoom,1.25);
		CodeMessageCommand=function(self,params)
			if params.Name == "SetState" then
				if getenv("pointset") == 0 then
					setenv("pointset",1);
				end;
			end;
		end;
		SetCommand=function(self)
			self:stoptweening();
			if getenv("pointset") == 1 then
				local cs_path = "CSDataSave/"..playername.."_Save/0000_co "..sys_group.."";
				local sys_songc = split(":",GetCSCParameter(sys_group,"Status",playername));
				if File.Read( cs_path ) then
					local sys_spoint = split(",",sys_songc[index+1]);
					self:settext(sys_spoint[2]);
				end;
			end;
		end;
		NoSetCommand=function(self)
			self:stoptweening();
			self:settext("");
		end;
	};
};

local function update(self)
	if getenv("pointset") == 1 then
		self:queuecommand("Set");
	else
		self:queuecommand("NoSet");
	end;
end;

stateset.InitCommand=cmd(SetUpdateFunction,update;);

t[#t+1] = stateset;

return t;