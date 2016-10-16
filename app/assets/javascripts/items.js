(function() {
  $(document).on('page:change', function() {
    initItemsActions();
  });

  function initItemsActions () {
    $('#new_tag .btn-primary').on('click', function(e){
      submitCreateTagForm();
    });

    $('#new_tag').on('submit', function(e){
      e.preventDefault();
      submitCreateTagForm();
    });

    $('.js-add-tag').on('click', function(e){
      $('#new_tag').attr('action','/items/'+$(this).attr('data-item-id')+'/tags');
    });

    $("a[data-remote]").on("ajax:success", function(e, data, status, xhr) {
      if (data.tag_id) {
        $(this).parents(".btn").remove();
      } else {
        $('.row-id-' + data.id).remove();
      }
    });  
  }

  function submitCreateTagForm () {
      var submitData = $('#new_tag').serialize();
      $.ajax({
          type: "POST",
          url: $('#new_tag').attr('action'), 
          data: submitData,
          dataType: "JSON"
      }).success(function(json){
        onCreateTagSuccess(json);
      }).error(function(json){
        onCreateTagError(json);
      });  
  }

  function onCreateTagSuccess(data){
    var tag_name = $('#tag_name').val(); 
    $('#tag_name').val('');
             
    var template = $('#hidden-tag-template').html();          
    $('#td-actions-id-'+data.item_id).append(template);      
    $('#js-tag-btn-new').attr('id', 'js-tag-id-'+data.tag_id);      
    $('#js-tag-id-'+data.tag_id + ' .js-tag-name-content').html(tag_name);      
    $('#js-tag-id-'+data.tag_id + ' .js-tag-name-x').attr('href', '/items/'+data.item_id+'/tags/'+data.tag_id);             
    initItemsActions();
    $('#addTagModal').modal('hide');  
  }

  function onCreateTagError(data){
    var tag_name = $('#tag_name').val(); 
    $('#tag_name').val('');
    $('#addTagModal').modal('hide'); 
  }  
}).call(this);