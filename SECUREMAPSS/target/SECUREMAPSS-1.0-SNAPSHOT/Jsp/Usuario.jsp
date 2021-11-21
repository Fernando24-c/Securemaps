<%-- 
    Document   : Usuario
    Created on : 20 nov. 2021, 22:32:29
    Author     : fpere
--%>
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
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Securemaps</title>
        <link rel="stylesheet" href="../Css/Index.css">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700,800&display=swap" rel="stylesheet"> 

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Zen+Kurenaido&display=swap" rel="stylesheet">
        <link rel="shortcut icon" type="image/jpg" href="../Imagenes/favicon.ico"/>
    </head>
    <body>
    <header>
        <div class="container">
            <nav>
                <a href="#" id="icono" class="icono">Menú</a>
                <div class="enlaces uno" id="enlaces">
                    <a href="">Inicio</a>
                    <a href="#">Mi cuenta</a>
                    <a href="#">Mis lugares</a>
                    <a href="#">Buscar lugares</a>
                    <a href="#">Sobre nosotros</a>
                    <a href="#">Contacto</a>
                </div>
            </nav>
            <%
//            String cor = request.getParameter("email");
//            String con = request.getParameter("password");
            

            String cor = request.getParameter("correo");
            String con = request.getParameter("contra");

            Connection conx = null;
            Statement sta = null;
            ResultSet res = null;
            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                conx = DriverManager.getConnection("jdbc:mysql://localhost/SECUREMAPS?autoReconnect=true&useSSL=false","root","Fernandoipn9");
                sta = conx.createStatement();
            }
            catch (SQLException error){
                out.print(error.toString());
            }
            try{
                cor = request.getParameter("email");
                con = request.getParameter("password");
                res = sta.executeQuery("select * from USUARIO where CORREO='"+cor+"' and PSW ='"+con+"';");
                
                if (res.next()) {
                    out.println("<script>alert('Bienvenid@')</script>");
                    int id_usuario = res.getInt("USERNAME");
                    String nombre = res.getString("NOMBRE");
                    String correo = res.getString("CORREO");
                    String contra = res.getString("PSW");
                        
                      out.print("<p class='copy'>Bienvenido</p>");
                      out.print("<h2>");
                      out.print(nombre);
                      out.print("</h2>");
                } 
                    else {
                    out.println("<script>alert('No hay registros, <a href = '#'>crea una cuenta</a>')</script>");
                    out.print("");
                    out.print("<h1>");
                    out.println("<a href ='../Login.html' >Crea una cuenta aquí</a>");
                    out.print("</h1>");
                }
                conx.close();
                sta.close();
                res.close();
            }
            catch(SQLException error){
                out.println(error.toString());
            }     
            %>
            <div class="textos">
                <h1>Bienvenido</h1>
                <h2>Find something new!</h2>
                <a href="#">Mi Cuenta</a>
            </div>
            
            <img src="../Imagenes/vector.png" alt="">
        </div>
    </header>
    <div class="wave">
        <div style="height: 150px; overflow: hidden;" ><svg viewBox="0 0 500 150" preserveAspectRatio="none" style="height: 100%; width: 100%;"><path d="M0.00,49.98 C150.00,150.00 349.20,-50.00 500.00,49.98 L500.00,150.00 L0.00,150.00 Z" style="stroke: none; fill: #fff;"></path></svg></div>
    </div>
            <script src="../JavaScript/Index.js"></script>
        
        
        
    </body>
</html>
