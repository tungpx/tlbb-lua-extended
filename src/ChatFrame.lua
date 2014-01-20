local g_KeepHeight = 105; --��Ļ�Ϸ����ɸ��ǵ�������ռ�ĸ߶�
local g_MinHeight = 112; --����������Сֵ
local g_MaxHeight = 336; --�����������ֵ
local g_Spin = 4
local g_FenpingMinHeight = 108; --�������߶���Сֵ
local g_FenpingMaxHeight = 192; --�������߶����ֵ

local g_MinWidth	=	320;	--���������ȵ���Сֵ
local g_MaxWidth	=	608;	--���������ȵ����ֵ

local g_MaxFrameHeight = 423   --������ڵ����߶�
local g_MinFrameHeight = 255   -- or 255 depend on buttonframe

local g_SpeakerHeight = 85
local g_CheckBoxHeight = 20
local g_ToggleButtonHeight = 19
local g_EditBarHeight = 19

local g_MoveUpHeight = 70; --��Ļ�ֱ��ʱ仯ʱ������߶�
local g_CurSpeakerName = "";
local g_CurSpeakerZoneworldid = -1
local g_CurSpeakerDisplayName = "" --�����@������
local channel_config = {};
local CHANNEL_DATA = {};

local channel_seltab = 0;		--Ĭ��ѡ��ȫ����
local channel_tab = {};
local CHANNEL_TAB_MAX = 7;	--��������ҳ��Tab
local g_channel_fenping = 7; --����ID
local channel_tab_total = 4;	--Ĭ��������ҳ��Tab, 0 & 1

local channel_sendhis = 0;	--0 ���Ǵӷ�����ʷ���ȡ���ִ�
														--1 �Ǵӷ�����ʷ���ȡ���ִ�
local channel_sendhis2 = 0;

local g_CurFlashTab = -1;

local channel_flash = {};


local CHANNEL_DATA_NEAR = 
	{	
		"set:Buttons image:Channelvicinity_Normal", 		-- Ƶ��ѡ��ť��ͨ
		"set:Buttons image:ChannelVicinity_Hover", 		-- Ƶ��ѡ��ť����
		"set:Buttons image:ChannelVicinity_Pushed",		-- Ƶ��ѡ��ť����
		"#cFFFFFF",									-- ����������ɫ
		"#e010101#cFFFFFF",						-- ��ơ�����
--		"#91#e010101#cFFFFFF",
	};
	
local CHANNEL_DATA_SCENE = 
	{
		"set:Buttons image:ChannelWorld_Normal", 
		"set:Buttons image:ChannelWorld_Hover", 
		"set:Buttons image:ChannelWorld_Pushed",
		"#cFFFFFF",
		"#e010101#c00FFCC",					--�����硿
--		"#92#e010101#c00FF00",
	};
	
local CHANNEL_DATA_PRIVATE = 
	{
		"set:Buttons image:ChannelPersonal_Normal", 
		"set:Buttons image:ChannelPersonal_Hover", 
		"set:Buttons image:ChannelPersonal_Pushed",
		"#cFFFFFF",
		"#e010101#cFF7C80",					--��˽�ġ�
--		"#98#e010101#c99CC00",
	};

local CHANNEL_DATA_SYSTEM = 
	{
		"set:Buttons image:ChannelPersonal_Normal", 
		"set:Buttons image:ChannelPersonal_Hover", 
		"set:Buttons image:ChannelPersonal_Pushed",
		"#cFF0000",
		"#e010101#cFF0000",					--��ϵͳ��
--		"#96#e010101#cFFFF00",
	};
	
local CHANNEL_DATA_TEAM = 
	{
		"set:Buttons image:ChannelTeam_Normal", 
		"set:Buttons image:ChannelTeam_Hover", 
		"set:Buttons image:ChannelTeam_Pushed",
		"#cFFFFFF",
		"#e010101#cCC99FF",					--�����顿
--	"#93#e010101#cFFFF00",
	};

local CHANNEL_DATA_SELF =
	{
		"set:Buttons image:ChannelTeam_Normal", 
		"set:Buttons image:ChannelTeam_Hover", 
		"set:Buttons image:ChannelTeam_Pushed",
		"#e010101#cFFFFFF",
--		"#e010101#cFFFF00",				--�����á�
		"nouse",
	};
	
local CHANNEL_DATA_HELP =
	{
		"set:Buttons image:ChannelTeam_Normal", 
		"set:Buttons image:ChannelTeam_Hover", 
		"set:Buttons image:ChannelTeam_Pushed",
		"#e010101#cFFFFFF",
--		"#e010101#cFFFF00",				--������
		"nouse",
	};
	
local CHANNEL_DATA_MENPAI =
	{
		"set:Buttons image:ChannelMenpai_Normal", 
		"set:Buttons image:ChannelMenpai_Hover", 
		"set:Buttons image:ChannelMenpai_Pushed",
		"#cFFFFFF",
		"#e010101#cFFFF00",					--�����ɡ�
--		"#94#e010101#cFFFF00",
	};

local CHANNEL_DATA_GUILD = 
	{
		"set:Buttons image:ChannelCorporative_Normal", 
		"set:Buttons image:ChannelCorporative_Hover", 
		"set:Buttons image:ChannelCorporative_Pushed",
		"#cFFFFFF",
		"#e010101#cFFCC99",					--����᡿
--		"#95#e010101#cFFFF00",
	};

local CHANNEL_DATA_GUILD_LEAGUE = 
	{
		"set:CommonFrame6 image:ChannelTongMeng_Normal", 
		"set:CommonFrame6 image:ChannelTongMeng_Hover", 
		"set:CommonFrame6 image:ChannelTongMeng_Pushed",
		"#cFFFFFF",
		"#e010101#c66c4fc",					--�����ͬ�ˡ�
--		"#95#e010101#cFFFF00",
	};

local CHANNEL_DATA_IPREGION =
	{
		"set:UIIcons image:ChannelCorporative_Normal", 
		"set:UIIcons image:ChannelCorporative_Hover", 
		"set:UIIcons image:ChannelCorporative_Pushed",
		"#e010101#cFFFFFF",
--		"#e010101#cFFFF00",				--��ͬ�ǡ�
		"nouse",
	};
	
local CHANNEL_DATA_RAID = 
	{
		"set:Union1 image:Union_Channel_Normal", 
		"set:Union1 image:Union_Channel_Hover", 
		"set:Union1 image:Union_Channel_Pushed",
		"#cFFFFFF",
		"#e010101#cff3300",					--���Ŷӡ�
	};
	
local CHANNEL_DATA_RAIDSQUAD = 
	{
		"set:Buttons image:ChannelTeam_Normal", 
		"set:Buttons image:ChannelTeam_Hover", 
		"set:Buttons image:ChannelTeam_Pushed",
		"#cFFFFFF",
		"#e010101#cCC99FF",					--��С�ӡ�
	};

local CHANNEL_DATA_BIGWORLD =
	{
		"set:Button12 image:ChannelOUT_Normal",
		"set:Button12 image:ChannelOUT_Hover",
		"set:Button12 image:ChannelOUT_Pushed",
		"#cFFFFFF",
		"#e010101#cFF0000",					--�����⡿
	};

local CHANNEL_DATA_CLAN =
	{
		"set:Button12 image:ChannelShili_Normal",
		"set:Button12 image:ChannelShili_Hover",
		"set:Button12 image:ChannelShili_Pushed",
		"#cFFFFFF",
		"#e010101#cFF0000",					--��������
	};

local g_theCurrentChannel = "near";
local g_theCurrentChannelName = "";
local g_MoveCtl = nil;

-- ����˫�����춯���ַ���Ϣ
local g_ChatActionTxt = "";
local g_InputLanguageIcon = {};

function ChatFrame_PreLoad()
	this:RegisterEvent("APPLICATION_INITED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("CHAT_MESSAGE");
	this:RegisterEvent("CHAT_CHANNEL_CHANGED");
	this:RegisterEvent("CHAT_CHANGE_PRIVATENAME");
	this:RegisterEvent("CHAT_TAB_CREATE_FINISH");
	this:RegisterEvent("CHAT_TAB_CONFIG_FINISH");
	this:RegisterEvent("ACCELERATE_KEYSEND");
	this:RegisterEvent("CHAT_CONTEX_MENU");
	this:RegisterEvent("CHAT_ACTSET");							-- �������ж���
	this:RegisterEvent("CHAT_DOUBLE_ACTSET");				-- ˫�����ж���
	this:RegisterEvent("CHAT_ADJUST_MOVE_CTL");
	this:RegisterEvent("CHAT_LOAD_TAB_CONFIG");
	this:RegisterEvent("CHAT_MENUBAR_ACTION");			-- ���������������ַ�
	this:RegisterEvent("RESET_ALLUI");
	this:RegisterEvent("SHOW_SPEAKER");
	this:RegisterEvent("FLASH_TAB");
	
	-- ע��ͬ��Ƶ����˸, ��¼����˸X��
	this:RegisterEvent("UI_COMMAND");

	this:RegisterEvent("CHAT_FENPING_CREATE");
	this:RegisterEvent("CHAT_FENPING_CONFIG");
	this:RegisterEvent("CHAT_FENPING_CLOSE");
	this:RegisterEvent("OPEN_FENPING_DLG_CHATFRAME");
	this:RegisterEvent("HIDE_TLBB_MAIN")
	
	this:RegisterEvent("CHAT_ACCEPT_DOUBLE_ACTION_STRING");		-- ��������������˫�����ж�������Ӧ	
	this:RegisterEvent("CHAT_INPUTLANGUAGE_CHANGE");
	this:RegisterEvent("CHAT_TEXTCOLOR_SELECT");
	this:RegisterEvent("CHAT_FACEMOTION_SELECT");
end
	
function ChatFrame_OnLoad()

	CHANNEL_DATA["near"] = CHANNEL_DATA_NEAR;
	CHANNEL_DATA["scene"] = CHANNEL_DATA_SCENE;
	CHANNEL_DATA["private"] = CHANNEL_DATA_PRIVATE;
	CHANNEL_DATA["system"] = CHANNEL_DATA_SYSTEM;
	CHANNEL_DATA["team"] = CHANNEL_DATA_TEAM;
	CHANNEL_DATA["self"] = CHANNEL_DATA_SELF;
	CHANNEL_DATA["menpai"] = CHANNEL_DATA_MENPAI;
	CHANNEL_DATA["guild"] = CHANNEL_DATA_GUILD;
	CHANNEL_DATA["guild_league"] = CHANNEL_DATA_GUILD_LEAGUE;
	CHANNEL_DATA["help"] = CHANNEL_DATA_HELP;
	CHANNEL_DATA["ipregion"] = CHANNEL_DATA_IPREGION;
	
	CHANNEL_DATA["raid"] = CHANNEL_DATA_RAID;
	CHANNEL_DATA["raidsquad"] = CHANNEL_DATA_RAIDSQUAD;
	CHANNEL_DATA["bigworld"] = CHANNEL_DATA_BIGWORLD;
	CHANNEL_DATA["clan"] = CHANNEL_DATA_CLAN;

	g_InputLanguageIcon[1] = "set:Button2 image:BtnE_Normal";
	g_InputLanguageIcon[2052] = "set:Buttons image:IME_Chinese";
	g_InputLanguageIcon[1033] = "set:Button2 image:BtnE_Normal";
	
	--TABҳ��������Ϣ
	channel_tab[2] = Chat_SelfChk;
	channel_tab[3] = Chat_City;
	channel_tab[4] = Chat_CreateChk1;
	channel_tab[5] = Chat_CreateChk2;
	channel_tab[6] = Chat_CreateChk3;

	channel_flash[3] = Chat_City_Flash
	
	-- ����GameDefine2.h �� ENUM_CHAT_TYPE ˳��
	channel_config[0] = {"ALL",1,1,1,1,1,1,1,1,0,1,0,0,1,1,1,0,1, 1};
	channel_config[1] = {"SYS",0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0, 0};
	channel_config[2] = {"PM",0,1,0,1,0,0,1,0,0,0,0,0,1,1,1,0,1, 1};
	channel_config[3] = {"T�nh",0,1,0,1,0,0,1,0,0,0,0,1,1,1,1,0,0, 0};
	channel_config[4] = {"",1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,0,1, 1};
	channel_config[5] = {"",1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,0,1, 1};
	channel_config[6] = {"",1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,0,1, 1};
	--����
	channel_config[7] = {"",1,1,1,1,1,1,1,1,0,1,0,0,1,1,1,0,1, 1};

	--����С����
	Chat_ChatSpeaker_StarWindow:SetText( "" );
	Chat_ChatSpeaker_StarWindow:SetProperty( "Name","" );
	Chat_ChatSpeaker_StarWindow:Hide();
	Chat_ChatSpeaker_StarWindow2:Hide();

	Chat_Frame_FenpingFrame:Hide();
	NotFlashAllTab()
	
	Chat_Chat_ScaleBtn:SetProperty("MiniHeight" ,tostring(g_MinFrameHeight) )
	Chat_Chat_ScaleBtn:SetProperty("MaxHeight" ,tostring(g_MaxFrameHeight) )
	Chat_Chat_ScaleBtn:SetProperty("MinWidth" ,tostring(g_MinWidth) )
	Chat_Chat_ScaleBtn:SetProperty("MaxWidth" ,tostring(g_MaxWidth) )
	
end

function ChatFrame_OnEvent(event)

	if ( event == "PLAYER_ENTERING_WORLD" ) then
		this:Show();
		--������ʷ��Ϣ��¼��������ֵ
		Talk:SetMaxSaveNumber(tonumber(Chat_Frame_History:GetProperty("ChatBoardNumber")));
		--����ϵͳ��Ϣ���Զ���ʧʱ����
		Talk:SetDisappearTime(tonumber(Chat_Frame_History:GetProperty("BoardKillTimer")));
		Talk:SetCurTab(channel_seltab);

		ChatFrame_SetTabConfig( 0 );
		ChatFrame_SetTabConfig( 1 );
		ChatFrame_SetTabConfig( 2 );
		ChatFrame_SetTabConfig( 3 );
		channel_tab[3]:SetText("T�nh");
		ChatFrame_SetChannelSel(g_theCurrentChannel, g_theCurrentChannelName);
		
		local noChatActiveMode = Variable:GetVariable("NonChatActive");
		if(noChatActiveMode==nil or noChatActiveMode=="0") then
			Chat_EditBox:SetProperty("DefaultEditBox", "True");
		end
		ChatFrame_InputLanguage_Changed();
		
		Chat_CheckBox_Frame:Hide()
		local _,_,_,_,_,_,_,_,_,f10,_,_,_,_,_,_,_,_,_,_,_,_,_,_ = SystemSetup:GameGetData();
		local alphaStr = string.format("%f" , f10 / 2 )
		Chat_Frame_HistoryFrame:SetProperty("Alpha" , alphaStr)
		Chat_Frame_FenpingFrame:SetProperty("Alpha" , alphaStr)

	elseif (event == "CHAT_MESSAGE" ) then
		--ChatFrame_InsertChatContent(arg0, arg1, arg2);
	elseif (event == "CHAT_CHANNEL_CHANGED" ) then
		ChatFrame_ChannelChanged(arg0);
	elseif (event == "CHAT_TAB_CREATE_FINISH") then
		ChatFrame_CreateTabFinish(arg0,arg1,arg2);
	elseif (event == "CHAT_FENPING_CREATE") then
		ChatFrame_CreateFenping(arg0);
	elseif (event == "CHAT_FENPING_CLOSE") then
		ChatFrame_CloseFenping(arg0);
	elseif (event == "CHAT_FENPING_CONFIG") then
		ChatFrame_ConfigFenping(arg0);
	elseif (event == "OPEN_FENPING_DLG_CHATFRAME") then
		ChatFrame_OpenFenpingDlg(arg0);
	elseif (event == "CHAT_TAB_CONFIG_FINISH") then
		ChatFrame_ConfigTabFinish(arg0,arg1,arg2);
	elseif (event == "ACCELERATE_KEYSEND") then
		ChatFrame_HandleAccKey(arg0,arg1,arg2);
	elseif (event == "CHAT_CHANGE_PRIVATENAME") then
		ChatFrame_ChangePrivateName(arg0);
	elseif (event == "CHAT_CONTEX_MENU") then
		ChatFrame_ContexMenu_Open(arg0,arg1);
	elseif (event == "CHAT_ACTSET")	then							-- �������춯��
		ChatFrame_ActSetMessage(arg0, 1);
	elseif (event == "CHAT_DOUBLE_ACTSET")	then			-- ˫�����춯��
		ChatFrame_ActSetMessage(arg0, 2);
	elseif (event == "CHAT_ADJUST_MOVE_CTL") then
	--	ChatFrame_AdjustMoveCtl(arg0, arg1);
	elseif (event == "CHAT_LOAD_TAB_CONFIG") then
		ChatFrame_LoadTabConfig(arg2,arg0,arg1);

	-- ���������������ַ�
	elseif (event == "CHAT_MENUBAR_ACTION") then
		ChatFrame_HandleMenuBarAction(arg0,arg1,arg2);
	elseif ( event == "HIDE_TLBB_MAIN" ) then
		this:Hide()
	elseif (event == "RESET_ALLUI") then
		-- ���ض����Tab����
		channel_tab_total = 4;
		for i= channel_tab_total, CHANNEL_TAB_MAX-1 do
			ChatFrame_SetTabMouseRButtonHollow(i, 1);
			channel_tab[i]:Hide();
		end
		g_theCurrentChannel = "near";
		g_theCurrentChannelName = "";
		channel_seltab = 0;
		--����С����
		Chat_ChatSpeaker_StarWindow:SetText( "" );
		Chat_ChatSpeaker_StarWindow:SetProperty( "Name","" );
		Chat_ChatSpeaker_StarWindow:Hide();
		Chat_ChatSpeaker_StarWindow2:Hide();

		Chat_SystemChk : SetCheck(1)

		--�ȹرշ��� TT:81898
		Talk:CloseFenping();

		NotFlashAllTab()
		ChatFrame_SetEditBoxTxt("");
		ChatFrame_SetChannelSel("near","");
	elseif (event == "SHOW_SPEAKER") then
		g_CurSpeakerName = arg0;
		g_CurSpeakerContex = arg1;
		g_CurSpeakerZoneworldid = tonumber(arg2)
		g_CurSpeakerDisplayName = g_CurSpeakerName
		local selfZoneWorldID = DataPool:GetSelfZoneWorldID()

		if(Player:GetName() == g_CurSpeakerName and (selfZoneWorldID == g_CurSpeakerZoneworldid or selfZoneWorldID == -1 or g_CurSpeakerZoneworldid == -1) )then
			Chat_ChatSpeaker_StarWindow:SetText( "#e010101["..tostring( arg0 ).."]#W:"..tostring(arg1) );
		else
			if selfZoneWorldID ~= 0 and selfZoneWorldID ~= g_CurSpeakerZoneworldid and g_CurSpeakerZoneworldid ~= -1 then
				local serverName = DataPool:GetServerName( g_CurSpeakerZoneworldid )
				g_CurSpeakerDisplayName = g_CurSpeakerName.."@"..tostring(serverName)
				Chat_ChatSpeaker_StarWindow:SetText( "#e010101#c00ccff["..tostring( g_CurSpeakerDisplayName ).."]#W:"..tostring(arg1) )
			else
				Chat_ChatSpeaker_StarWindow:SetText( "#e010101#c00ccff["..tostring( arg0 ).."]#W:"..tostring(arg1) );
			end
		end
		
		Chat_ChatSpeaker_StarWindow:SetProperty( "Name","["..tostring(arg0).."]" );
		Chat_ChatSpeaker_StarWindow:SetProperty( "Reset","false" );
		Chat_ChatSpeaker_StarWindow2:SetProperty( "Reset","false" );
		Talk:HideContexMenu4Speaker();

--	ȡ��ÿ����ͬ�Ƿ����г��ְ�ť��˸
--	elseif (event == "FLASH_TAB") then
--
--		local showTab = tonumber(arg0);
--		local isShow  = tonumber(arg1);
--		
--		if(showTab > 0 and showTab < CHANNEL_TAB_MAX -1) then
--			if(isShow > 0 ) then
--				FlashTab(showTab);
--			else
--				NotFlashTab(showTab);
--			end
--		end
	
	-- ����ͬ��Ƶ����˸
	elseif (event == "UI_COMMAND") then
		if (tonumber( arg0 ) == 870001001) then
			FlashTab(3);
			SetTimer("ChatFrame","StopFlashCityChannel()", 5000);		--���ö�ʱ��10���ӹرմ���
		end
	elseif(event == "CHAT_ACCEPT_DOUBLE_ACTION_STRING") then
		ChatFrame_DoubleChatActionMessageSend(tonumber(arg0), tostring(arg1));
	elseif (event == "CHAT_INPUTLANGUAGE_CHANGE") then
		ChatFrame_InputLanguage_Changed();
	elseif (event == "CHAT_TEXTCOLOR_SELECT") then
		ChatFrame_SelectColorFaceFinish(arg0, arg1);
	elseif (event == "CHAT_FACEMOTION_SELECT") then
		ChatFrame_SelectColorFaceFinish(arg0, arg1);
	end
end

function StopFlashCityChannel()
	NotFlashTab(3);
	KillTimer("StopFlashCityChannel()");		--�رն�ʱ��
end

function NotFlashTab(idx)
	for i =2, 6 do
		if(idx == i and channel_flash[i])then
			g_CurFlashTab = -1;
			channel_flash[i] : Play( false );
		end
	end  
end

function FlashTab(idx)
	for i =2, 6 do
		if(idx == i and channel_flash[i])then
			g_CurFlashTab = idx;
			channel_flash[i] : Play( true );
		end
	end  
end

function NotFlashAllTab()
	for i =2, 6 do
		if(channel_flash[i])then
			
			channel_flash[i] : Play( false );
		end
		
	end  

	g_CurFlashTab = -1;
end

function ChatFrame_ChannelListSelect()
	Chat_Frame_ChannelFrame:Hide();

	local selCh = Chat_Frame_Channel:GetProperty("HoverChannel");
	local prv = Chat_Frame_Channel:GetHoverChannelName();
	
	ChatFrame_ChannelListChange( selCh, prv );
end

function ChatFrame_ChannelListChange( selChannel, prvtxt)

	if(CHANNEL_DATA[selChannel] == nil) then
		return;
	end

	g_theCurrentChannel = selChannel;
	g_theCurrentChannelName = prvtxt;

	ChatFrame_SetChannelSel(g_theCurrentChannel, g_theCurrentChannelName);
	local curtxt = Chat_EditBox:GetItemElementsString();
	local facetxt = Talk:ModifyChatTxt(g_theCurrentChannel, g_theCurrentChannelName, curtxt);
	ChatFrame_SetEditBoxTxt(facetxt);
end

function ChatFrame_ChangePrivateName( newname )
	if(ChatFrame_IsNameMySelf(newname) > 0) then
		return;
	end
	local curtxt = Chat_EditBox:GetItemElementsString();
	local facetxt = Talk:ModifyChatTxt("private", newname, curtxt);
	ChatFrame_SetEditBoxTxt(facetxt);
end

function ChatFrame_InsertChatContent(chatType, chatTalkerName, chatContent)
	if(CHANNEL_DATA[chatType] == nil) then
		return
	end

	local strFinal;
	local strHeader = Talk:GetChannelHeader(chatType, chatTalkerName);
	if(nil == strHeader) then
		return
	end
	if(chatTalkerName == "" and chatType ~= "self") then
		strFinal = CHANNEL_DATA[chatType][5];
		strFinal = strFinal .. "[" .. strHeader .. "]";
		strFinal = strFinal .. CHANNEL_DATA[chatType][4] ..chatContent;
	else
		if(chatType ~= "self") then
			strFinal = CHANNEL_DATA[chatType][5];
			if(string.byte(chatContent, 1) ~= 64 and string.byte(chatContent, 1) ~= 42) then -- '@' ���ֱ������
				strFinal = strFinal .. "[" .. strHeader .. "]";
				if(ChatFrame_IsNameMySelf(chatTalkerName) > 0) then
					strFinal = strFinal .. "#W[" .. chatTalkerName .. "]";
				else
					strFinal = strFinal .. Talk:GetHyperLinkString(chatType,chatTalkerName);
				end
				strFinal = strFinal .. CHANNEL_DATA[chatType][4] .. ": " ..chatContent;
			else
				local strTemplate = Talk:GetTalkTemplateString(chatTalkerName, chatContent);
				strFinal = strFinal .. "[" .. strHeader .. "]";
				strFinal = strFinal .. strTemplate;
			end
		else
			strFinal = CHANNEL_DATA[chatType][4] .. chatContent;
		end
	end

	Chat_Frame_History:InsertChatString(strFinal);
	
end

function ChatFrame_PrepareMove()
	g_MoveCtl = {
					frame = Chat_Frame,
					check = Chat_CheckBox_Frame,
					history = Chat_Frame_HistoryFrame,
					toolbar1 = Chat_ToolBar,
					toolbar2 = Chat_Button_ChatFrame,
					fenping = Chat_Frame_FenpingFrame,
					speaker = Chat_ChatSpeaker,
				};
end

--���������߶�
function ChatFrame_MoveCtl(dir)
	ChatFrame_PrepareMove();

	local absFrameHeight = g_MoveCtl.frame:GetProperty("AbsoluteHeight");
	local absFenpingHeight = g_MoveCtl.fenping:GetProperty("AbsoluteHeight");
	local absHistoryHeight = g_MoveCtl.history:GetProperty("AbsoluteHeight");
	local absCheckHeight = g_MoveCtl.check:GetProperty("AbsoluteHeight");
	local absToolBarHeight_1 = g_MoveCtl.toolbar1:GetProperty("AbsoluteHeight");
	local absToolBarHeight_2 = g_MoveCtl.toolbar2:GetProperty("AbsoluteHeight");
	local absToolBarHeight = absToolBarHeight_1 + absToolBarHeight_2
	local absSpeakerHeight = g_MoveCtl.speaker:GetProperty("AbsoluteHeight")
	local step = 28;

	if(dir > 0) then
		--��������
		if g_MoveCtl.fenping:IsVisible() then
			--������Ѵ����ֵ����С����
			if tonumber(absFrameHeight) >= g_MaxFrameHeight then
				--�����Ѿ���Сֵ����������
				if absFenpingHeight - step < g_FenpingMinHeight then
					return
				else
					--fenping
					local udimStr_fenping = string.format("{%f,%f}", 0.000000, absFenpingHeight - step );
					g_MoveCtl.fenping:SetProperty("UnifiedHeight", udimStr_fenping );
					udimStr_fenping= string.format("{%f,%f}", 1.000000, -(absToolBarHeight + absFenpingHeight - step));
					g_MoveCtl.fenping:SetProperty("UnifiedYPosition", udimStr_fenping);
				end
			--�����û�дﵽ���ֵ��ֱ�����ӣ���������
			else
				if absFrameHeight + step > g_MaxFrameHeight then
					step = g_MaxFrameHeight - absFrameHeight
				end
				--frame
				g_MoveCtl.frame:SetProperty("AbsoluteHeight", absFrameHeight + step );
				local udimStr_frame= string.format("{%f,%f}", 1.000000, -(absFrameHeight + step + g_MoveUpHeight));
				g_MoveCtl.frame:SetProperty("UnifiedYPosition", udimStr_frame);
			end
		--��������
		else
			--������Ѵ����ֵ
			if tonumber(absFrameHeight) >= g_MaxFrameHeight then
				return
			else
				if absFrameHeight + step > g_MaxFrameHeight then
					step = g_MaxFrameHeight - absFrameHeight
				end
				--frame
				g_MoveCtl.frame:SetProperty("AbsoluteHeight", absFrameHeight + step );
				local udimStr_frame= string.format("{%f,%f}", 1.000000, -(absFrameHeight + step + g_MoveUpHeight));
				g_MoveCtl.frame:SetProperty("UnifiedYPosition", udimStr_frame);
			end
		end
	else
		if tonumber(absHistoryHeight) <= g_MinHeight then
			return
		else
			if absHistoryHeight - step < g_MinHeight then
				step = absHistoryHeight - g_MinHeight
			end
			--frame
			g_MoveCtl.frame:SetProperty("AbsoluteHeight", absFrameHeight - step );
			local udimStr_frame= string.format("{%f,%f}", 1.000000, -(absFrameHeight - step + g_MoveUpHeight));
			g_MoveCtl.frame:SetProperty("UnifiedYPosition", udimStr_frame);
		end
	end
	--History
	if g_MoveCtl.fenping:IsVisible() then
		local new_absFenpingHeight = g_MoveCtl.fenping:GetProperty("AbsoluteHeight");
		local other_Height = absSpeakerHeight + absCheckHeight + new_absFenpingHeight + absToolBarHeight + g_Spin
		local udimStr_history = string.format("{%f,%f}", 1.000000, -other_Height);
		g_MoveCtl.history:SetProperty("UnifiedHeight" ,udimStr_history)
		
	else
		local other_Height = absSpeakerHeight + absCheckHeight + absToolBarHeight
		local udimStr_history = string.format("{%f,%f}", 1.000000, -other_Height);
		g_MoveCtl.history:SetProperty("UnifiedHeight" ,udimStr_history)
	end
	Chat_Frame_History:ScrollToEnd();
end

--���������߶�
function ChatFrame_MoveCtl_Fenping(dir)
	ChatFrame_PrepareMove();
	
	local absFrameHeight = g_MoveCtl.frame:GetProperty("AbsoluteHeight");
	local absFenpingHeight = g_MoveCtl.fenping:GetProperty("AbsoluteHeight");
	local absHistoryHeight = g_MoveCtl.history:GetProperty("AbsoluteHeight");
	local absCheckHeight = g_MoveCtl.check:GetProperty("AbsoluteHeight");
	local absToolBarHeight_1 = g_MoveCtl.toolbar1:GetProperty("AbsoluteHeight");
	local absToolBarHeight_2 = g_MoveCtl.toolbar2:GetProperty("AbsoluteHeight");
	local absToolBarHeight = absToolBarHeight_1 + absToolBarHeight_2
	local absSpeakerHeight = g_MoveCtl.speaker:GetProperty("AbsoluteHeight")
	local step = 28;
	
	--����3λ��ʾ�Ƿ���Ҫ�ƶ��ؼ���λ��
	local bMoveFrame = 0
	local bMoveHistory = 0
	local bMoveFenping = 0
	--ע�⣬�߻�Ҫ�������������ܺ������ֵ�������������߶�Ϊg_FenpingMaxHeight,�������ܺʹﵽ���ֵ��ʱ����������ᶥ���������
	if absFenpingHeight + step > g_FenpingMaxHeight then
		--�����ĸ߶ȳ������ֵ������ԭ��ֵ
		step = absFenpingHeight - g_FenpingMinHeight;
		--fenping
		local udimStr_fenping = string.format("{%f,%f}", 0.000000, absFenpingHeight - step );
		g_MoveCtl.fenping:SetProperty("UnifiedHeight", udimStr_fenping );
		udimStr_fenping= string.format("{%f,%f}", 1.000000, -(absToolBarHeight + absFenpingHeight - step));
		g_MoveCtl.fenping:SetProperty("UnifiedYPosition", udimStr_fenping);
		--frame
		g_MoveCtl.frame:SetProperty("AbsoluteHeight", absFrameHeight - step );
		local udimStr_frame= string.format("{%f,%f}", 1.000000, -(absFrameHeight - step + g_MoveUpHeight));
		g_MoveCtl.frame:SetProperty("UnifiedYPosition", udimStr_frame);
	else
		--�����߶�û�������ֵ,���ӷ����߶�
		--fenping
		local udimStr_fenping = string.format("{%f,%f}", 0.000000, absFenpingHeight + step );
		g_MoveCtl.fenping:SetProperty("UnifiedHeight", udimStr_fenping );
		udimStr_fenping= string.format("{%f,%f}", 1.000000, -(absToolBarHeight + absFenpingHeight + step));
		g_MoveCtl.fenping:SetProperty("UnifiedYPosition", udimStr_fenping);
		
		if absFrameHeight + step > g_MaxFrameHeight then
			--frame
			g_MoveCtl.frame:SetProperty("AbsoluteHeight", g_MaxFrameHeight );
			local udimStr_frame= string.format("{%f,%f}", 1.000000, -(g_MaxFrameHeight + g_MoveUpHeight));
			g_MoveCtl.frame:SetProperty("UnifiedYPosition", udimStr_frame);
		else
			--frame
			g_MoveCtl.frame:SetProperty("AbsoluteHeight", absFrameHeight + step );
			local udimStr_frame= string.format("{%f,%f}", 1.000000, -(absFrameHeight + step + g_MoveUpHeight));
			g_MoveCtl.frame:SetProperty("UnifiedYPosition", udimStr_frame);
		end
	end

	--History

	local new_absFenpingHeight = g_MoveCtl.fenping:GetProperty("AbsoluteHeight");
	local other_Height = absSpeakerHeight + absCheckHeight + new_absFenpingHeight + absToolBarHeight + g_Spin
	local udimStr_history = string.format("{%f,%f}", 1.000000, -other_Height);
	g_MoveCtl.history:SetProperty("UnifiedHeight" ,udimStr_history)

	Chat_Frame_History:ScrollToEnd();
	Chat_Frame_Fenping:ScrollToEnd();
end

--���������Ŀ��
function ChatFrame_WidthCtl(dir)
	ChatFrame_PrepareMove();
	local absFrameWidth = g_MoveCtl.frame:GetProperty("AbsoluteWidth");
	
	local step;
	if(dir > 0) then
		step = -18
		if(absFrameWidth-step > g_MaxWidth) then
			return;
		end
	else
		step = 18;
		if(absFrameWidth-step < g_MinWidth) then
			return;
		end
	end

	--frame
	g_MoveCtl.frame:SetProperty("AbsoluteWidth", absFrameWidth-step);
	
	Chat_Frame_History:ScrollToEnd();
	Chat_Frame_Fenping:ScrollToEnd();
end

function ChatFrame_AdjustMoveCtl( screenWidth, screenHeight )
	ChatFrame_PrepareMove();
end

function ChatFrame_ChannelChanged(force)
	if(force == "force_near") then
		g_theCurrentChannel = "near"
		ChatFrame_SetChannelSel(g_theCurrentChannel, "");
	elseif(force == "close_team" and g_theCurrentChannel == "team") then
		g_theCurrentChannel = "near"
		ChatFrame_SetChannelSel(g_theCurrentChannel, "");
	elseif(force == "close_menpai" and g_theCurrentChannel == "menpai") then
		g_theCurrentChannel = "near"
		ChatFrame_SetChannelSel(g_theCurrentChannel, "");
	elseif(force == "close_guild" and g_theCurrentChannel == "guild") then
		g_theCurrentChannel = "near"
		ChatFrame_SetChannelSel(g_theCurrentChannel, "");
	elseif(force == "close_guild_league" and g_theCurrentChannel == "guild_league") then
		g_theCurrentChannel = "near"
		ChatFrame_SetChannelSel(g_theCurrentChannel, "");
	elseif(g_theCurrentChannel == "private") then
		g_theCurrentChannel = "near"
		ChatFrame_SetChannelSel(g_theCurrentChannel, "");
	elseif(force == "close_raid" and g_theCurrentChannel == "raid") then
		g_theCurrentChannel = "near"
		ChatFrame_SetChannelSel(g_theCurrentChannel, "");
	elseif(force == "close_raid" and g_theCurrentChannel == "raidsquad") then
		g_theCurrentChannel = "near"
		ChatFrame_SetChannelSel(g_theCurrentChannel, "");
	elseif(force == "close_bigworld" and g_theCurrentChannel == "bigworld") then
		g_theCurrentChannel = "near"
		ChatFrame_SetChannelSel(g_theCurrentChannel, "");
		--�ر�Ƶ���б?��Ȼ��������ʾ����
		Chat_Frame_ChannelFrame:Hide()
    elseif(force == "close_clan" and g_theCurrentChannel == "clan") then
		g_theCurrentChannel = "near"
		ChatFrame_SetChannelSel(g_theCurrentChannel, "");
	end
end

-- ѡ��ĳһ��Tab��Ӧ��Ƶ��
function Chat_ChangeTabIndex( nIndex )
	Chat_Frame_History:RemoveAllChatString();
	channel_seltab = nIndex;
	Talk:SetCurTab(channel_seltab);
	
	if channel_config[nIndex] == nil then
		Talk:InsertHistory( nIndex, "" );
	else
		local i = 2;
		local strConfig = "";
		while channel_config[nIndex][i] ~= nil do
			strConfig = strConfig .. tostring(channel_config[nIndex][i]);
			i = i+1;
		end
		Talk:InsertHistory( nIndex, strConfig);
	end
	
	Chat_Frame_History:ScrollToEnd();

	if(g_CurFlashTab == channel_seltab and channel_seltab > 0)then
		NotFlashTab(g_CurFlashTab);
	end
end

-- ��׽Tab��ťʧ��ʱ�Ĳ���
-- ��� TT��47859	��Ƶ�������·�4��Ƶ���������סһ��Ƶ�������⣬�϶�����Ƶ������������֣�Ƶ��������ı䣬���ݲ���
function Chat_OnTabCaptureLost (nIndex)
	if nIndex ~= channel_seltab then
		Chat_ChangeTabIndex(nIndex);
	end
end

function ChatFrame_CreateTabFinish(tabName,tabCfg, strFlg)
	if(tabName == nil or tabCfg == nil or strFlg == nil) then
		return;
	end
	
	if(strFlg == "cancel") then
		--channel_tab_total = channel_tab_total - 1;
	elseif(strFlg == "sucess") then
		channel_tab_total = channel_tab_total + 1;
		if(tabName == "") then
			tabName = "T� ki�n" .. tostring(channel_tab_total - 4);
		end
		
		channel_seltab = channel_tab_total-1;
		ChatFrame_ChangeTabConfig(tabCfg);
		channel_config[channel_seltab][1] = tabName;
		
		--��������
		Talk:SaveTab(channel_seltab, tabName, tabCfg);
		ChatFrame_SetTabConfig(channel_seltab);
		
		ChatFrame_SetTabMouseRButtonHollow(channel_seltab, 0);
		channel_tab[channel_seltab]:Show();
		channel_tab[channel_seltab]:SetCheck(1);
		channel_tab[channel_seltab]:SetText(channel_config[channel_seltab][1]);
		Chat_ChangeTabIndex(channel_seltab);
	end
end

function ChatFrame_ConfigTabFinish(tabName, tabCfg, strFlg)
	if(tabName == nil or tabCfg == nil or strFlg == nil) then
		return;
	end
	
	if(strFlg == "cancel") then
	elseif(strFlg == "delete") then
		Chat_DestoryTabIndex(channel_seltab);
	elseif(strFlg == "sucess") then
		if(channel_seltab ~= 0) then
			ChatFrame_ChangeTabConfig(tabCfg);

			--��������
			Talk:SaveTab(channel_seltab, channel_config[channel_seltab][1], tabCfg);
			ChatFrame_SetTabConfig(channel_seltab);
		end
	end
end

-- �������ҳ��Tab����
function ChatFrame_ChangeTabConfig( tabCfg )
	local k = 1;
	for i = 2, table.getn(channel_config[channel_seltab]) do
		if(string.byte(tabCfg, k) == 48) then -- 0
			channel_config[channel_seltab][i] = 0;
		elseif(string.byte(tabCfg, k) == 49) then -- 1
			channel_config[channel_seltab][i] = 1;
		else
			channel_config[channel_seltab][i] = 0;
		end

		k = k+1;
	end
	ChatFrame_PrintTabConfig(channel_seltab);
end

-- ɾ������ҳ��Tab
function Chat_DestoryTabIndex( nIndex )
	if( nIndex <= 3 ) then
		PushDebugMessage("K�nh n�y kh�ng ���c x�a b�");
		return;
	end
	
	if(channel_tab_total-1 == 3) then
		return;
	end
	
	channel_tab_total = channel_tab_total - 1;

	-- ��ǰ��������
	if( channel_tab_total ~= 3 ) then
		local i;
		for i=nIndex, channel_tab_total do
			local k=1;
			while channel_config[i][k] ~= nil and channel_config[i+1][k] ~= nil and i+1<CHANNEL_TAB_MAX do
				channel_config[i][k] = channel_config[i+1][k];
				k = k+1;
			end
			--��������
			local xxi = 2;
			local strConfig = "";
			while channel_config[i][xxi] ~= nil do
				strConfig = strConfig .. tostring(channel_config[i][xxi]);
				xxi = xxi+1;
			end

			if(nil ~= channel_config[i][1]) then
				Talk:SaveTab(i, channel_config[i][1], strConfig);
				ChatFrame_SetTabConfig(i);
			end
			--�ı�����
			channel_tab[i]:SetText(channel_config[i][1]);
		end
	
		if(channel_seltab == channel_tab_total) then
			channel_seltab = channel_seltab - 1;
		end	
		
		if(1 < channel_seltab) then
			channel_tab[channel_seltab]:SetText(channel_config[channel_seltab][1]);
			channel_tab[channel_seltab]:SetCheck(1);
		end
	else
		channel_seltab = 0;
		Chat_CommonChk:SetCheck(1);
	end

	-- ���ض����Tab����
	for i=channel_tab_total, CHANNEL_TAB_MAX-1 do
		ChatFrame_SetTabMouseRButtonHollow(i, 1);
		channel_tab[i]:Hide();
	end	
	Talk:ClearTab(channel_tab_total);
	
	-- ����ChatHistory�������
	Talk:MoveTabHisQue(nIndex, channel_tab_total);
	Chat_ChangeTabIndex(channel_seltab);
end

function ChatFrame_HandleAccKey( op, msg )
	if( nil == op ) then
		return;
	end
	
	if(channel_sendhis == 0 and op == "save_old") then
	elseif( op == "shift_up" or op == "shift_down") then
		local txt = Chat_EditBox:GetItemElementsString();
		Talk:SaveOldTalkMsg(g_theCurrentChannel, txt);
		ChatFrame_SetEditBoxTxt(msg);
	elseif( op == "acc_prevchannel") then
		ChatFrame_ChangeCurrentChannel(1); --��ǰƵ����ǰһƵ��
	elseif( op == "acc_nextchannel") then
		ChatFrame_ChangeCurrentChannel(-1);	--��ǰƵ���ĺ�һƵ��
	elseif( op == "acc_clearchat" ) then
		ChatFrame_extendRegionTest();
	elseif (op == "acc_chatmod") then
		ChatFrame_ChatMood()
	elseif (op == "acc_face") then
		ChatFrame_SelectFaceMotion()
	end
end

function ChatFrame_ClearSendHis()
	if(1 ~= channel_sendhis2) then
		channel_sendhis = 0;
	end
	
	channel_sendhis2 = 0;
end

function ChatFrame_ChangeCurrentChannel( dir )
	local newtype, newname = Talk:ChangeCurrentChannel( g_theCurrentChannel, g_theCurrentChannelName, dir );
	ChatFrame_ChannelListChange(newtype, newname);
end

function ChatFrame_ContexMenu_Open( strLink,msgid )
	if(nil == strLink or ChatFrame_IsNameMySelf(strLink)>0) then
		return;
	end
	
	Talk:ShowContexMenu( strLink,tonumber(msgid) );
end

function ChatFrame_ActSetMessage( strAct, type )

	if(strAct == nil or strAct == "") then
		return;
	end
	
	if (type <= 0) or (type > 2) then
	  return;
	end

	local strKey = "";
	if ( type == 1 ) then
		strKey = "*" .. strAct;					-- �������ж���		
	elseif ( type ==2 ) then
		strKey = "*@" .. strAct;				-- ˫�����ж��������ﲻ����"**"������'*'��Ϊһ����*����� )		
	end

	Talk : SendChatMessage(g_theCurrentChannel, strKey);	

end

function ChatFrame_IsNameMySelf( strName )
	if( strName == nil or strName == "") then
		return -1;
	end
	
	local myselfName = Player:GetName();
	if( myselfName == strName) then
		return 1;
	else
		return -1;
	end
end

function ChatFrame_LoadTabConfig(tabIdx, tabName, tabConfig)
	if(nil == tabIdx or nil == tabName or nil == tabConfig) then
		return;
	end

	local selbak = channel_seltab;
	
	local tabId = tonumber(tabIdx);
	if(tabId > 0 and tabId < CHANNEL_TAB_MAX) then
		channel_seltab = tabId;
		ChatFrame_ChangeTabConfig(tabConfig);
		channel_config[channel_seltab][1] = tabName;

		ChatFrame_SetTabMouseRButtonHollow(channel_seltab, 0);
		if(channel_seltab == 3) then	--ͬ��Ƶ�����⴦��
			channel_tab[channel_seltab]:SetText("T�nh");
		else
			channel_tab[channel_seltab]:SetText(channel_config[channel_seltab][1]);
		end
		channel_tab[channel_seltab]:Show();
		if(tabId > 3) then channel_tab_total = channel_tab_total + 1; end
		ChatFrame_SetTabConfig( tabId );
	elseif tabId == g_channel_fenping then
		--��������load
		Talk:CreateFenping(tabConfig)
	end
	
	channel_seltab = selbak;
end

function ChatFrame_SetTabConfig( tabIdx )
	if(channel_config[tabIdx] ~= nil) then
		local i = 2;
		local strConfig = "";
		while channel_config[tabIdx][i] ~= nil do
			strConfig = strConfig .. tostring(channel_config[tabIdx][i]);
			i = i+1;
		end
		Talk:SetTabCfg(tabIdx, strConfig);
	end
end

function ChatFrame_SetTabMouseRButtonHollow( tabIdx, op )
	if(nil == tabIdx or tabIdx < 3 or tabIdx >= CHANNEL_TAB_MAX) then return end;

	if(0 == tonumber(op)) then
		channel_tab[tabIdx]:SetProperty("MouseRButtonHollow", "False");
	elseif(1 == tonumber(op)) then
		channel_tab[tabIdx]:SetProperty("MouseRButtonHollow", "True");
	end
end

function ChatFrame_HandleMenuBarAction(op,arg,new)

	if(op == "chatbkg") then
		ChatFrame_ChangeChatBkgAlpha(arg);
	elseif(op == "infochannel") then
		ChatFrame_ChannelListChange(arg,new);
	end
end

function ChatFrame_ChannelSelect_ChangePosition(pos)
	Chat_Frame_Channel:SetProperty("AnchorPosition", "x:"..tostring(pos-2).." y:23.0");
end

function ChatFrame_ChangeChatBkgAlpha(val)
	Chat_Frame_HistoryFrame:SetProperty( "Alpha", val );
	Chat_Frame_FenpingFrame:SetProperty( "Alpha", val );
end

function ChatFrame_PrintTabConfig(idx)
	if(idx == nil or idx < 0 or idx > 6) then
		return;
	end	
	
	local strMsg = "ChatTabConfig idx:"..tostring(idx).." config:";
	for i = 2, table.getn(channel_config[idx]) do
		strMsg = strMsg..tostring(channel_config[idx][i]);
	end
end

function Chat_ChatSpeaker_NameLClick()
	--ChatFrame_ChangePrivateName( g_CurSpeakerName );
	ChatFrame_ChangePrivateName( g_CurSpeakerDisplayName );
end
function Chat_ChatSpeaker_NameRClick()
	--if(nil == g_CurSpeakerName or ChatFrame_IsNameMySelf(g_CurSpeakerName)>0) then
	if(nil == g_CurSpeakerDisplayName or ChatFrame_IsNameMySelf(g_CurSpeakerDisplayName)>0) then
		return;
	end
	--Talk:ShowContexMenu4Speaker( g_CurSpeakerName, g_CurSpeakerContex);
	Talk:ShowContexMenu4Speaker( g_CurSpeakerName, g_CurSpeakerContex, g_CurSpeakerZoneworldid);
end

--�������� added by zhanglei 
--strCfg ��������
function ChatFrame_CreateFenping(strCfg)
	ChatFrame_PrepareMove();
	
	local absFrameHeight = g_MoveCtl.frame:GetProperty("AbsoluteHeight");
	local absFenpingHeight = g_FenpingMinHeight
	local absHistoryHeight = g_MoveCtl.history:GetProperty("AbsoluteHeight");
	local absCheckHeight = g_MoveCtl.check:GetProperty("AbsoluteHeight");
	local absToolBarHeight_1 = g_MoveCtl.toolbar1:GetProperty("AbsoluteHeight");
	local absToolBarHeight_2 = g_MoveCtl.toolbar2:GetProperty("AbsoluteHeight");
	local absToolBarHeight = absToolBarHeight_1 + absToolBarHeight_2
	local absSpeakerHeight = g_MoveCtl.speaker:GetProperty("AbsoluteHeight")
	
	g_MoveCtl.fenping:Show()
	--fenping
	local udimStr_fenping = string.format("{%f,%f}", 0.000000, absFenpingHeight );
	g_MoveCtl.fenping:SetProperty("UnifiedHeight", udimStr_fenping );
	udimStr_fenping= string.format("{%f,%f}", 1.000000, -(absToolBarHeight + absFenpingHeight));
	g_MoveCtl.fenping:SetProperty("UnifiedYPosition", udimStr_fenping);
	--frame
	if absFrameHeight + absFenpingHeight > g_MaxFrameHeight then
		--frame
		g_MoveCtl.frame:SetProperty("AbsoluteHeight", g_MaxFrameHeight );
		local udimStr_frame= string.format("{%f,%f}", 1.000000, -(g_MaxFrameHeight + g_MoveUpHeight));
		g_MoveCtl.frame:SetProperty("UnifiedYPosition", udimStr_frame);
	else
		--frame
		g_MoveCtl.frame:SetProperty("AbsoluteHeight", absFrameHeight + absFenpingHeight + g_Spin );
		local udimStr_frame= string.format("{%f,%f}", 1.000000, -(absFrameHeight + absFenpingHeight + g_Spin + g_MoveUpHeight));
		g_MoveCtl.frame:SetProperty("UnifiedYPosition", udimStr_frame);
	end
	--History
	local other_Height = absSpeakerHeight + absCheckHeight + absFenpingHeight + absToolBarHeight + g_Spin
	local udimStr_history = string.format("{%f,%f}", 1.000000, -other_Height);
	g_MoveCtl.history:SetProperty("UnifiedHeight" ,udimStr_history)
	
	ChatFrame_FenpingCreateConfig(strCfg);
	
	Chat_Frame_History:ScrollToEnd();
	Chat_Frame_Fenping:ScrollToEnd();
	
	local minHeight = tonumber(Chat_Chat_ScaleBtn:GetProperty("MiniHeight"))
	Chat_Chat_ScaleBtn:SetProperty("MiniHeight" , tostring(minHeight + g_FenpingMinHeight + g_Spin) )
end

--����������ʱ�����õı��棬��ʷ��ݵ�д��
function ChatFrame_FenpingCreateConfig(tabCfg)
		local tabName = "FP";
		local old_channel = channel_seltab;
		channel_seltab = g_channel_fenping;
		ChatFrame_ChangeTabConfig(tabCfg);
		channel_config[channel_seltab][1] = tabName;
		
		--��������
		Talk:SaveTab(channel_seltab, tabName, tabCfg);
		ChatFrame_SetTabConfig(channel_seltab);
		
		ChatFrame_AddFenpingMsg(channel_seltab);

		channel_seltab = old_channel;
end

-- ��������ʷ��ݵĴ���
-- ����ʷ��Ϣ��ʾ������
function ChatFrame_AddFenpingMsg(nIndex)
	Chat_Frame_Fenping:RemoveAllChatString();
	
	if channel_config[nIndex] == nil then
		Talk:InsertHistory( nIndex, "" );
	else
		local i = 2;
		local strConfig = "";
		while channel_config[nIndex][i] ~= nil do
			strConfig = strConfig .. tostring(channel_config[nIndex][i]);
			i = i+1;
		end
		Talk:InsertHistory( nIndex, strConfig);
	end
	
	Chat_Frame_Fenping:ScrollToEnd();
end
--���÷������� added by zhanglei 
--strCfg ��������
function ChatFrame_CloseFenping(strCfg)
	ChatFrame_PrepareMove();

	--�ȹرշ���
	g_MoveCtl.fenping:Hide();

	local absFrameHeight = g_MoveCtl.frame:GetProperty("AbsoluteHeight");
	local absFenpingHeight = g_MoveCtl.fenping:GetProperty("AbsoluteHeight");
	local absHistoryHeight = g_MoveCtl.history:GetProperty("AbsoluteHeight");
	local absCheckHeight = g_MoveCtl.check:GetProperty("AbsoluteHeight");
	local absToolBarHeight_1 = g_MoveCtl.toolbar1:GetProperty("AbsoluteHeight");
	local absToolBarHeight_2 = g_MoveCtl.toolbar2:GetProperty("AbsoluteHeight");
	local absToolBarHeight = absToolBarHeight_1 + absToolBarHeight_2
	local absSpeakerHeight = g_MoveCtl.speaker:GetProperty("AbsoluteHeight")
	
	
	--frame
	g_MoveCtl.frame:SetProperty("AbsoluteHeight", absFrameHeight - absFenpingHeight - g_Spin );
	local udimStr_frame= string.format("{%f,%f}", 1.000000, -(absFrameHeight - absFenpingHeight - g_Spin + g_MoveUpHeight));
	g_MoveCtl.frame:SetProperty("UnifiedYPosition", udimStr_frame);
	--History
	local other_Height = absSpeakerHeight + absCheckHeight + absToolBarHeight
	local udimStr_history = string.format("{%f,%f}", 1.000000, -other_Height);
	g_MoveCtl.history:SetProperty("UnifiedHeight" ,udimStr_history)
	
	Talk:ClearTab(g_channel_fenping);
	
	-- ����ChatHistory�������
	Talk:ClearFenpingHisQue();
	Chat_Frame_History:ScrollToEnd();
	
	local minHeight = tonumber(Chat_Chat_ScaleBtn:GetProperty("MiniHeight"))
	Chat_Chat_ScaleBtn:SetProperty("MiniHeight" , tostring(minHeight - g_FenpingMinHeight - g_Spin) )
end

--�ı������ʾ����
function ChatFrame_ConfigFenping(tabCfg)
	if(tabCfg == nil ) then
		return;
	end
	local old_channel = channel_seltab;
	channel_seltab = g_channel_fenping --����ID
	ChatFrame_ChangeTabConfig(tabCfg);

	--��������
	Talk:SaveTab(channel_seltab, channel_config[channel_seltab][1], tabCfg);
	ChatFrame_SetTabConfig(channel_seltab);

	channel_seltab = old_channel;
end

function ChatFrame_OpenFenpingDlg(isFenpingOpen)
	if tonumber(isFenpingOpen) == 0 then
		Talk:OpenFenpingConfigDlg("");
	else
		-- ��õ�ǰ����
		local i = 2;
		local strConfig = "";
		while channel_config[g_channel_fenping][i] ~= nil do
			strConfig = strConfig .. tostring(channel_config[g_channel_fenping][i]);
			i = i+1;
		end
		Talk:OpenFenpingConfigDlg(strConfig);
	end
end

function ChatFrame_PrepareBtnCtl()
	g_ChatBtn = {
					ime		= Chat_Chat_IME,
					color	= Chat_Chat_LetterColor,
					face	= Chat_Chat_Face,
					action	= Chat_Chat_Action,
					pingbi	= Chat_Chat_Screen,
					create	= Chat_Chat_User,
					config	= Chat_Chat_Config,
					select	= Chat_ChannelSelecter,
				};
end

function ChatFrame_GetBtnScreenPosX(btn)
	ChatFrame_PrepareBtnCtl();
	if btn == "ime" or btn == "color" or btn == "face" or btn == "action" then 
		local barxpos = Chat_Frame:GetProperty("AbsoluteXPosition");
		local barmxpos = Chat_ToolBar:GetProperty("AbsoluteXPosition");
		local barmmxpos	= Chat_Button_LeftFrame:GetProperty("AbsoluteXPosition")
		local btnxpos = g_ChatBtn[btn]:GetProperty("AbsoluteXPosition");
		return barxpos + btnxpos + barmxpos + barmmxpos;
	else
		local barxpos = Chat_Frame:GetProperty("AbsoluteXPosition");
		local barmxpos = Chat_Button_ChatFrame:GetProperty("AbsoluteXPosition");
		local barmmxpos	= Chat_Button_Chat:GetProperty("AbsoluteXPosition")
		local btnxpos = g_ChatBtn[btn]:GetProperty("AbsoluteXPosition");
		return barxpos + btnxpos + barmxpos + barmmxpos;
	end
end
--������������¼
function ChatFrame_SaveTabTalkHistory()
	Talk:SaveChatHistory(channel_seltab);
end
--������ΰ�ť
function ChatFrame_PingBi()
	Talk:ShowPingBi(ChatFrame_GetBtnScreenPosX("pingbi"));
end
--����û��Զ���Ƶ��
function ChatFrame_CreateTab()
	if(channel_tab_total+1 > CHANNEL_TAB_MAX) then
		PushDebugMessage("Kh�ng ���c t�o nhi�u k�nh");
	else
		Talk:CreateTab(ChatFrame_GetBtnScreenPosX("create"));
	end
end
--�������
function ChatFrame_ConfigTab()
	if(channel_seltab == 0 or channel_seltab == 1) then
		PushDebugMessage("K�nh n�y kh�ng ���c b�y tr�");
		return;
	end
	-- ��õ�ǰ����
	local i = 2;
	local strConfig = "";
	while channel_config[channel_seltab][i] ~= nil do
		strConfig = strConfig .. tostring(channel_config[channel_seltab][i]);
		i = i+1;
	end
	ChatFrame_PrintTabConfig(channel_seltab);
	-- ֪ͨ����ʼ����
	Talk:ConfigTab( channel_config[channel_seltab][1],strConfig,ChatFrame_GetBtnScreenPosX("config"));
end
--�������
function ChatFrame_Open_Fenping_Config()
	local isFenpingOpen = Talk:IsFenpingOpen()
	if tonumber(isFenpingOpen) == 0 then
		Talk:OpenFenpingConfigDlg("");
	else
		-- ��õ�ǰ����
		local i = 2;
		local strConfig = "";
		while channel_config[g_channel_fenping][i] ~= nil do
			strConfig = strConfig .. tostring(channel_config[g_channel_fenping][i]);
			i = i+1;
		end
		Talk:OpenFenpingConfigDlg(strConfig);
	end
end
--������Ӹ߶�
function ChatFrame_AskFrameSizeUP()
	ChatFrame_MoveCtl(1);
end
--������ٸ߶�
function ChatFrame_AskFrameSizeDown()
	ChatFrame_MoveCtl(-1);
end
--������ӿ��
function ChatFrame_AskFrameWidthUP()
	ChatFrame_WidthCtl(1);
end
--������ٿ��
function ChatFrame_AskFrameWidthDown()
	ChatFrame_WidthCtl(-1);
end
--���ʲô����
function ChatFrame_extendRegionTest()
	Chat_Frame_History:ExtendClearRegion();
end
--���������ɫ
function ChatFrame_SelectTextColor()
	local yPos = Chat_Frame:GetProperty("AbsoluteYPosition")
	yPos = yPos + Chat_ToolBar:GetProperty("AbsoluteYPosition")
	yPos = yPos + Chat_Button_LeftFrame:GetProperty("AbsoluteYPosition")
	yPos = yPos - 120
	Talk:SelectTextColor("select", ChatFrame_GetBtnScreenPosX("color") , yPos);
end
--�������
function ChatFrame_SelectFaceMotion()
	local yPos = Chat_Frame:GetProperty("AbsoluteYPosition")
	yPos = yPos + Chat_ToolBar:GetProperty("AbsoluteYPosition")
	yPos = yPos + Chat_Button_LeftFrame:GetProperty("AbsoluteYPosition")
	yPos = yPos - 310
	Talk:SelectFaceMotion("select", ChatFrame_GetBtnScreenPosX("face") , yPos);
end
--�������
function ChatFrame_ChatMood()
	Talk:ShowChatMood(ChatFrame_GetBtnScreenPosX("action"));
end
--���Ƶ��ѡ��
function ChatFrame_ChannelSelect()
	ChatFrame_ChannelSelect_ChangePosition(ChatFrame_GetBtnScreenPosX("select"));
	Chat_Frame_ChannelFrame:Show();

	local nChannelNum = Talk:GetChannelNumber();
	Chat_Frame_Channel:ClearAllChannel();
	
	local i=1;
	local FoundPrv=-1;
	while i<=nChannelNum do
		local strChannelType, strChannelName = Talk:GetChannel(i-1);
		if(strChannelType == "-" or CHANNEL_DATA[strChannelType] == nil) then
			return;
		end

		if(strChannelType ~= "private") then
			Chat_Frame_Channel:AddChannel(strChannelType, CHANNEL_DATA[strChannelType][1], strChannelName);
		else
			FoundPrv = i-1;
		end
		
		i = i+1;
	end
	-- ˽�Ķ����б���룬todo_yangjun
	if(-1 ~= FoundPrv) then
		local strPrvType, strPrvName1, strPrvName2, strPrvName3 = Talk:GetChannel(FoundPrv);
		if(CHANNEL_DATA[strPrvType] == nil) then
			return;
		end
		if(strPrvName1 ~= "" and strPrvName1 ~= nil) then
			Chat_Frame_Channel:AddChannel(strPrvType, CHANNEL_DATA[strPrvType][1], strPrvName1);
		end
		if(strPrvName2 ~= "" and strPrvName2 ~= nil) then
			Chat_Frame_Channel:AddChannel(strPrvType, CHANNEL_DATA[strPrvType][1], strPrvName2);
		end
		if(strPrvName3 ~= "" and strPrvName3 ~= nil) then
			Chat_Frame_Channel:AddChannel(strPrvType, CHANNEL_DATA[strPrvType][1], strPrvName3);
		end
	end
end
--����ѡ���Ƶ��
function ChatFrame_SetChannelSel(channel, channelname)
	if(CHANNEL_DATA[channel] == nil) then
		return;
	end
	Chat_ChannelSelecter:SetProperty("NormalImage", CHANNEL_DATA[channel][1]);
	Chat_ChannelSelecter:SetProperty("HoverImage", CHANNEL_DATA[channel][2]);
	Chat_ChannelSelecter:SetProperty("PushedImage", CHANNEL_DATA[channel][3]);
end
-- ����˫�����춯����Ϣ
function ChatFrame_DoubleChatActionMessageSend(bEnable, talker)
	-- �Ҳ���˵����
	if (talker == "") then
		return
	end

	-- ˵���Ĳ����Լ�
	local myName = Player:GetName()	
	if (myName ~= talker) then
		return
	end

	-- �Է����������춯������
	if (bEnable == 1) then
		local prvname,perColor = Talk : SendChatMessage(g_theCurrentChannel, g_ChatActionTxt);
		g_ChatActionTxt = "";

		if (nil == prvname ) then prvname = ""; end
		if( nil == perColor ) then perColor = ""; end
		local str = "";
		if (prvname == "")then
			str = str..perColor;
		else
			str = str.."/"..prvname.." "..perColor;
		end

		if("" ~= str) then
			ChatFrame_SetEditBoxTxt(str);		-- ˽��
		else
			ChatFrame_SetEditBoxTxt("");			-- ��˽��
		end
	end

end
--��
function ChatFrame_TextAccepted()

	-- �õ�������ַ�
	local txt = Chat_EditBox:GetItemElementsString();
	
	-- Ԥ���ж������ַ��ǲ�����Ч��˫�����춯��
	local bChatAction = Talk : IsValidChatActionString(g_theCurrentChannel, txt);
	
	-- ��Ч��˫�����춯��
	if (bChatAction == 1) then
		-- ѯ�ʶԷ��Ƿ�������������ݲ�����������Ϣ�ַ�Ҳ����¼��ʷ�����¼��
		g_ChatActionTxt = txt							-- �Ȱ����춯���ַ��¼����
		ChatFrame_SetEditBoxTxt("")			-- ��ձ༭��
		Talk : CanDoDoubleAction_Bar()
	
	-- ��Ч��˫�����춯��
	elseif (bChatAction == 2) then
		-- ������������Ϣ�ַ�Ҳ����¼��ʷ�����¼��ֻ����ʾ��Ϣ
		g_ChatActionTxt = ""			-- ������춯���ַ�
		ChatFrame_SetEditBoxTxt("")			-- ��ձ༭��

	-- �������춯��������ͨ������Ϣ
	elseif (bChatAction == 0) then		
		-- ������ͨ������Ϣ
		local prvname,perColor = Talk : SendChatMessage(g_theCurrentChannel, txt);
		if(nil == prvname ) then prvname = ""; end
		if(nil == perColor ) then perColor = ""; end
		local str = "";
		if(prvname == "")then
			str = str..perColor;
		else
			str = str.."/"..prvname.." "..perColor;
		end
		
		if("" ~= str) then
			ChatFrame_SetEditBoxTxt(str);		-- ˽��
		else
			ChatFrame_SetEditBoxTxt("");			-- ��˽��
		end
	end	
end

function ChatFrame_SetEditBoxTxt(txt)
	Chat_EditBox:SetProperty("ClearOffset", "True");
	Chat_EditBox:SetItemElementsString(txt);
	Chat_EditBox:SetProperty("CaratIndex", 1024);
end

function ChatFrame_InputLanguage_Changed()

	local langId = Talk:GetCurInputLanguage();

	if(g_InputLanguageIcon[langId] == nil)then
		Chat_Chat_IME:SetProperty("NormalImage", g_InputLanguageIcon[1]);
		Chat_Chat_IME:SetProperty("HoverImage", g_InputLanguageIcon[1]);
		Chat_Chat_IME:SetProperty("PushedImage", g_InputLanguageIcon[1]);
	else
		Chat_Chat_IME:SetProperty("NormalImage", g_InputLanguageIcon[langId]);
		Chat_Chat_IME:SetProperty("HoverImage", g_InputLanguageIcon[langId]);
		Chat_Chat_IME:SetProperty("PushedImage", g_InputLanguageIcon[langId]);
	end
end

function ChatFrame_SelectColorFaceFinish(act, strResult)
	if(act == "sucess") then
		local txt = Chat_EditBox:GetItemElementsString();
		local facetxt = txt .. strResult;
		ChatFrame_SetEditBoxTxt(facetxt);
	end
end

function ChatFrame_JoinItemElementFailure()
	PushDebugMessage("T�ng th�m tin t�c v�t ph�m th�t b�i.");
end

function ChatFrame_ItemElementFull()
	PushDebugMessage("Kh�ng ���c t�ng th�m nhi�u tin t�c v�t ph�m.");
end

function ChatFrame_OpenSpeakerBox()
--	Talk : OpenSpeakerSelectDlg();
	Talk:OpenSpeakerDlg(0)
end

function ChatFrame_MouseEnter()
	Chat_CheckBox_Frame:Show()
	local _,_,_,_,_,_,_,_,_,f10,_,_,_,_,_,_,_,_,_,_,_,_,_,_ = SystemSetup:GameGetData();
	local alphaStr = string.format("%f" , f10 )
	Chat_Frame_HistoryFrame:SetProperty("Alpha" , alphaStr)
	Chat_Frame_FenpingFrame:SetProperty("Alpha" , alphaStr)
end

function ChatFrame_MouseLeave()
	Chat_CheckBox_Frame:Hide()
	local _,_,_,_,_,_,_,_,_,f10,_,_,_,_,_,_,_,_,_,_,_,_,_,_ = SystemSetup:GameGetData();
	local alphaStr = string.format("%f" , f10 / 2 )
	Chat_Frame_HistoryFrame:SetProperty("Alpha" , alphaStr)
	Chat_Frame_FenpingFrame:SetProperty("Alpha" , alphaStr)
end

--- ***************************************
--  Mod by sou
--  ***************************************

--- Module: 'StringUtils'
--- Begin: 'StringUtils' declaration
local StringUtils = {}

function StringUtils.startWith(sign, source)
    -- valid parameters
    if source == nil or string.len(source) ==0 or sign == nil or string.len(sign) ==0 then return false
        -- check
    elseif string.sub(source, 1, 1) == sign then return true
    else return false
    end
end

function StringUtils.getByIndex(index, array)
    -- valid variable
    if array == nil or table.getn(array) == 0 or table.getn(array) < index then return nil end
    -- process
    return array[index]
end

function StringUtils.seperate(source)
    return StringUtils.split(source, "%S+")
end

function StringUtils.split(source, pattern)
    -- valid parameters
    if source == nil or string.len(source) ==0 then return source end
    -- process
    local iteratorSource = string.gmatch(source, pattern)
    local array = {}
    for str in iteratorSource do
        array[#array + 1] = str
    end
    return array
end
--- End: 'StringUtils' declaration

--- Module: 'CommandController'
--- Begin: 'CommandController' declaration
local CommandController = {
    COMMAND_SIGN = "!";

    COMMANDS = {
        [1] = "goto",
        [2] = "autoatk"
    };

    MODE_STANDARD = 1;
    MODE_EXTENDED = 2;

    currentMode = MODE_STANDARD; -- default
}

---
-- Set mode for processing load commands.
-- Modes: 1-Standard (default); 2-Extended.
--
function CommandController.setMode(mode)
    -- validate mode value
    if mode ~= CommandController.MODE_EXTENDED then mode = CommandController.MODE_STANDARD end
    -- set mode value
    CommandController.currentMode = mode
end

---
-- Process input text
--
function CommandController.process(text)
    -- validate command string
    if StringUtils.startWith(CommandController.COMMAND_SIGN, text) == false then return end
    -- process
    local commandStr = string.sub(text, 2)
    CommandController.dispatch(commandStr)
end

---
-- Dispatch commands
--
function CommandController.dispatch(commandStr)
    local array = StringUtils.seperate(commandStr)
    local command = StringUtils.getByIndex(1, array)
    -- validate command
    if command == nil then return end
    -- process
    command = string.lower(command)
    local arguments = {}
    for k, v in ipairs(array) do
        if k >= 2 then
            arguments[#arguments + 1] = string.lower(v)
        end
    end
    if CommandController.currentMode == CommandController.MODE_STANDARD then
        local i = 1
        while i <= table.getn(CommandController.COMMANDS) do
            if command == CommandController.COMMANDS[i] then
                CommandController.call(command, arguments)
                return
            end
            i = i + 1
        end
        PushDebugMessage("[ERROR] This command is not supported: '"..command.."'")
    else
        CommandController.call(command, arguments)
    end
end

---
-- Call command (Commands are stored in package 'command')
-- @param cmdName
-- @param arguments
--
function CommandController.call(cmdName, arguments)
    local func = loadstring("return ".."Command_"..cmdName.."(...)")
    local status, result = pcall(func, arguments)
    if status == false then
        PushDebugMessage("Failed to load command '"..cmdName.."'")
    end
end
--- End: 'CommandController' declaration

--- Module: 'MapData'
--- Begin: 'MapData' declaration
local MapData = {
    MAPS = {
        ["DAI_LY"] = {"daily", "dl", ["ID"]=1},
        ["LAC_DUONG"] = {"lacduong", "ld", ["ID"]=2},
        ["TO_CHAU"] = {"tochau", "tc", ["ID"]=3},
        ["LAU_LAN"] = {"laulan", "ll", ["ID"]=4}
    }
}

function MapData.getMapKey(map)
    -- validate map name
    if map == nil then return nil end
    -- process
    map = string.lower(map)
    for key, value in pairs(MapData.MAPS) do
        for k, v in pairs(value) do
            if v == map then return key end
        end
    end
    return nil
end

function MapData.getMapID(mapKey)
    -- validate map key
    if mapKey == nil then return -1 end
    -- process
    mapKey = string.upper(mapKey)
    for key in pairs(MapData.MAPS) do
        if(key == mapKey) then return MapData.MAPS[key]["ID"] end
    end
    return -1
end
--- End: 'MapData' declaration

--- ---------------------------------------
--  COMMANDS DECALARATION
--  ---------------------------------------
function Command_goto(arguments)
    PushDebugMessage("Command 'goto' loaded")

    local mapName = arguments[1]
    local xPos = arguments[2]
    local yPos = arguments[3]

    -- validate map
    local mapKey = MapData.getMapKey(mapName);
    if mapKey == nil then
        PushDebugMessage("[ERROR] This map is not supported: '"..mapName.."'")
        return
    end
    -- validate positions
    if xPos == nil  or yPos == nil or tonumber(xPos) < 0  or tonumber(yPos) < 0 then
        PushDebugMessage("[ERROR] Invalid position coordinates")
        return
    end
    -- process
    local mapID = MapData.getMapID(mapKey)
    PushDebugMessage("map: "..mapKey.." (id="..mapID..")")
end

---
-- (Only for testing)
-- Overide original function 'PushDebugMessage'.
-- Note: should comment this code-block before release.
--
--function PushDebugMessage(text)
--    print(text)
--end