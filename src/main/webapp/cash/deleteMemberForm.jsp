<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Register</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body class="bg-gradient-primary">>
	<!-- cash 수정 폼 -->
    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">               
                    <div class="col-lg-7">
                        <div class="p-5">	
	
	<h1>회원탈퇴</h1>
	<form action="<%=request.getContextPath()%>/cash/deleteMemberAction.jsp">
		<table border="1">
			<tr>
				<td>회원아이디</td>
				<td><input type="text" name="memberId"></td>
			</tr>
			<tr>
				<td>회원패스워드</td>
				<td><input type="password" name="memberPw"></td>
			</tr>					
		</table>
		<button type = "submint">회원탈퇴</button>	
	</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>