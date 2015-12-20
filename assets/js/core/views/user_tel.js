SharedApp.Views.UserTel = Backbone.View.extend({
  el: $(".js-tels"),
  template: JST["assets/js/core/templates/tel.html"],

  events: {
    "click .js-remove-tel": "removeTel"
  },

  initialize: function(){
    this.render();
  },

  render: function(){
    var number;
    var index;

    if (this.model !== undefined){
        number = this.model.get("number");
        index = this.model.get("index");
    }
    
    obj = {
      index: index,
      number: number
    };
    
    $(this.el).append(this.template(obj));
  },

  removeTel: function(elm){
    $this = $(elm.target);
    $this.parents(".js-tel").remove();
  }
});
