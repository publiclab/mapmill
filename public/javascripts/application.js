// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function vote(id,vote,site) {
	// this is not working: "Uncaught SyntaxError: Unexpected token )"
	new Ajax.Request("/vote/"+id+"/"+vote+"/"+site+"?ajax=true", {
		method: "get",
//		parameters: {},
		onComplete: function(response) {
			$('buttons-'+id).addClassName('grey');
			$$('#buttons-'+id+' a').each(function(el) { el.onclick = ""; });
		}
	})
}
