" Vim syntax file
" Language:	Lua 4.0, Lua 5.0 and Lua 5.1
" Maintainer:	Marcus Aurelius Farias <marcus.cf 'at' bol com br>
" First Author:	Carlos Augusto Teixeira Mendes <cmendes 'at' inf puc-rio br>
" Last Change:	2006 Aug 10
" Options:	lua_version = 4 or 5
"		lua_subversion = 0 (4.0, 5.0) or 1 (5.1)
"		default 5.1

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("lua_version")
  " Default is lua 5.1
  let lua_version = 5
  let lua_subversion = 1
elseif !exists("lua_subversion")
  " lua_version exists, but lua_subversion doesn't. So, set it to 0
  let lua_subversion = 0
endif

syn case match

" syncing method
syn sync minlines=100

" Comments
syn keyword luaTodo             contained TODO FIXME XXX
syn match   luaComment          "--.*$" contains=luaTodo,@Spell
if lua_version == 5 && lua_subversion == 0
  syn region  luaComment        matchgroup=luaComment start="--\[\[" end="\]\]" contains=luaTodo,luaInnerComment,@Spell
  syn region  luaInnerComment   contained transparent start="\[\[" end="\]\]"
elseif lua_version > 5 || (lua_version == 5 && lua_subversion >= 1)
  " Comments in Lua 5.1: --[[ ... ]], [=[ ... ]=], [===[ ... ]===], etc.
  syn region  luaComment        matchgroup=luaComment start="--\[\z(=*\)\[" end="\]\z1\]" contains=luaTodo,@Spell
endif

" First line may start with #!
syn match luaComment "\%^#!.*"

" catch errors caused by wrong parenthesis and wrong curly brackets or
" keywords placed outside their respective blocks

syn region luaParen transparent start='(' end=')' contains=ALLBUT,luaError,luaTodo,luaSpecial,luaCond,luaCondElseif,luaCondEnd,luaCondStart,luaBlock,luaRepeatBlock,luaRepeat,luaStatement
syn match  luaError ")"
syn match  luaError "}"
syn match  luaError "\<\%(end\|else\|elseif\|then\|until\|in\)\>"

" Function declaration
syn region luaFunctionBlock transparent matchgroup=luaFunction start="\<function\>" end="\<end\>" contains=ALLBUT,luaTodo,luaSpecial,luaCond,luaCondElseif,luaCondEnd,luaRepeat

" if then else elseif end
syn keyword luaCond contained else

" then ... end
syn region luaCondEnd contained transparent matchgroup=luaCond start="\<then\>" end="\<end\>" contains=ALLBUT,luaTodo,luaSpecial,luaRepeat

" elseif ... then
syn region luaCondElseif contained transparent matchgroup=luaCond start="\<elseif\>" end="\<then\>" contains=ALLBUT,luaTodo,luaSpecial,luaCond,luaCondElseif,luaCondEnd,luaRepeat

" if ... then
syn region luaCondStart transparent matchgroup=luaCond start="\<if\>" end="\<then\>"me=e-4 contains=ALLBUT,luaTodo,luaSpecial,luaCond,luaCondElseif,luaCondEnd,luaRepeat nextgroup=luaCondEnd skipwhite skipempty

" do ... end
syn region luaBlock transparent matchgroup=luaStatement start="\<do\>" end="\<end\>" contains=ALLBUT,luaTodo,luaSpecial,luaCond,luaCondElseif,luaCondEnd,luaRepeat

" repeat ... until
syn region luaRepeatBlock transparent matchgroup=luaRepeat start="\<repeat\>" end="\<until\>" contains=ALLBUT,luaTodo,luaSpecial,luaCond,luaCondElseif,luaCondEnd,luaRepeat

" while ... do
syn region luaRepeatBlock transparent matchgroup=luaRepeat start="\<while\>" end="\<do\>"me=e-2 contains=ALLBUT,luaTodo,luaSpecial,luaCond,luaCondElseif,luaCondEnd,luaRepeat nextgroup=luaBlock skipwhite skipempty

" for ... do and for ... in ... do
syn region luaRepeatBlock transparent matchgroup=luaRepeat start="\<for\>" end="\<do\>"me=e-2 contains=ALLBUT,luaTodo,luaSpecial,luaCond,luaCondElseif,luaCondEnd nextgroup=luaBlock skipwhite skipempty

" Following 'else' example. This is another item to those
" contains=ALLBUT,... because only the 'for' luaRepeatBlock contains it.
syn keyword luaRepeat contained in

" other keywords
syn keyword luaStatement return local break
syn keyword luaOperator  and or not
syn keyword luaConstant  nil
if lua_version > 4
  syn keyword luaConstant true false
endif

" Strings
if lua_version < 5
  syn match  luaSpecial contained "\\[\\abfnrtv\'\"]\|\\\d\{,3}"
elseif lua_version == 5 && lua_subversion == 0
  syn match  luaSpecial contained "\\[\\abfnrtv\'\"[\]]\|\\\d\{,3}"
  syn region luaString2 matchgroup=luaString start=+\[\[+ end=+\]\]+ contains=luaString2,@Spell
elseif lua_version > 5 || (lua_version == 5 && lua_subversion >= 1)
  syn match  luaSpecial contained "\\[\\abfnrtv\'\"]\|\\\d\{,3}"
  syn region luaString2 matchgroup=luaString start="\[\z(=*\)\[" end="\]\z1\]" contains=@Spell
endif
syn region luaString  start=+'+ end=+'+ skip=+\\\\\|\\'+ contains=luaSpecial,@Spell
syn region luaString  start=+"+ end=+"+ skip=+\\\\\|\\"+ contains=luaSpecial,@Spell

" integer number
syn match luaNumber "\<\d\+\>"
" floating point number, with dot, optional exponent
syn match luaFloat  "\<\d\+\.\d*\%(e[-+]\=\d\+\)\=\>"
" floating point number, starting with a dot, optional exponent
syn match luaFloat  "\.\d\+\%(e[-+]\=\d\+\)\=\>"
" floating point number, without dot, with exponent
syn match luaFloat  "\<\d\+e[-+]\=\d\+\>"

" hex numbers
if lua_version > 5 || (lua_version == 5 && lua_subversion >= 1)
  syn match luaNumber "\<0x\x\+\>"
endif

" tables
syn region  luaTableBlock transparent matchgroup=luaTable start="{" end="}" contains=ALLBUT,luaTodo,luaSpecial,luaCond,luaCondElseif,luaCondEnd,luaCondStart,luaBlock,luaRepeatBlock,luaRepeat,luaStatement

syn match selfKey /\<self[:\.]*[^( ]*\>/

syn keyword wonderFunc SetFontSize
syn keyword wonderFunc GetTextSize
syn keyword wonderFunc GetScreenSize
syn keyword wonderFunc OnContactDialog
syn keyword wonderFunc OpenContactDialog
syn keyword wonderFunc jsonLoadString
syn keyword wonderFunc jsonLoadFile
syn keyword wonderFunc jsonOpenString
syn keyword wonderFunc jsonOpenFile
syn keyword wonderFunc jsonRelease
syn keyword wonderFunc jsonToTable
syn keyword wonderFunc pluginCreate
syn keyword wonderFunc pluginRelease
syn keyword wonderFunc pluginInvoke
syn keyword wonderFunc paramCount
syn keyword wonderFunc paramGetType
syn keyword wonderFunc paramGetNumber
syn keyword wonderFunc paramGetInteger
syn keyword wonderFunc paramGetString
syn keyword wonderFunc paramGetData
syn keyword wonderFunc pluginGetObserver
syn keyword wonderFunc pluginInstall
syn keyword wonderFunc pluginUnInstall
syn keyword wonderFunc pluginGetTotalCount
syn keyword wonderFunc pluginGetInfoByIndex
syn keyword wonderFunc pluginGetInfoByName
syn keyword wonderFunc pluginChangeStatus
syn keyword wonderFunc registerCreate
syn keyword wonderFunc registerRelease
syn keyword wonderFunc registerLoad
syn keyword wonderFunc registerSave
syn keyword wonderFunc registerRemove
syn keyword wonderFunc registerClear
syn keyword wonderFunc registerSetNumber
syn keyword wonderFunc registerGetNumber
syn keyword wonderFunc registerSetInteger
syn keyword wonderFunc registerGetInteger
syn keyword wonderFunc registerSetString
syn keyword wonderFunc registerGetString
syn keyword wonderFunc registerTrace
syn keyword wonderFunc SpriteCoverflow_GetItemCount
syn keyword wonderFunc SpriteCoverflow_GetItem
syn keyword wonderFunc SpriteCoverflow_AddItem
syn keyword wonderFunc SpriteCoverflow_InsertItem
syn keyword wonderFunc SpriteCoverflow_RemoveItem
syn keyword wonderFunc SpriteCoverflow_RemoveAllItem
syn keyword wonderFunc SpriteCoverflow_LoadItem
syn keyword wonderFunc SpriteCoverflow_SetCurItem
syn keyword wonderFunc SpriteCoverflow_GetCurItem
syn keyword wonderFunc SpriteCoverflow_Adjust
syn keyword wonderFunc SpriteGallery_GetGalleryItemCount
syn keyword wonderFunc SpriteGallery_GetGalleryItem
syn keyword wonderFunc SpriteGallery_AddGalleryItem
syn keyword wonderFunc SpriteGallery_InsertGalleryItem
syn keyword wonderFunc SpriteGallery_RemoveGalleryItem
syn keyword wonderFunc SpriteGallery_RemoveAllGalleryItem
syn keyword wonderFunc SpriteGallery_LoadGalleryItem
syn keyword wonderFunc SpriteGallery_SetCurItem
syn keyword wonderFunc SpriteGallery_GetCurItem
syn keyword wonderFunc SpriteGallery_Adjust
syn keyword wonderFunc GetRootSprite
syn keyword wonderFunc GetCurScene
syn keyword wonderFunc SetCurScene
syn keyword wonderFunc LoadSprite
syn keyword wonderFunc LoadSpriteFromString
syn keyword wonderFunc LoadSpriteFromNode
syn keyword wonderFunc LoadSpriteFromSprite
syn keyword wonderFunc FreeSprite
syn keyword wonderFunc GetParentSprite
syn keyword wonderFunc FindChildSprite
syn keyword wonderFunc FindChildSpriteByClass
syn keyword wonderFunc ClearChildSprite
syn keyword wonderFunc CreateSprite
syn keyword wonderFunc SetSpriteProperty
syn keyword wonderFunc GetSpriteProperty
syn keyword wonderFunc GetSpriteText
syn keyword wonderFunc IsKindOfSprite
syn keyword wonderFunc AddChildSprite
syn keyword wonderFunc RemoveChildSprite
syn keyword wonderFunc WalkThroughSprite
syn keyword wonderFunc GetSpriteLevel
syn keyword wonderFunc SetSpriteName
syn keyword wonderFunc SetSpriteData
syn keyword wonderFunc GetSpriteData
syn keyword wonderFunc GetSpriteName
syn keyword wonderFunc GetSpriteParent
syn keyword wonderFunc GetSpriteRect
syn keyword wonderFunc SetSpriteRect
syn keyword wonderFunc SetSpriteLayoutType
syn keyword wonderFunc SetSpriteOnKeyVisible
syn keyword wonderFunc IsSpriteEnable
syn keyword wonderFunc SetSpriteEnable
syn keyword wonderFunc IsSpriteVisible
syn keyword wonderFunc SetSpriteVisible
syn keyword wonderFunc IsSpriteActive
syn keyword wonderFunc SetSpriteActive
syn keyword wonderFunc HasSpriteFocus
syn keyword wonderFunc SetSpriteFocus
syn keyword wonderFunc KillSpriteFocus
syn keyword wonderFunc SetSpriteCapture
syn keyword wonderFunc ReleaseSpriteCapture
syn keyword wonderFunc GetTailSpriteCapture
syn keyword wonderFunc SendSpriteEvent
syn keyword wonderFunc AdjustSprite
syn keyword wonderFunc SetPreResourceUrl
syn keyword wonderFunc TraceSpritesTree
syn keyword wonderFunc GetCurFocusSprite
syn keyword wonderFunc GetCurSceneDirPath
syn keyword wonderFunc FreeListSprite
syn keyword wonderFunc GetCurSceneList
syn keyword wonderFunc SetSpriteFont
syn keyword wonderFunc SpriteList_GetListItemCount
syn keyword wonderFunc SpriteList_GetListItem
syn keyword wonderFunc SpriteList_AddListItem
syn keyword wonderFunc Sprite_AddKeyListOut
syn keyword wonderFunc SpriteList_InsertListItem
syn keyword wonderFunc SpriteList_RemoveListItem
syn keyword wonderFunc SpriteList_ClearListItem
syn keyword wonderFunc SpriteList_LoadListItem
syn keyword wonderFunc SpriteList_SetCurItem
syn keyword wonderFunc SpriteList_GetCurItem
syn keyword wonderFunc SpriteList_GetLineCount
syn keyword wonderFunc SpriteList_GetColCount
syn keyword wonderFunc SpriteList_GetItemPerPage
syn keyword wonderFunc SpriteList_GetStartItem
syn keyword wonderFunc SpriteList_SetStartItem
syn keyword wonderFunc SpriteList_Adjust
syn keyword wonderFunc SpriteListItem_SetIndex
syn keyword wonderFunc SpriteListItem_GetIndex
syn keyword wonderFunc SpriteListView_GetListItemCount
syn keyword wonderFunc SpriteListView_GetListItem
syn keyword wonderFunc SpriteListView_AddListItem
syn keyword wonderFunc SpriteListView_InsertListItem
syn keyword wonderFunc SpriteListView_RemoveListItem
syn keyword wonderFunc SpriteListView_ClearListItem
syn keyword wonderFunc SpriteListView_LoadListItem
syn keyword wonderFunc SpriteListView_SetCurItem
syn keyword wonderFunc SpriteListView_GetCurItem
syn keyword wonderFunc SpriteListView_SetStartItem
syn keyword wonderFunc SpriteListView_Adjust
syn keyword wonderFunc SpriteListViewItem_SetIndex
syn keyword wonderFunc SpriteListViewItem_GetIndex
syn keyword wonderFunc SpritePanorama_GetItemCount
syn keyword wonderFunc SpritePanorama_GetItem
syn keyword wonderFunc SpritePanorama_AddItem
syn keyword wonderFunc SpritePanorama_InsertItem
syn keyword wonderFunc SpritePanorama_RemoveItem
syn keyword wonderFunc SpritePanorama_ClearItem
syn keyword wonderFunc SpritePanorama_LoadItem
syn keyword wonderFunc SpritePanorama_SetCurItem
syn keyword wonderFunc SpritePanorama_GetCurItem
syn keyword wonderFunc SpritePanorama_Adjust
syn keyword wonderFunc SpriteScrollBar_GetPos
syn keyword wonderFunc SpriteScrollBar_GetMaxSize
syn keyword wonderFunc SpriteScrollBar_GetSplider
syn keyword wonderFunc SpriteScrollBar_Adjust
syn keyword wonderFunc SetTimer
syn keyword wonderFunc CancelTimer
syn keyword wonderFunc TimerCallback
syn keyword wonderFunc SetSystemInterval
syn keyword wonderFunc SetRefreshInterval
syn keyword wonderFunc GetLocalFilename
syn keyword wonderFunc GetStringMD5
syn keyword wonderFunc GetFileMD5
syn keyword wonderFunc OpenDirectory
syn keyword wonderFunc GetModuleFolder
syn keyword wonderFunc BeginUnzip
syn keyword wonderFunc ProcessUnzip
syn keyword wonderFunc GetUnzipCurFileName
syn keyword wonderFunc GoToUnzipNextFile
syn keyword wonderFunc EndUnzip
syn keyword wonderFunc GetUnzipCount
syn keyword wonderFunc GetUnzipIndex
syn keyword wonderFunc ChangeSkin
syn keyword wonderFunc ConfigMachine
syn keyword wonderFunc GetMachineInfo
syn keyword wonderFunc GetPhoneNumber
syn keyword wonderFunc AppPassiveStart
syn keyword wonderFunc SendSMS
syn keyword wonderFunc PageChanged
syn keyword wonderFunc SetEffect
syn keyword wonderFunc Exit
syn keyword wonderFunc WriteLogs
syn keyword wonderFunc InstallApp
syn keyword wonderFunc InstallAppEx
syn keyword wonderFunc UnInstallApp
syn keyword wonderFunc RunApp
syn keyword wonderFunc ReleaseMirrorImage
syn keyword wonderFunc NetworkStop
syn keyword wonderFunc GetFlashCardName
syn keyword wonderFunc GetDiskFreeSpaceEx
syn keyword wonderFunc GetFileLength
syn keyword wonderFunc InstallMirrorImage
syn keyword wonderFunc GetDefaultFolder
syn keyword wonderFunc GetTickTime
syn keyword wonderFunc GetCurrentAPNType
syn keyword wonderFunc Makefolder
syn keyword wonderFunc Deletefolder
syn keyword wonderFunc WLanIsSwitchOn
syn keyword wonderFunc WLanGetAvailable
syn keyword wonderFunc WLanGetInUse
syn keyword wonderFunc WLanIsPortal
syn keyword wonderFunc WLanHaveLogin
syn keyword wonderFunc WLanSetWifiEnable
syn keyword wonderFunc WLanSetUrl
syn keyword wonderFunc GetNetworkStatus
syn keyword wonderFunc NetworkStart
syn keyword wonderFunc DecodeString
syn keyword wonderFunc GetUserAgent
syn keyword wonderFunc StartAPP
syn keyword wonderFunc StopAPP
syn keyword wonderFunc IsUserKeyScheme
syn keyword wonderFunc GetAppName
syn keyword wonderFunc QueryAutoPassword
syn keyword wonderFunc SetCMCCAccount
syn keyword wonderFunc MonitorStart
syn keyword wonderFunc MonitorStop
syn keyword wonderFunc xmlLoadString
syn keyword wonderFunc xmlSaveString
syn keyword wonderFunc xmlLoadFile
syn keyword wonderFunc xmlSaveFile
syn keyword wonderFunc xmlNewElement
syn keyword wonderFunc xmlRelease
syn keyword wonderFunc xmlFindElement
syn keyword wonderFunc xmlElementDeleteAttr
syn keyword wonderFunc xmlElementSetAttr
syn keyword wonderFunc xmlElementGetAttr
syn keyword wonderFunc xmlElementGetAttrCount
syn keyword wonderFunc xmlElementGetAttrByIndex
syn keyword wonderFunc xmlAdd
syn keyword wonderFunc xmlRemove
syn keyword wonderFunc xmlDelete
syn keyword wonderFunc xmlSetText
syn keyword wonderFunc xmlGetText
syn keyword wonderFunc xmlIsValidElement
syn keyword wonderFunc xmlNextElement
syn keyword wonderFunc xmlPushValue
syn keyword wonderFunc xmlWalkThrough
syn keyword wonderFunc xmlToTable
syn keyword wonderFunc xmlLoadFileToTable
syn keyword wonderFunc xmlLoadStringToTable

syn keyword wonderKey MSG_ACTIVATE MSG_DEACTIVATE MSG_SMS MSG_MINIMIZED MSG_MAXIMIZED MSG_ADJUST MSG_EXCEPTIVEKEY
syn keyword wonderKey MSG_NETWORK_ERROR MSG_USER MSG_CACHEDATA_RELOAD MSG_HTTPPIPE MSG_SCREENROTATE MSG_TURNBACKLIGHT
syn keyword wonderKey MSG_DIALNET MSG_SCREENLOCK MSG_WLAN
syn keyword wonderKey SCREEN_WIDTH SCREEN_HEIGHT
syn keyword wonderKey DIALNET_CONNECTED
syn keyword wonderKey NETERR_TRANS_FAIL NETERR_TRANS_LOGIN NETERR_TRANS_PASSWORD NETERR_TRANS_WlANAUTOCONNCLOSED NETERR_TRANS_INVALIDAPN
syn keyword wonderKey ENGINE_VERSION
syn keyword wonderKey PMSG_DOWNLOAD_FINISHED PMSG_DOWNLOAD_FAILED
syn keyword wonderKey WDFIDL_APP WDFIDL_MODULE WDFIDL_CACHE WDFIDL_MMS WDFIDL_DOWNLOAD WDFIDL_MYVIDIO

syn match wonderFrameworkFunc1 /\<Config:[^(]*\>/
syn match wonderFrameworkFunc1 /\<Dialog:[^(]*\>/
syn match wonderFrameworkFunc1 /\<Download:[^(]*\>/
syn match wonderFrameworkFunc1 /\<IO:[^(]*\>/
syn match wonderFrameworkFunc1 /\<Loading:[^(]*\>/
syn match wonderFrameworkFunc1 /\<Log:[^(]*\>/
syn match wonderFrameworkFunc1 /\<Scene:[^(]*\>/
syn match wonderFrameworkFunc1 /\<Util:[^(]*\>/
syn match wonderFrameworkFunc1 /\<Http:[^(]*\>/
syn match wonderFrameworkFunc1 /\<App:[^(]*\>/
syn match wonderFrameworkFunc1 /\<Upload:[^(]*\>/
syn match wonderFrameworkFunc1 /\<Player:[^(]*\>/
syn match wonderFrameworkFunc1 /\<Menu:[^(]*\>/
syn match wonderFrameworkFunc1 /\<WLAN:[^(]*\>/
syn match wonderFrameworkFunc1 /\<Tips:[^(]*\>/

syn match wonderFrameworkFunc /\<Upload\:_getHandle\>/
syn match wonderFrameworkFunc /\<Plugin\:create\>/
syn match wonderFrameworkFunc /\<Plugin\:release\>/
syn match wonderFrameworkFunc /\<Plugin\:invoke\>/
syn match wonderFrameworkFunc /\<Plugin\:getOberver\>/
syn match wonderFrameworkFunc /\<Plugin\:install\>/
syn match wonderFrameworkFunc /\<Plugin\:uninstall\>/
syn match wonderFrameworkFunc /\<Plugin\:getTotalCount\>/
syn match wonderFrameworkFunc /\<Plugin\:getInfoByIndex\>/
syn match wonderFrameworkFunc /\<Plugin\:getInfoByName\>/
syn match wonderFrameworkFunc /\<Plugin\:changeStatus\>/
syn match wonderFrameworkFunc /\<Param\:getCount\>/
syn match wonderFrameworkFunc /\<Param\:getType\>/
syn match wonderFrameworkFunc /\<Param\:getNumber\>/
syn match wonderFrameworkFunc /\<Param\:getInteger\>/
syn match wonderFrameworkFunc /\<Param\:getString\>/
syn match wonderFrameworkFunc /\<Param\:getData\>/
syn match wonderFrameworkFunc /\<IO\:openDir\>/
syn match wonderFrameworkFunc /\<IO\:dirExist\>/
syn match wonderFrameworkFunc /\<IO\:dirCreate\>/
syn match wonderFrameworkFunc /\<IO\:dirRemove\>/
syn match wonderFrameworkFunc /\<IO\:dirCopy\>/
syn match wonderFrameworkFunc /\<IO\:fileExist\>/
syn match wonderFrameworkFunc /\<IO\:fileCreate\>/
syn match wonderFrameworkFunc /\<IO\:fileRemove\>/
syn match wonderFrameworkFunc /\<IO\:fileRename\>/
syn match wonderFrameworkFunc /\<IO\:fileRead\>/
syn match wonderFrameworkFunc /\<IO\:fileWrite\>/
syn match wonderFrameworkFunc /\<IO\:fileCopy\>/
syn match wonderFrameworkFunc /\<IO\:fileReadToTable\>/
syn match wonderFrameworkFunc /\<IO\:fileSize\>/
syn match wonderFrameworkFunc /\<IO\:fileExt\>/
syn match wonderFrameworkFunc /\<Util\:isValidHandle\>/
syn match wonderFrameworkFunc /\<Util\:split\>/
syn match wonderFrameworkFunc /\<Util\:isAppStart\>/
syn match wonderFrameworkFunc /\<Util\:getCurTime\>/
syn match wonderFrameworkFunc /\<Util\:parseTime\>/
syn match wonderFrameworkFunc /\<Util\:getPlayerInfo\>/
syn match wonderFrameworkFunc /\<Util\:tostring\>/
syn match wonderFrameworkFunc /\<Util\:unzip\>/
syn match wonderFrameworkFunc /\<Util\:setCurAppId\>/
syn match wonderFrameworkFunc /\<Util\:getCurAppId\>/
syn match wonderFrameworkFunc /\<Util\:openContactDialog\>/
syn match wonderFrameworkFunc /\<Util\:md5\>/
syn match wonderFrameworkFunc /\<Util\:getDefaultFolder\>/
syn match wonderFrameworkFunc /\<Util\:isAppPassiveStart\>/
syn match wonderFrameworkFunc /\<Util\:sendSMS\>/
syn match wonderFrameworkFunc /\<Util\:installApp\>/
syn match wonderFrameworkFunc /\<Util\:createMirrorImage\>/
syn match wonderFrameworkFunc /\<Util\:removeMirrorImage\>/
syn match wonderFrameworkFunc /\<Util\:codeString\>/
syn match wonderFrameworkFunc /\<Util\:getCachePath\>/
syn match wonderFrameworkFunc /\<Log\:write\>/
syn match wonderFrameworkFunc /\<Timer\:set\>/
syn match wonderFrameworkFunc /\<Timer\:cancel\>/
syn match wonderFrameworkFunc /\<Json\:loadString2Table\>/
syn match wonderFrameworkFunc /\<Json\:loadFile2Table\>/
syn match wonderFrameworkFunc /\<Xml\:loadString\>/
syn match wonderFrameworkFunc /\<Xml\:save2String\>/
syn match wonderFrameworkFunc /\<Xml\:loadFile\>/
syn match wonderFrameworkFunc /\<Xml\:save2File\>/
syn match wonderFrameworkFunc /\<Xml\:newElement\>/
syn match wonderFrameworkFunc /\<Xml\:release\>/
syn match wonderFrameworkFunc /\<Xml\:findElement\>/
syn match wonderFrameworkFunc /\<Xml\:deleteElementAttr\>/
syn match wonderFrameworkFunc /\<Xml\:getElementAttr\>/
syn match wonderFrameworkFunc /\<Xml\:setElementAttr\>/
syn match wonderFrameworkFunc /\<Xml\:getElementAttrCount\>/
syn match wonderFrameworkFunc /\<Xml\:getElementAttrByIndex\>/
syn match wonderFrameworkFunc /\<Xml\:add\>/
syn match wonderFrameworkFunc /\<Xml\:remove\>/
syn match wonderFrameworkFunc /\<Xml\:delete\>/
syn match wonderFrameworkFunc /\<Xml\:getText\>/
syn match wonderFrameworkFunc /\<Xml\:loadFile2Table\>/
syn match wonderFrameworkFunc /\<Xml\:loadString2Table\>/
syn match wonderFrameworkFunc /\<Reg\:trace\>/
syn match wonderFrameworkFunc /\<Reg\:create\>/
syn match wonderFrameworkFunc /\<Reg\:release\>/
syn match wonderFrameworkFunc /\<Reg\:load\>/
syn match wonderFrameworkFunc /\<Reg\:save\>/
syn match wonderFrameworkFunc /\<Reg\:remove\>/
syn match wonderFrameworkFunc /\<Reg\:clear\>/
syn match wonderFrameworkFunc /\<Reg\:setNumber\>/
syn match wonderFrameworkFunc /\<Reg\:getNumber\>/
syn match wonderFrameworkFunc /\<Reg\:setInteger\>/
syn match wonderFrameworkFunc /\<Reg\:getInteger\>/
syn match wonderFrameworkFunc /\<Reg\:setString\>/
syn match wonderFrameworkFunc /\<Reg\:getString\>/
syn match wonderFrameworkFunc /\<System\:runApp\>/
syn match wonderFrameworkFunc /\<System\:getEngineVersion\>/
syn match wonderFrameworkFunc /\<System\:getSdkVersion\>/
syn match wonderFrameworkFunc /\<System\:setFontSize\>/
syn match wonderFrameworkFunc /\<System\:getTextSize\>/
syn match wonderFrameworkFunc /\<System\:getScreenSize\>/
syn match wonderFrameworkFunc /\<System\:getUserAgent\>/
syn match wonderFrameworkFunc /\<System\:getMachineInfo\>/
syn match wonderFrameworkFunc /\<System\:getPhoneNumber\>/
syn match wonderFrameworkFunc /\<System\:setBrightness\>/
syn match wonderFrameworkFunc /\<System\:startMonitor\>/
syn match wonderFrameworkFunc /\<System\:stopMonitor\>/
syn match wonderFrameworkFunc /\<System\:getTickTime\>/
syn match wonderFrameworkFunc /\<System\:getDiskFreeSpaceEx\>/
syn match wonderFrameworkFunc /\<System\:getFlashCardName\>/
syn match wonderFrameworkFunc /\<System\:changeSkin\>/
syn match wonderFrameworkFunc /\<Sprite\:getRoot\>/
syn match wonderFrameworkFunc /\<Sprite\:getCurScene\>/
syn match wonderFrameworkFunc /\<Sprite\:setCurScene\>/
syn match wonderFrameworkFunc /\<Sprite\:loadFromXml\>/
syn match wonderFrameworkFunc /\<Sprite\:loadFromNode\>/
syn match wonderFrameworkFunc /\<Sprite\:loadFromSprite\>/
syn match wonderFrameworkFunc /\<Sprite\:loadFromString\>/
syn match wonderFrameworkFunc /\<Sprite\:free\>/
syn match wonderFrameworkFunc /\<Sprite\:getParent\>/
syn match wonderFrameworkFunc /\<Sprite\:findChild\>/
syn match wonderFrameworkFunc /\<Sprite\:getData\>/
syn match wonderFrameworkFunc /\<Sprite\:findChildByClass\>/
syn match wonderFrameworkFunc /\<Sprite\:clearChild\>/
syn match wonderFrameworkFunc /\<Sprite\:create\>/
syn match wonderFrameworkFunc /\<Sprite\:setProperty\>/
syn match wonderFrameworkFunc /\<Sprite\:getProperty\>/
syn match wonderFrameworkFunc /\<Sprite\:getText\>/
syn match wonderFrameworkFunc /\<Sprite\:isKindOf\>/
syn match wonderFrameworkFunc /\<Sprite\:addChild\>/
syn match wonderFrameworkFunc /\<Sprite\:removeChild\>/
syn match wonderFrameworkFunc /\<Sprite\:walkThrough\>/
syn match wonderFrameworkFunc /\<Sprite\:getLevel\>/
syn match wonderFrameworkFunc /\<Sprite\:setName\>/
syn match wonderFrameworkFunc /\<Sprite\:getName\>/
syn match wonderFrameworkFunc /\<Sprite\:getRect\>/
syn match wonderFrameworkFunc /\<Sprite\:setRect\>/
syn match wonderFrameworkFunc /\<Sprite\:isEnable\>/
syn match wonderFrameworkFunc /\<Sprite\:setEnable\>/
syn match wonderFrameworkFunc /\<Sprite\:isVisible\>/
syn match wonderFrameworkFunc /\<Sprite\:setVisible\>/
syn match wonderFrameworkFunc /\<Sprite\:isActive\>/
syn match wonderFrameworkFunc /\<Sprite\:setActive\>/
syn match wonderFrameworkFunc /\<Sprite\:isFocused\>/
syn match wonderFrameworkFunc /\<Sprite\:setFocus\>/
syn match wonderFrameworkFunc /\<Sprite\:killFocus\>/
syn match wonderFrameworkFunc /\<Sprite\:setCapture\>/
syn match wonderFrameworkFunc /\<Sprite\:releaseCapture\>/
syn match wonderFrameworkFunc /\<Sprite\:sendEvent\>/
syn match wonderFrameworkFunc /\<Sprite\:ajust\>/
syn match wonderFrameworkFunc /\<Sprite\:traceTree\>/
syn match wonderFrameworkFunc /\<Sprite\:getCurFocus\>/
syn match wonderFrameworkFunc /\<Sprite\:addKeyList\>/
syn match wonderFrameworkFunc /\<Sprite\:setLayoutType\>/
syn match wonderFrameworkFunc /\<Sprite\:setOnKeyVisible\>/
syn match wonderFrameworkFunc /\<Gallery\:getItemCount\>/
syn match wonderFrameworkFunc /\<Gallery\:getItem\>/
syn match wonderFrameworkFunc /\<Gallery\:addItem\>/
syn match wonderFrameworkFunc /\<Gallery\:insertItem\>/
syn match wonderFrameworkFunc /\<Gallery\:removeItem\>/
syn match wonderFrameworkFunc /\<Gallery\:removeAllItems\>/
syn match wonderFrameworkFunc /\<Gallery\:loadItem\>/
syn match wonderFrameworkFunc /\<Gallery\:setCurItem\>/
syn match wonderFrameworkFunc /\<Gallery\:getCurItem\>/
syn match wonderFrameworkFunc /\<Gallery\:adjust\>/
syn match wonderFrameworkFunc /\<List\:getItemCount\>/
syn match wonderFrameworkFunc /\<List\:getItem\>/
syn match wonderFrameworkFunc /\<List\:addItem\>/
syn match wonderFrameworkFunc /\<List\:insertItem\>/
syn match wonderFrameworkFunc /\<List\:removeItem\>/
syn match wonderFrameworkFunc /\<List\:removeAllItems\>/
syn match wonderFrameworkFunc /\<List\:loadItem\>/
syn match wonderFrameworkFunc /\<List\:setCurItem\>/
syn match wonderFrameworkFunc /\<List\:getCurItem\>/
syn match wonderFrameworkFunc /\<List\:getLineCount\>/
syn match wonderFrameworkFunc /\<List\:getColCount\>/
syn match wonderFrameworkFunc /\<List\:getItemsCountPerPage\>/
syn match wonderFrameworkFunc /\<List\:getStartIndex\>/
syn match wonderFrameworkFunc /\<List\:setStartIndex\>/
syn match wonderFrameworkFunc /\<List\:adjust\>/
syn match wonderFrameworkFunc /\<List\:setItemIndex\>/
syn match wonderFrameworkFunc /\<List\:getItemIndex\>/
syn match wonderFrameworkFunc /\<ListView\:getItemCount\>/
syn match wonderFrameworkFunc /\<ListView\:getItem\>/
syn match wonderFrameworkFunc /\<ListView\:addItem\>/
syn match wonderFrameworkFunc /\<ListView\:insertItem\>/
syn match wonderFrameworkFunc /\<ListView\:removeItem\>/
syn match wonderFrameworkFunc /\<ListView\:removeAllItems\>/
syn match wonderFrameworkFunc /\<ListView\:loadItem\>/
syn match wonderFrameworkFunc /\<ListView\:setCurItem\>/
syn match wonderFrameworkFunc /\<ListView\:getCurItem\>/
syn match wonderFrameworkFunc /\<ListView\:adjust\>/
syn match wonderFrameworkFunc /\<ListView\:setItemToTop\>/
syn match wonderFrameworkFunc /\<ListView\:getItemIndex\>/
syn match wonderFrameworkFunc /\<ListView\:setItemIndex\>/
syn match wonderFrameworkFunc /\<Coverflow\:getItemCount\>/
syn match wonderFrameworkFunc /\<Coverflow\:getItem\>/
syn match wonderFrameworkFunc /\<Coverflow\:addItem\>/
syn match wonderFrameworkFunc /\<Coverflow\:insertItem\>/
syn match wonderFrameworkFunc /\<Coverflow\:removeItem\>/
syn match wonderFrameworkFunc /\<Coverflow\:removeAllItems\>/
syn match wonderFrameworkFunc /\<Coverflow\:loadItem\>/
syn match wonderFrameworkFunc /\<Coverflow\:setCurItem\>/
syn match wonderFrameworkFunc /\<Coverflow\:getCurItem\>/
syn match wonderFrameworkFunc /\<Coverflow\:adjust\>/
syn match wonderFrameworkFunc /\<Panorama\:getItemCount\>/
syn match wonderFrameworkFunc /\<Panorama\:getItem\>/
syn match wonderFrameworkFunc /\<Panorama\:addItem\>/
syn match wonderFrameworkFunc /\<Panorama\:insertItem\>/
syn match wonderFrameworkFunc /\<Panorama\:removeItem\>/
syn match wonderFrameworkFunc /\<Panorama\:removeAllItems\>/
syn match wonderFrameworkFunc /\<Panorama\:loadItem\>/
syn match wonderFrameworkFunc /\<Panorama\:setCurItem\>/
syn match wonderFrameworkFunc /\<Panorama\:getCurItem\>/
syn match wonderFrameworkFunc /\<Panorama\:adjust\>/
syn match wonderFrameworkFunc /\<ScrollBar\:getPos\>/
syn match wonderFrameworkFunc /\<ScrollBar\:getMaxSize\>/
syn match wonderFrameworkFunc /\<ScrollBar\:getSplider\>/
syn match wonderFrameworkFunc /\<ScrollBar\:ajust\>/
syn match wonderFrameworkFunc /\<Config\:load\>/
syn match wonderFrameworkFunc /\<Config\:get\>/
syn match wonderFrameworkFunc /\<Config\:set\>/
syn match wonderFrameworkFunc /\<Config\:delete\>/
syn match wonderFrameworkFunc /\<Config\:getSdkVersion\>/
syn match wonderFrameworkFunc /\<Config\:getAppVersion\>/
syn match wonderFrameworkFunc /\<Config\:getAppName\>/
syn match wonderFrameworkFunc /\<Config\:getResolution\>/
syn match wonderFrameworkFunc /\<Http\:request\>/
syn match wonderFrameworkFunc /\<Http\:jsonDecode\>/
syn match wonderFrameworkFunc /\<Http\:xmlDecode\>/
syn match wonderFrameworkFunc /\<Http\:_getHandle\>/
syn match wonderFrameworkFunc /\<Http\:getNetworkStatus\>/
syn match wonderFrameworkFunc /\<Http\:setPackingUrl\>/
syn match wonderFrameworkFunc /\<Http\:startNetwork\>/
syn match wonderFrameworkFunc /\<Http\:stopNetwork\>/
syn match wonderFrameworkFunc /\<Http\:connectCMWAP\>/
syn match wonderFrameworkFunc /\<Http\:connectWLAN\>/
syn match wonderFrameworkFunc /\<Http\:getCurConnect\>/
syn match wonderFrameworkFunc /\<Http\:requestDynamicPwd\>/
syn match wonderFrameworkFunc /\<Http\:setCMCCAccount\>/
syn match wonderFrameworkFunc /\<Http\:getCMCCLoginResult\>/
syn match wonderFrameworkFunc /\<Http\:setPreResourceUrl\>/
syn match wonderFrameworkFunc /\<Http\:setProxy\>/
syn match wonderFrameworkFunc /\<Http\:getCurrentAPNType\>/
syn match wonderFrameworkFunc /\<WLAN\:isAttach\>/
syn match wonderFrameworkFunc /\<WLAN\:isSwitchOn\>/
syn match wonderFrameworkFunc /\<WLAN\:getAvailable\>/
syn match wonderFrameworkFunc /\<WLAN\:isPortal\>/
syn match wonderFrameworkFunc /\<WLAN\:haveLogin\>/
syn match wonderFrameworkFunc /\<WLAN\:setEnable\>/
syn match wonderFrameworkFunc /\<WLAN\:setUrl\>/
syn match wonderFrameworkFunc /\<Dialog\:show\>/
syn match wonderFrameworkFunc /\<Dialog\:close\>/
syn match wonderFrameworkFunc /\<Dialog\:isShow\>/
syn match wonderFrameworkFunc /\<Dialog\:_set\>/
syn match wonderFrameworkFunc /\<Loading\:show\>/
syn match wonderFrameworkFunc /\<Loading\:close\>/
syn match wonderFrameworkFunc /\<Loading\:isShow\>/
syn match wonderFrameworkFunc /\<Loading\:_set\>/
syn match wonderFrameworkFunc /\<Download\:getStatus\>/
syn match wonderFrameworkFunc /\<Download\:getCount\>/
syn match wonderFrameworkFunc /\<Download\:append\>/
syn match wonderFrameworkFunc /\<Download\:start\>/
syn match wonderFrameworkFunc /\<Download\:pause\>/
syn match wonderFrameworkFunc /\<Download\:delete\>/
syn match wonderFrameworkFunc /\<Download\:deleteByName\>/
syn match wonderFrameworkFunc /\<Download\:getIndexById\>/
syn match wonderFrameworkFunc /\<Download\:_getHandle\>/
syn match wonderFrameworkFunc /\<Ebook\:create\>/
syn match wonderFrameworkFunc /\<Ebook\:open\>/
syn match wonderFrameworkFunc /\<Ebook\:show\>/
syn match wonderFrameworkFunc /\<Ebook\:getSumm\>/
syn match wonderFrameworkFunc /\<Ebook\:getCate\>/
syn match wonderFrameworkFunc /\<Ebook\:read\>/
syn match wonderFrameworkFunc /\<Ebook\:_getHandle\>/
syn match wonderFrameworkFunc /\<Player\:create\>/
syn match wonderFrameworkFunc /\<Player\:getStatus\>/
syn match wonderFrameworkFunc /\<Player\:getCurTime\>/
syn match wonderFrameworkFunc /\<Player\:getTotalTime\>/
syn match wonderFrameworkFunc /\<Player\:getBufferPercent\>/
syn match wonderFrameworkFunc /\<Player\:play\>/
syn match wonderFrameworkFunc /\<Player\:pause\>/
syn match wonderFrameworkFunc /\<Player\:open\>/
syn match wonderFrameworkFunc /\<Player\:stop\>/
syn match wonderFrameworkFunc /\<Player\:setFullScreen\>/
syn match wonderFrameworkFunc /\<Player\:volumeDown\>/
syn match wonderFrameworkFunc /\<Player\:volumeUp\>/
syn match wonderFrameworkFunc /\<Player\:seek\>/
syn match wonderFrameworkFunc /\<Player\:show\>/
syn match wonderFrameworkFunc /\<Player\:_getHandle\>/
syn match wonderFrameworkFunc /\<Scene\:go\>/
syn match wonderFrameworkFunc /\<Scene\:add2pool\>/
syn match wonderFrameworkFunc /\<Scene\:getNameByHandle\>/
syn match wonderFrameworkFunc /\<Scene\:getHandleByName\>/
syn match wonderFrameworkFunc /\<Scene\:freeByHandle\>/
syn match wonderFrameworkFunc /\<Scene\:freeByName\>/
syn match wonderFrameworkFunc /\<Scene\:setReturn\>/
syn match wonderFrameworkFunc /\<Scene\:clearPageStack\>/
syn match wonderFrameworkFunc /\<Scene\:back\>/
syn match wonderFrameworkFunc /\<Scene\:create\>/
syn match wonderFrameworkFunc /\<Scene\:exit\>/
syn match wonderFrameworkFunc /\<Sync\:init\>/
syn match wonderFrameworkFunc /\<Sync\:setServer\>/
syn match wonderFrameworkFunc /\<Sync\:setLocal\>/
syn match wonderFrameworkFunc /\<Sync\:register\>/
syn match wonderFrameworkFunc /\<Sync\:login\>/
syn match wonderFrameworkFunc /\<Sync\:logout\>/
syn match wonderFrameworkFunc /\<Sync\:changePwd\>/
syn match wonderFrameworkFunc /\<Sync\:start\>/
syn match wonderFrameworkFunc /\<Sync\:stop\>/
syn match wonderFrameworkFunc /\<Sync\:getStatus\>/
syn match wonderFrameworkFunc /\<Sync\:_getHandle\>/
syn match wonderFrameworkFunc /\<Upload\:getStatus\>/
syn match wonderFrameworkFunc /\<Upload\:getCount\>/
syn match wonderFrameworkFunc /\<Upload\:append\>/
syn match wonderFrameworkFunc /\<Upload\:pause\>/
syn match wonderFrameworkFunc /\<Upload\:start\>/
syn match wonderFrameworkFunc /\<Upload\:delete\>/
syn match wonderFrameworkFunc /\<Upload\:_getHandle\>/
syn match wonderFrameworkFunc /\<Plugin\:create\>/
syn match wonderFrameworkFunc /\<Plugin\:release\>/
syn match wonderFrameworkFunc /\<Plugin\:invoke\>/
syn match wonderFrameworkFunc /\<Plugin\:getOberver\>/
syn match wonderFrameworkFunc /\<Plugin\:install\>/
syn match wonderFrameworkFunc /\<Plugin\:uninstall\>/
syn match wonderFrameworkFunc /\<Plugin\:getTotalCount\>/
syn match wonderFrameworkFunc /\<Plugin\:getInfoByIndex\>/
syn match wonderFrameworkFunc /\<Plugin\:getInfoByName\>/
syn match wonderFrameworkFunc /\<Plugin\:changeStatus\>/
syn match wonderFrameworkFunc /\<Param\:getCount\>/
syn match wonderFrameworkFunc /\<Param\:getType\>/
syn match wonderFrameworkFunc /\<Param\:getNumber\>/
syn match wonderFrameworkFunc /\<Param\:getInteger\>/
syn match wonderFrameworkFunc /\<Param\:getString\>/
syn match wonderFrameworkFunc /\<Param\:getData\>/
syn match wonderFrameworkFunc /\<IO\:openDir\>/
syn match wonderFrameworkFunc /\<IO\:dirExist\>/
syn match wonderFrameworkFunc /\<IO\:dirCreate\>/
syn match wonderFrameworkFunc /\<IO\:dirRemove\>/
syn match wonderFrameworkFunc /\<IO\:dirCopy\>/
syn match wonderFrameworkFunc /\<IO\:fileExist\>/
syn match wonderFrameworkFunc /\<IO\:fileCreate\>/
syn match wonderFrameworkFunc /\<IO\:fileRemove\>/
syn match wonderFrameworkFunc /\<IO\:fileRename\>/
syn match wonderFrameworkFunc /\<IO\:fileRead\>/
syn match wonderFrameworkFunc /\<IO\:fileWrite\>/
syn match wonderFrameworkFunc /\<IO\:fileCopy\>/
syn match wonderFrameworkFunc /\<IO\:fileReadToTable\>/
syn match wonderFrameworkFunc /\<IO\:fileSize\>/
syn match wonderFrameworkFunc /\<IO\:fileExt\>/
syn match wonderFrameworkFunc /\<Util\:isValidHandle\>/
syn match wonderFrameworkFunc /\<Util\:split\>/
syn match wonderFrameworkFunc /\<Util\:isAppStart\>/
syn match wonderFrameworkFunc /\<Util\:getCurTime\>/
syn match wonderFrameworkFunc /\<Util\:parseTime\>/
syn match wonderFrameworkFunc /\<Util\:getPlayerInfo\>/
syn match wonderFrameworkFunc /\<Util\:unzip\>/
syn match wonderFrameworkFunc /\<Util\:setCurAppId\>/
syn match wonderFrameworkFunc /\<Util\:getCurAppId\>/
syn match wonderFrameworkFunc /\<Util\:openContactDialog\>/
syn match wonderFrameworkFunc /\<Util\:md5\>/
syn match wonderFrameworkFunc /\<Util\:getDefaultFolder\>/
syn match wonderFrameworkFunc /\<Util\:isAppPassiveStart\>/
syn match wonderFrameworkFunc /\<Util\:sendSMS\>/
syn match wonderFrameworkFunc /\<Util\:installApp\>/
syn match wonderFrameworkFunc /\<Util\:installAppEx\>/
syn match wonderFrameworkFunc /\<Util\:uninstallApp\>/
syn match wonderFrameworkFunc /\<Util\:runApp\>/
syn match wonderFrameworkFunc /\<Util\:createMirrorImage\>/
syn match wonderFrameworkFunc /\<Util\:removeMirrorImage\>/
syn match wonderFrameworkFunc /\<Util\:codeString\>/
syn match wonderFrameworkFunc /\<Util\:getCachePath\>/
syn match wonderFrameworkFunc /\<Log\:write\>/
syn match wonderFrameworkFunc /\<Timer\:set\>/
syn match wonderFrameworkFunc /\<Timer\:cancel\>/
syn match wonderFrameworkFunc /\<Json\:loadString2Table\>/
syn match wonderFrameworkFunc /\<Json\:loadFile2Table\>/
syn match wonderFrameworkFunc /\<Xml\:loadString\>/
syn match wonderFrameworkFunc /\<Xml\:save2String\>/
syn match wonderFrameworkFunc /\<Xml\:loadFile\>/
syn match wonderFrameworkFunc /\<Xml\:save2File\>/
syn match wonderFrameworkFunc /\<Xml\:newElement\>/
syn match wonderFrameworkFunc /\<Xml\:release\>/
syn match wonderFrameworkFunc /\<Xml\:findElement\>/
syn match wonderFrameworkFunc /\<Xml\:deleteElementAttr\>/
syn match wonderFrameworkFunc /\<Xml\:getElementAttr\>/
syn match wonderFrameworkFunc /\<Xml\:setElementAttr\>/
syn match wonderFrameworkFunc /\<Xml\:getElementAttrCount\>/
syn match wonderFrameworkFunc /\<Xml\:getElementAttrByIndex\>/
syn match wonderFrameworkFunc /\<Xml\:add\>/
syn match wonderFrameworkFunc /\<Xml\:remove\>/
syn match wonderFrameworkFunc /\<Xml\:delete\>/
syn match wonderFrameworkFunc /\<Xml\:getText\>/
syn match wonderFrameworkFunc /\<Xml\:loadFile2Table\>/
syn match wonderFrameworkFunc /\<Xml\:loadString2Table\>/
syn match wonderFrameworkFunc /\<Reg\:trace\>/
syn match wonderFrameworkFunc /\<Reg\:create\>/
syn match wonderFrameworkFunc /\<Reg\:release\>/
syn match wonderFrameworkFunc /\<Reg\:load\>/
syn match wonderFrameworkFunc /\<Reg\:save\>/
syn match wonderFrameworkFunc /\<Reg\:remove\>/
syn match wonderFrameworkFunc /\<Reg\:clear\>/
syn match wonderFrameworkFunc /\<Reg\:setNumber\>/
syn match wonderFrameworkFunc /\<Reg\:getNumber\>/
syn match wonderFrameworkFunc /\<Reg\:setInteger\>/
syn match wonderFrameworkFunc /\<Reg\:getInteger\>/
syn match wonderFrameworkFunc /\<Reg\:setString\>/
syn match wonderFrameworkFunc /\<Reg\:getString\>/
syn match wonderFrameworkFunc /\<System\:runApp\>/
syn match wonderFrameworkFunc /\<System\:getEngineVersion\>/
syn match wonderFrameworkFunc /\<System\:getSdkVersion\>/
syn match wonderFrameworkFunc /\<System\:setFontSize\>/
syn match wonderFrameworkFunc /\<System\:getTextSize\>/
syn match wonderFrameworkFunc /\<System\:getScreenSize\>/
syn match wonderFrameworkFunc /\<System\:getUserAgent\>/
syn match wonderFrameworkFunc /\<System\:getMachineInfo\>/
syn match wonderFrameworkFunc /\<System\:getPhoneNumber\>/
syn match wonderFrameworkFunc /\<System\:setBrightness\>/
syn match wonderFrameworkFunc /\<System\:startMonitor\>/
syn match wonderFrameworkFunc /\<System\:stopMonitor\>/
syn match wonderFrameworkFunc /\<System\:getTickTime\>/
syn match wonderFrameworkFunc /\<System\:getDiskFreeSpaceEx\>/
syn match wonderFrameworkFunc /\<System\:getFlashCardName\>/
syn match wonderFrameworkFunc /\<System\:changeSkin\>/
syn match wonderFrameworkFunc /\<Sprite\:getRoot\>/
syn match wonderFrameworkFunc /\<Sprite\:getCurScene\>/
syn match wonderFrameworkFunc /\<Sprite\:setCurScene\>/
syn match wonderFrameworkFunc /\<Sprite\:loadFromXml\>/
syn match wonderFrameworkFunc /\<Sprite\:loadFromNode\>/
syn match wonderFrameworkFunc /\<Sprite\:loadFromSprite\>/
syn match wonderFrameworkFunc /\<Sprite\:loadFromString\>/
syn match wonderFrameworkFunc /\<Sprite\:free\>/
syn match wonderFrameworkFunc /\<Sprite\:getParent\>/
syn match wonderFrameworkFunc /\<Sprite\:findChild\>/
syn match wonderFrameworkFunc /\<Sprite\:getData\>/
syn match wonderFrameworkFunc /\<Sprite\:findChildByClass\>/
syn match wonderFrameworkFunc /\<Sprite\:clearChild\>/
syn match wonderFrameworkFunc /\<Sprite\:create\>/
syn match wonderFrameworkFunc /\<Sprite\:setProperty\>/
syn match wonderFrameworkFunc /\<Sprite\:getProperty\>/
syn match wonderFrameworkFunc /\<Sprite\:getText\>/
syn match wonderFrameworkFunc /\<Sprite\:isKindOf\>/
syn match wonderFrameworkFunc /\<Sprite\:addChild\>/
syn match wonderFrameworkFunc /\<Sprite\:removeChild\>/
syn match wonderFrameworkFunc /\<Sprite\:walkThrough\>/
syn match wonderFrameworkFunc /\<Sprite\:getLevel\>/
syn match wonderFrameworkFunc /\<Sprite\:setName\>/
syn match wonderFrameworkFunc /\<Sprite\:getName\>/
syn match wonderFrameworkFunc /\<Sprite\:getRect\>/
syn match wonderFrameworkFunc /\<Sprite\:setRect\>/
syn match wonderFrameworkFunc /\<Sprite\:isEnable\>/
syn match wonderFrameworkFunc /\<Sprite\:setEnable\>/
syn match wonderFrameworkFunc /\<Sprite\:isVisible\>/
syn match wonderFrameworkFunc /\<Sprite\:setVisible\>/
syn match wonderFrameworkFunc /\<Sprite\:isActive\>/
syn match wonderFrameworkFunc /\<Sprite\:setActive\>/
syn match wonderFrameworkFunc /\<Sprite\:isFocused\>/
syn match wonderFrameworkFunc /\<Sprite\:setFocus\>/
syn match wonderFrameworkFunc /\<Sprite\:killFocus\>/
syn match wonderFrameworkFunc /\<Sprite\:setCapture\>/
syn match wonderFrameworkFunc /\<Sprite\:releaseCapture\>/
syn match wonderFrameworkFunc /\<Sprite\:sendEvent\>/
syn match wonderFrameworkFunc /\<Sprite\:ajust\>/
syn match wonderFrameworkFunc /\<Sprite\:traceTree\>/
syn match wonderFrameworkFunc /\<Sprite\:getCurFocus\>/
syn match wonderFrameworkFunc /\<Sprite\:addKeyList\>/
syn match wonderFrameworkFunc /\<Sprite\:setLayoutType\>/
syn match wonderFrameworkFunc /\<Sprite\:setOnKeyVisible\>/
syn match wonderFrameworkFunc /\<Gallery\:getItemCount\>/
syn match wonderFrameworkFunc /\<Gallery\:getItem\>/
syn match wonderFrameworkFunc /\<Gallery\:addItem\>/
syn match wonderFrameworkFunc /\<Gallery\:insertItem\>/
syn match wonderFrameworkFunc /\<Gallery\:removeItem\>/
syn match wonderFrameworkFunc /\<Gallery\:removeAllItems\>/
syn match wonderFrameworkFunc /\<Gallery\:loadItem\>/
syn match wonderFrameworkFunc /\<Gallery\:setCurItem\>/
syn match wonderFrameworkFunc /\<Gallery\:getCurItem\>/
syn match wonderFrameworkFunc /\<Gallery\:adjust\>/
syn match wonderFrameworkFunc /\<List\:getItemCount\>/
syn match wonderFrameworkFunc /\<List\:getItem\>/
syn match wonderFrameworkFunc /\<List\:addItem\>/
syn match wonderFrameworkFunc /\<List\:insertItem\>/
syn match wonderFrameworkFunc /\<List\:removeItem\>/
syn match wonderFrameworkFunc /\<List\:removeAllItems\>/
syn match wonderFrameworkFunc /\<List\:loadItem\>/
syn match wonderFrameworkFunc /\<List\:setCurItem\>/
syn match wonderFrameworkFunc /\<List\:getCurItem\>/
syn match wonderFrameworkFunc /\<List\:getLineCount\>/
syn match wonderFrameworkFunc /\<List\:getColCount\>/
syn match wonderFrameworkFunc /\<List\:getItemsCountPerPage\>/
syn match wonderFrameworkFunc /\<List\:getStartIndex\>/
syn match wonderFrameworkFunc /\<List\:setStartIndex\>/
syn match wonderFrameworkFunc /\<List\:adjust\>/
syn match wonderFrameworkFunc /\<List\:setItemIndex\>/
syn match wonderFrameworkFunc /\<List\:getItemIndex\>/
syn match wonderFrameworkFunc /\<ListView\:getItemCount\>/
syn match wonderFrameworkFunc /\<ListView\:getItem\>/
syn match wonderFrameworkFunc /\<ListView\:addItem\>/
syn match wonderFrameworkFunc /\<ListView\:insertItem\>/
syn match wonderFrameworkFunc /\<ListView\:removeItem\>/
syn match wonderFrameworkFunc /\<ListView\:removeAllItems\>/
syn match wonderFrameworkFunc /\<ListView\:loadItem\>/
syn match wonderFrameworkFunc /\<ListView\:setCurItem\>/
syn match wonderFrameworkFunc /\<ListView\:getCurItem\>/
syn match wonderFrameworkFunc /\<ListView\:adjust\>/
syn match wonderFrameworkFunc /\<ListView\:setItemToTop\>/
syn match wonderFrameworkFunc /\<ListView\:getItemIndex\>/
syn match wonderFrameworkFunc /\<ListView\:setItemIndex\>/
syn match wonderFrameworkFunc /\<Coverflow\:getItemCount\>/
syn match wonderFrameworkFunc /\<Coverflow\:getItem\>/
syn match wonderFrameworkFunc /\<Coverflow\:addItem\>/
syn match wonderFrameworkFunc /\<Coverflow\:insertItem\>/
syn match wonderFrameworkFunc /\<Coverflow\:removeItem\>/
syn match wonderFrameworkFunc /\<Coverflow\:removeAllItems\>/
syn match wonderFrameworkFunc /\<Coverflow\:loadItem\>/
syn match wonderFrameworkFunc /\<Coverflow\:setCurItem\>/
syn match wonderFrameworkFunc /\<Coverflow\:getCurItem\>/
syn match wonderFrameworkFunc /\<Coverflow\:adjust\>/
syn match wonderFrameworkFunc /\<Panorama\:getItemCount\>/
syn match wonderFrameworkFunc /\<Panorama\:getItem\>/
syn match wonderFrameworkFunc /\<Panorama\:addItem\>/
syn match wonderFrameworkFunc /\<Panorama\:insertItem\>/
syn match wonderFrameworkFunc /\<Panorama\:removeItem\>/
syn match wonderFrameworkFunc /\<Panorama\:removeAllItems\>/
syn match wonderFrameworkFunc /\<Panorama\:loadItem\>/
syn match wonderFrameworkFunc /\<Panorama\:setCurItem\>/
syn match wonderFrameworkFunc /\<Panorama\:getCurItem\>/
syn match wonderFrameworkFunc /\<Panorama\:adjust\>/
syn match wonderFrameworkFunc /\<ScrollBar\:getPos\>/
syn match wonderFrameworkFunc /\<ScrollBar\:getMaxSize\>/
syn match wonderFrameworkFunc /\<ScrollBar\:getSplider\>/
syn match wonderFrameworkFunc /\<ScrollBar\:ajust\>/
syn match wonderFrameworkFunc /\<Config\:load\>/
syn match wonderFrameworkFunc /\<Config\:get\>/
syn match wonderFrameworkFunc /\<Config\:set\>/
syn match wonderFrameworkFunc /\<Config\:delete\>/
syn match wonderFrameworkFunc /\<Config\:getSdkVersion\>/
syn match wonderFrameworkFunc /\<Config\:getAppVersion\>/
syn match wonderFrameworkFunc /\<Config\:getAppName\>/
syn match wonderFrameworkFunc /\<Config\:getResolution\>/
syn match wonderFrameworkFunc /\<Http\:request\>/
syn match wonderFrameworkFunc /\<Http\:jsonDecode\>/
syn match wonderFrameworkFunc /\<Http\:xmlDecode\>/
syn match wonderFrameworkFunc /\<Http\:getNetworkStatus\>/
syn match wonderFrameworkFunc /\<Http\:setPackingUrl\>/
syn match wonderFrameworkFunc /\<Http\:startNetwork\>/
syn match wonderFrameworkFunc /\<Http\:stopNetwork\>/
syn match wonderFrameworkFunc /\<Http\:connectCMWAP\>/
syn match wonderFrameworkFunc /\<Http\:connectWLAN\>/
syn match wonderFrameworkFunc /\<Http\:getCurConnect\>/
syn match wonderFrameworkFunc /\<Http\:requestDynamicPwd\>/
syn match wonderFrameworkFunc /\<Http\:setCMCCAccount\>/
syn match wonderFrameworkFunc /\<Http\:getCMCCLoginResult\>/
syn match wonderFrameworkFunc /\<WLAN\:isAttach\>/
syn match wonderFrameworkFunc /\<WLAN\:isSwitchOn\>/
syn match wonderFrameworkFunc /\<WLAN\:getAvailable\>/
syn match wonderFrameworkFunc /\<WLAN\:isPortal\>/
syn match wonderFrameworkFunc /\<WLAN\:haveLogin\>/
syn match wonderFrameworkFunc /\<WLAN\:setEnable\>/
syn match wonderFrameworkFunc /\<Dialog\:show\>/
syn match wonderFrameworkFunc /\<Dialog\:close\>/
syn match wonderFrameworkFunc /\<Dialog\:isShow\>/
syn match wonderFrameworkFunc /\<Loading\:show\>/
syn match wonderFrameworkFunc /\<Loading\:close\>/
syn match wonderFrameworkFunc /\<Loading\:isShow\>/
syn match wonderFrameworkFunc /\<Download\:getStatus\>/
syn match wonderFrameworkFunc /\<Download\:getCount\>/
syn match wonderFrameworkFunc /\<Download\:append\>/
syn match wonderFrameworkFunc /\<Download\:start\>/
syn match wonderFrameworkFunc /\<Download\:pause\>/
syn match wonderFrameworkFunc /\<Download\:delete\>/
syn match wonderFrameworkFunc /\<Download\:deleteByName\>/
syn match wonderFrameworkFunc /\<Download\:getIndexById\>/
syn match wonderFrameworkFunc /\<Ebook\:create\>/
syn match wonderFrameworkFunc /\<Ebook\:open\>/
syn match wonderFrameworkFunc /\<Ebook\:show\>/
syn match wonderFrameworkFunc /\<Ebook\:getSumm\>/
syn match wonderFrameworkFunc /\<Ebook\:getCate\>/
syn match wonderFrameworkFunc /\<Ebook\:read\>/
syn match wonderFrameworkFunc /\<Player\:create\>/
syn match wonderFrameworkFunc /\<Player\:getStatus\>/
syn match wonderFrameworkFunc /\<Player\:getCurTime\>/
syn match wonderFrameworkFunc /\<Player\:getTotalTime\>/
syn match wonderFrameworkFunc /\<Player\:getBufferPercent\>/
syn match wonderFrameworkFunc /\<Player\:play\>/
syn match wonderFrameworkFunc /\<Player\:pause\>/
syn match wonderFrameworkFunc /\<Player\:open\>/
syn match wonderFrameworkFunc /\<Player\:stop\>/
syn match wonderFrameworkFunc /\<Player\:setFullScreen\>/
syn match wonderFrameworkFunc /\<Player\:volumeDown\>/
syn match wonderFrameworkFunc /\<Player\:volumeUp\>/
syn match wonderFrameworkFunc /\<Player\:seek\>/
syn match wonderFrameworkFunc /\<Player\:show\>/
syn match wonderFrameworkFunc /\<Scene\:go\>/
syn match wonderFrameworkFunc /\<Scene\:add2pool\>/
syn match wonderFrameworkFunc /\<Scene\:getNameByHandle\>/
syn match wonderFrameworkFunc /\<Scene\:getHandleByName\>/
syn match wonderFrameworkFunc /\<Scene\:freeByHandle\>/
syn match wonderFrameworkFunc /\<Scene\:freeByName\>/
syn match wonderFrameworkFunc /\<Scene\:setReturn\>/
syn match wonderFrameworkFunc /\<Scene\:clearPageStack\>/
syn match wonderFrameworkFunc /\<Scene\:back\>/
syn match wonderFrameworkFunc /\<Scene\:create\>/
syn match wonderFrameworkFunc /\<Scene\:exit\>/
syn match wonderFrameworkFunc /\<Sync\:init\>/
syn match wonderFrameworkFunc /\<Sync\:setServer\>/
syn match wonderFrameworkFunc /\<Sync\:setLocal\>/
syn match wonderFrameworkFunc /\<Sync\:register\>/
syn match wonderFrameworkFunc /\<Sync\:login\>/
syn match wonderFrameworkFunc /\<Sync\:logout\>/
syn match wonderFrameworkFunc /\<Sync\:changePwd\>/
syn match wonderFrameworkFunc /\<Sync\:start\>/
syn match wonderFrameworkFunc /\<Sync\:stop\>/
syn match wonderFrameworkFunc /\<Sync\:getStatus\>/
syn match wonderFrameworkFunc /\<Upload\:getStatus\>/
syn match wonderFrameworkFunc /\<Upload\:getCount\>/
syn match wonderFrameworkFunc /\<Upload\:append\>/
syn match wonderFrameworkFunc /\<Upload\:pause\>/
syn match wonderFrameworkFunc /\<Upload\:start\>/
syn match wonderFrameworkFunc /\<Upload\:delete\>/


syn keyword luaFunc assert collectgarbage dofile error next
syn keyword luaFunc print rawget rawset tonumber tostring type _VERSION

if lua_version == 4
  syn keyword luaFunc _ALERT _ERRORMESSAGE gcinfo
  syn keyword luaFunc call copytagmethods dostring
  syn keyword luaFunc foreach foreachi getglobal getn
  syn keyword luaFunc gettagmethod globals newtag
  syn keyword luaFunc setglobal settag settagmethod sort
  syn keyword luaFunc tag tinsert tremove
  syn keyword luaFunc _INPUT _OUTPUT _STDIN _STDOUT _STDERR
  syn keyword luaFunc openfile closefile flush seek
  syn keyword luaFunc setlocale execute remove rename tmpname
  syn keyword luaFunc getenv date clock exit
  syn keyword luaFunc readfrom writeto appendto read write
  syn keyword luaFunc PI abs sin cos tan asin
  syn keyword luaFunc acos atan atan2 ceil floor
  syn keyword luaFunc mod frexp ldexp sqrt min max log
  syn keyword luaFunc log10 exp deg rad random
  syn keyword luaFunc randomseed strlen strsub strlower strupper
  syn keyword luaFunc strchar strrep ascii strbyte
  syn keyword luaFunc format strfind gsub
  syn keyword luaFunc getinfo getlocal setlocal setcallhook setlinehook
elseif lua_version == 5
  " Not sure if all these functions need to be highlighted...
  syn keyword luaFunc _G getfenv getmetatable ipairs loadfile
  syn keyword luaFunc loadstring pairs pcall rawequal
  syn keyword luaFunc require setfenv setmetatable unpack xpcall
  "if lua_subversion == 0
    syn keyword luaFunc gcinfo loadlib LUA_PATH _LOADED _REQUIREDNAME
  "elseif lua_subversion == 1
    syn keyword luaFunc load module select
    syn match luaFunc /package\.cpath/
    syn match luaFunc /package\.loaded/
    syn match luaFunc /package\.loadlib/
    syn match luaFunc /package\.path/
    syn match luaFunc /package\.preload/
    syn match luaFunc /package\.seeall/
    syn match luaFunc /coroutine\.running/
  "endif
  syn match   luaFunc /coroutine\.create/
  syn match   luaFunc /coroutine\.resume/
  syn match   luaFunc /coroutine\.status/
  syn match   luaFunc /coroutine\.wrap/
  syn match   luaFunc /coroutine\.yield/
  syn match   luaFunc /string\.byte/
  syn match   luaFunc /string\.char/
  syn match   luaFunc /string\.dump/
  syn match   luaFunc /string\.find/
  syn match   luaFunc /string\.len/
  syn match   luaFunc /string\.lower/
  syn match   luaFunc /string\.rep/
  syn match   luaFunc /string\.sub/
  syn match   luaFunc /string\.upper/
  syn match   luaFunc /string\.format/
  syn match   luaFunc /string\.gsub/
  "if lua_subversion == 0
    syn match luaFunc /string\.gfind/
    syn match luaFunc /table\.getn/
    syn match luaFunc /table\.setn/
    syn match luaFunc /table\.foreach/
    syn match luaFunc /table\.foreachi/
  "elseif lua_subversion == 1
    syn match luaFunc /string\.gmatch/
    syn match luaFunc /string\.match/
    syn match luaFunc /string\.reverse/
    syn match luaFunc /table\.maxn/
  "endif
  syn match   luaFunc /table\.concat/
  syn match   luaFunc /table\.sort/
  syn match   luaFunc /table\.insert/
  syn match   luaFunc /table\.remove/
  syn match   luaFunc /math\.abs/
  syn match   luaFunc /math\.acos/
  syn match   luaFunc /math\.asin/
  syn match   luaFunc /math\.atan/
  syn match   luaFunc /math\.atan2/
  syn match   luaFunc /math\.ceil/
  syn match   luaFunc /math\.sin/
  syn match   luaFunc /math\.cos/
  syn match   luaFunc /math\.tan/
  syn match   luaFunc /math\.deg/
  syn match   luaFunc /math\.exp/
  syn match   luaFunc /math\.floor/
  syn match   luaFunc /math\.log/
  syn match   luaFunc /math\.log10/
  syn match   luaFunc /math\.max/
  syn match   luaFunc /math\.min/
  "if lua_subversion == 0
    syn match luaFunc /math\.mod/
  "elseif lua_subversion == 1
    syn match luaFunc /math\.fmod/
    syn match luaFunc /math\.modf/
    syn match luaFunc /math\.cosh/
    syn match luaFunc /math\.sinh/
    syn match luaFunc /math\.tanh/
  "endif
  syn match   luaFunc /math\.pow/
  syn match   luaFunc /math\.rad/
  syn match   luaFunc /math\.sqrt/
  syn match   luaFunc /math\.frexp/
  syn match   luaFunc /math\.ldexp/
  syn match   luaFunc /math\.random/
  syn match   luaFunc /math\.randomseed/
  syn match   luaFunc /math\.pi/
  syn match   luaFunc /io\.stdin/
  syn match   luaFunc /io\.stdout/
  syn match   luaFunc /io\.stderr/
  syn match   luaFunc /io\.close/
  syn match   luaFunc /io\.flush/
  syn match   luaFunc /io\.input/
  syn match   luaFunc /io\.lines/
  syn match   luaFunc /io\.open/
  syn match   luaFunc /io\.output/
  syn match   luaFunc /io\.popen/
  syn match   luaFunc /io\.read/
  syn match   luaFunc /io\.tmpfile/
  syn match   luaFunc /io\.type/
  syn match   luaFunc /io\.write/
  syn match   luaFunc /os\.clock/
  syn match   luaFunc /os\.date/
  syn match   luaFunc /os\.difftime/
  syn match   luaFunc /os\.execute/
  syn match   luaFunc /os\.exit/
  syn match   luaFunc /os\.getenv/
  syn match   luaFunc /os\.remove/
  syn match   luaFunc /os\.rename/
  syn match   luaFunc /os\.setlocale/
  syn match   luaFunc /os\.time/
  syn match   luaFunc /os\.tmpname/
  syn match   luaFunc /debug\.debug/
  syn match   luaFunc /debug\.gethook/
  syn match   luaFunc /debug\.getinfo/
  syn match   luaFunc /debug\.getlocal/
  syn match   luaFunc /debug\.getupvalue/
  syn match   luaFunc /debug\.setlocal/
  syn match   luaFunc /debug\.setupvalue/
  syn match   luaFunc /debug\.sethook/
  syn match   luaFunc /debug\.traceback/
  if lua_subversion == 1
    syn match luaFunc /debug\.getfenv/
    syn match luaFunc /debug\.getmetatable/
    syn match luaFunc /debug\.getregistry/
    syn match luaFunc /debug\.setfenv/
    syn match luaFunc /debug\.setmetatable/
  endif
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_lua_syntax_inits")
  if version < 508
    let did_lua_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink luaStatement		Statement
  HiLink luaRepeat		Repeat
  HiLink luaString		String
  HiLink luaString2		String
  HiLink luaNumber		Number
  HiLink luaFloat		Float
  HiLink luaOperator		Operator
  HiLink luaConstant		Constant
  HiLink luaCond		Conditional
  HiLink luaFunction		Function
  HiLink luaComment		Comment
  HiLink luaTodo		Todo
  HiLink luaTable		Structure
  HiLink luaError		Error
  HiLink luaSpecial		SpecialChar
  HiLink luaFunc		Identifier
  hi     wonderFunc             term=bold cterm=bold ctermfg=3 gui=underline guifg=indianred
  "term=bold cterm=bold ctermfg=1 gui=bold guifg=LightBlue
  hi     wonderKey              term=bold ctermfg=3 gui=bold guifg=#809BF3
  HiLink wonderFrameworkFunc    Title
  hi wonderFrameworkFunc1       term=bold ctermfg=3 guifg=#E28654 
  "term=bold ctermfg=3 guifg=#CD0797
  HiLink selfKey                SpecialKey

  delcommand HiLink
endif

let b:current_syntax = "lua"

" vim: et ts=8
