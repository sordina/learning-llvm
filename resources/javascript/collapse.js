
(function() {

document.body.className += " " + localStorage.getItem('floating-toc');
document.body.className += " " + localStorage.getItem('small');

function foo(v) {
	var cn  = document.body.className
	if(cn.match(v)) { document.body.className  = cn.replace(v,''); localStorage.setItem(v, "") }
	else            { document.body.className += " " + v         ; localStorage.setItem(v, v ) }
}

document.onkeypress = function(e) {

	e = e || window.event;
	var charCode = (typeof e.which == "number") ? e.which : e.keyCode;
	if (charCode) {
		var key = String.fromCharCode(charCode)
		     if(key === "t") { foo("floating-toc") }
		else if(key === "o") { foo("small")        }
	}
}

var toc = document.getElementById('toc').cloneNode(true)

toc.className = "floating-toc"
toc.id        = "floating-toc"

document.body.appendChild(toc)

})();

