<%@page import="model.ModelLogin"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="head.jsp"></jsp:include>
  <body>
<jsp:include page="theme-loader.jsp"></jsp:include>
  <!-- Pre-loader end -->
  <div id="pcoded" class="pcoded">
      <div class="pcoded-overlay-box"></div>
      <div class="pcoded-container navbar-wrapper">
          
<jsp:include page="nav-bar.jsp"></jsp:include>

          <div class="pcoded-main-container">
              <div class="pcoded-wrapper">
              
                 <jsp:include page="nav-bar-main-menu.jsp"></jsp:include>
                  
                  <div class="pcoded-content">
                  
                  
                  <jsp:include page="page-head.jsp"></jsp:include>
                      <!-- Page-header start -->
                     
                     
                     
                      <!-- Page-header end -->
                        <div class="pcoded-inner-content">
                            <!-- Main-body start -->
                            <div class="main-body">
                                <div class="page-wrapper">
                                    <!-- Page-body start -->
                                    <div class="page-body">
                                       
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <!-- Basic Form Inputs card start -->
                                                <div class="card">
                                                    
                                                    <div class="card-block">
                                                        <h4 class="sub-title">Cadastro de Usuarios</h4>
                                       
                                    						  
                                                            
                                                           
                                                            <form class="form-material" action="<%= request.getContextPath()%>/ServletUsuarioController" method="post" id="formUser">
                                                           
                                                            <input type="hidden" name="acao" id="acao" value="" >
                                                           
                                                            <div class="form-group form-default form-static-label" >
                                                                <input type="text" name="id" id="id" class="form-control" readonly="readonly" value="${modelLogin.id}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">ID</label>
                                                            </div>
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="text" name="nome" id="nome" class="form-control" required="required" value="${modelLogin.nome }">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Nome</label>
                                                            </div>
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="email" name="email" id="email" class="form-control" required="required" autocomplete="off" value="${modelLogin.email }">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">E-mail (exa@gmail.com)</label>
                                                            </div>
                                                             <div class="form-group form-default form-static-label">
	                                                            <select class="form-control" aria-label="Default select example" name="perfil" id="perfil" >
																  <option disabled="disabled" >[ Selecione o perfil do Cargo]</option>
																  <option value="ADMIN"<%
																		  
																  ModelLogin modelLogin = (ModelLogin)request.getAttribute("modelLogin");
																  
																  																  
																  if(modelLogin != null &&  modelLogin.getPerfil().equals("ADMIN")){
																	  
																	  out.print(" ");
																	  out.print("selected=\"selected\"");
																	  out.print(" ");
																  } %>>Administra��o</option>
									    
																  <option value="SECRETARIO"<%
																		  
																 modelLogin = (ModelLogin)request.getAttribute("modelLogin");
																  
																  																  
																  if(modelLogin != null &&  modelLogin.getPerfil().equals("SECRETARIO")){
																	  
																	  out.print(" ");
																	  out.print("selected=\"selected\"");
																	  out.print(" ");
																  } %>>Secretariado</option>
																  <option value="AUXILIAR"<%
																		  
																  modelLogin = (ModelLogin)request.getAttribute("modelLogin");
																  
																  																  
																  if(modelLogin != null &&  modelLogin.getPerfil().equals("AUXILIAR")){
																	  
																	  out.print(" ");
																	  out.print("selected=\"selected\"");
																	  out.print(" ");
																  } %>>Auxiliar</option>
																  
																</select>
																<span class="form-bar"></span>
                                                                <label class="float-label">Perfil</label>
	                                                            </div>
                                                             <div class="form-group form-default form-static-label">
                                                                <input type="text" name="login" id="login" class="form-control" required="required" autocomplete="off" value="${modelLogin.login }" >
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Login</label>
                                                            </div>
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="password" name="senha" id="senha" class="form-control" required="required" autocomplete="off" value="${modelLogin.senha }" >
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Senha</label>
                                                            </div>
                                                            
                                                            <button type="button" class="btn btn-primary waves-effect waves-light" onclick="limparForm();">Novo</button>
												            <button type="submit" class="btn btn-success waves-effect waves-light">Salvar</button>
												            <button type="button" class="btn btn-info waves-effect waves-light" onclick="criarDeleteComAjax();" >Excluir</button>
												    <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#exampleModalUsuario">Pesquisar</button>
												   <!--         <button class="btn btn-warning waves-effect waves-light">Warning Button</button>
												            <button class="btn btn-danger waves-effect waves-light">Danger Button</button>
												            <button class="btn btn-inverse waves-effect waves-light">Inverse Button</button>
												            <button class="btn btn-disabled disabled waves-effect waves-light">Disabled Button</button>
                                                          -->  
                                                        </form>
                                                            </div>
                                                            </div>
                                                            </div>
                                                            </div>
                                                            <span id="msg">${msg}</span> <!-- o $ é para mostra a mensagem de redirecionamento do jsp , ja o id é a mensagem que vem do javascript -->
                                                            
                                                           <div style="height: 300px; overflow: scroll;">
															<table class="table" id="tabelaresultadosview">
														  <thead>
														    <tr>
														      <th scope="col">ID</th>
														      <th scope="col">Nome</th>
														      <th scope="col">Ver</th>
														    </tr>
														  </thead>
														  <tbody>
														  
														    <c:forEach items="${modelLogins}" var="ml">
														    <tr>
														    <td><c:out value="${ml.id }"></c:out> </td>
														    <td><c:out value="${ml.nome }"></c:out> </td>
														   <td><a class="btn btn-success" href="<%= request.getContextPath() %>/ServletUsuarioController?acao=buscarEditar&id=${ml.id }" ">Ver</a></td>
														   </tr>
														    </c:forEach>
														  </tbody>
														</table>
														
												</div>
                                                           
                                                            </div>
                                                            
                                    <!-- Page-body end -->
                                    
                                    
                                </div>
                                <div id="styleSelector"> </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
 <!-- Modal -->
<div class="modal fade" id="exampleModalUsuario" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Pesquisa de usuário</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        
			        <div class="input-group mb-3">
				  <input type="text" class="form-control" placeholder="Nome" aria-label="nome" id="nomeBusca" aria-describedby="basic-addon2">
				  <div class="input-group-append">
				    <button class="btn btn-success" type="button" onclick="buscarUsuario();">Buscar</button>
				  </div>
				</div>
				
				<div style="height: 300px; overflow: scroll;">
				<table class="table" id="tabelaresultados">
			  <thead>
			    <tr>
			      <th scope="col">ID</th>
			      <th scope="col">Nome</th>
			      <th scope="col">Ver</th>
			    </tr>
			  </thead>
			  <tbody>
			    
			  </tbody>
			</table>
			
	</div>
	<span id="totalResultados"></span>
	  </div>
        
    
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
      </div>
    </div>
  </div>
</div>
    <jsp:include page="javascriptfile.jsp"></jsp:include>
    
    <script type="text/javascript">
    
    function verEditar(id) {
    	
    	 var urlAction = document.getElementById('formUser').action;
    	 window.location.href = urlAction +'?acao=buscarEditar&id='+id;
	
    }
    
    function buscarUsuario() {
        
        var nomeBusca = document.getElementById('nomeBusca').value;
        
        if (nomeBusca != null && nomeBusca != '' && nomeBusca.trim() != ''){ /*Validando que tem que ter valor pra buscar no banco*/
    	
    	 var urlAction = document.getElementById('formUser').action;
    	
    	 $.ajax({
    	     
    	     method: "get",
    	     url : urlAction,
    	     data : "nomeBusca=" + nomeBusca + '&acao=buscarUserAjax',
    	     success: function (response) {
    		 
    	    	 var json = JSON.parse(response);
    	    	 console.info(json)
    	    	 
    		  $('#tabelaresultado > tbody > tr').remove();
    		  
    		 	for (var p = 0; p < json.length; p++) {
					$('#tabelaresultados > tbody').append('<tr> <td> '+json[p].id+'   </td><td> '+json[p].nome+'   </td><td>            <button onclick="verEditar('+json[p].id+')" type = "button" class="btn btn-info ">Ver</button>  </td> </tr>')
				}
    		 	document.getElementById('totalResultados').textContent = 'Resultados : ' + json.length
    	     }
    	     
    	 }).fail(function(xhr, status, errorThrown){
    	    alert('Erro ao buscar usuário por nome: ' + xhr.responseText);
    	 });
    	
    	
        }
        
    }
    
    function criarDeleteComAjax() {
    	if(confirm('Deseja relamente excluir este registro? ')){

    	var urlAction = document.getElementById('formUser').action;
    	var idUser = document.getElementById('id').value;

    	$.ajax({
    	method:"get",
    	url: urlAction,
    	data: "id=" + idUser + '&acao=deletarajax',
    	success: function(response){
    		
    		limparForm();
    		document.getElementById('msg').textContent = response;
    	}

    	}).fail(function(xhr, status, errorThrown){
    	alert('erro ao deletar usuario por id = ' +xhr.responseText);

    	})

    	}

    	}
    
    
    function criarDelete() {
    	
    	if (confirm('Deseja relamente excluir este registro? ')) {
    		document.getElementById("formUser").method = 'get';
        	document.getElementById("acao").value = 'deletar';
        	document.getElementById("formUser").submit();
		}
    	
    	
    	
		
	}
    
    function limparForm() {
    	var elementos = document.getElementById("formUser").elements; // retorna os elemntos html dentro do form
    	for (var p = 0; p < elementos.length; p++) {
    		elementos[p].value = '';
			
		}
		
	}
    
    </script>
    </body>

</html>