package mye.makeyoueco.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import mye.makeyoueco.model.DriverManagerConnectionPool;
import mye.makeyoueco.model.Product;
import mye.makeyoueco.model.ProductDao;
import mye.makeyoueco.model.User;
import mye.makeyoueco.model.UserDao;

@WebServlet("/create-account-servlet")
public class CreateAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public CreateAccount() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			String email = request.getParameter("email");
			
			UserDao pm = new UserDao(DriverManagerConnectionPool.getConnection());
			ArrayList<User> users= pm.getAllUser();
			
			Gson gson = new Gson();
			String jsonResponse;
			
			int l = users.size();
			
			
			if(!email.equals("")) {
				for(int i = 0; i<l; i++) {
					if(users.get(i).getEmail().equals(email)) {
					    jsonResponse = gson.toJson("true");
					    out.print(jsonResponse);
					    return;
					}
		        }
			}
		    jsonResponse = gson.toJson("false");
		    out.print(jsonResponse);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
			
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
