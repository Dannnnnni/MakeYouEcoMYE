package mye.makeyoueco.control;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.mysql.jdbc.PreparedStatement;

import mye.makeyoueco.model.DriverManagerConnectionPool;

@WebServlet("/UploadPhoto")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
                 maxFileSize=1024*1024*10,      // 10MB
                 maxRequestSize=1024*1024*50)   // 50MB
public class UploadPhoto extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static String SAVE_DIR ="/uploadTemp";
       
    public UploadPhoto() {
        super();
    }
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");

		out.write("Error: GET method is used but POST method is required");
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        response.setContentType("text/html;charset=UTF-8");

        String id = "";
        
        try (PrintWriter out = response.getWriter()) {
			
		    BufferedReader reader = request.getReader();
		    StringBuilder stringBuilder = new StringBuilder();
		    String line;
		    while ((line = reader.readLine()) != null) {
		        stringBuilder.append(line);
		    }
		    String formData = stringBuilder.toString();

	        String[] params = formData.split("&");
	        for (String param : params) {
	            String[] keyValue = param.split("=");
	            if (keyValue.length == 2) {
	                String key = keyValue[0];
	                String value = keyValue[1];
	                try {
	                    value = URLDecoder.decode(value, "UTF-8");
	                } catch (Exception e) {
	                    e.printStackTrace();
	                }

	                if (key.equals("id")) {
	                    id = value;
	            }
	        }
	      }
	        
        int result = 0;
        Part part = request.getPart("image");
        if (part != null) {
            try {
                Connection con = DriverManagerConnectionPool.getConnection();
                PreparedStatement ps = (PreparedStatement) con.prepareStatement("UPDATE PRODUCT SET IMAGE = ? WHERE ID = ?");
                InputStream is = part.getInputStream();
                ps.setBlob(1, is);
                ps.setInt(2, Integer.parseInt(id));
                result = ps.executeUpdate();
                if (result > 0) {
                    response.sendRedirect("view.jsp");
                } else {
                    response.sendRedirect("index.jsp?message=Some+Error+Occurred");
                }
            } catch (Exception e) {
                out.println(e);
            }
        }
    }
  }
		
}
