$(document).on('page:change', function() {
  $("#welcome-cover").css({'min-height': $(window).height()+ 'px'});
  $("#login_wrapper").hide();
  $("#signup_wrapper").hide();

  $("#signup").click(function(e) {
    e.preventDefault();
    $(".text-overlay").hide();
    $("#login_wrapper").hide();
    $("#signup_wrapper").fadeIn();
  });
  $("#login").click(function(e) {
    e.preventDefault();
    $(".text-overlay").hide();
    $("#signup_wrapper").hide();
    $("#login_wrapper").fadeIn();
  });
});
