$(document).ready(function(){

  $('#new_subscription').on('submit', function(ev){
    ev.preventDefault()
    $.post({
        url: $(ev.target).attr('action'),
        data: new FormData(ev.target),
        processData: false,
        contentType: false,
        success: function(data) {
          console.log(data)
          $('#SubscribeModal' + data.plan_id + '').modal("hide")
          if (window.location.pathname === '/plans/' + data.plan_id + ''){
            $('#subscriptions').prepend(HandlebarsTemplates['subscription'](data))
          }
          document.getElementById('new_subscription').reset();
          $('#new_subscription input[type="submit"]').prop('disabled', false);
        }
        error: function(error){
        console.log(error)
        }
    })
  })

})
