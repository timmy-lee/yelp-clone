$(document).ready(function() {
  $user_password_confirmation = $('#user_password_confirmation')
  $user_password_confirmation.on('blur', function(e) {
    if ($('#user_password').val() !== $user_password_confirmation.val()) {
      $('.password').removeClass('hidden');
      $('input[type=submit]').attr('disabled', 'disabled');
    } else {
      $('.password').addClass('hidden');
      $('input[type=submit]').removeAttr('disabled');
    }
  });
});
