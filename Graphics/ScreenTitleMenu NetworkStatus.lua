local netConnected = IsNetConnected();
local loggedOnSMO = IsNetSMOnline();

local t = Def.ActorFrame{
	LoadFont("Common Normal") .. {
		InitCommand=cmd(uppercase,true;zoom,0.65;horizalign,left;shadowlength,1;maxwidth,SCREEN_WIDTH;diffuse,color("0,0,0,1"));
		BeginCommand=function(self)
			-- check network status
			if netConnected then
				self:strokecolor( color("1,1,0,1") );
				self:settext( Screen.String("Network OK") );
			else
				self:strokecolor( color("0.75,0.75,0.75,1") );
				self:settext( Screen.String("Offline") );
			end;
		end;
	};
};

if netConnected then
	t[#t+1] = LoadFont("Common Normal") .. {
		InitCommand=cmd(y,14;horizalign,left;zoom,0.475;shadowlength,1;maxwidth,SCREEN_WIDTH;diffuse,color("0,0,0,1");strokecolor,color("1,1,0,1"));
		BeginCommand=function(self)
			self:settext( string.format(Screen.String("Connected to %s"), GetServerName()) );
		end;
	};
end;

return t;