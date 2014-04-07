$(document).ready(function() {
  $('form.resolve-exception button').on('click', function (event) {
    button = $(this);
    form = button.parents('form');

    $.ajax({
      type: "POST",
      url: form.attr('action'),
      data: {},
      success: function (data, status, xhr) {
        $(form.data('target')).fadeOut(500, function () { $(this).remove() });
      }
    });

    event.preventDefault();
  });
});
