this["JST"] = this["JST"] || {};

this["JST"]["assets/js/core/templates/comment_item.html"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div class="comment-item float-left">\r\n\t<div class="text float-left">\r\n\t\t' +
((__t = ( text )) == null ? '' : __t) +
'\r\n\t</div>\r\n\t<div class="date float-right">\r\n\t\t' +
((__t = ( created_at )) == null ? '' : __t) +
'\r\n\t</div>\r\n</div> \r\n<div class="v-space-1 float-left"></div>';

}
return __p
};

this["JST"]["assets/js/core/templates/escale.html"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape, __j = Array.prototype.join;
function print() { __p += __j.call(arguments, '') }
with (obj) {
__p += '<div class="js-escale">\r\n\tescale\r\n\t<div class="padding-right-1 position-relative">\r\n\t\t<select name="escale[escale_ville_id][]" >\r\n\t\t\t';
 for (i = 0; i< SVALS.villes.length; i++){ 
				selected = "";
				if ((selected_ville_id !== undefined) && selected_ville_id === SVALS.villes[i].id){
					selected = "selected";
				}

				;
__p += '\r\n\r\n\t\t\t\t<option value="' +
((__t = ( SVALS.villes[i].id )) == null ? '' : __t) +
'" ' +
((__t = (selected)) == null ? '' : __t) +
' >' +
((__t = (SVALS.villes[i].name)) == null ? '' : __t) +
'</option>\r\n\t\t\t';
  } ;
__p += '\r\n\t\t</select>\r\n\t\t<button type="button" class="btn-controle js-remove-escale" >-</button>\r\n\t</div>\r\n</div>';

}
return __p
};

this["JST"]["assets/js/core/templates/tel.html"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape, __j = Array.prototype.join;
function print() { __p += __j.call(arguments, '') }
with (obj) {
__p += '<div class="js-tel">\r\n\t<div class="label">\r\n\t\t';
 if (index !== undefined) { ;
__p += '\r\n\t\t\tTel N° ' +
((__t = ( index + 1 )) == null ? '' : __t) +
'\r\n\t\t';
 } else { ;
__p += '\r\n\t\t\tSaisir le Tel\r\n\t\t';
 } ;
__p += '\r\n\t</div>\r\n\t<input type="text" value="' +
((__t = (number)) == null ? '' : __t) +
'" name="user[tel_numbers][]" >\r\n\t<button type="button" class="js-remove-tel btn">Supprimer ce N°</button>\r\n\t<div class="v-space-1"></div>\r\n\t<div class="v-space-1"></div>\r\n\t<div class="v-space-1"></div>\r\n</div>\r\n\t';

}
return __p
};

this["JST"]["assets/js/core/templates/timepicker.html"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div class="tp-master-container js-time-picker mfp-hide" >\r\n\t<div class="tp-container">\r\n\t\t<div class="v-space-1"></div>\r\n\t\t<div class="tp-col js-tp-time-container">\r\n\t\t\t<div class="tp-center-block">\r\n\t\t\t\t<div class="tp-width-1 ">\r\n\t\t\t\t\t<button class=" js-tp-plus-time">+</button>\r\n\t\t\t\t</div>\r\n\t\t\t\t<div class="v-space-1"></div>\r\n\t\t\t\t<div class="tp-width-1">\r\n\t\t\t\t\t<input type="text" readonly="true" class="tp-input js-tp-time js-tp-hour" value="10">\r\n\t\t\t\t</div>\r\n\t\t\t\t<div class="v-space-1"></div>\r\n\t\t\t\t<div class="tp-width-1 ">\r\n\t\t\t\t\t<button class=" js-tp-minus-time">-</button>\r\n\t\t\t\t</div>\r\n\t\t\t</div>\r\n\t\t</div>\r\n\r\n\t\t<div class="tp-col js-tp-time-container">\r\n\t\t\t<div class="tp-center-block ">\r\n\t\t\t\t<div class="tp-width-1 ">\r\n\t\t\t\t\t<button class=" js-tp-plus-time">+</button>\r\n\t\t\t\t</div>\r\n\t\t\t\t<div class="v-space-1"></div>\r\n\t\t\t\t<div class="tp-width-1">\r\n\t\t\t\t\t<input type="text" readonly="true" class="tp-input js-tp-time js-tp-min" value="20">\r\n\t\t\t\t</div>\r\n\t\t\t\t<div class="v-space-1"></div>\r\n\t\t\t\t<div class="tp-width-1 ">\r\n\t\t\t\t\t<button class=" js-tp-minus-time">-</button>\r\n\t\t\t\t</div>\r\n\t\t\t</div>\r\n\t\t</div>\r\n\t\t<div class="float-left v-space-1"></div>\r\n\t\t<div class="width-1 float-left">\r\n\t\t\t<button class="js-tp-set-time">Ok</button>\r\n\t\t\t<button class="js-tp-cancel-time">cancel</button>\r\n\t\t</div>\r\n\t</div>\r\n</div>';

}
return __p
};