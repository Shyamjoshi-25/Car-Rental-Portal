package controller;

import dao.CarDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Car;
import java.io.IOException;
import java.io.InputStream;

@WebServlet("/car-image")
public class CarImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            Car car = new CarDAO().getCarById(id);
            if (car == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            // A custom image uploaded by Admin always takes priority.
            byte[] savedImage = car.getImageData();
            if (savedImage != null && savedImage.length > 0) {
                response.setContentType(car.getImageContentType() == null ? "image/jpeg" : car.getImageContentType());
                response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                response.getOutputStream().write(savedImage);
                return;
            }

            // Existing seeded cars have no database image yet, so show the bundled
            // matching car photo until an Admin uploads a custom image.
            String name = car.getCarName() == null ? "" : car.getCarName().toLowerCase();
            String image;
            if (name.contains("swift")) image = "/images/car1.jpeg";
            else if (name.contains("baleno")) image = "/images/car2.jpeg";
            else if (name.contains("creta")) image = "/images/car3.jpeg";
            else if (name.contains("venue")) image = "/images/car4.jpeg";
            else if (name.contains("nexon")) image = "/images/car5.jpeg";
            else if (name.contains("harrier")) image = "/images/car6.jpeg";
            else if (name.contains("city")) image = "/images/car2.jpeg";
            else if (name.contains("innova")) image = "/images/car4.jpeg";
            else if (name.contains("xuv")) image = "/images/car5.jpeg";
            else if (name.contains("fortuner")) image = "/images/car6.jpeg";
            else image = "/images/noimage.jpeg";

            try (InputStream in = getServletContext().getResourceAsStream(image)) {
                if (in == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
                response.setContentType("image/jpeg");
                response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                in.transferTo(response.getOutputStream());
            }
        } catch (Exception e) {
            throw new ServletException("Unable to load car image", e);
        }
    }
}
