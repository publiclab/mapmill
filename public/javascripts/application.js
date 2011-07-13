// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var mapmill_id = null

function vote(id,vote,site) {
	// this is not working: "Uncaught SyntaxError: Unexpected token )"
	new Ajax.Request("/vote/"+id+"/"+vote+"/"+site+"?ajax=true", {
		method: "get",
		parameters: { "mapmill_id": mapmill_id},
		onComplete: function(response) {
			$('buttons-'+id).addClassName('grey');
			$$('#buttons-'+id+' a').each(function(el) { el.onclick = ""; });
		}
	})
}

function hashgen() {
	return parseInt(Math.random()*100000000000000).toString(36)
}

function init() {
	if (localStorage) {
		mapmill_id = localStorage.getItem('mapmill_id')
		if (mapmill_id == null) {
			mapmill_id = hashgen()
			localStorage.setItem('mapmill_id',mapmill_id)
		}
	}

	$$('#buttons a').each(function(button) {
		button.href += "?mapmill_id="+mapmill_id
	})
}
