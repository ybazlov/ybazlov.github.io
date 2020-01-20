// JavaScript Document

/***
 *** Colour and Style switcher configuration
 ***/

var styleConfig = {
	targetId : "contrast-switcher",
	colourOptions : [
		{ title:"default contrast", styleClasses:"defaultColours" }, // First item must be default
		{ title:"high contrast 1", styleClasses:"altColours1 darkStyle" },
		{ title:"high contrast 2", styleClasses:"altColours2 darkStyle" },
		{ title:"black-blue contrast", styleClasses:"altColours3" },
		{ title:"black-yellow contrast", styleClasses:"altColours4" }
	],
	fontOptions : [
		{ title:"serif", styleClasses:"defaultFont" }, // First item must be default
		{ title:"sans-serif", styleClasses:"altFont1" }
	]
};


/***
 *** Colour and Style switcher
 ***/

var parentElement = null; // Reference to the target DIV in the document
var switcherMenu = null; // Reference to the menu of options
var lastColourStyle = ""; // The last colour style applied
var lastFontStyle = "";  // The last font style applied
var _this = this; // Reference to the DOM

/**
 * Initiation code.  
 * Inserts switch options into document element with ID "styleConfig.targetId"
 */
this.document.addEventListener('DOMContentLoaded', function() {
	parentElement = _this.document.getElementById(styleConfig.targetId);
	createSwitcherButton();
	createSwitcherMenu();
	
	// Check cookies for saved preferences
	var savedColourOption = getCookie("colour-option");
	var savedFontOption = getCookie("font-option");
	if(savedColourOption) {	switchStyle(savedColourOption, "colour-option"); }
	if(savedFontOption) { switchStyle(savedFontOption, "font-option"); }
	
}, false);


function createSwitcherButton() {
	// Create the switcher button
	var switcherButton = this.document.createElement("button");
	switcherButton.setAttribute("id", styleConfig.targetId + "-button");
	switcherButton.innerHTML = "<span>A</span> Display Options";
	parentElement.appendChild(switcherButton);
	
	// Set the button click event to "show" the menu
	switcherButton.onclick = function(){ 
		_this.document.getElementById(styleConfig.targetId + "-menu").classList.toggle("show");
	};
	
	// Close the dropdown menu if the user clicks outside of it
	this.window.onclick = function(event) {
		if (!event.target.matches("#" + styleConfig.targetId + "-button")) {
			var dropdowns = _this.document.getElementsByClassName(styleConfig.targetId + "-content");
			var i;
			for (i = 0; i < dropdowns.length; i++) {
				var openDropdown = dropdowns[i];
				if (openDropdown.classList.contains('show')) {
					openDropdown.classList.remove('show');
				}
			}
		}	
	}
	
}

function createSwitcherMenu(){
	//C reate the switcher menu
	switcherMenu = this.document.createElement("ul");
	switcherMenu.setAttribute("id", styleConfig.targetId + "-menu");
	switcherMenu.setAttribute("class", styleConfig.targetId + "-content");
	parentElement.appendChild(switcherMenu);
	
	// Add group of colour scheme options
	addGroupTitle(switcherMenu, "Preferred colour scheme");
	var options = styleConfig.colourOptions;
	for (var i = 0; i < options.length; i++) {
		addStyleOption(switcherMenu, options[i].title, options[i].styleClasses, "colour-option", (i == 0));
	}
	
	// Add group of typeface options
	addGroupTitle(switcherMenu, "Preferred typeface");
	options = styleConfig.fontOptions;
	for (i = 0; i < options.length; i++) {
		addStyleOption(switcherMenu, options[i].title, options[i].styleClasses, "font-option", (i == 0));
	}
	addDisclaimer(switcherMenu);
}

function addStyleOption(switcherMenu, linkText, styleClasses, groupType, isDefault) {
	// Build the menu item
	var item = this.document.createElement('li');
	item.setAttribute('class', styleClasses + " option");
	var newLink = this.document.createElement('a');
	newLink.setAttribute('href','#');
	var textNode = this.document.createTextNode(linkText);
	newLink.appendChild(textNode);
	item.appendChild(newLink);
	var newSpan = this.document.createElement('span');
	item.appendChild(newSpan);
	switcherMenu.appendChild(item);
	
	// Set the click event and styling for each option type
	switch(groupType) {
		case("colour-option"):
			addStyle(item, groupType);
			newLink.onclick = function(event){ 
				switchStyle(styleClasses, groupType);
				event.preventDefault();
			};
			if(isDefault) { setSelected(newLink, groupType); }
			break;
		case("font-option"):
			addStyle(item, groupType);
			newLink.onclick = function(event){ 
				switchStyle(styleClasses, groupType);
				event.preventDefault();
			};
			if(isDefault) { setSelected(newLink, groupType); }
			break;
		default:
			throw Error("Unknown style type");
	}
}

/**
 * Adds a simple text item with title style to the menu
 */
function addGroupTitle(switcherMenu, textString) {
	addTextItem(switcherMenu, textString, "group-title");
}
/**
 * Adds cookies disclaimer to the menu
 */
function addDisclaimer(switcherMenu) {
	var disclaimer = "By selecting a display option you agree to <strong>cookies</strong> being used to record your preference between pages.";
	addTextItem(switcherMenu, disclaimer, "accessiblity-disclaimer");
}
/**
 * Adds a simple text/html item element to the menu
 */
function addTextItem(switcherMenu, textString, styleClasses) {
	var item = this.document.createElement('li');
	item.innerHTML = textString;
	item.setAttribute('class', styleClasses);
	switcherMenu.appendChild(item);
}

/**
 * Sets the style classes for a given display option and records setting
 * in a cookie so this will work across pages.
 */
function switchStyle(styleClasses, groupType){
	// Remove the last style from the document and update selected state
	var optionLink = getOptionLink(styleClasses, groupType);
	switch(groupType) {
		case("colour-option"):
			removeStyle(this.document.body, lastColourStyle);
			lastColourStyle = styleClasses;
			setSelected(optionLink, groupType);
			setCookie("colour-option", styleClasses, 180);
			break;
		case("font-option"):
			removeStyle(this.document.body, lastFontStyle);
			lastFontStyle = styleClasses;
			setSelected(optionLink, groupType);
			setCookie("font-option", styleClasses, 180);
			break;
		default:
			throw Error("Unknown style type");
	}
	// Add the new style to the document
	addStyle(this.document.body, styleClasses);
}

/**
 * Sets a given option with a tick symbol to indicate the current selection.
 */
function setSelected(selectedElement, groupType) {
	var optionItems  = switcherMenu.getElementsByClassName(groupType);
	for(var i = 0; i < optionItems.length; i++) {
		optionItems[i].firstChild.nextSibling.innerHTML = "";
	}
	selectedElement.nextSibling.innerHTML = "&#x2714;";
}

/**
 * Gets a given display option link element by style class names of its parent.
 */
function getOptionLink(styleClasses, groupType) {
	var optionItems = switcherMenu.getElementsByClassName(groupType);
	for(var i = 0; i < optionItems.length; i++) {
		if( optionItems[i].className.indexOf(styleClasses) >= 0 ) {
			return optionItems[i].firstChild;
		}
	}
	return null;
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
function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+ d.toUTCString();
    this.document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}
/**
 * Gets a cookie value by name.
 */
function getCookie(cname) {
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

