SharedApp.Views.Shared = Backbone.View.extend({

  initialize: function(){
    this.manageSelects();
    this.manageValidationForm();
    return false;
  },

  manageSelects: function(){
    $("select").select2({
      placeholder: "Select a state",
      allowClear: true
    });

    $( "select" ).addClass( "width-1" );
  },

  manageValidationForm: function(){
    $("form").validationEngine("attach", {promptPosition : "topLeft", scroll: false});
  }
  
});
