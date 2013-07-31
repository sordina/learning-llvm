var answers = document.getElementsByClassName('answer');

for(var i = 0; i < answers.length; i++) {
	var a = answers[i];
	var parent = a.parentNode;
	var expander = document.createElement("a");

	expander.href = "#";
	expander.innerHTML = "Show Answer...";

	parent.insertBefore(expander,a);
	
	(function(ex,el) {
		ex.onclick = function() {
			el.style.display = 'block';
			ex.parentNode.removeChild(ex)
			return false;
		}
	})(expander,a);
}
