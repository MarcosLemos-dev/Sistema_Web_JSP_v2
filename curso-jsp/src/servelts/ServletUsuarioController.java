package servelts;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.compress.utils.IOUtils;
import org.apache.tomcat.util.codec.binary.Base64;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.DAOUsuarioRepository;

import model.ModelLogin;



@MultipartConfig
@WebServlet(urlPatterns = { "/ServletUsuarioController"})// array de mapeamento da pagina 
public class ServletUsuarioController extends ServeltGenericUtil {
	private static final long serialVersionUID = 1L;
      private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository(); 
    
    public ServletUsuarioController() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
		String acao = request.getParameter("acao");
		if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletar")) {
			
			String idUser = request.getParameter("id");
			daoUsuarioRepository.deletarUser(idUser);
			
			List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));// para mostrar todos os usuario abaixo da tela de edição de usuario
			request.setAttribute("modelLogins", modelLogins);// linha para segurar os dados na tela
			
			
			request.setAttribute("msg", "Excluido com sucesso!");
			request.setAttribute("totalPagina", daoUsuarioRepository.totalPagina(this.getUserLogado(request)));
			request.getRequestDispatcher("principal/usuario.jsp").forward(request, response);
		}
		else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletarajax")) {
				
				String idUser = request.getParameter("id");
				daoUsuarioRepository.deletarUser(idUser);
				
				response.getWriter().write("Excluido com sucesso!");
		}
		else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarUserAjax")) {
			
			String nomeBusca = request.getParameter("nomeBusca");
			List<ModelLogin> dadosJsonUser = daoUsuarioRepository.consultaUsuarioList(nomeBusca, super.getUserLogado(request));
			
			ObjectMapper mapper = new ObjectMapper();//trabalhando coom o jackson json dependencies databind
			String json = mapper.writeValueAsString(dadosJsonUser);
			response.getWriter().write(json);
	}
		else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarEditar")) {
			String id = request.getParameter("id");
			ModelLogin modelLogin = daoUsuarioRepository.consultarUsuarioID(id, super.getUserLogado(request));
			
			List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));// para mostrar todos os usuario abaixo da tela de edição de usuario
			request.setAttribute("modelLogins", modelLogins);// linha para segurar os dados na tela
			
			request.setAttribute("msg", "Usuario em edição");
			request.setAttribute("modelLogin", modelLogin);// linha para segurar os dados na tela
			request.setAttribute("totalPagina", daoUsuarioRepository.totalPagina(this.getUserLogado(request)));

			request.getRequestDispatcher("principal/usuario.jsp").forward(request, response);
		
		}
		else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listarUser")) {
			
			List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
			
			request.setAttribute("msg", "Usuarios Carregados");
			request.setAttribute("modelLogins", modelLogins);// linha para segurar os dados na tela
			request.setAttribute("totalPagina", daoUsuarioRepository.totalPagina(this.getUserLogado(request)));

			request.getRequestDispatcher("principal/usuario.jsp").forward(request, response);
		

			
		}
		else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("downloadFoto")) {
			
			String idUser = request.getParameter("id");
			ModelLogin modelLogin = daoUsuarioRepository.consultarUsuarioID(idUser, super.getUserLogado(request));
			
			if (modelLogin.getFotouser() != null && !modelLogin.getFotouser().isEmpty()) {
				
				response.setHeader("Content-Disposition", "attachment;filename=arquivo." + modelLogin.getExtensaofotouser());
				response.getOutputStream().write(new Base64().decodeBase64(modelLogin.getFotouser().split("\\,")[1]));
			}
		}
		else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("paginar")) {
			
			
			int offset = Integer.parseInt(request.getParameter("pagina"));
			
			
			List<ModelLogin> modelLogins  = daoUsuarioRepository.consultaUsuarioListpaginada(this.getUserLogado(request), offset);
			
			System.out.println(modelLogins);
			
			request.setAttribute("modelLogins", modelLogins);// linha para segurar os dados na tela
			
			request.setAttribute("totalPagina", daoUsuarioRepository.totalPagina(this.getUserLogado(request)));
			
			request.getRequestDispatcher("principal/usuario.jsp").forward(request, response);
			
		}
		else {
			List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));// para mostrar todos os usuario abaixo da tela de edição de usuario
			request.setAttribute("modelLogins", modelLogins);// linha para segurar os dados na tela
			request.setAttribute("totalPagina", daoUsuarioRepository.totalPagina(this.getUserLogado(request)));

			request.getRequestDispatcher("principal/usuario.jsp").forward(request, response);
		}
		

		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
			request.setAttribute("msg",e.getMessage());
			redirecionar.forward(request, response);
		
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String msg  = "Operação realizada com sucesso!";
			
		String id = request.getParameter("id");
		String nome = request.getParameter("nome");
		String email = request.getParameter("email");
		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		String perfil = request.getParameter("perfil");
		String sexo = request.getParameter("sexo");
		String cep = request.getParameter("cep");
		String logradouro = request.getParameter("logradouro");
		String bairro = request.getParameter("bairro");
		String localidade = request.getParameter("localidade");
		String uf = request.getParameter("uf");
		String numero = request.getParameter("numero");
		
		
		ModelLogin modelLogin = new ModelLogin();
		modelLogin.setId(id !=null && !id.isEmpty() ? Long.parseLong(id) : null);
		modelLogin.setNome(nome);
		modelLogin.setEmail(email);
		modelLogin.setLogin(login);
		modelLogin.setSenha(senha);
		modelLogin.setPerfil(perfil);
		modelLogin.setSexo(sexo);
		modelLogin.setCep(cep);
		modelLogin.setLogradouro(logradouro);
		modelLogin.setBairro(bairro);
		modelLogin.setLocalidade(localidade);
		modelLogin.setUf(uf);
		modelLogin.setNumero(numero);
		
		if (ServletFileUpload.isMultipartContent(request)) {
			Part part = request.getPart("filefoto");
			
			  if (part.getSize() > 0) {
				  
				  byte[] foto =  IOUtils.toByteArray(part.getInputStream());
				  String imagembase64 = "data:image/" + part.getContentType().split("\\/")[1] + ";base64," + new Base64().encodeBase64String(foto);
			  
				  modelLogin.setFotouser(imagembase64);
				  modelLogin.setExtensaofotouser(part.getContentType().split("\\/")[1]); 
			  
			}
			  
		 
		  
		}	
		
			 
		
		if (daoUsuarioRepository.validarLogin(modelLogin.getLogin()) && modelLogin.getId() == null) {
			msg = "já exite usuário com o mesmo login, Por favor informe outro Login";
		} else {
			if (modelLogin.isNovo()) {
				msg = "Gravado com sucesso !";
			} else {
				msg = "Atualizado com sucesso !";
			}
			modelLogin = daoUsuarioRepository.gravarUsuario(modelLogin, super.getUserLogado(request));

		}
		
		List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));// para mostrar todos os usuario abaixo da tela de edição de usuario
		request.setAttribute("modelLogins", modelLogins);// linha para segurar os dados na tela
		
		
		request.setAttribute("msg", msg);
		request.setAttribute("modelLogin", modelLogin);// linha para segurar os dados na tela
		request.setAttribute("totalPagina", daoUsuarioRepository.totalPagina(this.getUserLogado(request)));

		request.getRequestDispatcher("principal/usuario.jsp").forward(request, response);
		
		}catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
			request.setAttribute("msg",e.getMessage());
			redirecionar.forward(request, response);
		
		}
	}

}
