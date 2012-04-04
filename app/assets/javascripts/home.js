
 $(document).ready(function() {
   
   /* MENU AND SCROLL CODE */   
   var currentmenu = 'home'; // current section
   var anchorClick = false;   // user clicked left menu?
   var leftmenu = "absolute";   // how is leftmenu positioned?
   /* clicking left menu function */
   $('.leftMenu li').click( function(){
     anchorClick = true;
     currentmenu = $(this).attr("id");
     changeMenu(currentmenu);
     if(currentmenu == "home"){
      $('html,body').animate({scrollTop: 0}, 500, function() { anchorClick = false; }); 
     }
     else {
       $('html,body').animate({scrollTop: $('#'+currentmenu+'-section').offset().top}, 500, function() { anchorClick = false; });
     }
   });
   /* scrolling function */
   $(window).bind("scroll", function(){
     currentmenu = checkMenu(currentmenu,anchorClick);
     if($(window).scrollTop() > $('#home-section').offset().top-75 && leftmenu == "absolute"){
       leftmenu = "fixed";
       $('.leftMenu').css("position","fixed").css("top","75px").css("left",$('#wrapper').offset().left+5);
       $('.rightMenu').css("position","fixed").css("top","75px").css("left",$('#wrapper').offset().right-5);
       $('.signup_page_item a').addClass('animate_join');
     }
     else if($(window).scrollTop() < $('#home-section').offset().top-75 && leftmenu == "fixed"){
       leftmenu = "absolute";
       $('.leftMenu').css("position","absolute").css("top","35px").css("left","5px");
       $('.rightMenu').css("position","absolute").css("top","35px").css("left","auto").css("right","5px");
       $('.signup_page_item a').removeClass('animate_join');
     }
   });
   $(window).bind("resize", function(){
      if(leftmenu == "fixed"){
        $('.leftMenu').css("position","fixed").css("top","75px").css("left",$('#wrapper').offset().left+5);
        $('.rightMenu').css("position","fixed").css("top","75px").css("left",$('#wrapper').offset().right-5);
      }
   });
   /* check starting state */
   checkMenu(currentmenu, anchorClick);
   if($(window).scrollTop() > $('#home-section').offset().top-75 && leftmenu == "absolute"){
     leftmenu = "fixed";
     $('.leftMenu').css("position","fixed").css("top","75px").css("left",$('#wrapper').offset().left+5);
     $('.signup_page_item a').addClass('animate_join');
   }
   else if($(window).scrollTop() < $('#home-section').offset().top-75 && leftmenu == "fixed"){
     leftmenu = "absolute";
     $('.leftMenu').css("position","absolute").css("top","35px").css("left","0px");
     $('.signup_page_item a').removeClass('animate_join');
   }
 });
 function checkMenu(current, killscroll){
   if(killscroll){ 
    return current; 
   }
   var scrollTop = $(window).scrollTop();
   var scrollOffset = 425;
   if(scrollTop > 0 && scrollTop < $('.kind_words-section').offset().top-scrollOffset){ 
     if(current != 'home'){ 
      changeMenu('home');
      return 'home';
    }
   }

   if(scrollTop > $('.kind_words-section').offset().top-scrollOffset && scrollTop < $('.gallery-section').offset().top-scrollOffset){ 
     if(current != 'kind_words'){ 
      changeMenu('kind_words');
      return 'kind_words';
    }
   }   

   if(scrollTop > $('.gallery-section').offset().top-scrollOffset && scrollTop < $('.team-section').offset().top-scrollOffset){ 
     if(current != 'gallery'){ 
      changeMenu('gallery');
      return 'gallery';
    }
   }

   if(scrollTop > $('.team-section').offset().top-scrollOffset && scrollTop < $('.jobs-section').offset().top-scrollOffset){ 
     if(current != 'team'){ 
      changeMenu('team');
      return 'team';
    }
   }
     
    if(scrollTop > $('.jobs-section').offset().top-scrollOffset && scrollTop < $('.press_kit-section').offset().top-scrollOffset){ 
     if(current != 'jobs'){ 
      changeMenu('jobs');
      return 'jobs';
    }
   }

   if(scrollTop > $('.press_kit-section').offset().top-scrollOffset && scrollTop < $('#end').offset().top){ 
     if(current != 'press_kit'){ 
      changeMenu('press_kit');
      return 'press_kit';
    }
   }
   return current;
 }

 function changeMenu(name){
    $('.current').removeClass('current');
    $('.currentSection').removeClass('currentSection');
    $('#'+name).addClass('current');
    $('.'+name+'-section').addClass('currentSection');
 }



$(document).ready(function() {
  $(".share_bar").hover( function() {
      $('.rightMenuOff').fadeOut(100);
      $('.rightMenuOn').fadeIn(300);
    }, function() {
      $('.rightMenuOn').fadeOut(100);
      $('.rightMenuOff').fadeIn(300);
    });

    $('.popup').click(function(event) {
    var width  = 575,
        height = 400,
        left   = ($(window).width()  - width)  / 2,
        top    = ($(window).height() - height) / 2,
        url    = this.href,
        via    = "homeroom"
        options  = 'status=1' +
                 ',width='  + width  +
                 ',height=' + height +
                 ',top='    + top    +
                 ',data-via=' + via +
                 ',left='   + left;

    window.open(url,'twitte', options);

    return false;
  });

 });