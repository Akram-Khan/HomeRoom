$(document).ready(function(){

$('.show-comments').live("click",(function(event){
        event.preventDefault();
        $(this).parent('.note-comment-link').nextAll('.custom-comment').slideToggle();

})).live("click",(function(event){
               event.preventDefault();
               var toggled = $(this).data('toggled');
               $(this).data('toggled', !toggled);
               if (!toggled) {
                       $(this).children('span').children('a').html("&#8211").css('fontWeight', 'bold');
               }
               else {
                       $(this).children('span').children('a').text("+").css('fontWeight', 'bold');
               }

}));

	$(".delete-note").bind('ajax:success', function(evt, data, status, xhr){
		$(this).parents(".note").fadeOut();
	});

	$('.cycle-comments').hover(function(){
		$(this).children('.delete-comment-link').toggle();
	});

});
