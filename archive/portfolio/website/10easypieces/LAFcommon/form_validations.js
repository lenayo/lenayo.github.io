// ======================================================================
// Use, modification or distribution of this file, in whole or in part, via
// any medium, is expressly prohibited without the consent of Look and Feel
// New Media.
//
// Copyright 1999, 2000 Look and Feel New Media
// ======================================================================
// DDDDD   OOOOO      NNN  NN  OOOOO  TTTTTTTT
// DD  DD OO   OO     NNNN NN OO   OO    TT
// DD  DD OO   OO     NN NNNN OO   OO    TT
// DD  DD OO   OO     NN  NNN OO   OO    TT    .. .. ..
// DDDDD   OOOOO      NN   NN  OOOOO     TT    .. .. ..
//
// ...copy this file into your project!  It MUST be accessed as:
//     /LAFcommon/form_validations.js
// If that URL does not work, tell the sysadmin to setup the LAFcommon
// virtual directory.  Any person(s) found in violation of this edict shall
// immediately forfeit all their accumulated Slack and shall be found by
// the Stark Fist Of Removal.  This is not a test.  You have been warned.
// ======================================================================
// form_validations.js
//
// ABSTRACT:
// This file contains a library of general-purpose javascript form
// validation functions.  It is intended to provide a consistant set of
// rules and methods for form validation.
//
// NOTE: Do not copy this file into your project.  The latest version
// of this file should always be available on all LAF servers as:
//   /LAFcommon/form_validations.js
// It can be included into any HTML or ASP file with the following lines:
//   <SCRIPT LANGUAGE="Javascript" SRC="/LAFcommon/form_validations.js>
//   </SCRIPT>
// If your project is to be hosted somewhere other than LAF, please
// verify that the LAFcommon library will _not_ be installed on the
// server before making a copy of this file in your project directory.
//
// NOTE: No functions from this library should be called directly except
// the three detailed below.
//
// USAGE:
// For every form field on your page that you want to validate, call the
// following function once:
//   validate_addelement(form_element, element_type, format_fail,
//     required_flag, required_fail)
// The parameters have the following meanings:
//   form_element: The Javascript object of your form element, usually
//     something like document.form_name.object_name.  Be careful when
//     using DHTML tags like LAYER, ILAYER, SPAN and DIV -- they create
//     sub-"document" objects that contain their content.  In those cases
//     you should call validate_addelement() from within the DHTML block.
//     NOTE: Do not surround this parameter with quotes -- the object
//     reference is required, not the name of the object as a string.
//   element_type: A string representing the type of data your form element
//     contains.  See below for acceptable values and what they expect.
//   format_fail: The string to print when the data in the field is not
//     of the correct type.  See below for how the string is seen.
//   required_flag: A boolean indicating if data is required in the field
//     -- validation will not be performed if the field is empty.  This
//     parameter is ignored for some field types (see below).
//   required_fail: The text to print when data is required in the field
//     but none was supplied.  See below for how the string is seen.
//
// If you want validation to take place as the user is working, call the
// following function from the form element's onChange handler:
//   validate_checkone(form_element, noisy_flag)
// The parameters have the following meanings:
//   form_element: The Javascript object of the form element that was
//     given in the validate_addelement() call.  From within an element's
//     onChange handler, the keyword "this" refers to the object.
//   noisy_flag: A boolean value indicating that if the element fails
//     validation, an alert box should appear containing the corresponding
//     message from the validate_addelement() call.
// Note that validate_checkone() returns a true or false value to indicate
// the outcome of the validation regardless of the value of the noisy_flag
// parameter.
//
// To check all of the elements at once, call the following function:
//   validate_checkall(noisy_flag)
// The parameter has the following meaning:
//   noisy_flag: A boolean value indicating that if an element fails
//     validation, an alert box should appear containing the corresponding
//     message(s) from the validate_addelement() call(s).
// validate_checkall() is typically called just before the form is
// submitted, either from the form's onSubmit handler or the submit
// button's onClick handler.  Note that validate_checkall() returns a true
// or false value to indicate the outcome of the validation regardless of
// the value of the noisy_flag parameter.
//
// NOTE: The element types below dealing with credit card account numbers
// only validate that (1) the account number is the correct length, (2) the
// account number passes the LUHN formula and (3) the number falls within
// a range allocated for the given account provider.  They do not verify
// that the account actually exists.
//
// The valid element type strings are as follows:
//   "americanexpress": A TEXT or TEXTAREA that contains a valid American
//     Express account number with no spaces or dashes.
//   "candianzip": A TEXT or TEXTAREA that contains a Canadian ZIP code
//     (three alphanumeric characters, a space and three more alphanumeric
//     characters).
//   "checkbox": A CHECKBOX.  No validation is done on checkboxes at
//     all -- it is only included for completeness.
//   "creditcard": An "americanexpress", "dinersclub", "discover", "jcb",
//     "mastercard" or "visa"
//   "date": A TEXT or TEXTAREA that contains a date.  Must be in
//     numeric notation and can use either dashes or slashes as
//     separators.  Four digit years must be used.
//   "datetime": A TEXT or TEXTAREA that contains a date followed by a
//     time.  The date is validated as above for "date".  The time can be
//     in either civilian (12-hour) format or military (24-hour) format.
//     Seconds can be given.
//   "dinersclub": A TEXT or TEXTAREA that contains a valid Diner's Club
//     account number with no spaces or dashes.
//   "discover": A TEXT or TEXTAREA that contains a valid Discover
//     account number with no spaces or dashes.
//   "email": A TEXT or TEXTAREA that contains an email address: one or
//     more characters followed by a '@', followed by one or more
//     characters that contain at least one period.
//   "float": A TEXT or TEXTAREA that contains a real number.  Can use
//     scientific notation.
//   "integer": A TEXT or TEXTAREA that contains an integer number.
//     Can use scientific notation.
//   "jcb": A TEXT or TEXTAREA that contains a valid JCB account number
//     with no spaces or dashes.
//   "mastercard": A TEXT or TEXTAREA that contains a valid MasterCard
//     account number with no spaces or dashes.
//   "mssqldate": A "date" that MS SQL Server will accept (i.e.
//     1/1/1753 or later).
//   "mssqldatetime": A "datetime" that MS SQL Server will accept (i.e.
//     1/1/1753 12:00 AM or later).
//   "number": A number, either an "integer" or a "float".
//   "phone": A TEXT or TEXTAREA that contains a phone number.  It will
//     take a large number of inputs.  Basically, a phone number is a
//     collection of seven or more numbers.  The first three numbers can
//     be separated from the others by a dash, a comma or a period and one
//     or more spaces.  If an area code is given, it must be three digits
//     long.  It may be surrounded by parenthesis and separated from the
//     rest of the numbers by a dash, a comma or a period and one or more
//     spaces.  An extension, if provided, can be up to six digits and can
//     be separated from the rest of the numbers by an 'x', an 'X', a dash,
//     a comma, a period, "ext" with any capitalization and optionally
//     followed by a period.
//   "radio": A RADIO.  No format validation is done on radio buttons,
//     but they can be checked to see if a choice has been made.
//   "select": A SELECT.  No format validation is done on select fields,
//     but they can be checked to see that both a value has been selected
//     and that value is not zero-length.
//   "text": A TEXT or TEXTAREA.  No format validation is done on text
//     fields.
//   "uszip": A TEXT or TEXTAREA that contains a U.S. ZIP code (a five
//     digit number optionally followed by a dash and four more digits).
//   "visa": A TEXT or TEXTAREA that contains a valid Visa account number
//     with no spaces or dashes.
//   "zip": A "uszip" or a "canadianzip".
// ======================================================================

var validate_elements = new Array();

function validate_element(form_element, element_type, format_fail, required_flag, required_fail)
  {
  this.form_element = form_element;
  this.element_type = element_type;
  this.format_fail = format_fail;
  this.required_flag = required_flag;
  this.required_fail = required_fail;

  return(true);
  }

function validate_addelement(form_element, element_type, format_fail, required_flag, required_fail)
  {
  var new_element = new validate_element(form_element, element_type, format_fail, required_flag, required_fail);

  validate_elements[validate_elements.length] = new_element;

  return(true);
  }
function validate_checkone(form_element, noisy_flag)
  {
  var i;
  var element_index = -1;
  var tmp_return = false;

  for (i = 0; (i < validate_elements.length) && (element_index == -1); i++)
    if (validate_elements[i].form_element == form_element)
      element_index = i;

  if (element_index != -1)
    if (validate_elements[element_index].required_flag)
      if (!validate_containsData(validate_elements[element_index]))
        {
        if (noisy_flag)
          validate_elementFail(validate_elements[element_index], validate_elements[element_index].required_fail);
        }
      else if (!validate_isFormat(validate_elements[element_index]))
        {
        if (noisy_flag)
          validate_elementFail(validate_elements[element_index], validate_elements[element_index].format_fail);
        }
      else
        tmp_return = true;
    else
      if (!validate_isFormat(validate_elements[element_index]))
        {
        if (noisy_flag)
          validate_elementFail(validate_elements[element_index], validate_elements[element_index].format_fail);
        }
      else
        tmp_return = true;

  return(tmp_return);
  }
function validate_checkall(noisy_flag)
  {
  var i;
  var tmp_return = true;

  for (i = 0; (i < validate_elements.length) && tmp_return; i++)
    if (validate_elements[i].required_flag)
      {
      if (!validate_containsData(validate_elements[i]))
        {
        if (noisy_flag)
          validate_elementFail(validate_elements[i], validate_elements[i].required_fail);
        tmp_return = false;
        }
      else if (!validate_isFormat(validate_elements[i]))
        {
        if (noisy_flag)
          validate_elementFail(validate_elements[i], validate_elements[i].format_fail);
        tmp_return = false;
        }
      }
    else
      if (!validate_isFormat(validate_elements[i]))
        {
        if (noisy_flag)
          validate_elementFail(validate_elements[i], validate_elements[i].format_fail);
        tmp_return = false;
        }

  return(tmp_return);
  }
function validate_elementFail(validate_object, fail_text)
  {
  alert(fail_text);
  validate_doSelect(validate_object);

  return(true);
  }

// ========================================
// containsData validation functions
// ========================================
function validate_containsData(validate_object)
  {
  var tmp_return = false;

  switch (validate_object.element_type)
    {
    case "creditcard":
    case "visa":
    case "mastercard":
    case "americanexpress":
    case "dinersclub":
    case "discover":
    case "jcb":
    case "phone":
    case "email":
    case "number":
    case "float":
    case "integer":
    case "date":
    case "datetime":
    case "mssqldate":
    case "mssqldatetime":
    case "uszip":
    case "canadianzip":
    case "zip":
    case "text":
      tmp_return = validate_textContainsData(validate_object);
      break;
    case "radio":
      tmp_return = validate_radioContainsData(validate_object);
      break;
    case "select":
      tmp_return = validate_selectContainsData(validate_object);
      break;
    case "checkbox":
      tmp_return = true;
    }

  return(tmp_return);
  }
function validate_textContainsData(validate_object)
  {
  var tmp_return = (validate_object.form_element.value.length > 0) ? true : false;

  return(tmp_return);
  }
function validate_radioContainsData(validate_object)
  {
  var i;
  var tmp_return = false;

  for (i = 0; (i < validate_object.form_element.length) && !tmp_return; i++)
    tmp_return = validate_object.form_element[i].checked;

  return(tmp_return);
  }
function validate_selectContainsData(validate_object)
  {
  return(((validate_object.form_element.selectedIndex >= 0) && (validate_object.form_element.options[validate_object.form_element.selectedIndex].value.length > 0)) ? true : false);
  }

// ========================================
// Format validation functions
// ========================================
function validate_isFormat(validate_object)
  {
  var tmp_return;

  switch (validate_object.element_type)
    {
    case "phone":
      tmp_return = validate_isPhone(validate_object);
      break;
    case "email":
      tmp_return = validate_isEmail(validate_object);
      break;
    case "number":
      tmp_return = validate_isNumber(validate_object);
      break;
    case "float":
      tmp_return = validate_isFloat(validate_object);
      break;
    case "integer":
      tmp_return = validate_isInteger(validate_object);
      break;
    case "datetime":
      tmp_return = validate_isDatetime(validate_object);
      break;
    case "date":
      tmp_return = validate_isDate(validate_object);
      break;
    case "mssqldate":
      tmp_return = validate_isMssqldate(validate_object);
      break;
    case "mssqldatetime":
      tmp_return = validate_isMssqldatetime(validate_object);
      break;
    case "text":
    case "select":
    case "radio":
    case "checkbox":
      tmp_return = true;
      break;
    case "creditcard":
      tmp_return = validate_isCreditCard(validate_object);
      break;
    case "visa":
      tmp_return = validate_isVisa(validate_object);
      break;
    case "mastercard":
      tmp_return = validate_isMasterCard(validate_object);
      break;
    case "americanexpress":
      tmp_return = validate_isAmericanExpress(validate_object);
      break;
    case "dinersclub":
      tmp_return = validate_isDinersClub(validate_object);
      break;
    case "discover":
      tmp_return = validate_isDiscover(validate_object);
      break;
    case "jcb":
      tmp_return = validate_isJCB(validate_object);
      break;
    case "zip":
      tmp_return = validate_isUSZIP(validate_object) || validate_isCanadianZIP(validate_object);
      break;
    case "uszip":
      tmp_return = validate_isUSZIP(validate_object);
      break;
    case "canadianzip":
      tmp_return = validate_isCanadianZIP(validate_object);
    }

  return(tmp_return);
  }
function validate_isDate(validate_object)
  {
  var tmp_return = true;

  if (validate_object.form_element.value.replace(/^((0?[1-9])|(1[0-2]))[-\/]((0?[1-9])|([1-2][0-9])|(3[0-1]))[-\/](([1-9][0-9]{3})|(0[1-9][0-9]{2})|(00[1-9][0-9])|(000[1-9]))$/, "").length > 0)
    tmp_return = false;
  else
    validate_object.form_element.value = validate_object.form_element.value.replace(/-/g, "\/");

  return(tmp_return);
  }
function validate_isDatetime(validate_object)
  {
  var tmp_return = true;

  if (validate_object.form_element.value.replace(/^((0?[1-9])|(1[0-2]))[-\/]((0?[1-9])|([1-2][0-9])|(3[0-1]))[-\/](([1-9][0-9]{3})|(0[1-9][0-9]{2})|(00[1-9][0-9])|(000[1-9])) (0?[1-9]|1[0-2]):(0?[1-9]|[0-5][0-9]) [aApP][mM]$/, "").length > 0)
    tmp_return = false;
  else
    validate_object.form_element.value = validate_object.form_element.value.replace(/-/g, "\/");

  return(tmp_return);
  }
function validate_isMssqldate(validate_object)
  {
  var tmp_return = validate_isDate(validate_object);
  var tmp_date;

  if (tmp_return == true)
    {
    tmp_date = new Date(validate_object.form_element.value);
    if (tmp_date.getFullYear() < 1753)
      tmp_return = false;
    }

  return(tmp_return);
  }
function validate_isMssqldatetime(validate_object)
  {
  var tmp_return = validate_isDatetime(validate_object);
  var tmp_date;

  if (tmp_return == true)
    {
    tmp_date = new Date(validate_object.form_element.value);
    if (tmp_date.getFullYear() < 1753)
      tmp_return = false;
    }

  return(tmp_return);
  }
function validate_isFloat(validate_object)
  {
  var tmp_return = true;

  if (validate_object.form_element.value.replace(/^[-+]?(([0-9]*)|([0-9]{1,3}(\,[0-9]{3})*))\.[0-9]+([eE][-+]?(([0-9]+)|([0-9]{1,3}(\,[0-9]{3})*))(\.[0-9]+)?)?$/, "").length > 0)
    tmp_return = false;

  return(tmp_return);
  }
function validate_isInteger(validate_object)
  {
  var tmp_return = true;

  if (validate_object.form_element.value.replace(/^[-+]?(([0-9]+)|([0-9]{1,3}(\,[0-9]{3})*))([eE]?(([0-9]+)|([0-9]{1,3}(\,[0-9]{3})*)))?$/, "").length > 0)
    tmp_return = false;

  return(tmp_return);
  }
function validate_isNumber(validate_object)
  {
  var tmp_return = validate_isFloat(validate_object) || validate_isInteger(validate_object);

  return(tmp_return);
  }
function validate_isEmail(validate_object)
  {
  var tmp_return = true;

  if (validate_object.form_element.value.replace(/^[^\@]+\@[^\@]+\.[^\@\.]+$/, "").length > 0)
    tmp_return = false;

  return(tmp_return);
  }
function validate_isPhone(validate_object)
  {
  var tmp_return = true;

  if (validate_object.form_element.value.replace(/^(((\([0-9]{3}\))|([0-9]{3})) *(-|,|\.)? *)?[0-9]{3} *(-|,|\.)? *[0-9]{4} *(([xX-]|,|\.|([eE][xX][tT]\.?))? *[0-9]{1,6})?$/, "").length > 0)
    tmp_return = false;

  return(tmp_return);
  }
function validate_isCreditCard(validate_object, card_type)
  {
  var tmp_return;

  switch (card_type)
    {
    case "visa":
      tmp_return = validate_isVisa(validate_object);
      break;
    case "mastercard":
      tmp_return = validate_isMasterCard(validate_object);
      break;
    case "americanexpress":
      tmp_return = validate_isAmericanExpress(validate_object);
      break;
    case "dinersclub":
      tmp_return = validate_isDinersClub(validate_object);
      break;
    case "discover":
      tmp_return = validate_isDiscover(validate_object);
      break;
    case "jcb":
      tmp_return = validate_isJCB(validate_object);
      break;
    default:
      tmp_return = validate_isVisa(validate_object) ||
                   validate_isMasterCard(validate_object) ||
                   validate_isAmericanExpress(validate_object) ||
                   validate_isDinersClub(validate_object) ||
                   validate_isDiscover(validate_object) ||
                   validate_isJCB(validate_object);
    }

  return(tmp_return);
  }
// ===============================================================================
// The values for these credit card validation functions came from the NOVA EDC
// Technical Specifications Version 3.20a, part of the NOVA Script Server
// documentation.
// ===============================================================================
function validate_isVisa(validate_object)
  {
  var tmp_return = false;

  if (((validate_object.form_element.value.length == 13) ||
       (validate_object.form_element.value.length == 16)) &&
      (Number(validate_object.form_element.value.charAt(0)) == 4) &&
      validate_calculate_mod10(validate.form_element.value))
    tmp_return = true;

  return(tmp_return);
  }
function validate_isMasterCard(validate_object)
  {
  var tmp_return = false;

  if ((validate_object.form_element.value.length == 16) &&
      (Number(validate_object.form_element.value.substring(0, 1)) >= 50) &&
      (Number(validate_object.form_element.value.substring(0, 1)) <= 55) &&
      validate_calculate_mod10(validate.form_element.value))
    tmp_return = true;

  return(tmp_return);
  }
function validate_isAmericanExpress(validate_object)
  {
  var tmp_return = false;

  if ((validate_object.form_element.value.length == 15) &&
      ((Number(validate_object.form_element.value.substring(0, 1)) == 34) ||
       (Number(validate_object.form_element.value.substring(0, 1)) == 37)) &&
      validate_calculate_mod10(validate.form_element.value))
    tmp_return = true;

  return(tmp_return);
  }
function validate_isDinersClub(validate_object)
  {
  var tmp_return = false;

  if ((validate_object.form_element.value.length == 14) &&
      (((Number(validate_object.form_element.value.substring(0, 2)) >= 300) &&
        (Number(validate_object.form_element.value.substring(0, 2)) <= 305)) ||
       (Number(validate_object.form_element.value.substring(0, 1)) == 36)) &&
      validate_calculate_mod10(validate.form_element.value))
    tmp_return = true;

  return(tmp_return);
  }
function validate_isDiscover(validate_object)
  {
  var tmp_return = false;

  if ((validate_object.form_element.value.length == 16) &&
      (Number(validate_object.form_element.value.substring(0, 3)) == 6011) &&
      validate_calculate_mod10(validate.form_element.value))
    tmp_return = true;

  return(tmp_return);
  }
function validate_isJCB(validate_object)
  {
  var tmp_return = false;

  if ((validate_object.form_element.value.length == 16) &&
      ((Number(validate_object.form_element.value.substring(0, 3)) >= 3528) ||
       (Number(validate_object.form_element.value.substring(0, 2)) <= 358)) &&
      validate_calculate_mod10(validate.form_element.value))
    tmp_return = true;

  return(tmp_return);
  }
function validate_isUSZIP(validate_object)
  {
  var tmp_return = false;

  if (validate_object.form_element.value.replace(/^[0-9]{5}(-[0-9]{4})?$/, "").length == 0)
    tmp_return = true;

  return(tmp_return);
  }
function validate_isCanadianZIP(validate_object)
  {
  var tmp_return = false;

  if (validate_object.form_element.value.replace(/^[0-9a-zA-Z]{3} [0-9a-zA-Z]{3}$/, "").length == 0)
    tmp_return = true;

  return(tmp_return);
  }

// ========================================
// doSelect functions
// ========================================
function validate_doSelect(validate_object)
  {
  var tmp_return = true;
  
  switch (validate_object.element_type)
    {
    case "creditcard":
    case "visa":
    case "mastercard":
    case "americanexpress":
    case "dinersclub":
    case "discover":
    case "jcb":
    case "phone":
    case "email":
    case "number":
    case "float":
    case "integer":
    case "datetime":
    case "mssqldate":
    case "mssqldatetime":
    case "date":
    case "zip":
    case "uszip":
    case "canadianzip":
    case "text":
      validate_textSelect(validate_object);
      break;
    case "select":
    case "checkbox":
      validate_selectSelect(validate_object);
      break;
    case "radio":
      validate_radioSelect(validate_object);
    }

  return(tmp_return);
  }
function validate_textSelect(validate_object)
  {
  var tmp_return = true;

  validate_object.form_element.focus();
  validate_object.form_element.select();

  return(tmp_return);
  }
function validate_selectSelect(validate_object)
  {
  var tmp_return = true;

  validate_object.form_element.focus();

  return(tmp_return);
  }
function validate_radioSelect(validate_object)
  {
  var tmp_return = true;

  validate_object.form_element[0].focus();

  return(tmp_return);
  }

// ========================================
// Other functions
// ===============================================================================
// validate_calculate_mod10 implements the LUHN formula for verifying credit card
// numbers.  The algorithm works like this: Moving from right to left, every other
// digit in the Primary Account Number (PAN) is doubled, starting with the second-
// from-the-right digit (the rightmost digit is _not_ doubled).  If the result of
// the doubling is greater than 10, the two digits of the result are added
// together.  In other words, 6 doubled is 3:
//   6 x 2 = 12   and   1 + 2 = 3
// The sum of the doubled digits is added to the sum of the undoubled digits.  If
// the total is evenly divisible by 10, the PAN is valid.
// ===============================================================================
function validate_calculate_mod10(PAN_string)
  {
  var i;
  var double_values = new Array(0, 2, 4, 6, 8, 1, 3, 5, 7, 9);
  var double_next = false;
  var total = 0;
  
  for (i = PAN_string.length - 1; i >= 0; i--)
    {
    total += double_next ? double_values[Number(PAN_string.charAt(i))] : Number(PAN_string.charAt(i));
    double_next = !double_next;
    }

  return(((total % 10) == 0) ? true : false)
  }
