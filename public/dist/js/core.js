SharedApp = {};
SharedApp.Views = {};
SharedApp.Models = {};

if ($("meta[name=\"csrf-token\"]").length) {
    $.ajaxSetup({
      beforeSend: function (xhr) {
        xhr.setRequestHeader("X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content"));
      }
    });
}

SharedApp.main = {
  init: function () {
  },

	manageEscales: function(){
		$(".js-add-escale").click(function() {
			new SharedApp.Views.Escale();
		});


		$(".js-escale-villes").each(function(index, item) {
			var ville = new Ville({
			  id: $(item).val()
			});

			new SharedApp.Views.Escale({
				model: ville
			});
		});
	},

	manageTels: function(){
		$(".js-add-tel").click(function() {
			new SharedApp.Views.UserTel();
		});

		$(".js-user-tels").each(function(index, item) {
			var tel = new Tel({
			  index: index,
			  number: $(item).val()
			});

			new SharedApp.Views.UserTel({
				model: tel
			});

		});
	},

	manageComments: function(token, class_name){

		$.ajax({type: "GET", url: "/comments?token="+token+"&class_name="+class_name,
	      success: function(response) {
			$(".js-comments").html("");
			if (response.comment === undefined) {
				return;
			}
			for (var i = 0 ; i < response.comment.length ; i++) {
				// je crée un model en js 
				var comment = new Comment({
				  object: response.comment[i]
				});
				// je crée la vue et je passe le modele 
				new SharedApp.Views.Comment({
					model: comment
				});
			}
	      },

	      error: function() {
	        alert( "Sorry, there was a problem!" );
	       }
	    });

	},

	submitComments: function (token, class_name) {
		$(".js-comment-submit").click(function(){
			var comment_text = $(".js-comment-text").val();
			$.ajax({type: "POST",
				url: "/comment",
				data: {text: comment_text, class_name: class_name, token: token},
				success: function() {
					SharedApp.main.manageComments(token, class_name);
					$(".js-comment-text").val("");
				},

				error: function() {
					alert( "Sorry, there was a problem!" );
				}
			});
		});
	},

	submitNote: function (class_name) {
		$(".js-like-submit").click(function(){

			$elm = $(this);
			var type_action = parseInt($elm.attr("data-type-action"));
			var token = $elm.attr("data-"+class_name.toLowerCase()+"-token");
			if (type_action < 0 || type_action > 1) {
				alert( "Sorry, there was a problem!" );
				return;
			}
			$.ajax({type: "POST",
				url: "/like",
				data: {type_action: type_action, class_name: class_name, token: token},
				success: function(response) {
					$elm.parents(".js-"+class_name.toLowerCase()).find(".js-like-submit").hide();
					$elm.parents(".js-"+class_name.toLowerCase()).find(".js-likes").html(response.likes);
					$elm.parents(".js-"+class_name.toLowerCase()).find(".js-dislikes").html(response.dislikes);
				},

				error: function() {
					alert( "Sorry, there was a problem!" );
				}
			});
		});
	}

};
var Comment = Backbone.Model.extend({});
var Tel = Backbone.Model.extend({});
var Ville = Backbone.Model.extend({});
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
$(".open-popup-link").magnificPopup({
  type:"inline",
  midClick: true
});
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

SharedApp.Views.Timepicker = Backbone.View.extend({
	el: $("body"),
	template: JST["assets/js/core/templates/timepicker.html"],

	events: {
		"click .js-tp-plus-time": "plusTime",
		"click .js-tp-minus-time": "minusTime",
		"click .js-tp-set-time": "setTime",
		"click .js-tp-cancel-time": "cancelTime"
	},

	initialize: function(){
		self = this;
		this.render();
	},

	render: function(){
		$(this.el).append(this.template());
		$(".js-time").click(function() {
			el_time = $(this);
			$.magnificPopup.open({
			  items: {
			    src: ".js-time-picker"
			  },
			  type: "inline"
			});
		});
	},

	setTime: function() {
		el_time.val($(".js-tp-hour").val() + ":" + $(".js-tp-min").val());
		el_time.validationEngine("validate");
		$.magnificPopup.close({
		  items: {
		    src: ".js-time-picker"
		  }
		});
	},

	cancelTime: function() {
		$.magnificPopup.close({
		  items: {
		    src: ".js-time-picker"
		  }
		});
	},

	plusTime: function (elm) {
		$this = $(elm.target);

		$input = $this.parents(".js-tp-time-container").find(".js-tp-time");
		var criteriaVal = 23;
		if ($input.hasClass("js-tp-min")){
			criteriaVal = 59;
		}

		var time = parseInt($input.val());
		if(time < criteriaVal){
			time++;
		}else{
			time = 0;
		}
		$input.val(time);
	},

	minusTime: function (elm) {
		$this = $(elm.target);

		$input = $this.parents(".js-tp-time-container").find(".js-tp-time");
		var criteriaVal = 23;
		if ($input.hasClass("js-tp-min")){
			criteriaVal = 59;
		}
		var time = parseInt($input.val());
		if(time < 1){
			time = criteriaVal;
		}else{
			time--;
		}
		$input.val(time);
	}

});

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
