$(document).ready(function(){

  $('#new_subscribtion').on('submit', function(ev){
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
            $('#subscriptions').prepend
          }
          document.getElementById('new_subscription').reset();
          $('#new_subscription input[type="submit"]').prop('disabled', false);
        }
    })
  })

})

<div class="well well-lg">
  <div class="row">
    <div class="col-xs-6">
      <a class="col-xs-12" href="/users/<%= data.user.id %>">
        <h2>'+ data.user.username +'</h2>
      </a>
      <div class="col-xs-12">
        <p>'+ data.expectations +'</p>
      </div>
    </div>
    <h4 class="text-center">No Data Available</h4>
  </div>
  <hr>
  <div class="row">
    <div class="col-xs-4">
      <h4>Rating: N/A</h4>
    </div>
    <div class="col-xs-4">
      <h4>Starting Weight: '+ data.start_weight +'</h4>
    </div>
    <div class="col-xs-3">
      <h4>Starting BMI: '+ data.start_bmi +'</h4>
    </div>
  </div>
  <div class="col-xs-9 col-xs-offset-3">
    <hr>
  </div>
  <div class="row">
    <div class="col-xs-4 col-xs-offset-4">
      <h4>Current Weight: '+ data.user.current_weight +'</h4>
    </div>
    <div class="col-xs-4">
      <h4>Current BMI: '+ data.user.current_bmi +'</h4>
    </div>
  </div>
</div>
