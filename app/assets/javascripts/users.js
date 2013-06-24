(function() {
  function on_new_account_click() {
    var verify_password = $('div.verify-password');
    verify_password.animate({
      height: '52px'
    }, 400, function() {
      verify_password.animate({
        opacity: 1,
        filter: 'alpha(opacity=100)'
      }, 300);

      $('input#new-account').animate({
        opacity: 0,
        filter: 'alpha(opacity=0)',
        visibility: 'none',
        width: '0px',
        margin: '0 0 0 -35px'
      }, 300);

      $('a#forgot').animate({
        opacity: 0,
        filter: 'alpha(opacity=0)',
        visibility: 'none'
      }, 300);

      $('input[type=submit]').val('Sign Up');
    });
  }

  function validate_form() {
    // Validate the email field
    
  }

  $(function() {
    // On a new account, show the verify password field.
    $('input#new-account').click(on_new_account_click);
  });
})();

