webpackJsonp([8],{784:function(e,t,r){var o=r(38)(r(809),r(877),null,null);o.options.__file="G:\\html\\iview-admin-index\\iview-admin\\src\\views\\business\\agentQQ\\agentQQ.vue",o.esModule&&Object.keys(o.esModule).some(function(e){return"default"!==e&&"__esModule"!==e})&&console.error("named exports are not supported in *.vue files."),o.options.functional&&console.error("[vue-loader] agentQQ.vue: functional components are not supported with templates, they should use render functions."),e.exports=o.exports},801:function(e,t,r){"use strict";var o=String.prototype.replace,n=/%20/g;e.exports={default:"RFC3986",formatters:{RFC1738:function(e){return o.call(e,n,"+")},RFC3986:function(e){return e}},RFC1738:"RFC1738",RFC3986:"RFC3986"}},802:function(e,t,r){"use strict";var o=Object.prototype.hasOwnProperty,n=function(){for(var e=[],t=0;t<256;++t)e.push("%"+((t<16?"0":"")+t.toString(16)).toUpperCase());return e}(),a=function(e){for(var t;e.length;){var r=e.pop();if(t=r.obj[r.prop],Array.isArray(t)){for(var o=[],n=0;n<t.length;++n)void 0!==t[n]&&o.push(t[n]);r.obj[r.prop]=o}}return t};t.arrayToObject=function(e,t){for(var r=t&&t.plainObjects?Object.create(null):{},o=0;o<e.length;++o)void 0!==e[o]&&(r[o]=e[o]);return r},t.merge=function(e,r,n){if(!r)return e;if("object"!=typeof r){if(Array.isArray(e))e.push(r);else{if("object"!=typeof e)return[e,r];(n.plainObjects||n.allowPrototypes||!o.call(Object.prototype,r))&&(e[r]=!0)}return e}if("object"!=typeof e)return[e].concat(r);var a=e;return Array.isArray(e)&&!Array.isArray(r)&&(a=t.arrayToObject(e,n)),Array.isArray(e)&&Array.isArray(r)?(r.forEach(function(r,a){o.call(e,a)?e[a]&&"object"==typeof e[a]?e[a]=t.merge(e[a],r,n):e.push(r):e[a]=r}),e):Object.keys(r).reduce(function(e,a){var i=r[a];return o.call(e,a)?e[a]=t.merge(e[a],i,n):e[a]=i,e},a)},t.assign=function(e,t){return Object.keys(t).reduce(function(e,r){return e[r]=t[r],e},e)},t.decode=function(e){try{return decodeURIComponent(e.replace(/\+/g," "))}catch(t){return e}},t.encode=function(e){if(0===e.length)return e;for(var t="string"==typeof e?e:String(e),r="",o=0;o<t.length;++o){var a=t.charCodeAt(o);45===a||46===a||95===a||126===a||a>=48&&a<=57||a>=65&&a<=90||a>=97&&a<=122?r+=t.charAt(o):a<128?r+=n[a]:a<2048?r+=n[192|a>>6]+n[128|63&a]:a<55296||a>=57344?r+=n[224|a>>12]+n[128|a>>6&63]+n[128|63&a]:(o+=1,a=65536+((1023&a)<<10|1023&t.charCodeAt(o)),r+=n[240|a>>18]+n[128|a>>12&63]+n[128|a>>6&63]+n[128|63&a])}return r},t.compact=function(e){for(var t=[{obj:{o:e},prop:"o"}],r=[],o=0;o<t.length;++o)for(var n=t[o],i=n.obj[n.prop],l=Object.keys(i),c=0;c<l.length;++c){var s=l[c],u=i[s];"object"==typeof u&&null!==u&&-1===r.indexOf(u)&&(t.push({obj:i,prop:s}),r.push(u))}return a(t)},t.isRegExp=function(e){return"[object RegExp]"===Object.prototype.toString.call(e)},t.isBuffer=function(e){return null!==e&&void 0!==e&&!!(e.constructor&&e.constructor.isBuffer&&e.constructor.isBuffer(e))}},803:function(e,t,r){"use strict";var o=r(805),n=r(804),a=r(801);e.exports={formats:a,parse:n,stringify:o}},804:function(e,t,r){"use strict";var o=r(802),n=Object.prototype.hasOwnProperty,a={allowDots:!1,allowPrototypes:!1,arrayLimit:20,decoder:o.decode,delimiter:"&",depth:5,parameterLimit:1e3,plainObjects:!1,strictNullHandling:!1},i=function(e,t){for(var r={},o=t.ignoreQueryPrefix?e.replace(/^\?/,""):e,i=t.parameterLimit===1/0?void 0:t.parameterLimit,l=o.split(t.delimiter,i),c=0;c<l.length;++c){var s,u,f=l[c],p=f.indexOf("]="),d=-1===p?f.indexOf("="):p+1;-1===d?(s=t.decoder(f,a.decoder),u=t.strictNullHandling?null:""):(s=t.decoder(f.slice(0,d),a.decoder),u=t.decoder(f.slice(d+1),a.decoder)),n.call(r,s)?r[s]=[].concat(r[s]).concat(u):r[s]=u}return r},l=function(e,t,r){for(var o=t,n=e.length-1;n>=0;--n){var a,i=e[n];if("[]"===i)a=[],a=a.concat(o);else{a=r.plainObjects?Object.create(null):{};var l="["===i.charAt(0)&&"]"===i.charAt(i.length-1)?i.slice(1,-1):i,c=parseInt(l,10);!isNaN(c)&&i!==l&&String(c)===l&&c>=0&&r.parseArrays&&c<=r.arrayLimit?(a=[],a[c]=o):a[l]=o}o=a}return o},c=function(e,t,r){if(e){var o=r.allowDots?e.replace(/\.([^.[]+)/g,"[$1]"):e,a=/(\[[^[\]]*])/,i=/(\[[^[\]]*])/g,c=a.exec(o),s=c?o.slice(0,c.index):o,u=[];if(s){if(!r.plainObjects&&n.call(Object.prototype,s)&&!r.allowPrototypes)return;u.push(s)}for(var f=0;null!==(c=i.exec(o))&&f<r.depth;){if(f+=1,!r.plainObjects&&n.call(Object.prototype,c[1].slice(1,-1))&&!r.allowPrototypes)return;u.push(c[1])}return c&&u.push("["+o.slice(c.index)+"]"),l(u,t,r)}};e.exports=function(e,t){var r=t?o.assign({},t):{};if(null!==r.decoder&&void 0!==r.decoder&&"function"!=typeof r.decoder)throw new TypeError("Decoder has to be a function.");if(r.ignoreQueryPrefix=!0===r.ignoreQueryPrefix,r.delimiter="string"==typeof r.delimiter||o.isRegExp(r.delimiter)?r.delimiter:a.delimiter,r.depth="number"==typeof r.depth?r.depth:a.depth,r.arrayLimit="number"==typeof r.arrayLimit?r.arrayLimit:a.arrayLimit,r.parseArrays=!1!==r.parseArrays,r.decoder="function"==typeof r.decoder?r.decoder:a.decoder,r.allowDots="boolean"==typeof r.allowDots?r.allowDots:a.allowDots,r.plainObjects="boolean"==typeof r.plainObjects?r.plainObjects:a.plainObjects,r.allowPrototypes="boolean"==typeof r.allowPrototypes?r.allowPrototypes:a.allowPrototypes,r.parameterLimit="number"==typeof r.parameterLimit?r.parameterLimit:a.parameterLimit,r.strictNullHandling="boolean"==typeof r.strictNullHandling?r.strictNullHandling:a.strictNullHandling,""===e||null===e||void 0===e)return r.plainObjects?Object.create(null):{};for(var n="string"==typeof e?i(e,r):e,l=r.plainObjects?Object.create(null):{},s=Object.keys(n),u=0;u<s.length;++u){var f=s[u],p=c(f,n[f],r);l=o.merge(l,p,r)}return o.compact(l)}},805:function(e,t,r){"use strict";var o=r(802),n=r(801),a={brackets:function(e){return e+"[]"},indices:function(e,t){return e+"["+t+"]"},repeat:function(e){return e}},i=Date.prototype.toISOString,l={delimiter:"&",encode:!0,encoder:o.encode,encodeValuesOnly:!1,serializeDate:function(e){return i.call(e)},skipNulls:!1,strictNullHandling:!1},c=function e(t,r,n,a,i,c,s,u,f,p,d,m){var y=t;if("function"==typeof s)y=s(r,y);else if(y instanceof Date)y=p(y);else if(null===y){if(a)return c&&!m?c(r,l.encoder):r;y=""}if("string"==typeof y||"number"==typeof y||"boolean"==typeof y||o.isBuffer(y)){if(c){return[d(m?r:c(r,l.encoder))+"="+d(c(y,l.encoder))]}return[d(r)+"="+d(String(y))]}var v=[];if(void 0===y)return v;var g;if(Array.isArray(s))g=s;else{var b=Object.keys(y);g=u?b.sort(u):b}for(var h=0;h<g.length;++h){var j=g[h];i&&null===y[j]||(v=Array.isArray(y)?v.concat(e(y[j],n(r,j),n,a,i,c,s,u,f,p,d,m)):v.concat(e(y[j],r+(f?"."+j:"["+j+"]"),n,a,i,c,s,u,f,p,d,m)))}return v};e.exports=function(e,t){var r=e,i=t?o.assign({},t):{};if(null!==i.encoder&&void 0!==i.encoder&&"function"!=typeof i.encoder)throw new TypeError("Encoder has to be a function.");var s=void 0===i.delimiter?l.delimiter:i.delimiter,u="boolean"==typeof i.strictNullHandling?i.strictNullHandling:l.strictNullHandling,f="boolean"==typeof i.skipNulls?i.skipNulls:l.skipNulls,p="boolean"==typeof i.encode?i.encode:l.encode,d="function"==typeof i.encoder?i.encoder:l.encoder,m="function"==typeof i.sort?i.sort:null,y=void 0!==i.allowDots&&i.allowDots,v="function"==typeof i.serializeDate?i.serializeDate:l.serializeDate,g="boolean"==typeof i.encodeValuesOnly?i.encodeValuesOnly:l.encodeValuesOnly;if(void 0===i.format)i.format=n.default;else if(!Object.prototype.hasOwnProperty.call(n.formatters,i.format))throw new TypeError("Unknown format option provided.");var b,h,j=n.formatters[i.format];"function"==typeof i.filter?(h=i.filter,r=h("",r)):Array.isArray(i.filter)&&(h=i.filter,b=h);var q=[];if("object"!=typeof r||null===r)return"";var O;O=i.arrayFormat in a?i.arrayFormat:"indices"in i?i.indices?"indices":"repeat":"indices";var w=a[O];b||(b=Object.keys(r)),m&&b.sort(m);for(var x=0;x<b.length;++x){var A=b[x];f&&null===r[A]||(q=q.concat(c(r[A],A,w,u,f,p?d:null,h,m,y,v,j,g)))}var k=q.join(s),_=!0===i.addQueryPrefix?"?":"";return k.length>0?_+k:""}},809:function(e,t,r){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var o=r(116),n=function(e){return e&&e.__esModule?e:{default:e}}(o),a=r(803);t.default={data:function(){return{searchCompany:"",alldata:[],modal1:!1,state:"新增",qqlist:this.getQQList(),formItem:{qqname:"",qq:""},ruleValidate:{qqname:[{required:!0,message:"客服名称不能为空",trigger:"blur"}],qq:[{required:!0,message:"qq号码不能为空",trigger:"blur"}]}}},methods:{getQQList:function(){var e=this;n.default.ajax.get("getAgentQQ.asp").then(function(t){e.qqlist=t.data.rows})},ok:function(e){var t=this;this.$refs[e].validate(function(e){var r=t;if(!e)return t.modal1=!0,!1;var o=t.formItem;n.default.ajax.post("addAgentQQ.asp",a.stringify(o)).then(function(e){"success"==e.data?(r.modal1=!1,r.getQQList()):"exists"==e.data?r.$Message.info("该客服已存在"):"failed"==e.data&&r.$Message.info("保存出错")})})},cancel:function(){this.modal1=!1},clear:function(){this.formItem.qqname="",this.formItem.qq=""},add:function(){this.clear(),this.state="新增客服",this.modal1=!0},delrow:function(e){var t=this;this.$confirm("是否确定删除该客服?","提示",{confirmButtonText:"确定",cancelButtonText:"取消",type:"warning"}).then(function(){n.default.ajax.get("delAgentQQ.asp",{params:{id:e.row.id}}).then(function(r){"success"==r.data&&(t.qqlist.splice(e.$index,1),t.$message({type:"success",message:"删除成功!"}))})}).catch(function(){})}}}},877:function(e,t,r){e.exports={render:function(){var e=this,t=e.$createElement,r=e._self._c||t;return r("div",{staticStyle:{padding:"20px",background:"#fff",margin:"10px"}},[r("ButtonGroup",[r("Button",{attrs:{type:"primary",icon:"plus"},on:{click:e.add}},[e._v("新增")])],1),e._v(" "),r("Modal",{attrs:{title:e.state,width:"350",footerHide:""},on:{"on-cancel":e.cancel},model:{value:e.modal1,callback:function(t){e.modal1=t},expression:"modal1"}},[r("Form",{ref:"formItem",attrs:{"label-width":80,model:e.formItem,rules:e.ruleValidate}},[r("FormItem",{attrs:{label:"客服名称",prop:"qqname"}},[r("Input",{model:{value:e.formItem.qqname,callback:function(t){e.$set(e.formItem,"qqname",t)},expression:"formItem.qqname"}})],1),e._v(" "),r("FormItem",{attrs:{label:"qq号码",prop:"qq"}},[r("Input",{model:{value:e.formItem.qq,callback:function(t){e.$set(e.formItem,"qq",t)},expression:"formItem.qq"}})],1),e._v(" "),r("FormItem",[r("Button",{attrs:{type:"primary"},on:{click:function(t){e.ok("formItem")}}},[e._v("确定")]),e._v(" "),r("Button",{staticStyle:{"margin-left":"8px"},attrs:{type:"ghost"},on:{click:e.cancel}},[e._v("取消")])],1)],1)],1),e._v(" "),r("el-table",{attrs:{data:e.qqlist,height:"500",stripe:"","highlight-current-row":""}},[r("el-table-column",{attrs:{type:"index"}}),e._v(" "),r("el-table-column",{attrs:{prop:"qqname",label:"客服名称"}}),e._v(" "),r("el-table-column",{attrs:{prop:"qq",label:"qq号码"}}),e._v(" "),r("el-table-column",{attrs:{label:"操作"},scopedSlots:e._u([{key:"default",fn:function(t){return[r("el-button",{attrs:{type:"text",size:"small"},on:{click:function(r){e.delrow(t)}}},[e._v("删除")])]}}])})],1)],1)},staticRenderFns:[]},e.exports.render._withStripped=!0}});