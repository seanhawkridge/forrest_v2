jQuery(function($) {
  $("div#champion").click(function() {
    console.log('clicked');
    $(this).fadeOut(500);
  });
});
