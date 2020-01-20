/*
var coll = document.getElementById("collapse-general");
coll.addEventListener("click", function() {
    this.classList.toggle("active");
    var content = document.getElementById("general"); 
    if (content.style.display === "block") {
      content.style.display = "none";
    } else {
      content.style.display = "block";
    }
});
*/
var collapseConfig = {
	targetId : "collapse",
	collOptions : [
		{ title:"Hide this section", styleClasses:"collapsible-shown" }, // First item must be default
		{ title:"Show this section", styleClasses:"collapsible-hidden" }
	]
};

var ybparentElement = null; // Reference to the target DIV in the document
var ybcollMenu = null; // Reference to the menu of options
var lastCollStyle = "";  // The last coll style applied
var _this = this; // Reference to the DOM

/**
 * Initiation code.  
 * Inserts switch options into document element with ID "collapseConfig.targetId"
 */
this.document.addEventListener('DOMContentLoaded', function() {
	ybparentElement = _this.document.getElementById(collapseConfig.targetId+"-heading");
	createCollButton();
	
	// Check cookies for saved preferences
	var savedCollOption = getCookie("coll-option");
	if(savedCollOption) { ybSwitchStyle(savedCollOption); } else { ybSwitchStyle(collapseConfig.collOptions[0].styleClasses); }
}, false);

function createCollButton() {
	// Create the coll button
	var collButton = this.document.createElement("button");
	collButton.setAttribute("id", collapseConfig.targetId + "-button");
	collButton.innerHTML = collapseConfig.collOptions[0].title;
	//ybparentElement.appendChild(collButton);
	ybparentElement.insertBefore(collButton,ybparentElement.childNodes[0]);
	
	// Set the button click event to "show" the menu
	collButton.onclick = function(){ 
		toggleStyle()
	};
	
}

function toggleStyle(){
	if(lastCollStyle === collapseConfig.collOptions[0].styleClasses){ 
	ybSwitchStyle(collapseConfig.collOptions[1].styleClasses) 
}
else{ 
	ybSwitchStyle(collapseConfig.collOptions[0].styleClasses)
	}
}

function ybSwitchStyle(styleClasses){
	// Remove the last style from the document and update selected state
	removeStyle(_this.document.getElementById(collapseConfig.targetId + "-content"), lastCollStyle);
	lastCollStyle = styleClasses;
	ybsetCookie("coll-option", styleClasses, 7);
	// Add the new style to the document
	addStyle(_this.document.getElementById(collapseConfig.targetId + "-content"), styleClasses);
	if(styleClasses === collapseConfig.collOptions[0].styleClasses){ 
	_this.document.getElementById(collapseConfig.targetId + "-button").innerHTML=collapseConfig.collOptions[0].title 
}
else{
	_this.document.getElementById(collapseConfig.targetId + "-button").innerHTML=collapseConfig.collOptions[1].title 
}
}


/**
 * Adds style classes to an element.
 */
function addStyle(el, styleClasses) {
	if(!styleClasses) { return; }
	var styles = styleClasses.split(" ");
	for(var i = 0; i < styles.length; i++) {
		el.classList.add(styles[i]);
	}
}
/**
 * Removes style classes from an element.
 */
function removeStyle(el, styleClasses) {
	if(!styleClasses) { return; }
	var styles = styleClasses.split(" ");
	for(var i = 0; i < styles.length; i++) {
		el.classList.remove(styles[i]);
	}
}

/**
 * Sets a cookie name-value pair for a given duration.
 */
function ybsetCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+ d.toUTCString();
    this.document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}
/**
 * Gets a cookie value by name.
 */
function ybgetCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(this.document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

