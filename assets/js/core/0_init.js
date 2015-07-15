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
