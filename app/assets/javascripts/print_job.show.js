(function() {
  $(function() {
    $('input#add_print_request').click(function() {
      var option = $('select#select_requests option:selected');
      var id = option.val();
      var text = option.text().trim();

      var new_li = $('<li></li>');
      var new_input = $('<input type="hidden" name="print_requests[]"></input>');
      var new_span = $('<span></span>');

      new_input.val(id);
      new_span.text(text);

      new_li.append(new_input);
      new_li.append(new_span);
      $('ul.added-print-request-list').append(new_li);
    });
  });
})();

