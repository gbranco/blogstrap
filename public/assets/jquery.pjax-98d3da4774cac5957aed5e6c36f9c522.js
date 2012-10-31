// jquery.pjax.js
// copyright chris wanstrath
// https://github.com/defunkt/jquery-pjax
(function(e){function t(e,t){return this.live("click.pjax",function(r){n(r,e,t)})}function n(t,n,i){i=l(n,i);var s=t.currentTarget;if(s.tagName.toUpperCase()!=="A")throw"$.fn.pjax or $.pjax.click requires an anchor element";if(t.which>1||t.metaKey||t.ctrlKey)return;if(location.protocol!==s.protocol||location.host!==s.host)return;if(s.hash&&s.href.replace(s.hash,"")===location.href.replace(location.hash,""))return;if(s.href===location.href+"#")return;var o={url:s.href,container:e(s).attr("data-pjax"),target:s,clickedElement:e(s),fragment:null};r(e.extend({},o,i)),t.preventDefault()}function r(t){function d(t,r){var i=e.Event(t,{relatedTarget:n});return h.trigger(i,r),!i.isDefaultPrevented()}t=e.extend(!0,{},e.ajaxSettings,r.defaults,t),e.isFunction(t.url)&&(t.url=t.url());var n=t.target;!n&&t.clickedElement&&(n=t.clickedElement[0]);var i=f(t.url).hash,s=t.beforeSend,o=t.complete,a=t.success,l=t.error,h=t.context=c(t.container);t.data||(t.data={}),t.data._pjax=h.selector;var v;t.beforeSend=function(e,n){n.type!=="GET"&&(n.timeout=0),n.timeout>0&&(v=setTimeout(function(){d("pjax:timeout",[e,t])&&e.abort("timeout")},n.timeout),n.timeout=0),e.setRequestHeader("X-PJAX","true"),e.setRequestHeader("X-PJAX-Container",h.selector);var r;if(s){r=s.apply(this,arguments);if(r===!1)return!1}if(!d("pjax:beforeSend",[e,n]))return!1;t.requestUrl=f(n.url).href},t.complete=function(e,n){v&&clearTimeout(v),o&&o.apply(this,arguments),d("pjax:complete",[e,n,t]),d("pjax:end",[e,t]),d("end.pjax",[e,t])},t.error=function(e,n,r){var i=p("",e,t);l&&l.apply(this,arguments);var s=d("pjax:error",[e,n,r,t]);n!=="abort"&&s&&window.location.replace(i.url)},t.success=function(n,s,o){var l=p(n,o,t);if(!l.contents){window.location.replace(l.url);return}r.state={id:t.id||u(),url:l.url,title:l.title,container:h.selector,fragment:t.fragment,timeout:t.timeout},(t.push||t.replace)&&window.history.replaceState(r.state,l.title,l.url),l.title&&(document.title=l.title),h.html(l.contents),typeof t.scrollTo=="number"&&e(window).scrollTop(t.scrollTo),(t.replace||t.push)&&window._gaq&&_gaq.push(["_trackPageview"]);if(i!==""){var c=f(l.url);c.hash=i,r.state.url=c.href,window.history.replaceState(r.state,l.title,c.href);var v=e(c.hash);v.length&&e(window).scrollTop(v.offset().top)}a&&a.apply(this,arguments),d("pjax:success",[n,s,o,t])},r.state||(r.state={id:u(),url:window.location.href,title:document.title,container:h.selector,fragment:t.fragment,timeout:t.timeout},window.history.replaceState(r.state,document.title));var m=r.xhr;m&&m.readyState<4&&(m.onreadystatechange=e.noop,m.abort()),r.options=t;var m=r.xhr=e.ajax(t);return m.readyState>0&&(e(document).trigger("pjax",[m,t]),t.push&&!t.replace&&(g(r.state.id,h.clone().contents()),window.history.pushState(null,"",t.url)),d("pjax:start",[m,t]),d("start.pjax",[m,t]),d("pjax:send",[m,t])),r.xhr}function i(t,n){var i={url:window.location.href,push:!1,replace:!0,scrollTo:!1};return r(e.extend(i,l(t,n)))}function s(t){var n=t.state;if(n&&n.container){var i=e(n.container);if(i.length){var s=d[n.id];if(r.state){var o=r.state.id<n.id?"forward":"back";y(o,r.state.id,i.clone().contents())}var u=e.Event("pjax:popstate",{state:n,direction:o});i.trigger(u);var a={id:n.id,url:n.url,container:i,push:!1,fragment:n.fragment,timeout:n.timeout,scrollTo:!1};s?(e(document).trigger("pjax",[null,a]),i.trigger("pjax:start",[null,a]),i.trigger("start.pjax",[null,a]),n.title&&(document.title=n.title),i.html(s),r.state=n,i.trigger("pjax:end",[null,a]),i.trigger("end.pjax",[null,a])):r(a),i[0].offsetHeight}else window.location.replace(location.href)}}function o(t){var n=e.isFunction(t.url)?t.url():t.url,r=t.type?t.type.toUpperCase():"GET",i=e("<form>",{method:r==="GET"?"GET":"POST",action:n,style:"display:none"});r!=="GET"&&r!=="POST"&&i.append(e("<input>",{type:"hidden",name:"_method",value:r.toLowerCase()}));var s=t.data;if(typeof s=="string")e.each(s.split("&"),function(t,n){var r=n.split("=");i.append(e("<input>",{type:"hidden",name:r[0],value:r[1]}))});else if(typeof s=="object")for(key in s)i.append(e("<input>",{type:"hidden",name:key,value:s[key]}));e(document.body).append(i),i.submit()}function u(){return(new Date).getTime()}function a(e){return e.replace(/\?_pjax=[^&]+&?/,"?").replace(/_pjax=[^&]+&?/,"").replace(/[\?&]$/,"")}function f(e){var t=document.createElement("a");return t.href=e,t}function l(t,n){return t&&n?n.container=t:e.isPlainObject(t)?n=t:n={container:t},n.container&&(n.container=c(n.container)),n}function c(t){t=e(t);if(!t.length)throw"no pjax container for "+t.selector;if(t.selector!==""&&t.context===document)return t;if(t.attr("id"))return e("#"+t.attr("id"));throw"cant get selector for pjax container!"}function h(t,n){var r=e();return t.each(function(){e(this).is(n)&&(r=r.add(this)),r=r.add(n,this)}),r}function p(t,n,r){var i={};i.url=a(n.getResponseHeader("X-PJAX-URL")||r.requestUrl);var s=e(t);if(s.length===0)return i;i.title=h(s,"title").last().text();if(r.fragment){var o=h(s,r.fragment).first();o.length&&(i.contents=o.contents(),i.title||(i.title=o.attr("title")||o.data("title")))}else/<html/i.test(t)||(i.contents=s);return i.contents&&(i.contents=i.contents.not("title"),i.contents.find("title").remove()),i.title&&(i.title=e.trim(i.title)),i}function g(e,t){d[e]=t,m.push(e);while(v.length)delete d[v.shift()];while(m.length>r.defaults.maxCacheLength)delete d[m.shift()]}function y(e,t,n){var r,i;d[t]=n,e==="forward"?(r=m,i=v):(r=v,i=m),r.push(t),(t=i.pop())&&delete d[t]}function b(){e.fn.pjax=t,e.pjax=r,e.pjax.enable=e.noop,e.pjax.disable=w,e.pjax.click=n,e.pjax.reload=i,e.pjax.defaults={timeout:650,push:!0,replace:!1,type:"GET",dataType:"html",scrollTo:0,maxCacheLength:20},e(window).bind("popstate.pjax",s)}function w(){e.fn.pjax=function(){return this},e.pjax=o,e.pjax.enable=b,e.pjax.disable=e.noop,e.pjax.click=e.noop,e.pjax.reload=window.location.reload,e(window).unbind("popstate.pjax",s)}var d={},v=[],m=[];e.inArray("state",e.event.props)<0&&e.event.props.push("state"),e.support.pjax=window.history&&window.history.pushState&&window.history.replaceState&&!navigator.userAgent.match(/((iPod|iPhone|iPad).+\bOS\s+[1-4]|WebApps\/.+CFNetwork)/),e.support.pjax?b():w()})(jQuery);