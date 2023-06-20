package mye.makeyoueco.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import mye.makeyoueco.model.*;

@WebServlet("/search-product")
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public Search() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			String name = request.getParameter("name");
			
			ProductDao pm = new ProductDao(DriverManagerConnectionPool.getConnection());
			ArrayList<Product> products = pm.doRetrieveAll(null);
			
			
			int l = products.size();
			
			for(int i = 0; i<l; i++) {  
	             for (int j = i+1; j<l; j++) {    
	                if(products.get(i).getName().compareTo(products.get(j).getName())>0) {  
	                    String temp = products.get(i).getName();
	                    products.get(i).setName(products.get(j).getName());
	                    products.get(j).setName(temp);
	                 }  
	             }
	        }
			
	        Iterator<Product> iterator = products.iterator();
	        int count = 0;
	        while (iterator.hasNext()) {
	            Product product = iterator.next();
	            if (!product.getName().toLowerCase().contains(name.toLowerCase())) {
	                iterator.remove();
	            } else {
	                count++;
	            }
	            if (count >= 3) {
	                while (iterator.hasNext()) {
	                    iterator.next();
	                    iterator.remove();
	                }
	            }
	        }

			ArrayList<String> arrayList = new ArrayList<String>();
			for(int i = 0; i < products.size(); i++) {
			    arrayList.add(products.get(i).getName());
			}

		    Gson gson = new Gson();
		    String jsonResponse = gson.toJson(arrayList);

		    out.print(jsonResponse);
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
			
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
