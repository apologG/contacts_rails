// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree
//= require jquery
//= require bootstrap-sprockets
//= require jasny-bootstrap.min
//= require jquery-ui


$(function () {
  $('#term').autocomplete({
    source: "/contacts/autocomplete",
    minLength: 3,  
    select: function (event, ui) {
      $('#term').val(ui.item.value)
      $(this).closest('form').submit()
    }
  })
})
$( document ).on('turbolinks:load', function() {
	$("#add-new-group").hide()

	$('body').on('click', '#add-group-btn', function () {
			$("#add-new-group").slideToggle(function() {
					$('#new_group').focus()
			})
			return false
	})

	$('body').on('click', '#save-group-btn', function(event) {
			event.preventDefault()

			let newGroup = $('#new_group');
			let inputGroup = newGroup.closest('.input-group');

			$.ajax({
					url: "/groups",
					method: "post",
					data: {
							group: { name: $('#new_group').val() }
					},
					success: function (response) {
						console.log(response)
					},
					error: function (xhr) {
						let errors = xhr.responseJSON;
						let error = errors.join(", ");
						if (error) {
								inputGroup.next('.text-danger').detach();

								inputGroup
												.addClass('has-error')
												.after('<p class="text-danger">' + error + '</p>');
					}
			}})
	})
})