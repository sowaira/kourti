SharedApp.Views.Comment = Backbone.View.extend({
  el: $(".js-comments"),
  template: JST["assets/js/core/templates/comment_item.html"],

/*  events: {
    "click .js-remove-escale": "removeEscale"
  },*/

  initialize: function(){
    this.render();
  },

  render: function(){
    var obj;
    if (this.model !== undefined){
        obj = this.model.attributes.object;
    }

    $(this.el).append(this.template(obj));
  },

/*  removeEscale: function(elm){
    $this = $(elm.target);
    $this.parents(".js-escale").remove();
  }*/
});