$(function() {

  // Set current active carousel slide id to #message_receiver_id
  $('#matches-carousel').on('slide.bs.carousel', function() {
    var id = $('#matches-carousel .active').index('#matches-carousel .item');
    $('input#receiver_id').val(id);
  });
});
