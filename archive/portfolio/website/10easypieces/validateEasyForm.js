/* ==========================================================
    Form validation functions for the Lee Riveted 10 Easy
    Pieces application. While most methods are general-
    purpose, the validateAll() method is application-
    specific.
    
    Created 8/28/2001 by ccbettis
    Version 1.0
    Last updated 8/30/2001 by ccbettis
   ========================================================== */

/** Returns boolean value indicating whether String parameter
    is null/empty. TRUE indicates it is NOT empty, and hence
    likely to be a valid String.
*/ 
function notEmpty(str) {
  return ((str != null) && (str != ""));
}

/** Returns boolean value indicating whether String parameter
    is a validly formatted e-mail address.
*/
function validEmail(str) {
  var emailRe = "^[\\w-_\.]*[\\w-_\.]\@[\\w]\.+[\\w]+[\\w]$";
  var re = new RegExp(emailRe);
  return re.test(str);
}

/** Returns a boolean value indicating whether the int
    parameter is equal to zero. This is used for select/
    option items, and operates on the assumption that the
    first option (index 0) will not be a valid selection.
*/
function isSelected(idx) {
  return (idx != 0);
}

/** Calls notEmpty method to determine whether a given
    String is null/empty and returns a boolean value.
    If the input String is null/empty, the specified
    String message is displayed in an alert and a value
    of FALSE is returned. Otherwise, a value of TRUE
    is returned.
*/
function testText(str, msg) {
  if (!notEmpty(str)) {
    alert(msg);
    return false;
  } else {
    return true;
  }
}

/** Calls validEmail method to determine whether a given
    String is a validly formatted email address and returns 
    a boolean value. If the input String is invalid for an
    email addres, the specified String message is displayed 
    in an alert and a value of FALSE is returned. Otherwise, 
    a value of TRUE is returned.
*/
function testEmail(str, msg) {
  if (!validEmail(str)) {
    alert(msg);
    return false;
  } else {
    return true;
  }
}

/** Calls isSelected method to determine whether a valid
    option has been select in a Select input (assuming
    the first option is not valid). If the selected index
    = 0, the specified String message is displayed 
    in an alert and a value of FALSE is returned. Otherwise, 
    a value of TRUE is returned.
*/
function testSelected(idx, msg) {
  if (!isSelected(idx)) {
    alert(msg);
    return false;
  } else {
    return true;
  }
}

/** Validates all required form fields. Since the required
    fields will vary from one application to another, this
    method is specific to the Lee 10 Easy Pieces application.
    If all required fields pass validation, a value of TRUE
    is returned, otherwise FALSE.
*/
function validateAll() {
  if (!(testText(document.frm.first_name.value, 'Please enter your first name.'))) {
    document.frm.first_name.focus();
    return false;
  }
  
  if (!(testText(document.frm.last_name.value, 'Please enter your last name.'))) {
    document.frm.last_name.focus();
    return false;
  }
  
  if (!(testEmail(document.frm.email_address.value, 'Please enter a valid email address (xxx@yyy.zzz).'))) {
    document.frm.email_address.focus();
    return false;
  }
  
  if (document.frm.promo_name.value == '10EasyCatalog') {
    if (!(testText(document.frm.address1.value, 'Please enter your street address.'))) {
      document.frm.address1.focus();
      return false;
    }
  }
  
  if (!(testText(document.frm.city.value, 'Please enter a city.'))) {
    document.frm.city.focus();
    return false;
  }
  
  if (!(testSelected(document.frm.state.selectedIndex, 'Please select a state.'))) {
    document.frm.state.focus();
    return false;
  }
  
  if (!(testText(document.frm.zip.value, 'Please enter a zip code.'))) {
    document.frm.zip.focus();
    return false;
  }
  
  if (!(testSelected(document.frm.heard_how.selectedIndex, 'Please tell us how you heard about 10 Easy Pieces.'))) {
    document.frm.heard_how.focus();
    return false;
  }
  
  return true;
  
}
