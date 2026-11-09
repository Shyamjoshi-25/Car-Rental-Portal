package controller;

import dao.CarDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Car;
import java.io.IOException;

@WebServlet("/CarServlet")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 6 * 1024 * 1024)
public class CarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && "ADMIN".equals(session.getAttribute("role")) && session.getAttribute("admin") != null;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
            return;
        }

        String action = request.getParameter("action");
        try {
            CarDAO dao = new CarDAO();
            if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("carId"));
                dao.deleteCar(id);
            } else if ("update".equalsIgnoreCase(action)) {
                Car car = readCar(request);
                car.setCarId(Integer.parseInt(request.getParameter("carId")));
                if (!dao.updateCar(car)) throw new IllegalArgumentException("Car update failed");
            } else {
                if (dao.getAllCars().size() >= 10) throw new IllegalArgumentException("The demo fleet already contains 10 cars");
                Car car = readCar(request);
                if (!dao.addCar(car)) throw new IllegalArgumentException("Car insert failed");
            }
            response.sendRedirect(request.getContextPath() + "/admin/manageCars.jsp?msg=success");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to save the car. Check the entered values.");
            request.getRequestDispatcher("admin/manageCars.jsp").forward(request, response);
        }
    }

    private Car readCar(HttpServletRequest request) {
        String status = request.getParameter("status");
        if (!"Not Available".equals(status)) status = "Available";
        double price = Double.parseDouble(request.getParameter("pricePerDay"));
        if (price < 0) throw new IllegalArgumentException("Negative price");
        Car car = new Car();
        String carName = required(request.getParameter("carName"));
        String brand = optional(request.getParameter("brand"));
        String model = optional(request.getParameter("model"));
        String fuel = optional(request.getParameter("fuelType"));
        if (!util.Validation.isSafeText(carName, 100)
                || !util.Validation.isSafeText(brand, 100)
                || !util.Validation.isSafeText(model, 50)
                || !util.Validation.isSafeText(fuel, 30)) {
            throw new IllegalArgumentException("Invalid car text.");
        }
        car.setCarName(carName);
        car.setBrand(brand);
        car.setModel(model);
        car.setFuelType(fuel);
        car.setPricePerDay(price);
        car.setStatus(status);
        try {
            Part imagePart = request.getPart("carImage");
            if (imagePart != null && imagePart.getSize() > 0) {
                String type = imagePart.getContentType();
                if (type == null || !(type.equals("image/jpeg") || type.equals("image/png") || type.equals("image/webp")))
                    throw new IllegalArgumentException("Use a JPG, PNG, or WEBP image.");
                if (imagePart.getSize() > 5 * 1024 * 1024) throw new IllegalArgumentException("Image must be 5 MB or smaller.");
                try (InputStream in = imagePart.getInputStream()) {
                    car.setImageData(in.readAllBytes());
                    car.setImageContentType(type);
                }
            }
        } catch (IOException | ServletException e) {
            throw new IllegalArgumentException("Unable to read the car image.");
        }
        return car;
    }

    private String optional(String value) {
        return value == null ? "" : value.trim();
    }

    private String required(String value) {
        if (value == null || value.isBlank()) throw new IllegalArgumentException("Required field");
        return value.trim();
    }
}
