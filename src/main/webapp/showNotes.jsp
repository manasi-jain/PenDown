<%@ page import="com.User.UserDetails"%>
<%@ page import="com.User.Post"%>
<%@ page import="com.DAO.PostDAO"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%
UserDetails user3 = (UserDetails) session.getAttribute("userDetails");
if (user3 == null) {
	response.sendRedirect("login.jsp");
	session.setAttribute("Login-error", "Please login");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Journals</title>
<%@include file="AllComponents/allcss.jsp"%>
<style>
.notes-col {
	flex-basis: 50%;
	background: #fff3f3;
	border-radius: 10px;
	margin-bottom: 5%;
	padding: 20px 12px;
	box-sizing: border-box;
	margin: auto;
}

.icons .bi {
	color: #f44336;
	margin: 0 13px;
	cursor: pointer;
	padding: 18px 0;
}

.notes-col:hover {
	box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2);
	transition: 0.5s;
}
</style>
</head>
<body>
	<section class="sub-header">
		<nav>
			<a href="index.jsp"><img src="images/logo1.png" alt="logo-img"></a>
			<div class="nav-links" id="navLinks">
				<i class="fa fa-times" onclick="hideMenu()"></i>
				<ul>

					<%
					UserDetails user = (UserDetails) session.getAttribute("userDetails");
					if (user != null) {
					%>

					<li><a href="" data-toggle="modal" data-target="#exampleModal"><%=user.getName()%></a></li>
					<!-- <li><a href="about.html">ADD NOTES</a></li> -->
					<li><a href="main.jsp">ADD JOURNAL</a></li>
					<li><a href="LogoutServlet">LOGOUT</a></li>

					<!-- Modal -->

					<div class="modal fade" id="exampleModal" tabindex="-1"
						role="dialog" aria-labelledby="exampleModalLabel"
						aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title container text-center"
										style="color: red;" id="exampleModalLabel">Your Details</h5>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">

									<div class="container text-center">
										<table class="table" style="color: black;">
											<tbody>
												<tr>
													<!-- <th>Id</th> -->
													<td>id - <%=user.getId()%></td>
												</tr>
												<tr>
													<!-- <th>Name</th> -->
													<td><%=user.getName()%></td>
												</tr>
												<tr>
													<!-- <th>Email</th> -->
													<td><%=user.getEmail()%></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="hero-btn red-btn"
										data-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>

					<%
					} else {
					%>

					<li><a href="index.jsp">HOME</a></li>
					<li><a href="about.html">ADD JOURNAL</a></li>
					<li><a href="contact.html">SHOW JOURNAL</a></li>

					<%
					}
					%>

				</ul>
			</div>



			<i class="fa fa-bars" onclick="showMenu()"></i>
		</nav>

		<h1>Your journals</h1>

	</section>



	<section class="course">

		<div class="row">
			<div class="col-md-12">
				<%
				if (user3 != null) {
					PostDAO ob = new PostDAO(DBConnect.getConn());
					List<Post> post = ob.getData(user3.getId());
					for (Post po : post) {
				%>

				<div class="notes-col">
					<!-- <h3>Your Journal</h3> -->
					<img src="images/journal.png" alt="logo-img">

					<h4><%=po.getTitle()%></h4>
					<p><%=po.getContent()%></p>
					<!-- <button type="submit" class="hero-btn red-btn">Edit</button>
					<button type="submit" class="hero-btn red-btn">Delete</button> -->
				</div>
				<%
				}
				}
				%>

			</div>
		</div>
	</section>





	<!-- Footer -->

	<section class="footer">
		<p>© Manasi Jain</p>
	</section>



	<!-- JavaScript for Toggle Menu -->
	<script>
		var navLinks = document.getElementById("navLinks");

		function showMenu() {
			navLinks.style.right = "0";
		}

		function hideMenu() {
			navLinks.style.right = "-200px";
		}
	</script>
</body>
</html>