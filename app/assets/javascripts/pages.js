$(document).ready(function () {   

	var currentURL = window.location.pathname;
	$('#navbar li a').each(function () {
		var $this = $(this);
		if ($this.attr('href') === currentURL) {
			$this.parents('li').addClass('active');
		}
	});
});



 