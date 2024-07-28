:MMENU
@echo off
SET NVER=0.1
@Title BCDEDIT V.%NVER%
set black=[30m
set red=[31m
set green=[32m
set yellow=[33m
set yyellow=[43m
set blue=[34m
set magenta=[35m
set bmagenta=[45m
set cyan=[36m
set white=[37m
set defcolor=[49m
set gold=[38;5;220m
set ggold=[48;5;220m
set grey=[90m
set ggrey=[100m
set orange=[38;5;208m
set indigo=[38;5;105m
cd /d %~dp0
mode con:cols=82 lines=40
color 7

SET CH1=0
SET CH2=0
SET CH3=0
SET CH4=0
SET CH5=0
SET CH6=0
SET CH7=0
SET CH8=0
SET CH9=0
SET CH10=0
SET CH11=0
SET CH12=0
SET CH13=0
SET CH14=0
SET CH15=0
SET CH16=0
SET CH17=0
SET CH18=0
SET CH19=0
SET CH20=0
SET CH21=0
SET CH22=0
SET CH23=0
SET CH24=0

SET VL1=AlwaysOff
SET VL2=No
SET VL3=No
SET VL4=No
SET VL5=No
SET VL6=No
SET VL7=No
SET VL8=No
SET VL9=No
SET VL10=No
SET VL11=No
SET VL12=No
SET VL13=No
SET VL14=No
SET VL15=No
SET VL16=No
SET VL17=No
SET VL18=No
SET VL19=No
SET VL20=No
SET VL21=0x0
SET VL22=0
SET VL23=No
SET VL24=No

for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "nx"') do (SET VL1=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "integrityservices"') do (SET VL2=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "vm"') do (SET VL3=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "isolatedcontext"') do (SET VL4=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "tpmbootentropy"') do (SET VL5=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "bootems"') do (SET VL6=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "ems"') do (SET VL7=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "lastknowngood"') do (SET VL8=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "bootdebug"') do (SET VL9=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "bootlog"') do (SET VL10=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "bootmenupolicy"') do (SET VL11=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "bootux"') do (SET VL12=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "quietboot"') do (SET VL13=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "useplatformtick"') do (SET VL14=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "useplatformclock"') do (SET VL15=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "disabledynamictick"') do (SET VL16=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "tscsyncpolicy"') do (SET VL17=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "vsmlaunchtype"') do (SET VL18=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "usefirmwarepcisettings"') do (SET VL19=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "hypervisorlaunchtype"') do (SET VL20=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "allowedinmemorysettings"') do (SET VL21=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "perfmem"') do (SET VL22=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "debug"') do (SET VL23=%%a)
for /f "tokens=2" %%a in ('bcdedit /enum ^| findstr /i "event"') do (SET VL24=%%a)

SET VL17A=%orange%&SET VL17B=%orange%&SET VL17C=%orange%
IF %VL1%==AlwaysOff (SET VL1A=%orange%&SET VL1B=%green%) else (SET VL1A=%green%&SET VL1B=%orange%)
IF %VL2%==Enable (SET VL2A=%green%&SET VL2B=%orange%) else (SET VL2A=%orange%&SET VL2B=%green%)
IF %VL3%==Yes (SET VL3A=%green%&SET VL3B=%orange%) else (SET VL3A=%orange%&SET VL3B=%green%)
IF %VL4%==Yes (SET VL4A=%green%&SET VL4B=%orange%) else (SET VL4A=%orange%&SET VL4B=%green%)
IF %VL5%==ForceEnable (SET VL5A=%green%&SET VL5B=%orange%) else (SET VL5A=%orange%&SET VL5B=%green%)
IF %VL6%==Yes (SET VL6A=%green%&SET VL6B=%orange%) else (SET VL6A=%orange%&SET VL6B=%green%)
IF %VL7%==Yes (SET VL7A=%green%&SET VL7B=%orange%) else (SET VL7A=%orange%&SET VL7B=%green%)
IF %VL8%==Yes (SET VL8A=%green%&SET VL8B=%orange%) else (SET VL8A=%orange%&SET VL8B=%green%)
IF %VL9%==Yes (SET VL9A=%green%&SET VL9B=%orange%) else (SET VL9A=%orange%&SET VL9B=%green%)
IF %VL10%==Yes (SET VL10A=%green%&SET VL10B=%orange%) else (SET VL10A=%orange%&SET VL10B=%green%)
IF %VL11%==Standard (SET VL11A=%green%&SET VL11B=%orange%) else (SET VL11A=%orange%&SET VL11B=%green%)
IF %VL11%==Legacy (SET VL11A=%green%&SET VL11B=%orange%) else (SET VL11A=%orange%&SET VL11B=%green%)
IF %VL12%==Enable (SET VL12A=%green%&SET VL12B=%orange%) else (SET VL12A=%orange%&SET VL12B=%green%)
IF %VL13%==Yes (SET VL13A=%green%&SET VL13B=%orange%) else (SET VL13A=%orange%&SET VL13B=%green%)
IF %VL14%==Yes (SET VL14A=%green%&SET VL14B=%orange%) else (SET VL14A=%orange%&SET VL14B=%green%)
IF %VL15%==Yes (SET VL15A=%green%&SET VL15B=%orange%) else (SET VL15A=%orange%&SET VL15B=%green%)
IF %VL16%==Yes (SET VL16A=%green%&SET VL16B=%orange%) else (SET VL16A=%orange%&SET VL16B=%green%)
IF %VL16%==Yes (SET VL16A=%green%&SET VL16B=%orange%) else (SET VL16A=%orange%&SET VL16B=%green%)
IF %VL17%==Enhanced (SET VL17A=%green%&SET VL17B=%orange%&SET VL17C=%orange%)
IF %VL17%==Legacy (SET VL17B=%green%&SET VL17A=%orange%&SET VL17C=%orange%)
IF %VL18%==Yes (SET VL18A=%green%&SET VL18B=%orange%) else (SET VL18A=%orange%&SET VL18B=%green%)
IF %VL19%==Yes (SET VL19A=%green%&SET VL19B=%orange%) else (SET VL19A=%orange%&SET VL19B=%green%)
IF %VL20%==Auto (SET VL20A=%green%&SET VL20B=%orange%) else (SET VL20A=%orange%&SET VL20B=%green%)
IF %VL21%==0x0 (SET VL21A=%orange%&SET VL21B=%green%) else (SET VL21A=%green%&SET VL21B=%orange%)
IF %VL22%==0 (SET VL22A=%orange%&SET VL22B=%green%) else (SET VL22A=%green%&SET VL22B=%orange%)
IF %VL23%==Yes (SET VL23A=%green%&SET VL23B=%orange%) else (SET VL23A=%orange%&SET VL23B=%green%)
IF %VL24%==Yes (SET VL24A=%green%&SET VL24B=%orange%) else (SET VL24A=%orange%&SET VL24B=%green%)

IF %VL1%==AlwaysOn (SET CH1=1)
IF %VL2%==Enable (SET CH2=1)
IF %VL3%==Yes (SET CH3=1)
IF %VL4%==Yes (SET CH4=1)
IF %VL5%==ForceEnable (SET CH5=1)
IF %VL6%==Yes (SET CH6=1)
IF %VL7%==Yes (SET CH7=1)
IF %VL8%==Yes (SET CH8=1)
IF %VL9%==Yes (SET CH9=1)
IF %VL10%==Yes (SET CH10=1)
IF %VL11%==Legacy (SET CH11=1)
IF %VL12%==Enable (SET CH12=1)
IF %VL12%==Disable (SET CH12=0)
IF %VL13%==Yes (SET CH13=1)
IF %VL14%==Yes (SET CH14=1)
IF %VL15%==Yes (SET CH15=1)
IF %VL16%==Yes (SET CH16=1)
IF %VL16%==Yes (SET CH16=1)
IF %VL17%==Enhanced (SET CH17=1)
IF %VL17%==Legacy (SET CH17=2)
IF %VL18%==Yes (SET CH18=1)
IF %VL19%==Yes (SET CH19=1)
IF %VL20%==Auto (SET CH20=1)
IF %VL21%==0x0 (SET CH21=0)
IF %VL22%==0 (SET CH22=0)
IF %VL23%==Yes (SET CH23=1)
IF %VL24%==Yes (SET CH24=1)
cls

echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ %gold%Securite :%white%                                             ³                    ÚÁÄ¿
echo ³ No Execute                 %grey%{nx}%white%                        ³   %VL1A%True%white%      %VL1B%False%white%  ³%indigo% 1%white%³
echo ³ Integrity Services         %grey%{integrityservices}%white%         ³   %VL2A%True%white%      %VL2B%False%white%  ³%indigo% 2%white%³
echo ³ Virtual Machine Platform   %grey%{vm}%white%                        ³   %VL3A%True%white%      %VL3B%False%white%  ³%indigo% 3%white%³
echo ³ Isolated Context           %grey%{isolatedcontext}%white%           ³   %VL4A%True%white%      %VL4B%False%white%  ³%indigo% 4%white%³
echo ³ Tpm Boot Entropy           %grey%{tpmbootentropy}%white%            ³   %VL5A%True%white%      %VL5B%False%white%  ³%indigo% 5%white%³
echo ³                                                        ³                    ÀÂÄÙ
echo ³ %gold%Demarrage :%white%                                            ³                    ÚÁÄ¿
echo ³ Boot EMS                   %grey%{bootems}%white%                   ³   %VL6A%True%white%      %VL6B%False%white%  ³%indigo% 6%white%³
echo ³ EMS                        %grey%{ems}%white%                       ³   %VL7A%True%white%      %VL7B%False%white%  ³%indigo% 7%white%³
echo ³ Last Known Good            %grey%{lastknowngood}%white%             ³   %VL8A%True%white%      %VL8B%False%white%  ³%indigo% 8%white%³
echo ³ Boot Debug                 %grey%{bootdebug}%white%                 ³   %VL9A%True%white%      %VL9B%False%white%  ³%indigo% 9%white%³
echo ³ Boot Log                   %grey%{bootlog}%white%                   ³   %VL10A%True%white%      %VL10B%False%white%  ³%indigo%10%white%³
echo ³                                                        ³                    ÀÂÄÙ
echo ³ %gold%Boot UI :%white%                                              ³                    ÚÁÄ¿
echo ³ Boot Menu Policy           %grey%{bootmenupolicy}%white%            ³   %VL11A%True%white%      %VL11B%False%white%  ³%indigo%11%white%³
echo ³ Boot UI                    %grey%{bootux}%white%                    ³   %VL12A%True%white%      %VL12B%False%white%  ³%indigo%12%white%³
echo ³ Quiet Boot                 %grey%{quietboot}%white%                 ³   %VL13A%True%white%      %VL13B%False%white%  ³%indigo%13%white%³
echo ³ 16000067                   %grey%{custom:16000067}%white%           ³   %VL13A%True%white%      %VL13B%False%white%  ³%indigo%13%white%³
echo ³ 16000068                   %grey%{custom:16000068}%white%           ³   %VL13A%True%white%      %VL13B%False%white%  ³%indigo%13%white%³
echo ³ 16000069                   %grey%{custom:16000069}%white%           ³   %VL13A%True%white%      %VL13B%False%white%  ³%indigo%13%white%³
echo ³                                                        ³                    ÀÂÄÙ
echo ³ %gold%Performances / Configurations Avancees :%white%               ³                    ÚÁÄ¿
echo ³ Use Platform Tick          %grey%{useplatformtick}%white%           ³   %VL14A%True%white%      %VL14B%False%white%  ³%indigo%14%white%³
echo ³ Use Platform Clock         %grey%{useplatformclock}%white%          ³   %VL15A%True%white%      %VL15B%False%white%  ³%indigo%15%white%³
echo ³ Disable Dynamic Tick       %grey%{disabledynamictick}%white%        ³   %VL16A%True%white%      %VL16B%False%white%  ³%indigo%16%white%³
echo ³ Tsc Sync Policy            %grey%{tscsyncpolicy}%white%             ³ %VL17A%Enhanced%white%    %VL17B%Legacy%white% ³%indigo%17%white%³
echo ³ VSM Launch Type            %grey%{vsmlaunchtype}%white%             ³   %VL18A%True%white%      %VL18B%False%white%  ³%indigo%18%white%³
echo ³ Use Firmware Pci Settings  %grey%{usefirmwarepcisettings}%white%    ³   %VL19A%True%white%      %VL19B%False%white%  ³%indigo%19%white%³
echo ³ %red%Hypervisor Launch Type%white%     %grey%{hypervisorlaunchtype}%white%      ³   %VL20A%True%white%      %VL20B%False%white%  ³%indigo%20%white%³
echo ³ %red%Allowed In Memory Settings%white% %grey%{allowedinmemorysettings}%white%   ³   %VL21A%True%white%      %VL21B%False%white%  ³%indigo%21%white%³
echo ³ %red%Perfmem%white%                    %grey%{perfmem}%white%                   ³   %VL22A%True%white%      %VL22B%False%white%  ³%indigo%22%white%³
echo ³                                                        ³                    ÀÂÄÙ
echo ³ %gold%Debogage et Diagnostics :%white%                              ³                    ÚÁÄ¿
echo ³ Debug                      %grey%{debug}%white%                     ³   %VL23A%True%white%      %VL23B%False%white%  ³%indigo%23%white%³
echo ³ Event                      %grey%{event}%white%                     ³   %VL24A%True%white%      %VL24B%False%white%  ³%indigo%24%white%³
echo ³                                                        ³                    ÀÂÄÙ
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
set /p CH="%green%>%white%"

IF %CH%==1 (
	IF %CH1%==1 (bcdedit /set nx alwaysoff) else (bcdedit /set nx alwayson)
	goto :MMENU
)

IF %CH%==2 (
	IF %CH2%==1 (bcdedit /set integrityservices Disable) else (bcdedit /set integrityservices Enable)
	goto :MMENU
)

IF %CH%==3 (
	IF %CH3%==1 (bcdedit /set vm No) else (bcdedit /set vm Yes)
	goto :MMENU
)

IF %CH%==4 (
	IF %CH4%==1 (bcdedit /set isolatedcontext No) else (bcdedit /set isolatedcontext Yes)
	goto :MMENU
)

IF %CH%==5 (
	IF %CH5%==1 (bcdedit /set tpmbootentropy ForceDisable) else (bcdedit /set tpmbootentropy ForceEnable)
	goto :MMENU
)

IF %CH%==6 (
	IF %CH6%==1 (bcdedit /set bootems No) else (bcdedit /set bootems Yes)
	goto :MMENU
)

IF %CH%==7 (
	IF %CH7%==1 (bcdedit /set ems No) else (bcdedit /set ems Yes)
	goto :MMENU
)

IF %CH%==8 (
	IF %CH8%==1 (bcdedit /set lastknowngood No) else (bcdedit /set lastknowngood Yes)
	goto :MMENU
)

IF %CH%==9 (
	IF %CH9%==1 (bcdedit /bootdebug Off) else (bcdedit /bootdebug On)
	goto :MMENU
)

IF %CH%==10 (
	IF %CH10%==1 (bcdedit /set bootlog No) else (bcdedit /set bootlog Yes)
	goto :MMENU
)

IF %CH%==11 (
	IF %CH11%==1 (bcdedit /deletevalue bootmenupolicy) else (bcdedit /set bootmenupolicy Legacy)
	goto :MMENU
)

IF %CH%==12 (
	IF %CH12%==1 (bcdedit /set bootux Disabled) else (bcdedit /set bootux On)
	goto :MMENU
)

IF %CH%==13 (
	IF %CH13%==1 (
		bcdedit /set quietboot No
		bcdedit /set {globalsettings} custom:16000067 False
		bcdedit /set {globalsettings} custom:16000068 False
		bcdedit /set {globalsettings} custom:16000069 False
	) else (
		bcdedit /set quietboot Yes
		bcdedit /set {globalsettings} custom:16000067 True
		bcdedit /set {globalsettings} custom:16000068 True
		bcdedit /set {globalsettings} custom:16000069 True
	)
	goto :MMENU
)

IF %CH%==14 (
	IF %CH14%==1 (bcdedit /set useplatformtick False) else (bcdedit /set useplatformtick True)
	goto :MMENU
)

IF %CH%==15 (
	IF %CH15%==1 (bcdedit /set useplatformclock False) else (bcdedit /set useplatformclock True)
	goto :MMENU
)

IF %CH%==16 (
	IF %CH16%==1 (bcdedit /set disabledynamictick No) else (bcdedit /set disabledynamictick Yes)
	goto :MMENU
)

IF %CH%==17 (
	IF %CH17%==1 bcdedit /deletevalue tscsyncpolicy&goto :MMENU
	IF %CH17%==2 bcdedit /set tscsyncpolicy Enhanced&goto :MMENU
	IF %CH17%==0 bcdedit /set tscsyncpolicy Legacy&goto :MMENU
)

IF %CH%==18 (
	IF %CH18%==1 (bcdedit /set vsmlaunchtype Off) else (bcdedit /set vsmlaunchtype On)
	goto :MMENU
)

IF %CH%==19 (
	IF %CH19%==1 (bcdedit /deletevalue usefirmwarepcisettings) else (bcdedit /set usefirmwarepcisettings Yes)
	goto :MMENU
)

IF %CH%==20 (
	IF %CH20%==1 (bcdedit /set hypervisorlaunchtype Off) else (bcdedit /set hypervisorlaunchtype On)
	goto :MMENU
)

IF %CH%==21 (
	IF %CH21%==1 (bcdedit /set allowedinmemorysettings 0) else (bcdedit /set allowedinmemorysettings 0)
	goto :MMENU
)

IF %CH%==22 (
	IF %CH22%==1 (bcdedit /set perfmem 0) else (bcdedit /set perfmem 0)
	goto :MMENU
)

IF %CH%==23 (
	IF %CH23%==1 (bcdedit /set debug No) else (bcdedit /set debug Yes)
	goto :MMENU
)

IF %CH%==24 (
	IF %CH24%==1 (bcdedit /event Off) else (bcdedit /event On)
	goto :MMENU
)

IF %CH%==x (
	bcdedit /set useplatformtick false
	bcdedit /set useplatformclock false
	bcdedit /set disabledynamictick yes
	bcdedit /set vsmlaunchtype Off
	bcdedit /set bootmenupolicy Legacy
	bcdedit /set lastknowngood yes
	bcdedit /set vm No
	bcdedit /set {globalsettings} custom:16000067 false
	bcdedit /set {globalsettings} custom:16000068 true
	bcdedit /set {globalsettings} custom:16000069 false
	bcdedit /set quietboot No
	bcdedit /set bootux Disabled
	bcdedit /set bootlog no
	bcdedit /timeout 3
	bcdedit /event off
	bcdedit /bootdebug off
	bcdedit /set debug No
	bcdedit /set ems No
	bcdedit /set bootems No
	bcdedit /set tpmbootentropy ForceDisable
	bcdedit /set nx alwaysoff
	bcdedit /set integrityservices disable
	bcdedit /set allowedinmemorysettings 0
	bcdedit /set perfmem 0
	bcdedit /deletevalue usefirmwarepcisettings
	bcdedit /set hypervisorlaunchtype off
	bcdedit /set isolatedcontext No
	goto :MMENU
)

IF %CH%==X (
	bcdedit /set useplatformtick false
	bcdedit /set useplatformclock false
	bcdedit /set disabledynamictick yes
	bcdedit /set vsmlaunchtype Off
	bcdedit /set bootmenupolicy Legacy
	bcdedit /set lastknowngood yes
	bcdedit /set vm No
	bcdedit /set {globalsettings} custom:16000067 false
	bcdedit /set {globalsettings} custom:16000068 true
	bcdedit /set {globalsettings} custom:16000069 false
	bcdedit /set quietboot No
	bcdedit /set bootux Disabled
	bcdedit /set bootlog no
	bcdedit /timeout 3
	bcdedit /event off
	bcdedit /bootdebug off
	bcdedit /set debug No
	bcdedit /set ems No
	bcdedit /set bootems No
	bcdedit /set tpmbootentropy ForceDisable
	bcdedit /set nx alwaysoff
	bcdedit /set integrityservices disable
	bcdedit /set allowedinmemorysettings 0
	bcdedit /set perfmem 0
	bcdedit /deletevalue usefirmwarepcisettings
	bcdedit /set hypervisorlaunchtype off
	bcdedit /set isolatedcontext No
	goto :MMENU
)
goto :MMENU
bcdedit /timeout 3