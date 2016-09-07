$(document).ready(function(){

  $('#new_plan').on('submit', function(ev){
    ev.preventDefault()
    $(this).prev().remove()
    $.post({
        url: $(ev.target).attr('action'),
        data: new FormData(ev.target),
        processData: false,
        contentType: false,
        success: function(data) {
          console.log(data)
          $('#PlanModal').modal("hide")
          if (window.location.pathname === '/plans'){
            $('#'+ data.category.title.replace(" ", "").toLowerCase() +'').prepend(HandlebarsTemplates['plan'](data))
            $('#'+ data.category.title.replace(" ", "").toLowerCase() +'tab').tab('show')
          }
          document.getElementById('new_plan').reset()
          $('#new_plan input[type="submit"]').prop('disabled', false)
        },
        error: function(error){
        console.log(error)
        $('#PlanModal .modal-body').prepend(HandlebarsTemplates['error'](error))
        $('#new_plan input[type="submit"]').prop('disabled', false)
      }
    })
  })

  $('ul.dropdown-menu [data-toggle=dropdown]').on('click', function(event) {
    // Avoid following the href location when clicking
    event.preventDefault()
    // Avoid having the menu to close when clicking
    event.stopPropagation()
    // If a menu is already open we close it
    //$('ul.dropdown-menu [data-toggle=dropdown]').parent().removeClass('open');
    // opening the one you clicked on
    $(this).parent().addClass('open')

    var menu = $(this).parent().find("ul")
    var menupos = menu.offset()

    var newpos = - menu.width()

    menu.css({ left:newpos })

  });

  $("#sidebar-toggle").click(function(){
    $("#sidebar").toggle();
  });


})
