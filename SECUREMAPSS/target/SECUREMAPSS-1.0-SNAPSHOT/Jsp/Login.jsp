<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Securemaps</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="../Css/login.css">
        <link href="https://fonts.googleapis.com/css2?family=Zen+Kurenaido&display=swap" rel="stylesheet">
        <link rel="shortcut icon" type="image/jpg" href="../Imagenes/favicon.ico"/>
    </head>
    <body>
         <%
            String nom = request.getParameter("nombre");
            String ape = request.getParameter("apellidos");
            String cor = request.getParameter("correo");
            String con = request.getParameter("contrasenia");
            
            Connection conx = null;
            Statement sta = null;
            ResultSet res = null;
            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                conx = DriverManager.getConnection("jdbc:mysql://localhost/Securemaps?autoReconnect=true&useSSL=false","root","Fernandoipn9");
                sta = conx.createStatement();
            }
            catch (SQLException error){
                out.print(error.toString());
            }
            try{
//               Este es un proceso para identificar si ya hay usuarios registrados en la base de datos
//                 Se hace con un if
                cor = request.getParameter("correo");
                con = request.getParameter("contrasenia");
                
                res = sta.executeQuery("select * from USUARIO where CORREO='"+cor+"' and PSW ='"+con+"';");
                
                if (res.next()) {
//                    Si encuentra un resultado 
                    int id_usuario = res.getInt("USENAME");
                    String nombre = res.getString("NOMBRE");
                    String correo = res.getString("CORREO");
                    String contra = res.getString("PSQ");
                    
                    out.println("<script>alert('Este usuario ya existe!')</script>");
                    out.print("<a href = ''><h4 style='color: #2ecc71; font-family: sans-serif'>¿Olvidaste tu contraseña?</h4></a>");
                }
                else{
                    sta.executeUpdate("insert into USUARIO values(null,'"+nom+"','"+cor+"','"+con+"');");
                    out.println("<script>alert('Usuario exitosamente registrado')</script>");
                    conx.close();
                    sta.close();
                }
            }
            catch(SQLException error){
                out.println(error.toString());
            }
        %>
        <script>
 	function alerta(campo) { 
		alert("Por favor, completa el campo "+campo) ;
	}
	function validar_formulario(form) {
                if (form.correo.value === "") { //para dar un mensaje si est vacio el campo
			alerta('\"Correo Electronico\"'); form.correo.focus(); 
                        return true; 
                    }
                if (form.campo_contrasena.value === "") { //para dar un mensaje si est vacio el campo
			alerta('\"Contraseña\"'); form.contra.focus(); 
                        return true; 
                    }
		form.submit(); //para verificar
                alert("Datos ingresados!"); 
            }
    </script> 
<body>
  <div class="cont">
      <!--Formulario LOGIN-->
          
    <div class="form sign-in">
      <h2>Iniciar Sesión</h2>
      <label>
        <span>Correo Electrónico</span>
        <form name="Login" action="Usuario.jsp" method="post">
            <input type="email" name="email" id="correo" required="" placeholder="alguien@example.com">
      </label>
      <label>
        <span>Contraseña</span>
        <input type="password" name="password" id="contra" required="" >
      </label>
      <button class="submit" type="button" onclick="validar_formulario()">Siguiente</button>
      
      </form>
      <p class="forgot-pass">¿Has olvidado tu contraseña?</p>
      <div class="social-media">
        <ul>
            <li><img src="../Imagenes/facebook.png" alt="Facebook"></li>
            <li><img src="../Imagenes/twitter.png" alt="twitter"></li>
            <li><img src="../Imagenes/linkedin.png" alt="linkedin"></li>
            <li><img src="../Imagenes/instagram.png" alt="instagram"></li>
        </ul>
      </div>
    </div>

      
    <div class="sub-cont">
      <div class="img">
        <div class="img-text m-up">
          <h2>¿Nuevo aquí?</h2>
          <p>¡Regístrate y descubre una gran cantidad de lugares!</p>
        </div>
        <div class="img-text m-in">
          <h2>¿Ya estás registrado?</h2>
          <p>Si ya te has registrado antes, solamente inicia sesión. </p><p>¡Te extrañamos!</p>
        </div>
        <div class="img-btn">
          <span class="m-up">Registrarse</span>
          <span class="m-in">Iniciar Sesión</span>
        </div>
      </div>
        
       <!--Formulario REGISTRO-->
      <div class="form sign-up">
          <form name="registro" method="post" action="Login.jsp">
              
        <h2>Registrarse</h2>
        <label>
          <span>Nombre</span>
          <input type="text"  required="">
        </label>
        <label>
          <span>Correo Electrónico</span>
          <input type="email" placeholder="alguien@example.com" required="">
        </label>
        <label>
          <span>Contraseña</span>
          <input type="password" placeholder="*******" required="">
        </label>
        <label>
          <span>Confirmar Contraseña</span>
          <input type="password" required="" placeholder="*******">
        </label>
        <button type="button" class="submit">Registrarme ahora</button>
          </form>  
      </div>
        
    </div>
  </div>
    <script type="text/javascript" src="../JavaScript/login.js"></script>
</body>
    </body>
</html>
