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

  $('#new_plan').on('submit', function(ev){
    ev.preventDefault()
    $.post({
        url: $(ev.target).attr('action'),
        data: new FormData(ev.target),
        processData: false,
        contentType: false,
        success: function(data) {
          $('#PlanModal').modal("hide")
          if (window.location.pathname === '/plans' || window.location.hostname === window.location.href){
            $('#' + data.category.title + '').prepend('<div class="row"><div class="col-xs-4"><h4>Rating:'+ data.rating + '/5</h4></div><div class="col-xs-4"><h4>Category:' + data.category.title + '</h4></div><div class="col-xs-3"><h4>Total Subscribers:' + data.subscriptions.count +'</h4></div><div class="col-xs-1 subbutton"><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#SubscribeModal'+ data.id +'">Subscribe</button></div></div>')
          }
          document.getElementById('new_plan').reset();
          $('#new_plan input[type="submit"]').prop('disabled', false);
        }
    })
  })




})
