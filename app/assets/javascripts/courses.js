$(document).ready(function(){
	
	$('.show-comments').click(function(){
		$(this).parent('.note-comment-link').nextAll('.custom-comment').slideToggle();
	}).toggle(function(){
		$(this).children('span').children('a').html("&#8211").css('fontWeight', 'bold');
		} , function() {
		$(this).children('span').children('a').text("+").css('fontWeight', 'bold');
	});

});


/*
$(document).ready(function(){
	$('.note-comment-link').click(function(){
		$(this).nextAll('.custom-comment').eq(0).toggle();
	}).toggle(function(){
		$(this).children('span').text("-");
		} , function() {
		$(this).children('span').text("+");
	});

});
*/