/*
 * Custom Nateware JS.
 */

$(function(){
  var er=[110,97,116,101,119,97,114,101,64,97,109,97,122,111,110,46,99,111,109];
  var em='';
  for (var i=0; i<er.length; i++) em+=String.fromCharCode(er[i]);
  $('#mailto').html('<a href="mailto:'+em+'">'+em+'</a>');
});
