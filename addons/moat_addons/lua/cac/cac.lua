if CAC and CAC.DispatchEvent then
	CAC:DispatchEvent ("Unloaded")
end

CAC = CAC or {}
include ("edition.lua")
include ("version.lua")
include ("license.lua")

-- Code generation
if CLIENT then
	include ("codegen/imports.lua")
end

include ("resources.lua")
include ("glib_import.lua")
CAC.Initialize ("CAC", CAC)

include ("glib2_import.lua")
include ("gooey_import.lua")
include ("gcad_import.lua")
include ("gnative_import.lua")

-- Networking
include ("networking/objectnetworker.lua")
include ("networking/objectnetworkerfactory.lua")

if SERVER then
	include ("networking/objectsender.lua")
end

if CLIENT then
	include ("networking/objectreceiver.lua")
end

-- Structs
include ("structs.lua")

-- Logger
include ("logger.lua")
CAC.Logger = CAC.Logger ("system_log_" .. (SERVER and "sv" or "cl") .. ".txt")
CAC.Logger:Message ("!cake Anti-Cheat version " .. CAC.Version)
CAC.Logger:Message ("\t" .. os.date ("%Y-%m-%d %H:%M:%S"))

if SERVER then
	include ("updatechecker.lua")
end

-- Structs, more of them
include ("structs2/operatingsystem.lua")
include ("structs2/cpuvendor.lua")
include ("structs2/gpuvendor.lua")

include ("structs2/accountinformation.lua")
include ("structs2/gameinformation.lua")
include ("structs2/locationinformation.lua")

include ("structs2/playerinformation.lua")
include ("structs2/playerinformationmanager.lua")

-- Lua function verification
include ("functionverification/updatetype.lua")
include ("functionverification/functionverificationresult.lua")
include ("functionverification/bytecodehashes.lua")
include ("functionverification/luainformation.lua")
include ("functionverification/serverluainformation.lua")
include ("functionverification/luasourceinformation.lua")
include ("functionverification/luafileinformation.lua")
include ("functionverification/luafunctioninformation.lua")

include ("functionverification/functionverificationinformation.lua")

include ("structs2/debuggetinfofunctioninformation.lua")
include ("structs2/jitutilfuncinfofunctioninformation.lua")

-- Code generation
if CLIENT then
	include ("codegen/clientsidecodeprocessor.lua")
	include ("codegen/obfuscation.lua")
	include ("codegen/fingerprinting1.lua")
	include ("codegen/structs.lua")
	include ("codegen/detours.lua")
	include ("codegen/preprocessing.lua")
	include ("codegen/blacklist.lua")
	include ("codegen/media.lua")
end

include ("codegen/fingerprinting2.lua")

include ("crypto.lua")
include ("identifiers.lua")

-- Signal Processing
include ("signalprocessing/digitalfilters/exponentialdecayresponsefilter.lua")
include ("signalprocessing/digitalfilters/sigmoidstepresponsefilter.lua")
include ("signalprocessing/digitalfilters/sigmoidstepresponseinterpolator.lua")

-- Statistics
include ("statistics/sampleset.lua")
include ("statistics/movingwindowsampleset.lua")
include ("statistics/continuousrealfunction.lua")
include ("statistics/probabilitydensityfunction.lua")
include ("statistics/standardnormaldistribution.lua")
include ("statistics/normaldistribution.lua")
include ("statistics/bullshitdistribution.lua")

if SERVER then
	-- Data
	include ("data/restrictedconvars.lua")
	
	-- Detectors
	include ("detectionsystems/detector.lua")
	
	include ("detectionsystems/timeoutdetector.lua")
	
	include ("detectionsystems/aimbotdetector.lua")
	include ("detectionsystems/antiaimdetector.lua")
	include ("detectionsystems/autobunnyhopdetector.lua")
	include ("detectionsystems/seedmanipulationdetector.lua")
	include ("detectionsystems/speedhackdetectorrunner.lua")
	include ("detectionsystems/speedhackdetector.lua")
	
	include ("detectionsystems/singleconvarmonitor.lua")
	include ("detectionsystems/convarmonitor.lua")
	include ("detectionsystems/configmonitor.lua")
	
	-- Hooks
	include ("hooks/movehandler.lua")
	include ("hooks/clientluahandler.lua")
	include ("hooks/adminuicommands.lua")
end

-- Detections
include ("detections/detection.lua")
include ("detections/detectionresponse.lua")
include ("detections/detectioninformation.lua")
include ("detections/detectionregistry.lua")

include ("detections/reasonarraydetection.lua")

include ("detections/anticheatcheckfailure.lua")
include ("detections/anticheattruthengineering.lua")
include ("detections/anticheattruthtimeout.lua")
include ("detections/gameversionmismatch.lua")
include ("detections/clientsideluaexecution.lua")
include ("detections/probableclientsideluaexecution.lua")
include ("detections/convarmanipulation.lua")

include ("detections/iluainterfacedetours.lua")
include ("detections/blacklistedmodule.lua")

include ("detections/aimbot.lua")
include ("detections/antiaim.lua")
include ("detections/autobunnyhop.lua")
include ("detections/antiscreenshot.lua")
include ("detections/seedmanipulation.lua")
include ("detections/speedhack.lua")

include ("detections/rconpasswordtheft.lua")

include ("detections/resourcemismatch.lua")

-- Checks
include ("checks/check.lua")
include ("checks/checkinformation.lua")
include ("checks/checkregistry.lua")

include ("checks/singleresponsecheck.lua")
include ("checks/incrementalreportingcheck.lua")

if SERVER then
	include ("checks/0000_fluidexchange.lua")
	include ("checks/0001_systeminformation.lua")
	include ("checks/0002_additionalsysteminformation.lua")
	include ("checks/0003_rconpasswordtheft.lua")
	include ("checks/0004_garbagecount.lua")
	include ("checks/0005_qacbypasscheck.lua")
	include ("checks/0006_systime.lua")
	include ("checks/0007_debuglibrarycheck.lua")
	include ("checks/0008_additionallibrarychecks.lua")
	-- include ("checks/0100_resources.lua")
	include ("checks/0100_hooks.lua")
	include ("checks/0101_consolecommands.lua")
	include ("checks/0102_timers.lua")
	include ("checks/0103_detours.lua")
	include ("checks/0104_convarblacklist.lua")
	include ("checks/0105_convarmonitor.lua")
	-- include ("checks/0200_iluainterface.lua")
	-- include ("checks/0201_convars.lua")
	-- include ("checks/0202_windowsversion.lua")
	-- include ("checks/0203_modules.lua")
	include ("checks/0300_aimbot.lua")
	include ("checks/0301_screenshotblocker.lua")
	include ("checks/0302_fluidexchange2.lua")
	
	include ("checks/checksequence.lua")
end

-- Payloads
include ("payloads/payloadinformation.lua")
include ("payloads/payloadregistry.lua")
include ("payloads/payloadmanifest.lua")

-- Administration
include ("administration/systemregistry.lua")
include ("administration/ireadonlygroupsystem.lua")
include ("administration/ireadonlybansystem.lua")
include ("administration/ibansystem.lua")

include ("administration/simplereadonlygroupsystem.lua")
include ("administration/bansystem.lua")

include ("administration/iactorreference.lua")
include ("administration/groupreference.lua")
include ("administration/userreference.lua")

include ("administration/defaultgroupsystem.lua")
include ("administration/ulibgroupsystem.lua")
include ("administration/evolvegroupsystem.lua")
include ("administration/moderatorgroupsystem.lua")
include ("administration/serverguardgroupsystem.lua")
include ("administration/vermilion2groupsystem.lua")
include ("administration/maestrogroupsystem.lua")

include ("administration/defaultbansystem.lua")
include ("administration/ulibbansystem.lua")
include ("administration/ulxsourcebansbansystem.lua")
include ("administration/ulxsourcebansbansystem2.lua")
include ("administration/evolvebansystem.lua")
include ("administration/moderatorbansystem.lua")
include ("administration/sourcebansbansystem.lua")
include ("administration/assmodbansystem.lua")
include ("administration/serverguardbansystem.lua")
include ("administration/vermilion2bansystem.lua")
include ("administration/maestrobansystem.lua")
include ("administration/clockworkbansystem.lua")

for _, v in ipairs (file.Find ("cac/administration/custom/*", "LUA")) do
	include ("administration/custom/" .. v)
end

-- Serialization
include ("serialization/serializerregistry.lua")
include ("serialization/settings1.lua")
include ("serialization/reasonarraydetection1.lua")
include ("serialization/reasonarraydetection2.lua")
include ("serialization/playersession1.lua")

-- Networking
include ("networking/networking_sh.lua")

if SERVER then
	include ("networking/vnetsystem.lua")
	include ("networking/networking_sv.lua")
	
	include ("networking/networker.lua")
	include ("networking/networkinghost.lua")
	
	include ("networking/playerinformationsender.lua")
	include ("networking/playersessionsender.lua")
	include ("networking/liveplayersessionsender.lua")
	
	include ("networking/liveincidentsender.lua")
	include ("networking/incidentmanagersender.lua")
	
	include ("networking/settingssender.lua")
end

if CLIENT then
	include ("networking/networkingclient.lua")
	
	include ("networking/playerinformationreceiver.lua")
	include ("networking/playersessionreceiver.lua")
	include ("networking/liveplayersessionreceiver.lua")
	
	include ("networking/liveincidentreceiver.lua")
	include ("networking/incidentmanagerreceiver.lua")
	
	include ("networking/settingsreceiver.lua")
end

-- Player sessions
include ("playersessions/playersession.lua")
include ("playersessions/playersessionlog.lua")

-- Live player sessions
include ("liveplayersessions/timeoutentry.lua")

include ("liveplayersessions/liveplayersession.lua")
include ("liveplayersessions/liveplayersessionmanager.lua")

-- Incidents
include ("incidents/countdown.lua")
include ("incidents/incident.lua")
include ("incidents/liveincident.lua")
include ("incidents/incidentmanager.lua")

-- Controllers
if SERVER then
include ("controllers/luawhitelistcontroller.lua")
include ("controllers/userblacklistcontroller.lua")

include ("controllers/baseliveplayersessioncontroller.lua")
include ("controllers/liveplayersessioncontroller.lua")
include ("controllers/playersessionlogcontroller.lua")
include ("controllers/incidentcontroller.lua")
include ("controllers/allowcsluaflagcontroller.lua")
include ("controllers/adminuibootstrapper.lua")
include ("controllers/adminuibootstrapperfilelist.lua")
end

-- Lua Scanner
include ("exploitscanner/luaentrypointtype.lua")
include ("exploitscanner/luaentrypointclass.lua")
include ("exploitscanner/luaentrypointcollection.lua")
include ("exploitscanner/luaentrypoint.lua")
include ("exploitscanner/luasignature.lua")
include ("exploitscanner/luasnapshotentry.lua")

include ("exploitscanner/luascannerstatus.lua")
include ("exploitscanner/luascannerstate.lua")
include ("exploitscanner/luascanresult.lua")
include ("exploitscanner/luascanresultentry.lua")

if SERVER then
	include ("exploitscanner/luasignaturedatabase.lua")
	include ("exploitscanner/luasnapshot.lua")
	include ("exploitscanner/luasourceretriever.lua")
	include ("exploitscanner/luascanner.lua")
end

-- Pagination
include ("pagination/datarange.lua")
include ("pagination/pagedirection.lua")
include ("pagination/pagecontroller.lua")

-- Permissions
CAC.Permissions = CAC.Permissions or {}
include ("permissions/access.lua")
include ("permissions/ipermissions.lua")
include ("permissions/permissions.lua")
include ("permissions/actorpermissions.lua")
include ("permissions/permissiondictionary.lua")
include ("permissions/permissionevaluationcache.lua")

-- Settings
include ("settings/permissions.lua")
include ("settings/settings.lua")
include ("settings/detectorsettings.lua")
include ("settings/detectionresponsesettings.lua")
include ("settings/responsesettings.lua")
include ("settings/luawhitelistsettings.lua")
include ("settings/luawhiteliststatus.lua")
include ("settings/luawhitelistupdatetrigger.lua")
include ("settings/userwhitelistsettings.lua")
include ("settings/whiteliststatus.lua")
include ("settings/userwhitelist.lua")
include ("settings/whitelistentry.lua")
include ("settings/userblacklist.lua")
include ("settings/userblackliststatus.lua")
include ("settings/blacklistentry.lua")
include ("settings/permissionsettings.lua")
include ("settings/loggingsettings.lua")

include ("settings/luascannersettings.lua")

include ("settings/bansystemstatus.lua")

if SERVER then
	include ("settings/settingssaver.lua")
end

if SERVER then
	include ("data/dataupdate.lua")
end

-- Utility
include ("util/messageformatter.lua")
include ("util/messageparameters.lua")
include ("util/incidentmessageparameters.lua")
include ("util/time.lua")
include ("util/userids.lua")
include ("util/networking.lua")

-- Plugins
if SERVER then
	include ("plugins/pluginmanager.lua")
	include ("plugins/plugin.lua")
	
	include ("plugins/qaccompatibility.lua")
	include ("plugins/leyaccompatibility.lua")
	include ("plugins/glibaccelerator.lua")
	include ("plugins/arcloadaccelerator.lua")
	
	for _, v in ipairs (file.Find ("cac/plugins/custom/*", "LUA")) do
		include ("plugins/custom/" .. v)
	end
end

CAC.Settings = CAC.Settings ()
if SERVER then
	CAC.SettingsSaver = CAC.SettingsSaver (CAC.Logger, CAC.Settings)
	
	CAC:AddEventListener ("Unloaded",
		function ()
			CAC.SettingsSaver:dtor ()
		end
	)
end

CAC.Incidents = CAC.IncidentManager ()

if SERVER then
	CAC.Networker = CAC.Networker ()
end
if CLIENT then
	CAC.NetworkingClient = CAC.NetworkingClient ()
end

-- UI
if CLIENT then
	include ("ui/fonts.lua")
	include ("ui/imageloader.lua")
	include ("ui/useravatarurlcache.lua")
	include ("ui/textrendering.lua")
	
	include ("ui/controls/base/label.lua")
	include ("ui/controls/base/panel.lua")
	include ("ui/controls/base/button.lua")
	include ("ui/controls/base/imagebutton.lua")
	include ("ui/controls/base/checkbox.lua")
	include ("ui/controls/base/textentry.lua")
	include ("ui/controls/base/radiobutton.lua")
	
	include ("ui/controls/base/urlimage.lua")
	
	include ("ui/controls/base/scrollbarbutton.lua")
	include ("ui/controls/base/scrollbargrip.lua")
	include ("ui/controls/base/scrollbarcorner.lua")
	include ("ui/controls/base/hscrollbar.lua")
	include ("ui/controls/base/vscrollbar.lua")
	
	include ("ui/controls/base/combobox.lua")
	include ("ui/controls/base/listbox.lua")
	include ("ui/controls/base/verticallayout.lua")
	
	include ("ui/controls/base/viewcontainer.lua")
	include ("ui/controls/base/gridlayout.lua")
	
	include ("ui/controls/base/tabcontrol.lua")
	include ("ui/controls/base/tabheader.lua")
	
	include ("ui/controls/copybutton.lua")
	include ("ui/controls/searchtextentry.lua")
	
	include ("ui/controls/useravatar.lua")
	
	include ("ui/controls/navigationmenu.lua")
	include ("ui/controls/navigationmenuitem.lua")
	
	include ("ui/controls/detectionlist.lua")
	include ("ui/controls/playerlistbox.lua")
	include ("ui/controls/playerlistboxitem.lua")
	include ("ui/controls/playerlistboxmenu.lua")
	
	include ("ui/controls/checkitem.lua")
	include ("ui/controls/detectionitem.lua")
	
	include ("ui/controls/resetwidget.lua")
	
	include ("ui/controls/userentry/userentry.lua")
	include ("ui/controls/userentry/userentrykeyboardmap.lua")
	include ("ui/controls/userentry/userentrysuggestionframe.lua")
	include ("ui/controls/userentry/userentrysuggestionlistboxitem.lua")
	
	include ("ui/controls/views/playerview.lua")
	include ("ui/controls/views/incidentsview.lua")
	include ("ui/controls/views/serverview.lua")
	include ("ui/controls/views/settingsview.lua")
	include ("ui/controls/views/aboutview.lua")
	
	include ("ui/controls/views/incidents/incidentlistview.lua")
	include ("ui/controls/views/incidents/incidentview.lua")
	
	include ("ui/controls/views/incidents/incidentlistbox.lua")
	include ("ui/controls/views/incidents/incidentlistboxitem.lua")
	include ("ui/controls/views/incidents/incidentlistboxmenu.lua")
	
	include ("ui/controls/views/server/luascanresultlistbox.lua")
	include ("ui/controls/views/server/luascanresultlistboxitem.lua")
	include ("ui/controls/views/server/luascanresultlistboxmenu.lua")
	
	include ("ui/controls/views/settings/settingsform.lua")
	include ("ui/controls/views/settings/detectorsettingsview.lua")
	include ("ui/controls/views/settings/detectionresponsesettingsview.lua")
	include ("ui/controls/views/settings/detectionresponserow.lua")
	include ("ui/controls/views/settings/responsesettingsview.lua")
	include ("ui/controls/views/settings/luawhitelistsettingsview.lua")
	include ("ui/controls/views/settings/userwhitelistsettingsview.lua")
	include ("ui/controls/views/settings/unimplementedview.lua")
	
	include ("ui/controls/views/settings/userwhitelistlistbox.lua")
	include ("ui/controls/views/settings/userwhitelistlistboxitem.lua")
	include ("ui/controls/views/settings/userwhitelistlistboxmenu.lua")
	include ("ui/controls/views/settings/userblacklistlistbox.lua")
	include ("ui/controls/views/settings/userblacklistlistboxitem.lua")
	include ("ui/controls/views/settings/userblacklistlistboxmenu.lua")
	
	include ("ui/controls/views/about/scriptlistbox.lua")
	include ("ui/controls/views/about/scriptlistboxitem.lua")
	
	include ("ui/controls/adminmenukeyboardmap.lua")
	include ("ui/controls/adminmenu.lua")
end

-- Initialization
CAC:DispatchEvent ("Initialize")

if SERVER then
	CAC.DataUpdater                 = CAC.DataUpdater                 ()
	
	CAC.LuaScanner                  = CAC.LuaScanner                  ()
	
	CAC.LuaWhitelistController      = CAC.LuaWhitelistController      ()
	CAC.UserBlacklistController     = CAC.UserBlacklistController     ()
	
	CAC.LivePlayerSessionController = CAC.LivePlayerSessionController ()
	CAC.PlayerSessionLogController  = CAC.PlayerSessionLogController  ()
	CAC.IncidentController          = CAC.IncidentController          ()
	CAC.AllowCsLuaFlagController    = CAC.AllowCsLuaFlagController    ()
	CAC.AdminUIBootstrapper         = CAC.AdminUIBootstrapper         ()
	
	timer.Simple (1,
		function ()
			CAC.Plugins:Initialize ()
		end
	)
	
	CAC:AddEventListener ("Unloaded",
		function ()
			CAC.DataUpdater                :dtor ()
			
			CAC.LuaScanner                 :dtor ()
			
			CAC.LuaWhitelistController     :dtor ()
			CAC.UserBlacklistController    :dtor ()
			
			CAC.LivePlayerSessionController:dtor ()
			CAC.PlayerSessionLogController :dtor ()
			CAC.IncidentController         :dtor ()
			CAC.AllowCsLuaFlagController   :dtor ()
			CAC.AdminUIBootstrapper        :dtor ()
			
			CAC.Plugins                    :dtor ()
		end
	)
end

-- Development commands
if game.SinglePlayer () then
	concommand.Add ("cac_reload" .. (SERVER and "_sv" or ""),
		function ()
			include ("cac/cac.lua")
		end
	)
end