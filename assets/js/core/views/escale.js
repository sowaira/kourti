SharedApp.Views.Escale = Backbone.View.extend({
  el: $(".js-escales"),
  template: JST["assets/js/core/templates/escale.html"],

  events: {
    "click .js-remove-escale": "removeEscale"
  },

  initialize: function(){
    this.render();
  },

  render: function(){
    var id;
    if (this.model !== undefined){
        id = this.model.get("id");
    }
    
    obj = {
      selected_ville_id: id
    };
    
    $(this.el).append(this.template(obj));
  },

  removeEscale: function(elm){
    $this = $(elm.target);
    $this.parents(".js-escale").remove();
  }
});

