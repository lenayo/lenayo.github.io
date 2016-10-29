<%
Dim fwd
If Instr(LCase(Request.ServerVariables("SERVER_NAME")),"lee.dev.lookandfeel.com") > 0 Then
  fwd = "http://10easypieces.lee.dev.lookandfeel.com/thanks.html"
ElseIf Instr(LCase(Request.ServerVariables("SERVER_NAME")),"teneasypiecesstage") > 0 Then
  fwd = "http://10easypieces.lee.dev.lookandfeel.com/thanks.html"
ElseIf Instr(LCase(Request.ServerVariables("SERVER_NAME")),"167.64.49") > 0 Then
  fwd = "http://10easypieces.lee.dev.lookandfeel.com/thanks.html"
ElseIf (Instr(LCase(Request.ServerVariables("SERVER_NAME")), "vfstaging.dev.lookandfeel.com") > 0) Then
  fwd = "http://10easypieces.lee.dev.lookandfeel.com/thanks.html"
Else
  fwd = "http://www.10easypieces.com/thanks.html"
End If

Dim handler
If Instr(LCase(Request.ServerVariables("SERVER_NAME")),"lee.dev.lookandfeel.com") > 0 Then
  handler = "http://registration.lee.dev.lookandfeel.com/lee10easy.asp"
ElseIf Instr(LCase(Request.ServerVariables("SERVER_NAME")),"teneasypiecesstage") > 0 Then
  handler = "http://registration.lee.dev.lookandfeel.com/lee10easy.asp"
ElseIf Instr(LCase(Request.ServerVariables("SERVER_NAME")),"167.64.49") > 0 Then
  handler = "http://registration.lee.dev.lookandfeel.com/lee10easy.asp"
ElseIf (Instr(LCase(Request.ServerVariables("SERVER_NAME")), "vfstaging.dev.lookandfeel.com") > 0) Then
  handler = "http://registration.lee.dev.lookandfeel.com/lee10easy.asp"
Else
  handler = "http://registration.lee.lookandfeel.com/lee10easy.asp"
End If
%>
<html>
<head>
<title>10 Easy Pieces by RivetedbyLee</title>

<meta name="keywords" content="RivetedByLee, apparel, basic fashion,
casual, clothing, career casual, career clothing, casual friday, weekend
wardrobe, contemporary, career dressing, casual classics, casual
clothing,
casual dressing, classic clothing, clothes, denim, denim clothing,
fabrics,
fashion, fashion attitude, fit, fit finder, jackets, jean jackets,
jeans,
jeanswear, khaki, large sizes, lee, lee apparel company, lee jeans, lee
riveted, long, misses clothing, misses jeans, misses pants, misses tops,
misses shirts, misses skirts, misses shorts, jeans, overall, overalls,
pant, pants, petites, riveted, riveted by lee, shirt, shirts, short,
shorts, skirt, skirts, style, stylish clothes, stylish clothing, top,
tops,
twill, twills, updated, washable fabrics, washable, wardrobe, women's
fashion, women's sizes, womens clothing, womens jeans, working
wardrobe">

<meta name="description" content="RivetedByLee, classic styles for
contemporary women.  If you're looking for jeans, pants, shorts, skirts
or
tops, Riveted by Lee is your clothing solution.">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="JavaScript" src="changeimage.js">
</script>

<script language="Javascript" src="scroll.js">
</script>

<script language="JavaScript" src="smallpop.js">
</script>

<script language="JavaScript" type="text/javascript" src="validateEasyForm.js">
</script>

<style type="text/css">
<!--

body, td {
font-family: Verdana, sans-serif;
font-size: 12px;
color: #3D3C39;
}

.red {
color: #6E0000;
}

a:link { color: #6E0000}
a:active { color: #6E0000}
a:visited { color: #6E0000}
a:hover { color: #6E0000}

-->
</style>


</head>

<body bgcolor="#ffffff" text="#3D3C39" marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" background="images/form/bgimg-full.gif">
<table width="500"  border="0" cellspacing="0" cellpadding="0" align="center">
  
  <tr> 
    <td valign="top" align="center"><img src="images/form/req-cat-img.jpg" width="500" height="200" border="0"></td>
  </tr>

  <tr> 
    <td>&nbsp;</td>
  </tr>
  
  <tr> 
    <td width="500" align="center">
	
	<p>Want to get the 10 Easy Pieces for yourself?<br>
	Just fill in the form and we'll send you <br>
	your own catalog featuring <b>Riveted by Lee&reg;</b><br>
	products you can order directly from us.</p>

	
	</td> 
   </tr>
   
  <tr>
    <td valign="top"> 
      <form name="frm" action="<%=handler%>" method=post>
        <input type=hidden name="promo_name" value="10EasyCatalog">
        <input type=hidden name="return_url" value="<%=fwd%>">
        <table border=0 cellpadding=0 cellspacing=5 width="450" align="center">
          <tr> 
            <td valign=top width="368"> 
              <table border=0 width="450" cellpadding="0" cellspacing="10">
                
                <tr> 
                  <td valign=top width="250"><b> First Name<span class="red">*</span>:</b></td>
                  <td valign=top width="168"> 
                    <input name="first_name" size=30 maxlength=30 onChange="javascript:testText(this.value, 'Please enter your first name.')">
                  </td>
                </tr>
                
   
                <tr> 
                  <td valign=top width="250"><b>Last Name<span class="red">*</span>:</b></td>
                  <td valign=top width="168"> 
                    <input name="last_name" size=30 maxlength=30 onChange="javascript:testText(this.value, 'Please enter your last name.')">
                  </td>
                </tr>
                
                
                <tr> 
                  <td valign=top width="250"><b>Email Address<span class="red">*</span>:</b></td>
                  <td valign=top width="168"> 
                    <input name="email_address" size=30 maxlength=30 onChange="javascript:testEmail(this.value, 'Please enter a valid email (xxx@yyy.zzz).')">
                  </td>
                </tr>
                
                
                <tr> 
                  <td valign=top width="250"><b>Address 1<span class="red">*</span>:</b></td>
                  <td valign=top width="168"> 
                    <input name="address1" size=30 maxlength=30 onChange="javascript:testText(this.value, 'Please enter your street address.')">
                  </td>
                </tr>
                
                <tr> 
                  <td valign=top width="250"><b>Address 2:</b></td>
                  <td valign=top width="168"> 
                    <input name="address2" size=30 maxlength=30>
                  </td>
                </tr>
                
                
                <tr> 
                  <td valign=top width="250"><b>City<span class="red">*</span>:</b></td>
                  <td valign=top width="168"> 
                    <input name="city" size=30 maxlength=30 onChange="javascript:testText(this.value, 'Please enter your city.')">
                  </td>
                </tr>
                
                
                <tr> 
                  <td valign=top width="250"><b>State<span class="red">*</span>:</b></td>
                  <td valign=top width="168"> 
                    <select name="state" onChange="javascript:testSelected(this.selectedIndex, 'Please select a state.')">
                      <option value="" selected>Select State 
                      <option value="AL" >Alabama 
                      <option value="AK" >Alaska 
                      <option value="AZ" >Arizona 
                      <option value="AR" >Arkansas 
                      <option value="CA" >California 
                      <option value="CO" >Colorado 
                      <option value="CT" >Connecticut 
                      <option value="DE" >Delaware 
                      <option value="DC" >Dist. of Columbia 
                      <option value="FL" >Florida 
                      <option value="GA" >Georgia 
                      <option value="HI" >Hawaii 
                      <option value="ID" >Idaho 
                      <option value="IL" >Illinois 
                      <option value="IN" >Indiana 
                      <option value="IA" >Iowa 
                      <option value="KS" >Kansas 
                      <option value="KY" >Kentucky 
                      <option value="LA" >Louisiana 
                      <option value="ME" >Maine 
                      <option value="MD" >Maryland 
                      <option value="MA" >Massachusetts 
                      <option value="MI" >Michigan 
                      <option value="MN" >Minnesota 
                      <option value="MS" >Mississippi 
                      <option value="MO" >Missouri 
                      <option value="MT" >Montana 
                      <option value="NE" >Nebraska 
                      <option value="NV" >Nevada 
                      <option value="NH" >New Hampshire 
                      <option value="NJ" >New Jersey 
                      <option value="NM" >New Mexico 
                      <option value="NY" >New York 
                      <option value="NC" >North Carolina 
                      <option value="ND" >North Dakota 
                      <option value="OH" >Ohio 
                      <option value="OK" >Oklahoma 
                      <option value="OR" >Oregon 
                      <option value="PA" >Pennsylvania 
                      <option value="RI" >Rhode Island 
                      <option value="SC" >South Carolina 
                      <option value="SD" >South Dakota 
                      <option value="TN" >Tennessee 
                      <option value="TX" >Texas 
                      <option value="UT" >Utah 
                      <option value="VT" >Vermont 
                      <option value="VA" >Virginia 
                      <option value="WA" >Washington 
                      <option value="WV" >West Virginia 
                      <option value="WI" >Wisconsin 
                      <option value="WY" >Wyoming 
                    </select>
                  </td>
                
                
                <tr> 
                  <td valign=top width="250"><b>Zip:<span class="red">*</span>:</b></td>
                  <td valign=top width="168"> 
                    <input name="zip" size=10 maxlength=10 onChange="javascript:testText(this.value, 'Please enter your zip code.')">
                  </td>
                </tr>
                 </table></td></tr>
                
                <tr> 
                <td valign=top width="368"> 
                <table border=0 width="450" cellpadding="0" cellspacing="10">
                
             
                <tr>
                  <td valign=top width="450"><b>How did you hear about 10 Easy Pieces?<span class="red">*</span>:</b></td>
                  </tr>
                  
                  <tr>
                  <td valign=top width="450"> 
                    <select name="heard_how" onChange="javascript:testSelected(this.selectedIndex, 'Please tell us how you heard about 10 Easy Pieces')">
                      <option value="" selected>Select</option>
                      <option value="Received Catalog in Mail">Received Catalog in Mail</option>
                      <option value="Linked from Rivetedbylee.com">Linked from Rivetedbylee.com</option>
                      <option value="Saw an ad with web address 10easypieces.com">Saw an ad with web address
                      10easypieces.com</option>
                      <option value="A friend sent it to me">A friend sent it to me</option>
                      <option value="Other">Other</option>
                    </select>
                  </td>
                </tr>
                
                
               
                
                <tr>
				 <td width="400" align="left"><span class="small"><span class="red">* denotes required fields</span></span></td>
				</tr>
				
				
				<tr>
				<td><a href="#" onclick="openWindow('policy.html','window1','toolbar=no,location=no,status=yes,menubar=no,scrollbars=auto,resizable=no,width=300,height=300')"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>Privacy policy</b></font></a></td>
				</tr>
							
				
			
              </table>
          <tr> 
            <td colspan=2 align=center valign=top nowrap> 
              <input type=submit value="Submit" name="submit" onClick="javascript:return(validateAll())">
              &nbsp;&nbsp; 
              <input type=reset value="Clear" name="reset">
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
<p> <br>
<p> 
</body>
</html>


