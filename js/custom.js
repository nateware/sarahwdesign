/*
 * Sarah Wiger JS.
 */

$(function(){
  // email crypting
  var er=[115,97,114,97,104,115,97,114,97,102,105,110,97,64,103,109,97,105,108,46,99,111,109];
  var em='';
  for (var i=0; i<er.length; i++) em+=String.fromCharCode(er[i]);
  $('#mailto').html('<a href="mailto:'+em+'">'+ $('#mailto').html() +'</a>');

  // phone too
  var pr=[54,49,57,45,55,55,48,45,48,51,53,49];
  var pm='';
  for (var i=0; i<pr.length; i++) pm+=String.fromCharCode(pr[i]);
  $('#cellph').html('<a href="tel:'+pm+'">'+ pm +'</a>');

  // setup fancybox for anything <a data-toggle="fancybox">
  $('[data-toggle="fancybox"]').fancybox();

});

