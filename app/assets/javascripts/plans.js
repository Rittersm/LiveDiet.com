$(document).ready(function(){

  $('#new_plan').on('submit', function(ev){
    ev.preventDefault()
    $.post({
        url: $(ev.target).attr('action'),
        data: new FormData(ev.target),
        processData: false,
        contentType: false,
        success: function(data) {
          console.log(data)
          $('#PlanModal').modal("hide")
          if ((window.location.pathname === '/plans') || (window.location.pathname === "blank") || (window.location.pathname === "/")){
            $('#'+ data.category.title.replace(" ", "").toLowerCase() +'').prepend('<div class="well well-lg" id="'+ data.id +'"><div class="row"><div class="col-xs-6"><a class="col-xs-12" href="/plans/' + data.id + '"><h2>'+ data.title +'</h2></a><div class="col-xs-12"><p>'+ data.overview +'</p></div></div><div class="col-xs-6"><h4 class="text-center">No Data Available</h4></div></div><hr><div class="row"><div class="col-xs-4"><h4>Rating:'+ data.rating + '/5</h4></div><div class="col-xs-4"><h4>Category:' + data.category.title + '</h4></div><div class="col-xs-3"><h4>Total Subscribers: 0</h4></div><div class="col-xs-1 subbutton"><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#SubscribeModal'+ data.id +'">Subscribe</button></div></div>')
            $('#'+ data.category.title.replace(" ", "").toLowerCase() +'tab').tab('show')
          }
          document.getElementById('new_plan').reset();
          $('#new_plan input[type="submit"]').prop('disabled', false);
        }
    })
  })

})
