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
	},

	uploadImage: function () {
		$(".js-upload-photo").click(function() {
			$(".js-upload-photo-container .cloudinary_fileupload").click();
		});
		$(".js-upload-photo-container .cloudinary_fileupload").unsigned_cloudinary_upload("n2x0h8b1",
		  { tags: "kourti" },
		  { multiple: true }
		).bind("cloudinarydone", function(e, data) {
		  $(".js-upload-photo-container").css("background-size", "cover");
		  $(".js-upload-photo-container").css("background-image", "url("+data.result.url+")");
		  $(".js-upload-photo-value").val(data.result.url);
		  $(".js-upload-photo").show();
		  $(".js-upload-photo-spinner").hide();
		}).bind("fileuploadprogress", function() {
		    $(".js-upload-photo").hide();
		    $(".js-upload-photo-spinner").show();
		});
	}
};