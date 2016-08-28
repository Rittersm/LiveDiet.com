$(document).ready(function(){

  $('#new_log').on('submit', function(ev){
    ev.preventDefault()
    $.post({
        url: $(ev.target).attr('action'),
        data: new FormData(ev.target),
        processData: false,
        contentType: false,
        success: function(data) {
          $('#LogModal').modal("hide")
          if (window.location.pathname === '/users/' + data.user_id +''){
            $('#logs').prepend('<div class="well well-lg"><div class="row"><h2>' + moment(data.created_at).format('ll') + '</h2></div><div class="row"><h5>' + data.daily_overview + '</h5></div></div><div class="row"><p class="text-center"> ... </p></div>')
          }
          document.getElementById('new_log').reset();
          $('#new_log input[type="submit"]').prop('disabled', false);
        }
    })
  })


})
