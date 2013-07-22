(function() {
  $(function() {
    $('select.print-request-status, select.print-request-printer').change(function() {
      var form = $(this).parents('form');
      form.submit();
    });
  });
})();

