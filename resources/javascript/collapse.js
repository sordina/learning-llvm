


document.onkeypress = function(e) {

	e = e || window.event;
	var charCode = (typeof e.which == "number") ? e.which : e.keyCode;
	if (charCode) {
		var key = String.fromCharCode(charCode)
		if(key === "x") {
			document.body.className += " small";
		}
		else if(key === "o") {
			document.body.className = "";
		}
	}
}
