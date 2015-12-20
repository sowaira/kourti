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
