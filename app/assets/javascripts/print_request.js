(function() {
  $(function() {
    $('select.print-request-status').change(function() {
      var form = $(this).parents('form');
      form.submit();
    });
  });
})();

