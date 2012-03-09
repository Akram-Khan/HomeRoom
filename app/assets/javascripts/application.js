// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(document).ready(function(){
$(".popup").click(function(e){
    $(".popup .popup_content").css("visibility","visible");
   e.stopPropagation();
});

$("body").click(function(e){
    $(".popup .popup_content").css("visibility","hidden");
});
});