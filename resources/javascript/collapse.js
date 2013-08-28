


document.onkeypress = function(e) {

	e = e || window.event;
	var charCode = (typeof e.which == "number") ? e.which : e.keyCode;
	if (charCode) {
		var key = String.fromCharCode(charCode)
		var cn  = document.body.className
		if(key === "t") {
			if(cn.match(/floating-toc/)) { document.body.className = cn.replace(/floating-toc/,'') }
			else                         { document.body.className += " floating-toc"; }
		}
		else if(key === "o") {
			if(cn.match(/small/))        { document.body.className = cn.replace(/small/,'') }
			else                         { document.body.className += " small" }
		}
	}
}

var toc = document.getElementById('toc').cloneNode(true)

toc.className = "floating-toc"
toc.id        = "floating-toc"

document.body.appendChild(toc)
