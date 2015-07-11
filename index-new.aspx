<%@ Page Language="VB" %>
<%@ Import Namespace = "System.Data.SqlClient" %>
<!DOCTYPE html>
<!--#include file="/conn/conn.aspx"-->
<script language="vb" runat="server">
 
    Sub Page_Load()
        Dim conn As New SqlConnection(ConnString)
        Dim sql As New SqlCommand

GetSmallCart()

If NOT IsPostBack Then

conn.open

Dim IPAddr As String = Request.ServerVariables("REMOTE_ADDR")
Dim FullURL As String = "bioevolve.com" & Request.ServerVariables("URL") & "?" & Request.ServerVariables("QUERY_STRING")
Dim UserAgent As String = Request.ServerVariables("HTTP_USER_AGENT")
Dim TSql As String  = "INSERT INTO WebLogs ([Date],[Referer],[IP],[URL],[UserAgent],[NewSession],[Engine],[Country]) VALUES ('" & Now & "','" & SqlEnc(Session("Referer")) & "','" & IPAddr & "','" & SqlEnc(FullURL) & "','" & SqlEnc(UserAgent) & "'," & Session("NewSession") & ",'" & Session("SearchEngine") & "','" & Session("Country") & "')"
sql = New SqlCommand(TSql, conn)
sql.ExecuteNonQuery()
Session("NewSession") = 0

            conn.Close()
End If            
            sql = Nothing
            conn = Nothing
				
    End Sub


</script>

<!--#include file="menu-new.aspx"-->

<!--
	Landed by HTML5 UP
	html5up.net | @n33co
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>BioEvolve : Simply Effective</title>
		<meta charset="utf-8" />
		<!--[if lte IE 8]><script src="assets/css/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie/v9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie/v8.css" /><![endif]-->
		<!--[if lte IE 8]><script src="assets/css/ie/respond.min.js"></script><![endif]-->

  <!-- Syntax Highlighter -->
  <link href="css/shCore.css" rel="stylesheet" type="text/css" />
  <link href="shThemeDefault.css" rel="stylesheet" type="text/css" />
  <!-- Demo CSS -->
  <link rel="stylesheet" href="assets/css/main.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="assets/css/main.css" type="text/css" media="screen" />




<!-- A Slider -->

<script src="aslider.js"></script>
        <style>
            .aslide {
                display: none;
            }
            .aslide img {
                max-width: 100%;
                /*height : 720px;*/
                max-height: 550px;                
            }
            .aslider {
                width: 100%;
                height: 550px;
            }
            .aslide .text {
                margin: 0 auto;
                color: #f8f8f8;
                text-shadow: 0 0 2px #000;
                font-weight: bold;
                font-size: 36px;
                width: 100%;
                text-align: center;
                position: absolute;
                bottom: 30px;
                font-family: sans-serif;
            }
 
 			.aspright {
				margin: 0;
				float:right;
			}
 			.aspleft {
				margin: 0;
				float:left;
			}

        </style>


<!-- Search Bar -->


 <div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.0";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>



	</head>
	<body class="landing">
<form runat="server">
		<div id="page-wrapper">


				<!-- Header -->
				<header id="header">
					<h1 id="logo"><font color="1e1f27">__</font><a href="index.html">BioEv<font color="8dc63f">o</font>lve</a><font color="1e1f27">__</font></h1>
					
					<nav id="nav">
<ul>
							<!-- <li><strong>BioEv<font color="8dc63f">o</font>lve</strong></li> -->
							<li>
										<h6><a href="account_info.html">Hello, Name!</a></h6>
										<ul>
											<li><a href="account_info.html">My Account</a></li>
											<li><a href="account_orderhistory.html"> Order History</a></li>
											<li><a href="index.html">Log Out</a></li>
											<!-- <li><a href="#">Option 4</a></li> -->
										</ul>
							</li>
							<li><h6><a href="index.html">Home</a></li>
							<li><h6><a href="aboutus.html">About Us</a></li>
							<li><h6><a href="contactus.html">Contact Us</a></li>
							<li><a href="products.html"><h6>Products</h6></a>
								<ul>
									<li><a href="products_personalcare.html">Personal Care</a></li>
									<li><a href="products_nutritionalnaturopath.html"> Nutritional & Naturopath</a></li>
									<li><a href="products_clinicalmedicinal.html">Clinical Medicinal</a></li>
								</ul>
							</li>

							<li><h6><a href="wholesale.html">Wholesale</a></li>
							<li><h6><a href="shipping.html">Shipping</a></li>
							
							</li>
							<li><h6><a href="faq.html">FAQ</a></li>

							<li><a href="cart.html"><h6><font color="#8dc63f">VIEW CART</font></h6></a>
								<ul>
									<li>
										<div class="table-wrapper">
											<table class="alt">
												<thead>
													<tr>
														<th>Product</th>
														<th>Quantity</th>
														<th>Price</th>
													</tr>
												</thead>
												<tbody>
 <% CartII = 0 
	 While CartII < CartTotalItems
	 CartII = CartII + 1
%>	 
													<tr>
														<td><a href="http://www.biosensepharmacy.com/detail.aspx?Z=<%= CartPID(CartII-1) %>"><%= CartDesc(CartII-1) %></a></td>
														<td><%= CartQuantity(CartII-1) %></td>
														<td><%= FormatCurrency(CartPrice(CartII-1) * CartQuantity(CartII-1),2) %></td>
													</tr>
  <% End While %>                                       

												</tbody>
												<tfoot>
													<tr>
														<td colspan="2"></td>
														<td><%= FormatCurrency(CartTotal,2) %></td>
													</tr>
												</tfoot>
											</table>
										</div>
									</li>
									
									<li><a href="cart.html"> View Cart</a></li>
									<li><a href="checkout01.html"> Checkout</a></li>
								</ul>
							</li>
							<!-- Login/Account -->
							<li><a href="login.html" class="button small">Login</a></li>
							


							<li>
								
<asp:textbox id="SearchTerm" placeholder="Search" Columns="10" runat="server" maxlength="99"/></asp:textbox>
							</li>
							<li>
<asp:LinkButton id="SearchButton" CssClass="button small" runat="server" text="🔎"  value="1" onclick="DoSearch"  /></asp:LinkButton>																									
							</li>


							<!-- Search Bar -->

							<!-- <li>

								<a href="#" class="button special small">Search</a>
								<ul>
									<li class="12u$">
											<input type="text" name="name" id="name" value="" placeholder="Search" />
									</li>
									<li>
										<a href="#" class="button small">Search</a>
									</li>
								</ul>
							</li> -->


							<!-- <li>
								<form action="action_page.php">
  									<input type="search" name="googlesearch" id="test">
 									<a href="#" class="button small">Search</a>
								</form>
							</li> -->

							<li><h6><a href="#">中文</a><font color="000">__</font></li>
									
								
						</ul>
					</nav>
				</header>

			<!-- Banner -->
				<section id="banner">
					<div class="content">
						<header>
							<center>
							<h2>BioEv<font color="8dc63f">o</font>lve</h2>
							<h6>SIMPLY EFFECTIVE</h6>
							<h4>Ethical Science™<br>
								Conscience Completes Our Science</h4>



						<ul class="icons">
						<h3>
						<!-- <a href="https://twitter.com/hashtag/bioevolve"><img src="images/icons/icon-twitter.png" style="width:5%"></span></a> -->

						<a href="https://www.facebook.com/bioevolve"><img src="images/icons/icon-facebook.png" style="width:5%"></span></a>

						<a href="https://instagram.com/bioevolveglobal/"><img src="images/icons/icon-instagram.png" style="width:5%"></span></a>

						<a href="contactus.html"><img src="images/icons/icon-email.png" style="width:5%"></span></a>
						</h3>

						</ul>



						<!-- <ul class="icons">
						<li><a href="https://twitter.com/hashtag/bioevolve" class="icon alt fa-twitter"><span class="label">Twitter</span></a></li>
						<li><a href="https://www.facebook.com/bioevolve" class="icon alt fa-facebook"><span class="label">Facebook</span></a></li>
						<li><a href="https://instagram.com/bioevolveasia/" class="icon alt fa-instagram"><span class="label">Instagram</span></a></li>
						<li><a href="contactus.html" class="icon alt fa-envelope"><span class="label">Email</span></a></li>
					</ul> -->

					<h3><a href="newsletter.html"><img src="images/icons/icon-newsletter.png" style="width:25%"></a></h3>

					<!-- <a href="newsletter.html" class="button small">Subscribe to our Newsletter</a> -->
						</center>



						</header>
						<!-- <span class="image"><img src="images/pic01.jpg" alt="" /></span> -->
					</div>
					<a href="#secbanner" class="goto-next scrolly">Next</a>
				</section>






<!-- Banner -->
<section id="secbanner">

<!-- <img src="images/img_banner.jpg" alt="Banner" style="width: 100%"> -->
<!-- <a href="#one" class="goto-next scrolly">Next</a> -->


<!-- IDEAL BANNER SIZE:
	nth X 500 PX -->


<!-- A Slider -->
<div id="slider" class="aslider" data-duration="10" >

            <div class="aslide" data-duration="4">
                <center><img src="images/ban_01.jpg" style="width: 100%"/></center>
            </div>
            <div class="aslide" data-duration="5">
                <img src="images/ban_02.jpg" style="width: 100%"/>
            </div>
            <div class="aslide" data-duration="6">
                <img src="images/ban_03.jpg" style="width: 100%"/>
            </div>
            <div class="aslide" data-duration="7">
                <img src="images/ban_04.jpg" style="width: 100%"/>
            </div>
        </div>
 <center>
<a href="#one"><img src="images/img_scrollarrow.png" alt="ScrollArrow"></a>
</center>       
</div>



<!-- A Slider END -->
     
</section>



			<!-- One -->
				<section id="one" class="spotlight style1 bottom">
					<span class="image fit main"><img src="images/img_banner.jpg" alt="" /></span>
					<div class="content">
						<div class="container">
							<div class="row">
								<div class="4u 12u$(medium)">
									<header>					
										<h2>BioEvolve Brand Story</h2>
										<center>
										<p>The BioEvolve's product creators believe in “Ethical Science™”, the process of eliminating harmful ingredients and where nature versus science becomes nature with science.</p>
										</center>
									</header>
								</div>
								<div class="4u 12u$(medium)">
									<p>The inspiration behind the creation of the BioEvolve brand is to help solve two major problems in the world of health and beauty care products. These problems being the confusing and conflicting schools of thoughts on nature versus science and the unnecessary use of harmful ingredients to achieve results.
									</p>
								</div>
								<div class="4u$ 12u$(medium)">
									<p>With Bioevolve “Conscience completes our Science” by combining the best of science and nature to create the next evolution in “Safe and Simply Effective” products.
										<br><br>
									All of our Bioevolve products are made with the total health of the human in mind. Stringently screened by a team of experts, Bioevolve products are clean, safe and simply effective.</p>
								</div>
							</div>
						</div>
					</div>
					<a href="#two" class="goto-next scrolly">Next</a>
				</section>

			<!-- Two -->
				<section id="two" class="spotlight style2 right">
					<span class="image fit main"><img src="images/img_multifunc.jpg" alt="" /></span>
					<div class="content">
						<header>
							<h2>Clinical Grade <br>Multi-Functional </br>Personal Care Products</h2>
							<!-- <p>Nunc commodo accumsan eget id nisi eu col volutpat magna</p> -->
						</header>
						<p>Save money and counter space. <br>
							Buy one item that has many uses. <br>
							BioEvolve's personal care line are highly effective with many uses.
							<br><br>
							Simplify your personal routine with these multitasking products that show fast results.</p>
						<ul class="actions">
							<li><a href="products_personalcare.html" class="button">Learn More</a></li>
						</ul>
					</div>
					<a href="#three" class="goto-next scrolly">Next</a>
				</section>

			<!-- Three -->
				<section id="three" class="spotlight style3 left">
					<span class="image fit main bottom"><img src="images/img_naturo.jpg" alt="" /></span>
					<div class="content">
						<header>
							<h2>Certified Nutritional & Naturopath Products</h2>
							<!-- <p>Accumsan integer ultricies aliquam vel massa sapien phasellus</p> -->
						</header>
						<p>Potent with proven clinical results. <br>
							Contains no gluten, animal products, wheat, gluten, dairy, yeast, artificial flavouring and coloring, soy, corn, dairy, or nuts.<br>
							<br>
							Products are formulated at professional therapeutic strength. <br>
							Safe, highly effective and clean. <br>
							Everything desired in nutritional and naturopathic products.</p>
						<ul class="actions">
							<li><a href="products_nutritionalnaturopath.html" class="button">Learn More</a></li>
						</ul>
					</div>
					<a href="#four" class="goto-next scrolly">Next</a>
				</section>

			<!-- Four -->
				<section id="four" class="spotlight style3 right">
					<span class="image fit main bottom"><img src="images/img_clinical.jpg" alt="" /></span>
					<div class="content">
						<header>
							<h2>Clinical Medicinal Products</h2>
							<!-- <p>Accumsan integer ultricies aliquam vel massa sapien phasellus</p> -->
						</header>
						<p>Potent, fast onset action.<br>
						Free of parabens and other chemical preservatives and non-toxic.<br>
						<br>
						Trust the heath team at Bioevolve to create effective, clean and clinical strength medicinal products for your needs</p>
						<ul class="actions">
							<li><a href="products_clinicalmedicinal.html" class="button">Learn More</a></li>
						</ul>
					</div>
					<a href="#five" class="goto-next scrolly">Next</a>
				</section>

			

				<section id="sec_about">



<div class="content">
						<div class="container">
							<div class="row">
								<div class="4u 12u$(medium)">
									<header>					
										<br><br>
										<h2>Contact Us</h2>
										
										<h5>
											MON - FRI : 9:30am - 5:00pm PST<br><br>
											SAT - SUN : CLOSED <br><br>
											Canadian Holidays : CLOSED<br>
											<hr>
										</h5>
										<td>
									<div>
										<h3 class="icon fa-mobile"><span class="label">Phone</span></h3>
										Local : 604-273-7896<br>
										Toll Free : 1-844-666-1888
									</div>
								</td><br>

								<td>
									<div>
										<h3 class="icon fa-envelope-o"><span class="label">Email</span></h3>
										Email:
										<a href="mailto:contact@bioevolve.com?Subject=Customer" target="_top">contact@BioEvolve.com</a>
									</div>
								</td>
										
									</header>
								</div>

								<div class="4u 12u$(medium)">
									<font color="000">.</font>
								</div>

								<div class="4u 12u$">
									<br>
									<p>				<div class="facebook">
					<div class="fb-like-box" data-href="https://www.facebook.com/BioEvolve" data-width="242px" data-colorscheme="light" data-show-faces="true" data-header="false" data-stream="true" data-show-border="false"></div></div>

									</p>
								</div>
							</div>
						</div>
					</div>





					</section>



			<!-- Footer -->
				<footer id="footer">

					<ul class="icons">
						<!-- <a href="https://twitter.com/hashtag/bioevolve"><img src="images/icons/icon-twitter.png" style="width:3%"></span></a> -->

						<a href="https://www.facebook.com/bioevolve"><img src="images/icons/icon-facebook.png" style="width:3%"></span></a>

						<a href="https://instagram.com/bioevolveglobal/"><img src="images/icons/icon-instagram.png" style="width:3%"></span></a>

						<a href="contactus.html"><img src="images/icons/icon-email.png" style="width:3%"></span></a></ul>


					
					<ul class="copyright">
						<li>&copy; 2013 - 2015 BioEvolve. All rights reserved.</li><li>Design Base: HTML5 UP</li>
					</ul>
				</footer>

		</div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrolly.min.js"></script>
			<script src="assets/js/jquery.dropotron.min.js"></script>
			<script src="assets/js/jquery.scrollex.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>







			<!-- jQuery -->
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
  <script>window.jQuery || document.write('<script src="js/libs/jquery-1.7.min.js">\x3C/script>')</script>

  <!-- FlexSlider -->
  <script defer src="assets/FlexSLider/jquery.flexslider.js"></script>

   <script type="text/javascript">
    $(function(){
      SyntaxHighlighter.all();
    });
    $(window).load(function(){
      $('.flexslider').flexslider({
        animation: "slide",
        start: function(slider){
          $('body').removeClass('loading');
        }
      });
    });
  </script>


  <!-- Syntax Highlighter -->
  <script type="text/javascript" src="assets/FlexsSlider/demo/js/shCore.js"></script>
  <script type="text/javascript" src="assets/FlexsSlider/demo/js/shBrushXml.js"></script>
  <script type="javascript" src="assets/FlexsSlider/demo/js/shBrushJScript.js"></script>

  <!-- Optional FlexSlider Additions -->
  <script src="assets/FlexsSlider/demo/js/jquery.easing.js"></script>
  <script src="assets/FlexsSlider/demo/js/jquery.mousewheel.js"></script>
  <script defer src="assets/FlexsSlider/demo/js/demo.js"></script>
</form>
	</body>
</html>