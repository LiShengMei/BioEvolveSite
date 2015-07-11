<script language="vb" runat="server">

Dim TempN As Integer = -1
Public CartTotalItems As Integer = 0
Public CartPrice(1) As Single
Public CartDesc(1) As String
Public CartID(1) As String
Public CartQuantity(1) As String
Public CartPID(1) As Integer
Public CartSSID(1) As Integer
Public CartOrderTotal As Single
Public CartTotal As Single
Public CartNumRows As Integer = 0
Public CartII As Integer = 0
Public TestTheName As String
Public TestTheLocation As String
Public TestTheNote As String
Public TestTheProduct AS String
Public TestThePID AS String


Sub DoSearch()

	Response.Redirect("http://www.biosensepharmacy.com/productlist.aspx?S=S&T=" & SearchTerm.Text)
	
End Sub


Public Function NthIndexOf(s As String, t As Char, n As Integer) As Integer
    Dim count As Integer = 0
    For i As Integer = 0 To s.Length - 1
        If s(i) = t Then
            count += 1
            If count = n Then
                Return i
            End If
        End If
    Next
    Return -1
End Function

Sub GetSmallCart()

      Dim Cartconn As New System.Data.SqlClient.SqlConnection(ConnString)
      Dim Cartdr As System.Data.SqlClient.SqlDataReader
      Dim Cartsql As New System.Data.SqlClient.SqlCommand
	  Dim II As Integer = 0
	  Dim TmpSt(1) As String
		
		CartNumRows = 0	  
		Cartconn.Open()
        Cartsql = New System.Data.SqlClient.SqlCommand("SELECT COUNT(*) As NumRows FROM TempItem WHERE OrderID = " & Session("OrderID") , Cartconn)
        Cartdr = Cartsql.ExecuteReader()
        If Cartdr.Read Then
            CartNumRows = Cartdr("NumRows")
        Else
            CartNumRows = 0
        End If
        Cartdr.Close()
        If CartNumRows > 0 Then
            ReDim CartPrice(CartNumRows+1)
            ReDim CartDesc(CartNumRows+1)
            ReDim CartID(CartNumRows+1)
            ReDim CartQuantity(CartNumRows+1)
			ReDim CartPID(CartNumRows+1)
			ReDim CartSSID(CartNumRows+1)

 
            If Session("InCAD") <> 1 Then
                Cartsql = New System.Data.SqlClient.SqlCommand("SELECT  Quantity,SSID,ProductID,[Desc],Price,ID FROM TempItem WHERE OrderID = " & Session("OrderID") & " ORDER BY ID DESC", Cartconn)
            Else
                Cartsql = New System.Data.SqlClient.SqlCommand("SELECT  Quantity,SSID,ProductID,[Desc],PriceC As Price,ID FROM TempItem WHERE OrderID = " & Session("OrderID") & " ORDER BY ID DESC", Cartconn)
            End If
            
            Cartdr = Cartsql.ExecuteReader()
			CartTotal = 0
            II = -1
            While Cartdr.Read 
                II = II + 1
'                If II < 3 Then
					CartPrice(II) = Cartdr("Price")
	                CartDesc(II) = Cartdr("Desc")
	                CartID(II) = Cartdr("ID")
	                CartQuantity(II) = Cartdr("Quantity")
					CartPID(II) = Cartdr("ProductID")
					CartSSID(II) = Cartdr("SSID")
'				End If
				CartTotalItems = CartTotalItems + 1
				CartTotal = CartTotal + (CartPrice(II) * CartQuantity(II))
			End While
			Cartdr.Close
			II = -1
		End If			
		Cartconn.Close()
		Cartconn = nothing
End Sub

Sub GetTestimonial()

        Dim conn As New SqlConnection(ConnString)
        Dim dr As SqlDataReader
        Dim sql As New SqlCommand
		Dim TempInt As Integer
		Dim II As Integer = 0		       
'	    Dim TestNumRows As Integer = 0
		conn.Open()
    
        Dim RandomClass As New Random()
		TempInt = RandomClass.Next(-1, 3)
	
'		TestNumRows = 5
			
	    sql = New SqlCommand("SELECT TOP 5 Testimonials.Name,Testimonials.Location,Testimonials.Note, Testimonials.ProductID, Products.Name AS PName From Testimonials LEFT JOIN Products ON Testimonials.ProductID = Products.ProductID WHERE Approved <> 0 AND Site=" & Session("TheCurrentSite") & " ORDER BY [Date] DESC, ID DESC", conn)
        dr = sql.ExecuteReader()
        II = -1
            While dr.Read AND II <= TempInt
                
				II = II + 1
                TestTheName = dr("Name")
                TestTheLocation = dr("Location")
             '   TheID(II) = dr("ID")
                TestTheNote = dr("Note")
				If NOT IsDBNull(dr("PName")) Then
					TestTheProduct = dr("PName")
					TestThePID = dr("ProductID")
				End If
            End While
            dr.Close()



		conn.Close
		dr = nothing
		sql = nothing
		conn = nothing


End Sub

</script>
    <!-- Bootstrap -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/styletest.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Overlock' rel='stylesheet' type='text/css'>

<script>(function() {
 var _fbq = window._fbq || (window._fbq = []);
 if (!_fbq.loaded) {
 var fbds = document.createElement('script');
 fbds.async = true;
 fbds.src = '//connect.facebook.net/en_US/fbds.js';
 var s = document.getElementsByTagName('script')[0];
 s.parentNode.insertBefore(fbds, s);
 _fbq.loaded = true;
 }
 _fbq.push(['addPixelId', '1447412168909237']);
 })();
 window._fbq = window._fbq || [];
 window._fbq.push(['track', 'PixelInitialized', {}]);
 </script>
 <noscript><img height="1" width="1" alt="" style="display:none" src="https://www.facebook.com/tr?id=1447412168909237&amp;ev=PixelInitialized" /></noscript>
  </head>
  <body>
  
  <div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.0";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>


<form runat="server">
  <!-- NAVBAR -->
   <!--Navbar-->
<div class="container">
<header>
	<div class="navbar navbar-default">
<div class="col-sm-2">
            <a class="navbar-brand" rel="home" href="http://www.biosensepharmacy.com/"><img src="/logo/biosense.png" alt=Biosense Pharmacy></a>
</div>
       		<div id="headnav" class="collapse navbar-collapse">
<div class="col-sm-6">
		<ul class="nav navbar-nav">
                    <li>
                    	<a href="http://www.biosensepharmacy.com/">Home</a>
                        </li><li>
                        	<a href="http://www.biosensepharmacy.com/about.aspx">About</a>
                            </li>
                            <li>
                        	<a href="http://www.biosensepharmacy.com/shipping.aspx">Shipping</a>
                            </li>
                            <li>
                            <a href="http://www.biosensepharmacy.com/faq.aspx">Faq</a>
                            </li>
                            <li>
                        	<a href="http://www.biosensepharmacy.com/contact.aspx">Contact</a>
                            </li>            
		
        </ul>
</div>
        
           
                
        		<div class="col-sm-4 pull-right">
        <a href="<% TempN = NthIndexOf(Request.ServerVariables("URL"),"/",2)
	If TempN > -1 Then
	  Response.Write(Strings.Left(Request.ServerVariables("URL"), Len(Request.ServerVariables("URL")) - (Len(Request.ServerVariables("URL")) - Strings.InStrRev(Request.ServerVariables("URL"), "/")) - TempN - 1) & "/cn" & Request.ServerVariables("URL") & "?" & Request.ServerVariables("QUERY_STRING")) 
	
	Else
	  Response.Write(Strings.Left(Request.ServerVariables("URL"), Len(Request.ServerVariables("URL")) - (Len(Request.ServerVariables("URL")) - Strings.InStrRev(Request.ServerVariables("URL"), "/")) - 1) & "/cn" & Request.ServerVariables("URL") & "?" & Request.ServerVariables("QUERY_STRING")) 
      End If %>"><asp:button Class="btn btn-default navbar-btn" style="margin:8px 8px 8px 0">中文</asp:button></a>
        <ul class="hovercart">
    <li class="dropdown">
                            	<a href="http://www.biosensepharmacy.com/cart.aspx"><asp:button Class="btn btn-default navbar-btn"><i class="glyphicon glyphicon-shopping-cart shopping-cart"></i>Cart(<%= CartTotalItems %>)</asp:button></a>                                                          
         								<ul class="dropdown-menu multi-level" role="menu" aria-labelledby="dropdownMenu">
                                          <table>
                                          <caption>Your Shopping Cart</caption>
                                          <tr>
                                            <th>Item</th>
                                            <th>&nbsp;</th>
                                            <th>Price</th>
                                            <th>&nbsp;</th>
                                          </tr>
 <% CartII = 0 
	 While CartII < CartTotalItems
	 CartII = CartII + 1
%>	 
	 
                                          <tr>
                                            <td><a href="http://www.biosensepharmacy.com/detail.aspx?Z=<%= CartPID(CartII-1) %>"><%= CartQuantity(CartII-1) & " " & CartDesc(CartII-1) %></a></td>
                                            <td>&nbsp;</td>
                                            <td><%= FormatCurrency(CartPrice(CartII-1) * CartQuantity(CartII-1),2) %></td>
                                            <td style="text-align:center">&nbsp;</td>
                                          </tr>
  <% End While %>                                       
                                          <tr><td colspan="2" style="text-align:center"><h3>Subtotal</h3></td><td colspan="2"><h3><%= FormatCurrency(CartTotal,2) %></h3></td></tr>
                                         
                                          
                                          <tr><td colspan="4" style="text-align:center"><a href="http://www.biosensepharmacy.com/cart.aspx">Go to Cart</a></td></tr>
                                        </table>
                                        </ul>
                                        </li>
                           </li>
                           </ul>
        <% If Session("ClientID") = 0 Then %>
        <a href="http://www.biosensepharmacy.com/login.aspx"><asp:button Class="btn btn-default navbar-btn"><i class="glyphicon glyphicon-log-in"></i>Log In</asp:button></a> <% Else %>
<a href="http://www.biosensepharmacy.com/login.aspx?L=O"><asp:button Class="btn btn-default navbar-btn"><i class="glyphicon glyphicon-log-in"></i>Log Out</asp:button></a><% End If %>        
       			</div>
                
<div class="signupbar">
<a href="http://www.biosensepharmacy.com/signup.aspx"><img src="../images/characters/home-newsletter-subscribe.png" alt="Sign up for our Newsletter!" style="width:50%"/></a>
						</div>
                        
                <div class="col-sm-4 pull-right">
                <p>Currency <img src="/icons/<% If Session("InCAD") <> 0 Then Response.Write("cadflag.png") Else Response.Write("usdflag.png") %>" width="30px" alt="flag">  We Accept
                <img src="/icons/visa-curved-32px.png" width="30px" alt="visa accepted">
                <img src="/icons/mastercard-curved-32px.png" width="30px" alt="mastercard accepted">
                <img src="/icons/american-express-curved-32px.png" width="30px" alt="american express accepted">
                <img src="/icons/paypal-curved-32px.png" width="30px" alt="paypal accepted"></p>
                </div>
        <!--/.nav-collapse -->
    		</div>
	</div>
 <!--/navbar -->
 </header>

 
<main>
	<div class="col-md-12 headerbanner">
        <img class="img" src="/img/freeshipping.png" alt="Free Shipping!">
        <h2>FREE Expedited shipping to Canada & US on orders $199 or more!</h2>
        <h2>FREE Xpresspost shipping Internationally on orders $399 or more!</h2>
        <p style="text-align:right"><subscript>*This promotion may not apply to some items*</subscript></p>
        </div>
        <br>
 <div class="col-md-12">
 			<div class="navbar navbar-default">
  
					<div id="productnav" class="collapse navbar-collapse">
		
			<ul class="nav navbar-nav">
 							
       					 <li class="dropdown">
                            	<a href="#">
                                Health & Wellness
                                </a>                                                          
         								<ul class="dropdown-menu multi-level" role="menu" aria-labelledby="dropdownMenu">
                                         <li class="dropdown-submenu">
                                          <a tabindex="-1" href="#">Detox & Digestion</a>
                                          <ul class="dropdown-menu">
                                          <li><a tabindex="-1" href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Digestive+Enzyme">Digestive Enzyme</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Liver+Care">Liver Care</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Fiber">Fiber</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Probiotic">Probiotic</a></li>
                                            </ul>
                                          </li>
                                          <li class="dropdown-submenu">
                                            <a tabindex="-1" href="#">Nutritional Supplements</a>
                                            <ul class="dropdown-menu">
                                              <li><a tabindex="-1" href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Calcium+%26+Magnesium">Calcium & Magnesium</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Children+Supplements">Children Supplements</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Coenzyme+Q10">Coenzyme Q10</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Energy Boosting">Energy Boosting</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Eye+Supplement">Eye Supplement</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Ginkgo">Ginkgo</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Grape+Seed+Extract">Grape Seed Extract</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Joint+Health">Joint Health</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Liquid+Nutrients">Liquid Nutrients</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Men's+Health">Men's Health</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Omega+3">Omega 3</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Vitamins+%26+Minerals">Vitamins & Minerals</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Superfruits">Superfruits</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Women's+Health">Women's Health</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Others">Others</a></li>
                                            </ul>
                                          </li>   
                                          <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Weight+Loss+%26+Sports+Nutrition">Weight Loss & Sports Nutrition</a></li>
                                          <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Water+Filtration+System">Water Filtration System</a></li>
                                        </ul>
                                        </li>
                           	</li>
               				<li class="dropdown">
                            	<a href="#">
                                Skin Care/Makeup
                                </a>                                                        
         								<ul class="dropdown-menu multi-level" role="menu" aria-labelledby="dropdownMenu">
                                            <li><a tabindex="-1" href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Cleansers">Cleansers</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Exfoliators+%26+Peels">Exfoliators & Peels</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Face+Masks">Face Masks</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Face+Mists">Face Mists</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Face+Oil+%26+Serum">Face Oil & Serum</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Lash+Care">Lash Care</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Lip+Balm+%26+Treatment">Lip Balm & Treatment</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Makeup">Makeup</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Facial+Moisturizer">Facial Moisturizer</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Skin+Supplements">Skin Supplements</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Sun+Protection">Sun Protection</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Toners">Toners</a></li>
                                              <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Value+Sets">Value Sets</a></li>
                                        </ul>
                                     </li>
                         	<li class="dropdown">
                            	<a href="#">
                                Personal Care
                                </a>                                                          
         								<ul class="dropdown-menu multi-level" role="menu" aria-labelledby="dropdownMenu">
                                         	<li><a tabindex="-1" href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Body+Care">Body Care</a></li>
                                          	<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Breast+Care">Breast Care</a></li>
                                            <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Deodorant">Deodorant</a></li>
                                          	<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Feminine+Care">Feminine Care</a></li>
					  						<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Foot+Care">Foot Care</a></li>
                                          	<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Hand+%26+Nail+Care">Hand & Nail Care</a></li>
                                          	<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Hair+Care">Hair Care</a></li>
					  						<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Oral+Care">Oral Care</a></li>
                                        	<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Massage+Oils">Massage Oils</a></li>
					  <li class="dropdown-submenu">
                                            <a tabindex="-1" href="#">Sexual Wellness</a>
                                            <ul class="dropdown-menu">
                                              <li><a tabindex="-1" href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Personal+Lubricant">Personal Lubricant</a></li>
                                            </ul>
                                          </li>
                                        </ul>
                                        </li>
                 			
					<li class="dropdown">
                            	<a href="#">
                                OTC/Non-Prescription Drugs
                                </a>
                                <ul class="dropdown-menu multi-level" role="menu" aria-labelledby="dropdownMenu">
                                            	<li><a tabindex="-1" href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Allergy%2C+Sinus+%26+Nasal Care">Allergy, Sinus & Nasal Care </a></li>
                                              	<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Antiperspirant">Antiperspirant </a></li>
                                              	<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Baby+Care">Baby Care </a></li>
                                            	<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Cough+%26+Cold">Cough & Cold </a></li>
												<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Ear+%26+Eye+Care">Ear & Eye Care </a></li>
                                            	<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=First+Aid">First Aid </a></li>
												<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Nausea+%26+Stomach+Remedies">Nausea & Stomach Remedies </a></li>
                                            	<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Pain+%26+Fever">Pain & Fever </a></li>
                                                <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Skin+Spot+Lightening">Skin Spot Lightening </a></li>
												<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Sleep+Aids">Sleep Aids </a></li>
												<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Smoking+Cessation">Smoking Cessation </a></li>
                                                <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Vitamins">Vitamins </a></li>
												<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Wound+Care">Wound Care </a></li>
												<li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=C&C=Yeast+Infection">Yeast Infection </a></li>
                        		</ul>
                            </li>       

					<li class="dropdown musthave">
                            	<a href="http://www.biosensepharmacy.com/musthave.aspx">
                                Must Haves
                                </a>                                                          
         			
                                 </li>

    		<div class="pull-right">
 		<div class="input-group">
			<asp:Panel id="SearchPanel" runat="server" defaultbutton="SearchButton">
 <asp:textbox id="SearchTerm" placeholder="What are you looking for?" Columns="10" CssClass="form-control" runat="server" maxlength="99" />
                </asp:textbox>
			<div class="input-group-btn">
                           <asp:LinkButton id="SearchButton" runat="server" text="Q" CssClass="btn btn-default" value="1" onclick="DoSearch" /></asp:LinkButton>
			</div>
            </asp:Panel>				
		</div>
       	</div>
        </ul>
        
       				 </div>
        </div>

  <section>

			<div class="row">
				<div class="col-sm-3">
					<div class="left-sidebar">
                      <!--featured-products-->
                        <div class="panel panel-default">
                        <a href="http://www.biosensepharmacy.com/currentspecials.aspx" id="currentspecials">
								<div class="panel-heading">
									<h4 class="panel-title">
											Current Specials
									</h4>
								</div></a></div>
                        
                        <div id="cssmenu">
							<ul>
                            <li><h2>Featured Brands</h2></li>
                            <li class="has-sub"><a href="http://www.biosensepharmacy.com/bioevolve.aspx">Bioevolve</a>
										<ul>
											<li class="redoption"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76184">Bioevolve Pure Damask Rose Squalene Serum + B12 Plus+ Cream Special Gift Box Set</a></li>
                                            <li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76265">Breast Booster (BBB)</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76266">Easy Slim Treatment (BEST)</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76178">B12 Plus+ Cream </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76179">Pure Damask Rose Squalene Serum </a></li>
                                            <li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75819">Argan Oil Facial </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75818">Argan Oil Body </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75812">B12 Sublingual Drops </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75814">Vitamin D Drops</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76180">Baby Vitamin D Drops </a></li>
                                            <li class="last"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76155">Immunity and Support </a></li>
										</ul>
                            </li>
                            
                            <li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=68977">Bioevolve Numbing Cream</a>
                               
                           	<li class="has-sub"><a href="http://www.biosensepharmacy.com/purefresh.aspx">Bioevolve PureFresh</a>
										<ul>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76273">PureFresh Shampoo</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76274">PureFresh Conditioner</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76275">PureFresh Body Wash</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76276">PureFresh Shampoo & Conditioner Combo</a></li>
											<li class="last"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76277">PureFresh Travel Set Package</a></li>
										</ul>
							</li>
                            <li class="has-sub"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76264">EltaMD</a>
										<ul>
											<li class="last"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76264">UV Physical Broad-Spectrum SPF 41</a></li>
										</ul>
							</li>
                            <li class="has-sub"><a href="http://www.biosensepharmacy.com/reviive.aspx">Reviive</a>
										<ul>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76255">Reviive Shampoo</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76256">Reviive Conditioner</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76254">Reviive Body Wash</a></li>
											<li class="last"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76253">Reviive Toothpaste</a></li>
										</ul>
							</li>
                            <li class="has-sub"><a href="http://www.biosensepharmacy.com/nutrifii.aspx">Nutrifii</a>
										<ul>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76161">Magnical-D</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76134">MOA</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75792">Biopro-Q</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75777">Omega-Q</a></li>
                                           	<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75778">Optimals</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75776">Rejuveniix</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75810">Restoriix</a></li>
											<li class="last"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75775">Vinali</a></li>
										</ul>
							</li>
                            <li class="has-sub"><a href="http://www.biosensepharmacy.com/slenderiiz.aspx">Slenderiiz</a>
										<ul>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75940">Slenderiiz Weight Loss System</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75815">Weight Management System</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76279">PureNourish</a></li>
                                            <li class="last"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75946">Blender Bottle</a></li>
										</ul>
							</li>
                            <li class="has-sub"><a href="http://www.biosensepharmacy.com/puritii.aspx">Puritii</a>
										<ul>
											<li class="last"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75816">Water Filtration System</a></li>
										</ul>
							</li>
                            
                            </li>
                            <li class="has-sub"><a href="#">Common Over The Counter / Non-Prescription Items</a>
										<ul>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=25350">Drixoral Cold and Sinus</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=56598">Nicorette Inhaler</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=25273">Vitamin B12 Injectable</a></li>
                                            <li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=74112">Vitamin B6 injectable</a></li>
                            				<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=25277">Vitamin C injectable</a></li>
                            				<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=56250">Needles</a></li>
                                            <li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=55394">Lustra-AF Cream SPF20</a></li>
                                            <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=S&T=Ultraquin">Ultraquin</a></li>
                                            <li><a href="http://www.biosensepharmacy.com/productlist.aspx?S=S&T=Drysol">Drysol</a></li>
                                            <li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=68977">Bioevolve Numbing Cream</a></li>
                                            <li class="last"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75812">Bioevolve B12 Sublingual Drops</a></li>
                            </ul></li>
                            
                            <li class="has-sub" id="ilike"><a href="http://www.biosensepharmacy.com/ilike.aspx">Ilike</a>
										<ul>
											<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                                            Cleansers & Toners<span class="glyphicon glyphicon-chevron-right"></span></a>
                                            <ul class="dropdown-menu" role="menu">
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76261">Sour Cherry Cleansing Milk</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76163">Rose Petal Cleansing Milk</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75830">Lemon Cleansing Milk</a></li>
                                            <li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75832">Mineral Exfoliating Wash</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76260">Sour Cherry Toner</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76182">Rose Petal Toner</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75846">Stonecrop Toner</a></li>
                                            </ul>
                                            </li>
                                            <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                                            Exfoliators & Peels<span class="glyphicon glyphicon-chevron-right"></span></a>
                                            <ul class="dropdown-menu" role="menu">
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75903">Spinach & Horsetail Exfoliator</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75904">Sulphuric Exfoliator</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75905">Yogurt Power Peel</a></li>
                                            </ul>
                                            </li>
                                            <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                                            Ilike Masks<span class="glyphicon glyphicon-chevron-right"></span></a>
                                            <ul class="dropdown-menu" role="menu">
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76282">Hyaluronic Time Erase Mask</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76257">Grape Stem Cell Solution Gel Mask</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76165">Pumpkin & Orange Mask</a></li>
                                            <li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75906">Peach Mask</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75841">Rosehip Gel Mask</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75845">Sour Cherry Gel Mask</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75839">Rose Petal Gel Mask</a></li>
                                            <li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75829">Fibrous Stonecrop Gel Mask</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75843">Seven-Herb Mask</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76109">Phytoestrogen Gel Mask</a></li>
                                            </ul>
                                            </li>
                                            <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                                            Special Treatment<span class="glyphicon glyphicon-chevron-right"></span></a>
                                            <ul class="dropdown-menu" role="menu">
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76259">Grape Stem Cell Solutions Hydrating Mist</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75831">Magnetic Skin Therapy</a></li>
                                            </ul>
                                            </li>
                                            <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                                            Eye Care, Lip Care, Acne Care<span class="glyphicon glyphicon-chevron-right"></span></a>
                                            <ul class="dropdown-menu" role="menu">
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75907">Paprika Spot Treatment</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76189">Lip Balm - Lemon Citrus</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75909">Lip Balm - Cool Mint</a></li>
                                            </ul>
                                            </li>
                                            <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                                            Ilike Moisturizers<span class="glyphicon glyphicon-chevron-right"></span></a>
                                            <ul class="dropdown-menu" role="menu">
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76193">Softening Thermal Moisturizer</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75910">Rose Petal Whipped Moisturizer</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75847">Stonecrop Whipped Moisturizer</a></li>
                                            <li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76111">Phytoestrogen Moisturizer</a></li>
                                            </ul>
                                            </li>
                                            <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                                            Serums & Oil Concentrates<span class="glyphicon glyphicon-chevron-right"></span></a>
                                            <ul class="dropdown-menu" role="menu">
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75911">Skin Power</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76087">Brightening Serum</a></li>
                                            <li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75912">Phytoestrogen Serum</a></li>
                                            </ul>
                                            </li>
                                            <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                                            Body Treatment<span class="glyphicon glyphicon-chevron-right"></span></a>
                                            <ul class="dropdown-menu" role="menu">
											<li class="last"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76171">Stonecrop Body Lotion</a></li>
                                            </ul>
                                            </li>
										</ul>
                            </li>
                            <li class="has-sub" id="colorescience"><a href="http://www.biosensepharmacy.com/colorescience.aspx">Colorescience</a>
										<ul>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76283">Sunforgettable Mineral Powder Brush SPF 30 </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76286">Sunforgettable Mineral Powder Brush SPF 50 </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76289">Sunforgettable Hydrating Mist (Be Still) </a></li>
											<li class="last"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76290">Sunforgettable Setting Mist </a></li>
										</ul>
                            </li>    
							<li class="has-sub" id="sliquid"><a href="http://www.biosensepharmacy.com/sliquid.aspx">Sliquid</a>
										<ul>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76239">H<sub>2</sub>O Intimate Lubricant </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76240">Satin Natural Intimate Moisturizer </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76241">Intimate Hybrid Lubricant </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76242">Organics Natural </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76243">Organics O Gel </a></li>
                                            <li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76244">Splash Gentle Feminine Wash (Unscented) </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76245">Splash Gentle Feminine Wash (Honey Dew Cucumber) </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76246">Splash Gentle Feminine Wash (Mango Passion) </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76247">Splash Gentle Feminine Wash (Grapefruit Thyme)</a></li>
											<li class="last"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76248">Smooth Intimate Shave Cream </a></li>
										</ul>
                            </li>            
							<li class="has-sub" id="crystal"><a href="http://www.biosensepharmacy.com/crystal.aspx">Crystal</a>
										<ul>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76232">Body Deodorant Stick (Unscented) </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76230">Body Deodorant Travel Stick (Unscented) </a></li>
                                            <li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76233">Body Deodorant Stick for Men (Unscented) </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76229">Body Deodorant Roll On (Unscented) </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76234">Lavender & White Tea Essence Roll On </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76235">Pomegranate Essence Roll On  </a></li>
                                            <li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76238">Unscented Body Deodorant Body Spray </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76236">Lavender & White Tea Essence Body Spray </a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76237">Pomegranate Essence Body Spray </a></li>
											<li class="last"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76231">Unscented Body Deodorant Towelettes </a></li>
										</ul>
                            </li>            
							<li class="has-sub" id="divaderme"><a href="http://www.biosensepharmacy.com/productlist.aspx?S=S&T=Divaderme">Divaderme</a>
										<ul>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76181">Lash Extender + Mascara Combo</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76061">Lash Extender</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76062">Lash Extender II</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75823">Brow Extender</a></li>
                                            <li class="last"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75824">Divaderme Mascara</a></li>
										</ul>
                            </li>    
                            <li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=64918">Ribose</a>
                            <li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76094">Reishi Mushrooms</a>
                            <li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=67846">Serrapeptase</a>
                            <li class="has-sub" id="specialpackages"><a href="#">Special Packages</a>
										<ul> 
                                            <li class="redoption"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=76184">Bioevolve Pure Damask Rose Squalene Serum + B12 Plus+ Cream Special Gift Box Set</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75815">Slenderiiz Weightloss Package</a></li>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75816">Puritii Water Filter Package</a></li>
                                            <li class="last"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75950">Ilike Super Signature Mask Combo</a></li>
										</ul>
                            </li>     
                            <li class="has-sub" id="onlineexclusives"><a href="#">Online Exclusives</a>
										<ul>
											<li><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75952">Bioevolve Argan Face/Body/Hair Treatment Combo</a></li>
                                            <li class="last"><a href="http://www.biosensepharmacy.com/detail.aspx?Z=75776">Nutrifii Rejuveniix Dual Combo</a></li>
										</ul>
                            </li>                  
				<!--/featured-products-->
						</div><!--/cssmenu-->
<br />
				<div class="facebook">
					<div class="fb-like-box" data-href="https://www.facebook.com/BiosensePharmacy" data-width="242px" data-colorscheme="light" data-show-faces="true" data-header="false" data-stream="true" data-show-border="false"></div></div>
<br />             
					<div class="testimonials">
						<h4><%= TestTheName %></h4><h5><%= TestTheLocation %></h5>
						<p><%= TestTheNote %><% If TestTheProduct <> "" Then
                  Response.Write("<br \>Review for: <u><a href=""/detailtest.aspx?Z=" & TestThePID & """>" & TestTheProduct & "</a></u>") 
          End If  %></p>
						<a href="http://www.biosensepharmacy.com/testimonials.aspx">read more testimonials</a>
<br/>
					</div>
						
					</div><!--/left-sidebar-->
				</div><!--/col-sm-3-->