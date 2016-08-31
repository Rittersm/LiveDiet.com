$(document).ready(function(){

  $('#new_log').on('submit', function(ev){
    ev.preventDefault()
    $.post({
        url: $(ev.target).attr('action'),
        data: new FormData(ev.target),
        processData: false,
        contentType: false,
        success: function(data){
          var context = {
            created_at: moment(data.created_at).format('ll'),
            daily_overview: data.daily_overview}
          $('#LogModal').modal("hide")
          if (window.location.pathname === '/users/' + data.user_id +''){
            $('#logs').prepend(HandlebarsTemplates['log'](context))
          }
          document.getElementById('new_log').reset()
          $('#new_log input[type="submit"]').prop('disabled', false)
        },
        error: function(error){
        console.log(error)
        $('#LogModal .modal-body').prepend(HandlebarsTemplates['error'](error))
        $('#new_log input[type="submit"]').prop('disabled', false)
        }
    })
  })


})
