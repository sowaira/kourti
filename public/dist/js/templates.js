this["JST"] = this["JST"] || {};

this["JST"]["assets/js/core/templates/escale.html"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape, __j = Array.prototype.join;
function print() { __p += __j.call(arguments, '') }
with (obj) {
__p += 'escale\r\n<select name="escale[escale_ville_id][]" >\r\n\t';
 for (i = 0; i< villes.length; i++){ ;
__p += '\r\n\t\t<option value="' +
((__t = ( villes[i].id )) == null ? '' : __t) +
'">' +
((__t = (ville.name)) == null ? '' : __t) +
'</option>\r\n\t';
  } ;
__p += '\r\n</select><br>';

}
return __p
};