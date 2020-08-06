if (self.CavalryLogger) { CavalryLogger.start_js(["kNoH3"]); }

__d("ModuleDependencies",["__debug"],function(a,b,c,d,e,f){function g(a,c,d){var e=b("__debug").modulesMap[d],f=b("__debug").deps;if(c[d])return;c[d]=!0;if(!e){f[d]&&(a[d]=!0);return}if(!e.dependencies||!e.dependencies.length){e.waiting&&(a[d]=!0);return}e.dependencies.forEach(function(b){g(a,c,b)})}function a(a){var b={};g(b,{},a);a=Object.keys(b);a.sort();return a}function c(){var a={loading:{},missing:[]},c={},d=b("__debug").getModules(),e=b("__debug").deps;for(var f in d){var h=d[f];if(h.waiting){var i={};g(i,{},h.id);delete i[h.id];a.loading[h.id]=Object.keys(i);a.loading[h.id].sort();a.loading[h.id].forEach(function(a){!(a in d)&&e[a]&&(c[a]=1)})}}a.missing=Object.keys(c);a.missing.sort();return a}d={getMissing:a,getNotLoadedModules:c};e.exports=d},null);
__d("MessagingBugReportStateUtils",["CurrentUser","ifRequired","killswitch"],function(a,b,c,d,e,f){"use strict";var g="N/A",h=function(){return g};a={getStateSnapshot:function(){var a,c=g,d=g;(a=b("ifRequired"))("ChatSidebarVisibility",function(a){c=a.isSidebarVisible(),d=a.isBuddyListVisible()});var e=g,f=g;a("MercurySyncDeltaHolder",function(a){a=a.get();e=a.getLastSeqID();f=a.getTop()||f});return{channel_connection:a("ChannelConnection",function(a){return!a.disconnected()},h),mqtt_enabled:!0,buddylist_visible:d,sidebar_visible:c,tab_id:a("ChannelClientID",function(a){return a.getID()},h),channel_host:a("ChannelManager",function(a){return a.getConfig("fullHost")+"."+a.getConfig("domain")},h),processedSeqID:e,receivedSeqID:f,messengerState:a("MessengerState.bs",function(a){if(b("killswitch")("MESSENGER_WEB_STOP_LOG_MESSENGER_STATE_INTO_BUG_REPORT"))return"";var c=b("CurrentUser").getID(),d=a.getThreadIDs_debug(c)||[],e={};d.forEach(function(d){var f=a.getCurrentlyLoadedMessages(b("CurrentUser").getID(),d);e[d]={};e[d].hasLoadedMessages=a.hasLoadedNMessages(c,d,1);Array.isArray(f)&&f.length>0&&(e[d].lastMessageID=f[f.length-1].message_id)});return JSON.stringify(e)},h)}}};e.exports=a},null);
__d("CometBugReportStateUtils",["ifRequired","recoverableViolation"],function(a,b,c,d,e,f){"use strict";f.addStateEntry=a;f.clearStateEntries=c;f.getStateSnapshot=d;var g={};function a(a,c){a in g&&b("recoverableViolation")("Key collision for key "+a+" in CometBugReportStateUtils. Use a different key to prevent overwriting existing bug report state.","comet_ui"),g[a]=c}function c(){g={}}function d(){var a,c,d,e;a=(a=b("ifRequired")("CometInteractionTracingMetrics",function(a){return a.dump()}))!=null?a:null;c=(c=b("ifRequired")("CometFeedUnitDebugInfoState",function(a){return a.getStateSnapshot()}))!=null?c:null;d=(d=b("ifRequired")("CometTailLoadDebugger",function(a){return a.dump()}))!=null?d:null;e=(e=b("ifRequired")("MWChatMultitabProvider.re",function(a){return a.getStateSnapshot()}))!=null?e:null;return babelHelpers["extends"]({},g,{CometFeedUnitDebugInfoState:c,CometInteractionTracingMetricsState:a,CometTailLoadDebuggerSnapshot:d,MWTabStateSnapshot:e})}},null);
__d("FBRTCBugReportStateUtils",["ifRequired"],function(a,b,c,d,e,f){"use strict";a={getStateSnapshot:function(){var a;return{scotchCallSummaries:(a=b("ifRequired"))("FBRTCCallSummaryStore",function(a){return a.getInstance().getCallSummaries()}),zenonCallSummaries:a("ZenonCallSummaryStore",function(a){a=a.ZenonCallSummaryStoreInstance;return a.getCallSummaries()}),fluxState:a("RTWebFluxDebugger",function(a){return a.fluxDumpState()}),zenonScotchUIState:a("ScotchCallModelEmitter",function(a){a=a.CallsModelEmitterInstance;return a.getCallsModel()}),zenonUIState:a("ZenonCallsModelEmitter",function(a){a=a.CallsModelEmitterInstance;return a.getCallsModel()})}}};e.exports=a},null);
__d("MediaStream",[],function(a,b,c,d,e,f){e.exports=window.MediaStream||window.webkitMediaStream},null);
__d("SICopyPasteTypedLogger",["Banzai","GeneratedLoggerUtils","nullthrows"],function(a,b,c,d,e,f){"use strict";a=function(){function a(){this.$1={}}var c=a.prototype;c.log=function(a){b("GeneratedLoggerUtils").log("content_matcher:SICopyPasteLoggerConfig",this.$1,b("Banzai").BASIC,a)};c.logVital=function(a){b("GeneratedLoggerUtils").log("content_matcher:SICopyPasteLoggerConfig",this.$1,b("Banzai").VITAL,a)};c.logImmediately=function(a){b("GeneratedLoggerUtils").log("content_matcher:SICopyPasteLoggerConfig",this.$1,{signal:!0},a)};c.clear=function(){this.$1={};return this};c.getData=function(){return babelHelpers["extends"]({},this.$1)};c.updateData=function(a){this.$1=babelHelpers["extends"]({},this.$1,a);return this};c.setText=function(a){this.$1.text=a;return this};c.setURL=function(a){this.$1.url=a;return this};return a}();c={text:!0,url:!0};e.exports=a},null);
__d("WorkGalahadBugReportStateUtils",["ifRequired"],function(a,b,c,d,e,f){"use strict";a={getStateSnapshot:function(){var a=b("ifRequired")("MessengerURIStore",function(a){return a}),c=b("ifRequired")("WorkGalahadNavStore",function(a){return a}),d=b("ifRequired")("WorkSkeletonState",function(a){return a});return{messenger:a?{uriState:a.getState()}:null,nav:c?{activeEntityKeys:c.getActiveEntityKeys(),stackedChannelData:c.getStackedChannelData(),selectedAppTabID:c.getSelectedAppTabID()}:null,viewport:d?g(d):null}}};function g(a){a=a.ViewportStateContext.currentValue();var b=a.entityColumnWidth,c=a.navColumnWidth,d=a.navColumnXOffset,e=a.viewportHeight;a=a.viewportWidth;return{entityColumnWidth:b,navColumnWidth:c,navColumnXOffset:d,viewportHeight:e,viewportWidth:a}}e.exports=a},null);
__d("ScreenRecordingDispatcher",["ExplicitRegistrationDispatcher"],function(a,b,c,d,e,f){"use strict";a=function(a){babelHelpers.inheritsLoose(b,a);function b(){return a.apply(this,arguments)||this}return b}(b("ExplicitRegistrationDispatcher"));e.exports=new a({strict:!0})},null);
__d("ScreenRecordingActions",["ScreenRecordingDispatcher"],function(a,b,c,d,e,f){"use strict";a={clearScreenRecordings:function(){b("ScreenRecordingDispatcher").dispatch({type:"clearScreenRecordings"})},markScreenRecordingCapabilityAsUnavailable:function(a,c){b("ScreenRecordingDispatcher").dispatch({type:"markScreenRecordingCapabilityAsUnavailable",previousScreenRecordingCapbility:c,reason:a})},registerMediaStream:function(a){b("ScreenRecordingDispatcher").dispatch({type:"registerMediaStream",mediaStream:a})},releaseMediaStream:function(){b("ScreenRecordingDispatcher").dispatch({type:"releaseMediaStream"})},requestMediaStream:function(){b("ScreenRecordingDispatcher").dispatch({type:"requestMediaStream"})},setRemoteHandleForScreenRecording:function(a,c){b("ScreenRecordingDispatcher").dispatch({type:"setScreenRecordingRemoteHandle",remoteHandle:c,timestamp:a})},uploadScreenRecording:function(a){b("ScreenRecordingDispatcher").dispatch({type:"uploadScreenRecording",recording:a})}};e.exports=a},null);
__d("SICopyPasteUtility",["EventListener","FBLogger"],function(a,b,c,d,e,f){var g={getSelectedText:function(){var a=null;window.getSelection?a=window.getSelection().toString():document.selection&&(a=document.selection.createRange().text);return String(a)},setCopyCallback:function(a){document.readyState==="loading"?b("EventListener").listen(document,"DOMContentLoaded",function(){g.setCopyEvent(a)}):g.setCopyEvent(a)},setCopyEvent:function(a){try{b("EventListener").listen(document,"copy",function(){var b=g.getSelectedText();b&&a(b)})}catch(a){b("FBLogger")("sicp").catching(a).info("failed to add logger to request")}}};e.exports=g},null);
__d("SICopyPaste",["SICopyPasteTypedLogger","SICopyPasteUtility"],function(a,b,c,d,e,f){e.exports={init:function(){b("SICopyPasteUtility").setCopyCallback(function(a){new(b("SICopyPasteTypedLogger"))().setText(a).logImmediately()})}}},null);
__d("HoverFlyout",["Arbiter","ArbiterMixin","DataStore","Event","Keys","mixin","removeFromArray","shield"],function(a,b,c,d,e,f){c=function(a){"use strict";babelHelpers.inheritsLoose(c,a);function c(c,d,e,f){var g;g=a.call(this)||this;c&&(g._showDelay=e,g._hideDelay=f,g.init(c),d&&g.initNode(d));b("Arbiter").subscribe("SwapButtonDEPRECATED/focusOnJoinButton",b("shield")(g.hideFlyout,babelHelpers.assertThisInitialized(g)),"all");return g}var d=c.prototype;d.init=function(a){this._flyout=a;this._showDelay=this._showDelay||0;this._hideDelay=this._hideDelay||100;this._showTimeout=null;this._hideTimeout=null;this._flyoutSubscriptions=[this._flyout.subscribe("mouseenter",this._onFlyoutMouseEnter.bind(this)),this._flyout.subscribe("mouseleave",b("shield")(this.hideFlyout,this))];this._nodes=[];this._dataStoreUnique="HoverFlyout_"+Date.now()+"_listeners";return this};d.initNode=function(a){if(this._nodes.includes(a))return this;this._nodes.push(a);b("DataStore").set(a,this._dataStoreUnique,[b("Event").listen(a,"mouseenter",this._onNodeMouseEnter.bind(this,a)),b("Event").listen(a,"mouseleave",b("shield")(this.hideFlyout,this)),b("Event").listen(a,"click",this._onNodeMouseEnter.bind(this,a)),b("Event").listen(a,"keydown",this._onNodeKeyEscape.bind(this))]);return this};d.deactivateNode=function(a){var c=b("DataStore").get(a,this._dataStoreUnique);if(c)while(c.length)c.pop().remove();b("removeFromArray")(this._nodes,a)};d.setShowDelay=function(a){this._showDelay=a;return this};d.setHideDelay=function(a){this._hideDelay=a;return this};d.showFlyout=function(a,b){this.setActiveNode(a);b?(this._flyout.setContext(a).show(),this.inform("show",a)):this._showTimeout=setTimeout(this.showFlyout.bind(this,a,!0),this._showDelay);return this};d.hideFlyout=function(a){clearTimeout(this._showTimeout),a?(this._flyout.hide(),this._activeNode&&this.inform("hide",this._activeNode),this._activeNode=null):this._hideTimeout=setTimeout(this.hideFlyout.bind(this,!0),this._hideDelay)};d.hideFlyoutDelayed=function(a){clearTimeout(this._showTimeout),clearTimeout(this._hideTimeout),this._hideTimeout=setTimeout(this.hideFlyout.bind(this,!0),a)};d.getActiveNode=function(){return this._activeNode};d.setActiveNode=function(a){clearTimeout(this._hideTimeout);this._activeNode&&this._activeNode!==a&&this.hideFlyout(!0);this._activeNode=a;return this};d.clearNodes=function(){for(var a=this._nodes.length;a>0;a--)this.deactivateNode(this._nodes[a-1])};d.destroy=function(){while(this._flyoutSubscriptions.length)this._flyout.unsubscribe(this._flyoutSubscriptions.pop());this.clearNodes()};d._onNodeMouseEnter=function(a){this._activeNode===a?clearTimeout(this._hideTimeout):this.showFlyout(a)};d._onFlyoutMouseEnter=function(){clearTimeout(this._hideTimeout)};d._onNodeKeyEscape=function(a){b("Event").getKeyCode(a)===b("Keys").ESC&&(this._activeNode&&this.inform("hide",this._activeNode),this._activeNode=null)};return c}(b("mixin")(b("ArbiterMixin")));e.exports=a.HoverFlyout||c},null);
__d("JSSchedulerLoomProvider",["FBLogger","JSScheduler","performanceNavigationStart"],function(a,b,c,d,e,f){"use strict";var g=b("performanceNavigationStart")(),h=1,i=2,j=3,k=4,l=5,m=6,n=7,o=8,p=!0,q=function(){function a(a){a.sequenceNumber===1?this.$1=a:p||(b("JSScheduler").startEventProfiling(),p=!0,this.$1=a)}var c=a.prototype;c.loomTraceWillEnd=function(){var a=this.$1;if(a==null)return;p=!1;var c=b("JSScheduler").stopEventProfiling();if(c==null)return;c=new Int32Array(c);var d=new Map(),e=new Map();for(var f=0;f<=5;f++){var q=0;e.set(f,q);a.buffer.addEvent({type:"JS_SCHEDULER_QUEUE",priority:f,queueSize:q},a.startTime)}q=0;while(q<c.length){f=c[q];var r=g+c[q+1]/1e3;if(f===0)break;else if(f>8){b("FBLogger")("web_loom").warn("Unknown JS Scheduler profiling event: "+f);break}var s=void 0;switch(f){case h:f=c[q+2];var t=c[q+3];d.set(f,t);f=e.get(t);f!=null&&(f+=1,e.set(t,f),s={type:"JS_SCHEDULER_QUEUE",priority:t,queueSize:f});q+=4;break;case i:case j:case k:t=c[q+2];f=d.get(t);if(f!=null){var u=e.get(f);u!=null&&(u-=1,e.set(f,u),s={type:"JS_SCHEDULER_QUEUE",priority:f,queueSize:u});d["delete"](t)}q+=3;break;case n:s={type:"JS_SCHEDULER_QUEUE",priority:0,queueSize:1};q+=3;break;case o:s={type:"JS_SCHEDULER_QUEUE",priority:0,queueSize:0};q+=3;break;case l:case m:q+=4;break}s&&a.buffer.addEvent(s,r)}this.$1=null};return a}();e.exports={loomProviderId:"JSScheduler",isSupported:function(){return!0},getInstance:function(a){return new q(a)}}},null);
__d("ServiceWorkerErrorUtils",["Promise","ClientServiceWorkerMessage","ServiceWorkerRegistration"],function(a,b,c,d,e,f){a={getHistory:function(){if(!b("ServiceWorkerRegistration").isSupported())return b("Promise").reject("serviceWorker or messageChannel not supported");var a=!1;return new(b("Promise"))(function(c){new(b("ClientServiceWorkerMessage"))("errordump",null,function(b){a||(a=!0,c(b.data.data.history||[]))}).sendViaController()})}};e.exports=a},null);