$(function() {
  function update() {
    var seed = $('#seed').val();
    var query = $(":input[name!=seed]", '#sandbox').filter(function(index, element) {
      return $(element).val() != '';
    }).serialize();

    var icon_link = '/' + seed + '?' + query;

    $('#debug').html(query);
    $('#icon').attr('src', icon_link);
    $('#icon-link').attr('href', icon_link);
  }

  $('#sandbox :input').on('change', update);
  $('#seed').on('keyup', update);

  $('.color').spectrum({allowEmpty: true, preferredFormat: "hex"});
});