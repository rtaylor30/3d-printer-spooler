//= require jquery.dataTables.min.js
//= require jquery-ui-1.10.3.custom.min.js

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

    $('#stl_file').change(function() {
      init_stl_previewer($(this).val());
    });
  });
})();

