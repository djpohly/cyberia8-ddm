FCCheck();

local t = Def.ActorFrame{};

local cap_path = "CSDataSave/0001_cc CSApp";

local fset = {
	"Regular",
	"Nonstop",
	"Challenge",
	"Endless",
	"Rave",
};

if GetAdhocPref("CSSetApp") == "00000001" and not File.Read( cap_path ) then
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(y,SCREEN_TOP);
		OnCommand=cmd(sleep,5;linear,0.2;zoomy,0;);
		Def.Quad{
			InitCommand=cmd(horizalign,left;y,68;cropright,1;cropbottom,1;zoomtowidth,SCREEN_WIDTH;zoomtoheight,118*0.8;
						diffuse,color("0,0,0,0.8");diffuserightedge,color("0,0.5,0.5,0.8"););
			OnCommand=cmd(sleep,0.5;linear,0.1;cropright,0;cropbottom,0;);
		};
	};

	for i = 1, 5 do
		t[#t+1] = Def.ActorFrame{
			InitCommand=cmd(y,SCREEN_TOP);
			OnCommand=cmd(sleep,5;linear,0.2;zoomy,0;);
			Def.Quad{
				InitCommand=function(self)
					(cmd(x,SCREEN_LEFT;zoomtowidth,72*0.8;zoomtoheight,28*0.8;diffuse,color("0,1,1,0.3");croptop,1;))(self)
					if i >=4 then
						self:x((i-2)*62);
						self:y(66+26);
					else
						self:x(i*62);
						self:y(66);
					end;
				end;
				OnCommand=cmd(sleep,0.5;linear,0.25;croptop,0;);
			};
			Def.Sprite{
				InitCommand=function(self)
					(cmd(x,SCREEN_LEFT;zoom,0.8;cropleft,1;))(self)
					if i >=4 then
						self:x((i-2)*62);
						self:y(66+26);
					else
						self:x(i*62);
						self:y(66);
					end;
					if fset[i] == "Challenge" then
						self:Load(THEME:GetPathG("ScreenGameplay","LifeFrame/Oni_LifeFrame/lifeframe_up_left"));
					else
						self:Load(THEME:GetPathG("ScreenGameplay","LifeFrame/"..fset[i].."_LifeFrame/lifeframe_up_left"));
					end;
				end;
				OnCommand=cmd(sleep,0.5;linear,0.25;cropleft,0;);
			};
		};
	end;
	
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(y,SCREEN_TOP;);
		OnCommand=cmd(sleep,5;linear,0.2;zoomy,0;);
		LoadFont("_Shared2") .. {
			InitCommand=function(self)
				(cmd(x,SCREEN_LEFT+30;horizalign,left;zoom,0.8;y,36;diffuse,color("1,0.5,0,1")))(self)
				self:settext(THEME:GetString("ScreenOptionsFrameSet","Added1"));
			end;
			OnCommand=cmd(maxwidth,SCREEN_WIDTH*1.2-30;cropright,1;sleep,0.5;decelerate,0.35;cropright,0;diffusealpha,1;);
		};
	};
	
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(y,SCREEN_TOP;);
		OnCommand=cmd(sleep,5;linear,0.2;zoomy,0;);
		LoadFont("_Shared2") .. {
			InitCommand=function(self)
				(cmd(x,SCREEN_LEFT+(62*3)+46;horizalign,left;zoom,0.8;y,78;diffuse,color("1,1,0,1")))(self)
				self:settext(string.format( THEME:GetString("ScreenOptionsFrameSet","Added2"),THEME:GetString("OptionTitles","Select Game Frame"),
				"[ "..fset[1].." ] [ "..fset[2].." ] [ "..fset[3].." ]\n[ "..fset[4].." ] [ "..fset[5].." ]" ));
			end;
			OnCommand=cmd(maxwidth,SCREEN_WIDTH*0.87;cropright,1;sleep,0.5;decelerate,0.35;cropright,0;diffusealpha,1;);
		};
	};

	File.Write( cap_path , "00000001" );
end;

return t;
