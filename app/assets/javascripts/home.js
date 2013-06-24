(function() {
  $(function() {
    $('input#upload-file-overlay').click(function() {
      $('input#stl_file').trigger('click');
    });

    $('input#stl_file').change(function() {
      $('input#upload-file-overlay').val($(this).val());
    });

    $('table').dataTable({
      'aaSorting': [[2, 'desc']] 
    });
  });
})();

