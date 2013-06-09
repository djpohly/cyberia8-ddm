InitUserPrefs();

local t = Def.ActorFrame {};

--[ja] 選曲画面他でフラグとして使います
setenv("exdcount",0);
setenv("csflag",0);
setenv("exflag","");
setenv("songstr","");
setenv("ExLifeLevel","Normal");
setenv("difunlock_flag","");
setenv("sys_difunlock","");
setenv("ctext","");
setenv("load_index","");
setenv("choiceindex","");
setenv("cs_song","");
setenv("load_jackets","");
setenv("load_songs","");
setenv("load_folders","");
setenv("load_cnt","");
setenv("load_songtitle","");
setenv("load_songartist","");
setenv("songst","");
setenv("rnd_song",0);
setenv("ccstpoint",0);
setenv("pointset",0);
setenv("omsflag",0);

setenv("psflag","");
setenv("sortflag",0);
setenv("SSort","");
setenv("SortCh","Group");
setenv("envAllowExtraStage",PREFSMAN:GetPreference("AllowExtraStage"));
GAMESTATE:ApplyGameCommand("sort,Group");

t[#t+1] = StandardDecorationFromFileOptional("VersionInfo","VersionInfo");
t[#t+1] = StandardDecorationFromFileOptional("CSVersionInfo","CSVersionInfo");
t[#t+1] = StandardDecorationFromFileOptional("Clock","Clock");
t[#t+1] = StandardDecorationFromFileOptional("CurrentGametype","CurrentGametype");
t[#t+1] = StandardDecorationFromFileOptional("LifeDifficulty","LifeDifficulty");
t[#t+1] = StandardDecorationFromFileOptional("TimingDifficulty","TimingDifficulty");
t[#t+1] = StandardDecorationFromFileOptional("MaxStages","MaxStages");

t[#t+1] = StandardDecorationFromFileOptional("NetworkStatus","NetworkStatus");


t[#t+1] = StandardDecorationFromFileOptional("NumSongs","NumSongs") .. {
	SetCommand=function(self)
		local InstalledSongs, AdditionalSongs, InstalledCourses, AdditionalCourses, Groups, Unlocked = 0;
		if SONGMAN:GetRandomSong() then
			InstalledSongs, AdditionalSongs, InstalledCourses, AdditionalCourses, Groups, Unlocked =
				SONGMAN:GetNumSongs(),
				SONGMAN:GetNumAdditionalSongs(),
				SONGMAN:GetNumCourses(),
				SONGMAN:GetNumAdditionalCourses(),
				SONGMAN:GetNumSongGroups(),
				SONGMAN:GetNumUnlockedSongs();
		else
			return
		end

		self:settextf(THEME:GetString("ScreenTitleMenu","%i Songs (%i Groups), %i Courses"), InstalledSongs, Groups, InstalledCourses);
-- 		self:settextf("%i (+%i) Songs (%i Groups), %i (+%i) Courses", InstalledSongs, AdditionalSongs, Groups, InstalledCourses, AdditionalCourses);
	end;
};

t[#t+1] = LoadActor( THEME:GetPathB("","_cfopen") )..{
};

return t