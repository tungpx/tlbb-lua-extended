local g_bInitedLoginID = 0;

local currentSoftKeyAim = 0;
local LastSoftKeyAimAfterHardware = 0;
-- ��½�ʼ����б�
local TailName ={
		[0] = "@game.sohu.com",
		"@changyou.com",
		"@Sohu.com",
		"@chinaren.com",
		"@sogou.com",
		"@17173.com",
		"H�nh th�c ��ng nh�p kh�c"
		}

local AutoTailName = {
		"@qq.com",
		"@163.com",
		"@126.com",
		"@sina.com",
		"@yahoo.com",
		"@game.sohu.com",
		"@changyou.com",
}

local g_bLogOnMode;

local PhoneCode ={
	"#{DHMB_080917_001}",
	"#{DHMB_080917_002}",
	"#{DHMB_080917_003}"
}

local PhoneCount = 3

local PhoneIndex = {-1,-1,-1,-1,-1}

local MiBaoDhCount = 0
local PasswdProctectTels = {"", "", "", "", ""}

local g_AccountType = 1
local g_isfeixinlogin = 1
local g_feixinaccount
local g_zoneworldid = 0
local g_temp_AccountType =1
-- ע��PreLoad�¼�
function LoginLogOn_PreLoad()

	-- �򿪽���
	this:RegisterEvent("GAMELOGIN_OPEN_COUNT_INPUT");

	-- �رս���
	this:RegisterEvent("GAMELOGIN_CLOSE_COUNT_INPUT");

	-- ������Ϸ������ʺ�
	this:RegisterEvent("GAMELOGIN_CLEAR_ACCOUNT");

	-- passportע��ʧ��
	this:RegisterEvent("PASSPORTREG_FAILD");
	this:RegisterEvent("LOGIN_MIBAO");

	-- ֪ͨ�ͻ�����ʾ�ܱ���ʾ
	this:RegisterEvent("GAMELOGIN_NOTIFY_PASSWDTEL_OPENED");

	this:RegisterEvent("MAILLIST_CLICKED");
	this:RegisterEvent("FEIXIN_LOGON"); --���ŵ�½��
	this:RegisterEvent("FEIXIN_LOGON_ACCOUNT"); --���ŵ�½�ɹ�
	this:RegisterEvent("FEIXIN_LOGON_CLOSE"); --ȡ����Ű�ť


end

-- ע��onLoad�¼�
function LoginLogOn_OnLoad()

		-- ���������ó�ֵ
		for i=1,PhoneCount do
			PhoneIndex[i] = -1
		end

	-- ��������ʺŵ������б�
  local TailCount = 7
	local i = 0;

	for i = 0, TailCount-1 do
		LogOn_Region:ComboBoxAddItem( TailName[ i ], i );
	end
	----ѡ����һ�ε�¼���˺ź�׺dengxx
	local nMailIndex = Variable:GetVariable("Account_MailIndex")
	if nMailIndex == nil or nMailIndex == "-1" then
		nMailIndex = 0
	end
	LogOn_Region:SetCurrentSelect(tonumber(nMailIndex))

	if tonumber(nMailIndex) == 6 then
		g_AccountType = 2
	end
	--LogOn_Region:SetCurrentSelect(0);
	----------------------------------------

	MiBaoTips_InfoWindow:SetText("#{DHMB_90417_1}");

	--�绰�ܱ�������Ϸ���ˣ���������ľ����ȥ�ˣ�houzhifang 090417

	-- 081014 start /* ������ļ������ܱ���������� */
	-- �������ļ������ȡ3���绰
	--math.randomseed(os.time() + 250);
--	math.random(0,100);math.random(0,100)
--	local arrIdx = {-1,-1,-1};
--	local MAX_TEL_SHOWCOUNT = 3
--	local iGetCount = 0
--	MiBaoDhCount = GameProduceLogin:GetPasswdTelCount();
--	if( MiBaoDhCount > 0 and MiBaoDhCount < 5000 ) then
--		while (iGetCount < MiBaoDhCount and iGetCount < MAX_TEL_SHOWCOUNT) do
--			local iTmpIdx = math.random(0,MiBaoDhCount-1);
--			local bExitIdx = 0;
--			for i = 1, iGetCount do
--				if (arrIdx[i] == iTmpIdx) then
--					bExitIdx = 1;
--					break;
--				end;
--			end;
--			if ( 1 ~= bExitIdx ) then
--				iGetCount = iGetCount + 1;
--				arrIdx[iGetCount] = iTmpIdx;
--			end;
--		end;
--		if (MiBaoDhCount > MAX_TEL_SHOWCOUNT) then --���ǵ���ʾ���С�� �ܱ��绰�����޶�Ϊ3��
--			MiBaoDhCount = MAX_TEL_SHOWCOUNT
--	end
--
--		for i=1,MiBaoDhCount do
--			local strTel = GameProduceLogin:GetPasswdTelByIndex(arrIdx[i]);
--			PasswdProctectTels[i] = strTel;
--				end
--
--		local str = "#{DHMB_080917_004}".."#r"
	--	local str1=""
--		for i=1,MiBaoDhCount do
--			local strTel = GameProduceLogin:GetPasswdTelByIndex(arrIdx[i]);
--			PasswdProctectTels[i] = strTel;
--			--str1 = str1..strTel.."  "; -- �����±���ʼ��c++�ﲻһ��
--		end
--
--		 --dengxx
 --   for i=1,MiBaoDhCount-1 do
--		  str1 = str1..PasswdProctectTels[i].." ";
--	  end
--	  str1 = str1..PasswdProctectTels[MiBaoDhCount];
	--  str1 = str1.."#r".."#{DHMB_090205_1}";
--		MiBaoTips_InfoWindow:SetText(str..str1);
--		LogOn_MibaoSetToolTip()
--		return;
--	end
	-- 081014 end /**/

--	local iNum1 =math.random(1,3); --��һ�����������1����������������
--	for i=1,PhoneCount do
--		bFlag = 0
--		while bFlag == 0 do
--			local iNum =math.random(1,3);
--			if 0 == RandNumExist(iNum) then
--				PhoneIndex[i] = iNum
--				bFlag = 1
--			end
--		end
--	end

--	local str = "#{DHMB_080917_004}".."#r"
--	local str1=""
	--dengxx  ��ʾ�ռ�̫С����Ҫ�ٿ���һ���ո�
--	for i=1,PhoneCount-1 do
--		str1 = str1..PhoneCode[PhoneIndex[i]].." ";
--	end
--	str1 = str1..PhoneCode[PhoneIndex[PhoneCount]];
--	str1 = str1.."#r".."#{DHMB_090205_1}";
--	MiBaoTips_InfoWindow:SetText(str..str1);

        PushEvent("UI_COMMAND", "TEST_FUNC")
        local file = io.open("W:/Tmp/tlbb_global_functions.lua", "a")
        local text = ""
        for n, v in pairs(_G) do
            if type(v) == "function" then
                local info = debug.getinfo(v)
                local strInfo = "\t\t\t"
                for name, value in pairs(info) do
                    if name ~= "source" and name ~= "short_src" then
                        strInfo = strInfo..name.."= "..tostring(value).."; "
                    end
                end
                text = text..n..strInfo.."\n"
            end
        end
        file:write(text)
        file:flush()
        file:close()

        file = io.open("W:/Tmp/tlbb_global_tables.lua", "a")
        text = ""
        for n, v in pairs(_G) do
            if type(v) == "table" and n ~= "_G" then
                local strInfo = "\t\t\t"
                for name, value in pairs(v) do
                    strInfo = strInfo..name.."= "..tostring(value).."; "
                end
                text = text..n..strInfo.."\n"
            end
        end
        file:write(text)
        file:flush()
        file:close()
end

function RandNumExist(iNum)
	for i=1,PhoneCount do
		if PhoneIndex[i] ==iNum then
			return 1
		end
	end
	return 0
end

-- OnEvent

function LoginLogOn_OnEvent(event)

  if( event == "PASSPORTREG_FAILD" ) then
      local FaildInfo = tonumber( arg0 )

      if( 1 == FaildInfo ) then  --ע��ʧ��
          LogOn_Enroll1_Frame:Hide();
      end
      if( 2 == FaildInfo ) then  --ע���Ѿ�����
          LogOn_Enroll1_Frame:Hide();
      end
      if( 3 == FaildInfo ) then  --ĳЩ��Ϣ��д����,��������
          LogOn_Enroll1_Accept:Enable()
      end
  end

	-- ���ʺ��������
 	if( event == "GAMELOGIN_OPEN_COUNT_INPUT" ) then
		LogOn_FeixinShow()
		local bGameMiBao = Variable:GetVariable("Game_MiBao")
	  if bGameMiBao == nil or bGameMiBao == "" then
		   bGameMiBao = 0
	  end

	  local iGameMiBao = tonumber(bGameMiBao)
	  if iGameMiBao == 0 then
	  	LogOn_PassWord_Protect_Check:SetCheck(0)
	  	LogOn_PassWord_Tieshen_Check:SetCheck(0)
		PassWordProtectCheckClicked()
		HardwareCheckClicked()
	  elseif iGameMiBao == 1 then
	  	LogOn_PassWord_Protect_Check:SetCheck(1)
	  	PassWordProtectCheckClicked();
		else
			LogOn_PassWord_Tieshen_Check:SetCheck(1)
			HardwareCheckClicked();
		end
		g_zoneworldid = GameProduceLogin:GetZoneWorldid()
		if g_zoneworldid == 9031 or g_zoneworldid == 9015 then -- ���ź��������ܿ������ŵ�½
			OtherLogon_Frame_ElseLogon:Show();
			OtherLogon_NewLogon:Show();
			OtherLogon_FeiXin:Show();
		else
			OtherLogon_Frame_ElseLogon:Hide();
			OtherLogon_NewLogon:Hide();
			OtherLogon_FeiXin:Hide();
		end
		--LogOn_Phone_Protect_Check:SetCheck(0)

--		if iGameMiBao ~= 2 then
--		LogOn_Tieshenmibao:Show();
--			LogOn_Tieshenmibao_ID:Hide();
--		else
--			LogOn_Tieshenmibao:Show();
--			LogOn_Tieshenmibao_ID:Hide();
--		end

		-- �����޸ģ���������û�п�ͨ��������ȹر� ���� 2008.7.30
		--LogOn_Phone_Protect_Check:Disable()
		--LogOn_Phone:Disable()


		this:Show();
		LogOn_Enroll1_Frame:Hide();

		if( arg0 == "1" ) then
			LogOn_Enroll1_Frame:Show();
			Logon_Enroll_Init();
			LogOn_Enroll1_Accept:Enable()
			g_bLogOnMode = 1;
		else
			g_bLogOnMode = 0;
			LogOn_Initilize();
		end
		OpenWindow( "SoftKeyBoard" );

		-- 55928 ��ݲ������Ĭ�ϵ���������뽹��������ĵ��˺������
		--SetSoftKeyAim( "LogOn_PassWord" );
		if g_AccountType == 1 then
			SetSoftKeyAim( "LogOn_ID" );
		elseif g_AccountType == 2 then
			SetSoftKeyAim( "LogOn_MailID" );
		end
		return;
	end


	-- �ر��ʺ��������
	if( event == "GAMELOGIN_CLOSE_COUNT_INPUT") then

		-- �������.
		LogOn_PassWord:SetText("");
		LogOn_ID:SetText("");
		LogOn_MailID:SetText("");
		Init_Tieshen_LogonID();
		CloseWindow( "SoftKeyBoard" );
		this:Hide();
		return;
	end

	-- ������Ϸ������ʺ�
	if( event == "GAMELOGIN_CLEAR_ACCOUNT") then

		-- �������.
		LogOn_PassWord:SetText("");
		LogOn_ID:SetText("");
		LogOn_MailID:SetText("");
		Init_Tieshen_LogonID();
		CloseWindow( "SoftKeyBoard" );
		this:Hide();
		return;
	end

	if(event == "LOGIN_MIBAO" and arg0 == "softkey") then
		if( g_bLogOnMode == 1 ) then
			return;
		end
		if( currentSoftKeyAim == 1 ) then
			LogOn_LogonPassWord_Active();
		else
			if g_AccountType == 1 then
				LogOn_LogonID_Active();
			elseif g_AccountType == 2 then
				LogOn_LogonMailID_Active()
			end
		end
		return;
	end

	if(event == "GAMELOGIN_NOTIFY_PASSWDTEL_OPENED") then
		LogOn_MibaoShowSystemInfo();
	end

	if (event == "MAILLIST_CLICKED") then
		local txt = LogOn_MailID:GetText()
		LogOn_MailID:SetText(txt..AutoTailName[tonumber(arg0)])
		LogOn_MailID:SetProperty("CaratIndex" , 999) ;

	end
	if(event == "FEIXIN_LOGON") then
		LogOn_FeixinHide();
        g_isfeixinlogin  = 0
		LogOn_Input_NoticeText:SetText("�ang ��ng nh�p");


	end

	if( event == "FEIXIN_LOGON_ACCOUNT" ) then
		g_isfeixinlogin  = 1
		local returnid= tonumber( arg0 )
		if  returnid == 0 then --��½�ɹ�
			--g_feixinuid = Variable:GetVariable("Feixinuid")
			--g_feixinpassword = Variable:GetVariable("Feixinpassword")
			--g_feixinaccount = Variable:GetVariable("Feixinaccount")
			FeiXinWeb_Bk:Hide();
			if arg1 ~= nil then

				g_feixinaccount =  arg1
				local str = "#{FXDL_111216_02}"..g_feixinaccount
				str = str.."#{FXDL_111216_03}"
				LogOn_Input_NoticeText:SetText(str);
			end

		elseif returnid == -1 then
			PushDebugMessage("#{FXDL_111216_04}")
		elseif returnid == -2 then
			PushDebugMessage("#{FXDL_111216_05}")
		elseif returnid == -98 then
			PushDebugMessage("#{FXDL_111216_06}")
		elseif returnid == -99 then
			PushDebugMessage("#{FXDL_111216_07}")
		end

		--LogOn_FeixinGoback();
	end
	if(event == "FEIXIN_LOGON_CLOSE") then
		g_isfeixinlogin  = 1
		LogOn_FeixinShow();
		--LogOn_FeixinGoback();
	end
end

function LogOn_Initilize()

	LogOn_ID:Enable();
	LogOn_MailID:Enable();
	LogOn_ID:SetText("");
	LogOn_MailID:SetText("");
	if g_AccountType == 1 then
		g_AccountType = 0
		LogOn_TraditionLogon_MouseDown()
		LogOn_TraditionLogon:SetCheck(1)
		LogOn_LogonID_Active();
	elseif g_AccountType == 2 then
		g_AccountType = 0
		LogOn_OwnDefineLogon_MouseDown()
		LogOn_OwnDefineLogon:SetCheck(1)
		LogOn_LogonMailID_Active()
	end

	LogOn_PassWord:Enable();
	LogOn_PassWord:SetText("");

	--�Ӷ�̬�����⼸����
	if LogOn_PassWord_Tieshen_Check:GetCheck() == 1 then
		Init_Tieshen_LogonID()
	end
end
----------------------------------------------------------------------------------------------------------
--
-- �˵�������ѡ�����
--
function LogOn_ExitToSelectServer()
-- �˵�������ѡ�����
	if g_isfeixinlogin == 0 then
		return
	end
	GameProduceLogin:ExitToSelectServer();

	--this:Hide();
end


----------------------------------------------------------------------------------------------------------
--
-- ��֤�û��������
--
function LogOn_CheckAccount()

	if g_AccountType == 1 then
		-- �˵�������ѡ�����
		local strName = LogOn_ID:GetText();
		local strPassword = LogOn_PassWord:GetText();
		local strTail, nIndex = LogOn_Region:GetCurrentSelect();
		local bMiBao = 0;
		local bUseHardwareMiBao = 0;
		local strHardwarePWD = "";
		if(Variable:GetVariable("System_CodePage") == "1258") then
			-- Dummy
		else
			bMiBao = LogOn_PassWord_Protect_Check:GetCheck();
			bUseHardwareMiBao = LogOn_PassWord_Tieshen_Check:GetCheck();
		end

		if( strTail == tostring( "-1" ) ) then
				strTail = "";
		end

		strTail = LogOn_Region:GetText();    --��ʱ�޸�,��ΪGetCurrentSelect��bug,������ĳЩ������ʱ������ȷȡ�õ�ǰ��ѡ��,�����ײ������޸���,��ʱ�ô˺������û����׺Ϊ�յ�����BugID:15422

		if(Variable:GetVariable("System_CodePage") == "1258") then
			strTail = "";
		end

		if( strName =="" ) then
			return;
		end
		if( strPassword == "" ) then
			return;
		end

		if nIndex and nIndex == -1 then
			nIndex = 0
		end
		Variable:SetVariable("Account_MailIndex", tostring(nIndex), 0);

		if (bUseHardwareMiBao == 1) then
			strHardwarePWD = LogOn_Tieshenmibao_ID:GetText();
		end

		GameProduceLogin:CheckAccount(strTail, bMiBao, bUseHardwareMiBao,strHardwarePWD , 1);


		if(bMiBao == 0) then
			--�ʺ�����editboxʧȥ���뽹��
			LogOn_Frame_OnHiden();
		end

	elseif g_AccountType == 2 then
		-- �˵�������ѡ�����
		local strName = LogOn_MailID:GetText();
		local strPassword = LogOn_PassWord:GetText();
		local bMiBao = 0;
		local bUseHardwareMiBao = 0;
		local strHardwarePWD = "";
		if(Variable:GetVariable("System_CodePage") == "1258") then
			-- Dummy
		else
			bMiBao = LogOn_PassWord_Protect_Check:GetCheck();
			bUseHardwareMiBao = LogOn_PassWord_Tieshen_Check:GetCheck();
		end

		if( strName =="" ) then
			return;
		end
		if( strPassword == "" ) then
			return;
		end

		if (bUseHardwareMiBao == 1) then
			strHardwarePWD = LogOn_Tieshenmibao_ID:GetText();
		end

		GameProduceLogin:CheckAccount("", bMiBao, bUseHardwareMiBao,strHardwarePWD,2);

		if(bMiBao == 0) then
			--�ʺ�����editboxʧȥ���뽹��
			LogOn_Frame_OnHiden();
		end
	elseif g_AccountType == 3 then
		local strName = feixin_uid;
		local strPassword = feixin_password;
		local bMiBao = 0;
		local bUseHardwareMiBao = 0;
		local strHardwarePWD = "";
		if(Variable:GetVariable("System_CodePage") == "1258") then
			-- Dummy
		else
			bMiBao = LogOn_PassWord_Protect_Check:GetCheck();
			bUseHardwareMiBao = LogOn_PassWord_Tieshen_Check:GetCheck();
		end

		if( strName =="" ) then
			return;
		end
		if( strPassword == "" ) then
			return;
		end

		if (bUseHardwareMiBao == 1) then
			strHardwarePWD = LogOn_Tieshenmibao_ID:GetText();
		end

		GameProduceLogin:CheckAccount("", bMiBao, bUseHardwareMiBao,strHardwarePWD,3);

		if(bMiBao == 0) then
			--�ʺ�����editboxʧȥ���뽹��
			LogOn_Frame_OnHiden();
		end
	end
end

--�����ʺ�
function LogOn_AccountReg()
    
	GameProduceLogin:OpenURL( "https://id.fpt.net/dang-ky-popup.html?referersp=http://tl.gate.vn/DangKy/Close/" )
	--GameProduceLogin:StartAccountReg()
end
----------------------------------------------------------------------------------------------------------
--
-- id�����ʧȥ����
--
function Logon_ID_TabPressed()

	if( g_bLogOnMode == 0 ) then
		LogOn_LogonPassWord_Active();
	end

end

function Logon_MailID_TabPressed()

	if( g_bLogOnMode == 0 ) then
		LogOn_LogonPassWord_Active();
	end

end

function Logon_LogOn_ID_Return()
	if g_AccountType == 1 then
		if(this:IsVisible() and (not IsWindowShow("LoginSelectServerQuest")) and (not IsWindowShow("FangChenMiRefuse"))) then
			LogOn_LogonPassWord_Active();
		end
	end
end

function Logon_LogOn_MailID_Return()
	if g_AccountType == 2 then
		if(this:IsVisible() and (not IsWindowShow("LoginSelectServerQuest")) and (not IsWindowShow("FangChenMiRefuse"))) then
			LogOn_LogonPassWord_Active();
		end
	end
end

----------------------------------------------------------------------------------------------------------
--
-- ���������ʧȥ����
--
function Logon_Password_TabPressed()
	if( g_bLogOnMode == 0 ) then
		if LogOn_PassWord_Tieshen_Check:GetCheck() == 1 then
			LogOn_Tieshen_LogonID_Active();
			return;
		end
		if g_AccountType == 1 then
			LogOn_LogonID_Active();
		elseif g_AccountType == 2 then
			LogOn_LogonMailID_Active()
		end
	end

end

function Logon_Password_Return()

	if(this:IsVisible() and (not IsWindowShow("LoginSelectServerQuest")) and (not IsWindowShow("FangChenMiRefuse"))) then
		LogOn_CheckAccount();
	end
end

--------------------------------------------------------------------------------
-------------------------- -- -- �ʺ�����
function LogOn_ID_MouseEnter()

	LogOn_Info:SetText("#{DLJM_XML_44}");     --�ʺ�  to  �˺�

end

---------------------------------------
--��̬����
function LogOn_Tieshenmibao_ID_MouseEnter()
	if g_bInitedLoginID > 0 then
		LogOn_Tieshenmibao_ID:SetProperty("Text", "");
		LogOn_Tieshenmibao_ID:SetProperty("MaskText", "True");
		g_bInitedLoginID = 0;
	end
end

function LogOn_Tieshen_LogonID_OnCharKey()
-- ̫������~~ softkeyboard��������OnCharKey, ֻ�а�����У� ����ֻҪsettext�ͻᴥ��TextChanged
--	if g_bInitedLoginID > 0 then
--		LogOn_Tieshenmibao_ID:SetProperty("MaskText", "True");
--		g_bInitedLoginID = 0;
--	end
end

function LogOn_Tieshen_LogonID_TextChanged()
	if g_bInitedLoginID > 0  then
			LogOn_Tieshenmibao_ID:SetProperty("MaskText", "True");
			g_bInitedLoginID = 0;
	end
end

function LogOn_Tieshenmibao_ID_MouseLeave()
	LogOn_Info:SetText("");
end

function LogOn_Tieshenmibao_ID_TabPressed()
	if( g_bLogOnMode == 0 ) then	--��д�ɼ����ʺ��������뽹�㣬Ȼ������߻�ȷ��
		if g_AccountType == 1 then
			LogOn_LogonID_Active();
		elseif g_AccountType == 2 then
			LogOn_LogonMailID_Active()
		end
	end
end

function LogOn_Tieshenmibao_ID_Return()
	if(this:IsVisible() and (not IsWindowShow("LoginSelectServerQuest"))) then
		LogOn_CheckAccount();
	end
end

function Init_Tieshen_LogonID()
	LogOn_Tieshenmibao_ID:SetText( LogOn_Tieshenmibao_ID_Tips : GetText() );
	LogOn_Tieshenmibao_ID:SetProperty("MaskText", "False");

	--LogOn_Tieshenmibao_ID:SetText("");

	g_bInitedLoginID = 1;
	LogOn_Tieshenmibao_ID:SetSelected(0,-1);
end
----------------------------------------------------------------------------------------------------------
--
-- ���������ʧȥ����
--
function LogOn_MouseLeave()

	LogOn_Info:SetText("");

end


function LogOn_PassWord_MouseEnter()

	LogOn_Info:SetText("#{DLJM_XML_45}");
end;

------------------------------------------------------------------------------------------------------
--
-- �˺ź�׺ѡ���
--
function LogOn_Region_MouseEnter()

	LogOn_Info:SetText("#{DLYH_091208_1}");

end;

------------------------------------------------------------------------------------------------------
--
-- ģ�����
--
function LogOn_KeyBoard()
	ToggleWindow( "SoftKeyBoard" );
	SetSoftKeyAim( "LogOn_PassWord" );
end


function LogOn_Keyboard_MouseEnter()

	LogOn_Info:SetText("#{DLJM_XML_43}");  --�ʺ�  to  �˺�

end


function LogOn_LogOnGame_MouseEnter()

	LogOn_Info:SetText("Nh�n n�t n�y � v�o tr� ch�i");
end;

function LogOn_Payment_MouseEnter()

	LogOn_Info:SetText("N�p cash v�o t�i kho�n c�a c�c h�");  --�ʺ�  to  �˺�
end

function LogOn_RequisitionID_MouseEnter()

	LogOn_Info:SetText("��ng k� t�i kho�n m�i");	--�ʺ�  to  �˺�
end;

function LogOn_Author_MouseEnter()

	LogOn_Info:SetText("Ki�m tra xem x�t tin t�c tr� ch�i khai th�c �o�n �i");
end;

function LogOn_Last_MouseEnter()

	LogOn_Info:SetText("Tr� v� b�ng ch�n server");
end;

function LogOn_AntiDetect_MouseEnter()

	LogOn_Info:SetText("Nh�n b�t �u scan Trojan");

end

function LogOn_LogonID_Active()

	SetSoftKeyAim( "LogOn_ID" );
	LogOn_ID:SetProperty("DefaultEditBox", "True");
	LogOn_MailID:SetProperty("DefaultEditBox", "False");
	LogOn_PassWord:SetProperty("DefaultEditBox", "False");
	LogOn_Tieshenmibao_ID:SetProperty("DefaultEditBox", "False");
	currentSoftKeyAim = 0;
	LastSoftKeyAimAfterHardware = currentSoftKeyAim;
end

function LogOn_LogonMailID_Active()

	SetSoftKeyAim( "LogOn_MailID" );
	LogOn_ID:SetProperty("DefaultEditBox", "False");
	LogOn_MailID:SetProperty("DefaultEditBox", "True");
	LogOn_PassWord:SetProperty("DefaultEditBox", "False");
	LogOn_Tieshenmibao_ID:SetProperty("DefaultEditBox", "False");
	currentSoftKeyAim = 0;
	LastSoftKeyAimAfterHardware = currentSoftKeyAim;
end

function LogOn_LogonID_Deactive()

end

function LogOn_LogonMailID_TextChanged()

	local xPos1 = LogOn_Input_Background_Frame:GetProperty("AbsoluteXPosition")
	local yPos1 = LogOn_Input_Background_Frame:GetProperty("AbsoluteYPosition")

	local xPos2 = LogOn_MailID:GetProperty("AbsoluteXPosition")
	local yPos2 = LogOn_MailID:GetProperty("AbsoluteYPosition")

	local yHeigth = LogOn_MailID:GetProperty("AbsoluteHeight")

	yPos2 = yPos1 + yPos2 + yHeigth


	local strName = LogOn_MailID:GetText();
	local i = string.find(strName , "@")
	if i == nil then
		ShowDropMailList(strName , xPos1 + xPos2 , tonumber(yPos2) )
	else
		ShowDropMailList("" , xPos1 + xPos2 , tonumber(yPos2) )
	end
end

function LogOn_LogonPassWord_Active()

	SetSoftKeyAim( "LogOn_PassWord" );
	LogOn_PassWord:SetProperty("DefaultEditBox", "True");
	LogOn_ID:SetProperty("DefaultEditBox", "False");
	LogOn_MailID:SetProperty("DefaultEditBox", "False");
	LogOn_Tieshenmibao_ID:SetProperty("DefaultEditBox", "False");
	currentSoftKeyAim = 1;
	LastSoftKeyAimAfterHardware = currentSoftKeyAim;
end

function LogOn_Tieshen_LogonID_Active()

	SetSoftKeyAim( "LogOn_Tieshenmibao_ID" );
	LogOn_Tieshenmibao_ID:SetProperty("DefaultEditBox", "True");
	LogOn_PassWord:SetProperty("DefaultEditBox", "False");
	LogOn_ID:SetProperty("DefaultEditBox", "False");
	LogOn_MailID:SetProperty("DefaultEditBox", "False");
	LastSoftKeyAimAfterHardware = currentSoftKeyAim;
	currentSoftKeyAim = 2;
end

function LogOn_Frame_OnHiden()
	LogOn_ID:SetProperty("DefaultEditBox", "False");
	LogOn_MailID:SetProperty("DefaultEditBox", "False");
	LogOn_PassWord:SetProperty("DefaultEditBox", "False");
end

function Logon_LogOn_Soft_Return()
	if( g_bLogOnMode == 1 ) then
		return;
	end
	if( currentSoftKeyAim == 1 ) then
		if g_AccountType == 1 then
			LogOn_LogonID_Active();
		elseif g_AccountType == 2 then
			LogOn_LogonMailID_Active()
		end
	else
		LogOn_LogonPassWord_Active();
	end

end

function LogOn_Enroll1_OK(iok)
	local strName 			= LogOn_Enroll1_Name:GetText();
	local strPassword 	= LogOn_Enroll1_Edit1:GetText();
	local strPassEx 		= LogOn_Enroll1_Edit2:GetText();
	local strSupPass  	= LogOn_Enroll1_Edit3:GetText();
	local strSupPassex 	= LogOn_Enroll1_Edit4:GetText();
	local strEmail      = LogOn_Enroll1_Edit6:GetText();

	if(iok == 1) then
		GameProduceLogin:CheckBilling1( strName,strPassword,strPassEx,strSupPass,strSupPassex,1, strEmail );
	elseif (iok == 0) then
		GameProduceLogin:CheckBilling1( strName,strPassword,strPassEx,strSupPass,strSupPassex,0, strEmail );
	end

	LogOn_Enroll1_Accept:Disable()

end
function Logon_Enroll_Init()
	local strName = LogOn_ID:GetText();
	LogOn_Enroll1_Name:SetText( strName );
	LogOn_Enroll1_Edit1:SetText( "");
	LogOn_Enroll1_Edit2:SetText( "" );
	LogOn_Enroll1_Edit3:SetText( "" );
	LogOn_Enroll1_Edit4:SetText( "" );
	LogOn_Enroll1_Edit6:SetText( "" );
	LogOn_PassWord:Disable();
	LogOn_ID:Disable();

end
function LogOn_Enroll1_Cancel()
	g_bLogOnMode = 0;
	LogOn_Enroll1_Frame:Hide();
	LogOn_PassWord:Enable();
	LogOn_ID:Enable();

	--����Ĭ������
	GameProduceLogin:PassportButNotReg();

end

function Logon_LostPassWord()

	if(Variable:GetVariable("System_CodePage") == "1258") then
    --GameProduceLogin:OpenURL( "http://sde.game.sohu.com/reg/changepwd.jsp" )
    GameProduceLogin:OpenURL( "https://psp.gate.vn/Account/ForgotPass/" )
	else
    GameProduceLogin:OpenURL(GetWeblink("WEB_CHANGEPWD"))
	end

end

function LogOn_AccountChongZhi()

	if(Variable:GetVariable("System_CodePage") == "1258") then
    GameProduceLogin:OpenURL( "https://pay.gate.vn/Default.aspx" )
  elseif(Variable:GetVariable("System_CodePage") == "950") then --̨��
    GameProduceLogin:OpenURL( "http://www.gameflier.com/" )
	else
    	GameProduceLogin:OpenURL(GetWeblink("WEB_LOGON_MAIN"))
	end

end

function Logon_Enroll_PressTable( iIndex )

	if( 1 == iIndex ) then
		LogOn_SoftKey:SetAimEditBox( "LogOn_Enroll1_Edit2" );
		LogOn_Enroll1_Edit2:SetProperty("DefaultEditBox", "True");
		LogOn_Enroll1_Edit1:SetProperty("DefaultEditBox", "False");
		currentSoftKeyAim = 0;
	end

	if( 2 == iIndex ) then
		LogOn_SoftKey:SetAimEditBox( "LogOn_Enroll1_Edit3" );
		LogOn_Enroll1_Edit3:SetProperty("DefaultEditBox", "True");
		LogOn_Enroll1_Edit2:SetProperty("DefaultEditBox", "False");
		currentSoftKeyAim = 0;
	end

	if( 3 == iIndex ) then
		LogOn_SoftKey:SetAimEditBox( "LogOn_Enroll1_Edit4" );
		LogOn_Enroll1_Edit4:SetProperty("DefaultEditBox", "True");
		LogOn_Enroll1_Edit3:SetProperty("DefaultEditBox", "False");
		currentSoftKeyAim = 0;
	end

	if( 4 == iIndex ) then
		LogOn_SoftKey:SetAimEditBox( "LogOn_Enroll1_Edit6" );
		LogOn_Enroll1_Edit6:SetProperty("DefaultEditBox", "True");
		LogOn_Enroll1_Edit4:SetProperty("DefaultEditBox", "False");
		currentSoftKeyAim = 0;
	end

	if( 5 == iIndex ) then
		LogOn_SoftKey:SetAimEditBox( "LogOn_Enroll1_Edit1" );
		LogOn_Enroll1_Edit1:SetProperty("DefaultEditBox", "True");
		LogOn_Enroll1_Edit6:SetProperty("DefaultEditBox", "False");
		currentSoftKeyAim = 0;
	end


end

function LogOn_Show_MibaoPage()
	--��ʱԽ�ϰ�����İ涼ָ��ͬ���ҳ�棬Խ�ϰ��ͬѧ����Ҫ�Լ���
	if(Variable:GetVariable("System_CodePage") == "1258") then
    GameProduceLogin:OpenURL(GetWeblink("WEB_MIBAO"))
	else
    GameProduceLogin:OpenURL(GetWeblink("WEB_MIBAO"))
	end
end

function LogOn_TieShen_MibaoPage()
	--��ʱԽ�ϰ�����İ涼ָ��ͬ���ҳ�棬Խ�ϰ��ͬѧ����Ҫ�Լ���
	if g_isfeixinlogin == 0 then
		return
	end
	if(Variable:GetVariable("System_CodePage") == "1258") then
    GameProduceLogin:OpenURL(GetWeblink("WEB_EKEY"))
	else
    GameProduceLogin:OpenURL(GetWeblink("WEB_EKEY"))
	end
end

function PassWordProtectCheckClicked()


	--local pwCheck = LogOn_PassWord_Protect_Check:GetCheck();
	--local phCheck = LogOn_Phone_Protect_Check:GetCheck();
	--if( pwCheck == 1 and phCheck == 1 ) then

	--	LogOn_PassWord_Protect_Check:SetCheck(1)
	--	LogOn_Phone_Protect_Check:SetCheck(0)

	--elseif( pwCheck == 1 and phCheck == 0 ) then

	--	LogOn_PassWord_Protect_Check:SetCheck(1)
	--	LogOn_Phone_Protect_Check:SetCheck(0)

	--elseif( pwCheck == 0 and phCheck == 1 ) then

	--	LogOn_PassWord_Protect_Check:SetCheck(1)
	--	LogOn_Phone_Protect_Check:SetCheck(0)

	--elseif( pwCheck == 0 and phCheck == 0 ) then

	--	LogOn_PassWord_Protect_Check:SetCheck(0)
	--	LogOn_Phone_Protect_Check:SetCheck(0)
	--end

	local pwCheck = LogOn_PassWord_Protect_Check:GetCheck();
	--local phCheck = LogOn_Phone_Protect_Check:GetCheck();
	local hdCheck = LogOn_PassWord_Tieshen_Check:GetCheck();

	if (pwCheck == 1) then
		-- LogOn_Phone_Protect_Check:SetCheck(0);
		LogOn_PassWord_Tieshen_Check:SetCheck(0);
		LogOn_Tieshenmibao:Show();
		LogOn_Tieshenmibao_ID:Hide();
		if( LastSoftKeyAimAfterHardware ~= currentSoftKeyAim ) then
			if (LastSoftKeyAimAfterHardware == 1) then
				LogOn_LogonPassWord_Active();
			else
				if g_AccountType == 1 then
					LogOn_LogonID_Active();
				elseif g_AccountType == 2 then
					LogOn_LogonMailID_Active()
				end
			end
		end
	end
end


function HardwareCheckClicked()

	local pwCheck = LogOn_PassWord_Protect_Check:GetCheck();
	--local phCheck = LogOn_Phone_Protect_Check:GetCheck();
	local hdCheck = LogOn_PassWord_Tieshen_Check:GetCheck();

	if (hdCheck == 1) then
		LogOn_Tieshenmibao_ID:SetSelected(0,-1);
		LogOn_PassWord_Protect_Check:SetCheck(0);
		--LogOn_Phone_Protect_Check:SetCheck(0);
		LogOn_Tieshenmibao:Hide();
		LogOn_Tieshenmibao_ID:Show();
		LogOn_Tieshen_LogonID_Active();
		Init_Tieshen_LogonID()
	else
		LogOn_Tieshenmibao:Show();
		LogOn_Tieshenmibao_ID:Hide();
		Init_Tieshen_LogonID();
		if( LastSoftKeyAimAfterHardware ~= currentSoftKeyAim ) then
			if (LastSoftKeyAimAfterHardware == 1) then
				LogOn_LogonPassWord_Active();
			else
				if g_AccountType == 1 then
					LogOn_LogonID_Active();
				elseif g_AccountType == 2 then
					LogOn_LogonMailID_Active()
				end
			end
		end
	end
end

function LogOn_MibaoSetToolTip()
	local strStart = "#{DHMB_081014_001_1}"
	local strCat = "#{WENZI_HUO}"
	local strEnd = "#{DHMB_081014_001_2}"
	local strTmp = strStart
	local strMid = ""
	local i = 0
	for i=1,MiBaoDhCount do
		if ( MiBaoDhCount > 1 and i < MiBaoDhCount) then
			strMid = PasswdProctectTels[i]..","
		elseif ( i == MiBaoDhCount and i ~= 1) then
			strMid = strCat.. PasswdProctectTels[i];
	    else
	        strMid = PasswdProctectTels[i];
		end
		strTmp = strTmp..strMid;

	end
	strTmp = strTmp..strEnd
	-- LogOn_Phone_Protect_Text:SetProperty("Tooltip", strTmp); --�������ת��
	--LogOn_Phone_Protect_Text:SetToolTip(strTmp);
end

function LogOn_MibaoShowSystemInfo()
	local strStart = "#{DHMB_081014_003_1}"
	local strCat = "#{WENZI_HUO}"
	local strEnd = "#{DHMB_081014_003_2}"
	local strTmp = strStart
	local strMid = ""
	local i = 0
	for i=1,MiBaoDhCount do
		if ( MiBaoDhCount > 1 and i < MiBaoDhCount) then
			strMid = PasswdProctectTels[i]..","
		elseif ( i == MiBaoDhCount and i ~= 1) then
			strMid = strCat.. PasswdProctectTels[i];
	    else
	        strMid = PasswdProctectTels[i];
		end
		strTmp = strTmp..strMid;

	end
	strTmp = strTmp..strEnd
	GameProduceLogin:GameLoginShowSystemInfo(strTmp);
end

function LogOn_AntiDetect_Begin()
	GameProduceLogin:DetectAntiBegin();
end

function LogOn_TraditionLogon_MouseDown()
	if g_AccountType == 3 then
		return
	end
	if g_AccountType == 1 then
		return
	end
	g_AccountType = 1

	LogOn_OwnDefineLogon:SetCheck(0)
	LogOn_MailID_Text:Hide()
	LogOn_MailID:Hide()

	LogOn_ID_Text:Show()
	LogOn_Region_Text:Show()

	LogOn_ID:Show()
	LogOn_Region:Show()

	LogOn_ID:SetText("")

	LogOn_LogonID_Active()
	LogOn_PassWord:SetText("");
	LogOn_Tieshenmibao_ID:SetText("")

	local strTail, nIndex = LogOn_Region:GetCurrentSelect();
	if nIndex == 6 then
		LogOn_Region:SetCurrentSelect(0);
	end

	if g_zoneworldid == 9031 or g_zoneworldid == 9015 then -- ���ź��������ܿ������ŵ�½
		OtherLogon_Frame_ElseLogon:Show();
		OtherLogon_NewLogon:Show();
		OtherLogon_FeiXin:Show();
	else
		OtherLogon_Frame_ElseLogon:Hide();
		OtherLogon_NewLogon:Hide();
		OtherLogon_FeiXin:Hide();
	end

	if LogOn_PassWord_Tieshen_Check:GetCheck() == 1 then
		Init_Tieshen_LogonID()
	end
end

function LogOn_OwnDefineLogon_MouseDown()
	if g_AccountType == 3 then
		return
	end
	if g_AccountType == 2 then
		return
	end
	g_AccountType = 2

	LogOn_TraditionLogon:SetCheck(0)
	LogOn_ID:Hide()
	LogOn_Region:Hide()
	LogOn_ID_Text:Hide()
	LogOn_Region_Text:Hide()

	LogOn_MailID_Text:Show()
	LogOn_MailID:Show()
	LogOn_MailID:SetText("")

	LogOn_LogonMailID_Active()
	LogOn_PassWord:SetText("");
	LogOn_Tieshenmibao_ID:SetText("")

	if g_zoneworldid == 9031 or g_zoneworldid == 9015 then -- ���ź��������ܿ������ŵ�½
		OtherLogon_Frame_ElseLogon:Show();
		OtherLogon_NewLogon:Show();
		OtherLogon_FeiXin:Show();
	else
		OtherLogon_Frame_ElseLogon:Hide();
		OtherLogon_NewLogon:Hide();
		OtherLogon_FeiXin:Hide();
	end

	if LogOn_PassWord_Tieshen_Check:GetCheck() == 1 then
		Init_Tieshen_LogonID()
	end
end

function LogOn_Region_Accept()
	local strTail, nIndex = LogOn_Region:GetCurrentSelect();
	if nIndex == 6 then
		LogOn_OwnDefineLogon:SetCheck(1)
		LogOn_OwnDefineLogon_MouseDown()
	end
end
function LogOn_FeixinLogin()
	g_temp_AccountType = g_AccountType

	g_AccountType = 3

	local sizex= 320
	local sizey=140
	local w = 380
	local h = 260

	GameProduceLogin:LogOnFeixin(sizex,sizey,w,h,"OauthClientServlet?provider=FEIXIN&from=TL","https://auth.changyou.com/servlet/SettingCookiesServlet")


end
function LogOn_FeixinGoback()
	g_AccountType = 1
	GameProduceLogin:LogOnFeixinGoBack()
	FeiXinWeb_Bk:Hide();
end
function LogOn_FeixinHide() --���ŵ�½ģʽ�ر�ƽ����½ģʽ
	FeiXinWeb_Bk:Show();
	LogOn_Input_Background_SubFrame:Hide();
	LogOn_Input_NoticeText:Show();

end
function LogOn_FeixinShow() --�˳����ŵ�½ģʽ����ƽ����½ģʽ
	if g_AccountType == 3 then
		g_AccountType = g_temp_AccountType
	end
	LogOn_Input_NoticeText:Hide();
	LogOn_Input_Background_SubFrame:Show();
end

