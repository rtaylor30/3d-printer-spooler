//= require jquery.dataTables.min.js
//= require jquery-ui-1.10.3.custom.min.js

(function() {
  $(function() {
    $('input#upload-file-overlay').click(function() {
      $('input#stl_file').trigger('click');
    });

    $('input#stl_file').change(function() {
      $('input#upload-file-overlay').val($(this).val().replace("C:\\fakepath\\", ""));
    });

    $('input#upload-file-overlay').val('Click to select file...');

    $('table').dataTable({
      'aaSorting': [[2, 'desc']] 
    });

    $('a.stl_file_preview_link').click(function() {
      init_stl_previewer($(this).attr('stl_file_name'));
    });
  });
})();

