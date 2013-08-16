var answers = document.getElementsByClassName('answer');

for(var i = 0; i < answers.length; i++) {
	var a        = answers[i];
	var parent   = a.parentNode;
	var expander = document.createElement("a");
	var para     = document.createElement("p");

	para.className = "reveal"
	para.appendChild(expander)

	expander.href = "#";
	expander.innerHTML = "Show Answer...";

	parent.insertBefore(para,a);
	
	(function(p,ex,el) {
		ex.onclick = function() {
			el.style.display = 'block';
			p.parentNode.removeChild(p)
			return false;
		}
	})(para,expander,a);
}
