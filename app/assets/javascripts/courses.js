$(document).ready(function(){

  $('.custom-comment').hide();

$('.show-comments').live("click",(function(event){
        event.preventDefault();
        $(this).parent('.note-comment-link').nextAll('.custom-comment').slideToggle();

})).live("click",(function(event){
               event.preventDefault();
        
               if ($(this).children('span').children('a').html() == "+") {
                       $(this).children('span').children('a').html("&#8211").css('fontWeight', 'bold');
               }
               else {
                       $(this).children('span').children('a').text("+").css('fontWeight', 'bold');
               }

}));

	$(".delete-post").live('ajax:success', function(evt, data, status, xhr){
		$(this).parents(".post").fadeOut();
	});

  $(".delete-answer").live('ajax:success', function(evt, data, status, xhr){
    $(this).parents(".answer").fadeOut();
  });

	$('.cycle-comments').live('hover', (function(){
		$(this).children('.delete-comment-link').toggle();
	})); 

  $('.note').click(function(){
    $('.link').removeClass('active');
    $('.media').removeClass('active');
    $('.file').removeClass('active');
    $('.question').removeClass('active');
    $('.note').addClass('active');
  });

  $('.link').click(function(){
    $('.note').removeClass('active');
    $('.media').removeClass('active');
    $('.file').removeClass('active');
    $('.question').removeClass('active');
    $('.link').addClass('active');
  });

  $('.media').click(function(){
    $('.note').removeClass('active');
    $('.link').removeClass('active');
    $('.file').removeClass('active');
    $('.question').removeClass('active');
    $('.media').addClass('active');
  });

  $('.file').click(function(){
    $('.note').removeClass('active');
    $('.link').removeClass('active');
    $('.media').removeClass('active');
    $('.question').removeClass('active');
    $('.file').addClass('active');
  });

  $('.question').click(function(){
    $('.note').removeClass('active');
    $('.link').removeClass('active');
    $('.media').removeClass('active');
    $('.file').removeClass('active');
    $('.question').addClass('active');
  });


});
