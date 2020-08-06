if (self.CavalryLogger) { CavalryLogger.start_js(["ZrL6x"]); }

__d("BugBar",["fbt","AsyncDialog","AsyncRequest","BanzaiODS","CSS","DataCollector","DOM","ErrorUtils","Event","FBLogger","Input","ReactDOM","ScreenRecordingActions","ServiceWorkerErrorUtils","SimpleXUIDialog","$","ge","isEmpty","nullthrows","promiseDone"],function(a,b,c,d,e,f,g){var h,i,j={_nub:null,_nubClasses:["bugNubInfo","bugNubWarning","bugNubFatal"],_taskTags:[],_taskSubscribers:[],_savedInput:null,_dialog:null,_form:null,_duplicate_task_title:null,_reactRoots:[],addMetadata:function(a){b("DataCollector").addMetadata(a)},getMetadata:function(){return b("DataCollector").getMetadata()},addTaskSubscribers:function(a){j._taskSubscribers=j._taskSubscribers.concat(a)},getTaskSubscribers:function(){return j._taskSubscribers},addTaskTags:function(a){j._taskTags=j._taskTags.concat(a)},getTaskTags:function(){return j._taskTags},reset:function(){b("DataCollector").reset(),this._reactRoots.forEach(function(a){b("ReactDOM").unmountComponentAtNode(a)}),this._reactRoots=[],j._taskTags=[]},cancel:function(){var a=j._dialog;j._dialog=null;j.reset();a&&a.hide()},initForm:function(a,c){a=b("nullthrows")(a.form,"Form is absent");this._form=a;if(c){var d;(d=this._reactRoots).push.apply(d,c)}this.initFormField(a.elements.logs);this.initFormField(a.elements.metadata);setTimeout(j.setProductAreaFocus,0)},isPotentialVideoDecodingReport:function(){var a="269405676539001",b=this._form.descr,c=this._form.product_category_id;c=c.options[c.selectedIndex];return c.value===a?b.value.search(/decoding|artifact|green|pixel|flicker|flashing|flashed/i)>-1:!1},initFormField:function(a){var c;if(a.name=="logs")try{a.value=b("DataCollector").collectLogs()}catch(a){b("BanzaiODS").bumpEntityKey(2966,"flytrap","client_log_failed")}else if(a.name=="metadata")try{c=b("DataCollector")._collectMetadata(),a.value=JSON.stringify(c)}catch(a){b("BanzaiODS").bumpEntityKey(2966,"flytrap","metadata_log_failed")}},initNub:function(a){this._nub=a},initScreenshotUploader:function(a,c){this._fileHandle=a;if(c){c=j._dialog;c=b("DOM").scry(c.getRoot(),"button");a.setSubmitButtons(c)}},initDescription:function(a){var c=this;b("Event").listen(a,"paste",function(a){return c._handleDescriptionPaste(a)})},_handleDescriptionPaste:function(a){var c=a.clipboardData.items;if(!c||!this._fileHandle)return;var d={};for(var e=0;e<c.length;e++)if(c[e].kind==="file"&&c[e].type.startsWith("image/")){var f=c[e].getAsFile(),i=/\.[^.]+$|$/.exec(f.name)[0];d["file"+e]=new File([f],g._("Pasted image {timestamp}",[g._param("timestamp",new Date().toISOString())])+i,{type:c[e].type})}(h||(h=b("isEmpty")))(d)||(this._fileHandle.addFilesAndSend(d),a.preventDefault())},setProductAreaFocus:function(){var a=b("DOM").scry(document.body,"select#product_category");a&&a.length&&a[0].focus()},taskCreated:function(a,c){this.cancel(),b("SimpleXUIDialog").show(c,a)},subscribeSubmit:function(a,c){var d=this;j._dialog=a;var e=!1;a.subscribe(["cancel","hide"],function(){e&&(b("ScreenRecordingActions").clearScreenRecordings(),e=!1),j.cancel()});a.subscribe(["submit"],function(){e=!0;if(d.isPotentialVideoDecodingReport()){var a=b("DOM").scry(d._form,"#bug_report_decoding_artifacts")[0];if(a&&!b("CSS").shown(a)){b("CSS").show(a);e=!1;return!1}}if(d._form.duplicate_task_id){a=d._form.duplicate_task_id.value;if(a){a="Another report of bug: "+d._duplicate_task_title;b("Input").isEmpty(c)||(a=a+"\n\nAdditional description: "+c.value);b("Input").setValue(c,a)}}if(b("Input").getValue(c).length<4){b("CSS").show(b("$")("bug_report_warning"));b("DOM").setContent(b("ge")("bug_report_warning"),g._("Please provide more details about the problem you are experiencing."));e=!1;return!1}if(d._form.product_category_id.value=="100977986739334"){b("CSS").show(b("$")("bug_report_warning"));b("DOM").setContent(b("ge")("bug_report_warning"),g._("Please select a product."));e=!1;return!1}if(d._form.querySelector('input[name="rank_bug"]:checked')){a=d._form.querySelector('input[name="rank_bug"]:checked');var f=c.value;f+="\n\nThis search result should be ranked: "+a.value;b("Input").setValue(c,f)}return!0})},fillSavedDescription:function(a){a=b("ge")(a),this._savedInput=this._savedInput||"Sorry, we lost your original description :(",b("DOM").setContent(a,this._savedInput)},hide:function(){if(j._dialog){b("CSS").hide(j._dialog.getRoot());return!0}return!1},unhide:function(){if(j._dialog){b("CSS").show(j._dialog.getRoot());var a=JSON.parse(this._form.debuginfo.value);a.additionalmetadata=a.additionalmetadata||{};Object.assign(a.additionalmetadata,j.getMetadata());this._form.debuginfo.value=JSON.stringify(a);return!0}return!1},serialize:function(){var a=this,b=function(b){b=a._form.querySelector(b);return b?b.value:null},c=b('[name="client_notifs"]'),d=b('[name="config_id"]'),e=b('[name="isTimeline"]'),f=b('[name="feed_story_identifier"]'),g=b('[name="feed_story_location"]'),h=b('[name="feed_story_object_class"]'),i=b('[name="feed_story_serialized"]'),j=b('[name="notif_alert_id"]'),k=b('[name="product_category_id"]');b=b('[name="source"]');return{client_notifs:c,config_id:d,defaultText:this._form.descr.value,isTimeline:e,feed_story_identifier:f,feed_story_location:g,feed_story_object_class:h,feed_story_serialized:i,notif_alert_id:j,product_category_id:k,source:b}},openBugDialog:function(a,c){c===void 0&&(c=!1);if(j._dialog)return!1;a=new(b("AsyncRequest"))(a);c&&a.setData({file_upload_disabled:!0});b("AsyncDialog").send(a,function(a){return a.subscribe("cancel",j.cancel)});return!0},registerMeToo:function(a,c,d,e,f){var g=this;b("Event").listen(a,"click",function(a){b("CSS").show(b("$")("bug_report_warning")),b("DOM").setContent(b("ge")("bug_report_warning"),["When you submit this bug report, it will be merged into task ",b("DOM").create("a",{href:f},"#"+d+": "+e),". It is optional to include a description. Please hit submit!"]),g._form.duplicate_task_id.value=d,g._duplicate_task_title=e})},setNubLevel:function(a){var c=this;this._nub?(this._nubClasses.forEach(function(a){return b("CSS").removeClass(c._nub,a)}),b("CSS").addClass(this._nub,this._nubClasses[a])):b("FBLogger")("flytrap").warn("The nub element hasn't been initialized")},prepareJSErrors:function(a){var b=55,c=5,d={},e=[];for(var a=a,f=Array.isArray(a),g=0,a=f?a:a[typeof Symbol==="function"?Symbol.iterator:"@@iterator"]();;){var h;if(f){if(g>=a.length)break;h=a[g++]}else{g=a.next();if(g.done)break;h=g.value}h=h;h=h.message&&h.message.substring(0,b)||"";e.length<c&&e.indexOf(h)===-1&&e.push(h);!d[h]?d[h]=1:d[h]++}h=e.map(function(a){return a+": "+d[a]}).join(", ");return h},summarizeJSErrors:function(a){var c=j.prepareJSErrors((i||(i=b("ErrorUtils"))).history);b("Input").setValue(a,c)},summarizeSWErrors:function(a){b("promiseDone")(b("ServiceWorkerErrorUtils").getHistory().then(function(c){c=j.prepareJSErrors(c);b("Input").setValue(a,c)}))}};e.exports=j},null);