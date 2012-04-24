// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs


//= require_tree .

$(document).ready(function(){

$(".login_popup").click(function(e){
    $(".login_popup .login_popup_content").css("visibility","visible");
   e.stopPropagation();
});

$("body").click(function(e){
    $(".login_popup .login_popup_content").css("visibility","hidden");
});
});

$(document).ready(function(){
$(".logout_popup").click(function(e){
    $(".logout_popup .logout_popup_content").css("visibility","visible");
   e.stopPropagation();
});

$("body").click(function(e){
    $(".logout_popup .logout_popup_content").css("visibility","hidden");
});
});


$(function(){
    /* */
    $(".posts").infinitescroll({
   
      navSelector  : ".pagination",            
                     // selector for the paged navigation (it will be hidden)
      nextSelector : "a.next_page:last",   
                     // selector for the NEXT link (to page 2)
      itemSelector : ".posts",          
                     // selector for all items you'll retrieve
	 				behavior : 'twitter',
			        debug: true,
			        errorCallback: function() { 
			          // fade out the error message after 2 seconds
			          $('#infscr-loading').animate({opacity: .8},2000).fadeOut('normal');   
			        }
    }, function(){
      $('.custom-comment').hide();
    });

    // remove the paginator when we're done.
    $(document).ajaxError(function(e,xhr,opt){
      if (xhr.status == 404) $('a.next_page:last').remove();
    });    
});
