package controller;

import model.Rental;
import service.RentalService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet("/rental")
public class RentalController extends HttpServlet {
    private final RentalService service = new RentalService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            request.setAttribute("code", request.getParameter("code"));
            request.getRequestDispatcher("/WEB-INF/views/confirmDelete.jsp").forward(request, response);
        } else if ("add".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/views/addRental.jsp").forward(request, response);
        } else {
            String type = request.getParameter("type");
            String floor = request.getParameter("floor");
            String price = request.getParameter("price");
            request.setAttribute("rentals", service.findAll(type, floor, price));
            request.getRequestDispatcher("/WEB-INF/views/listRental.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        if ("confirmDelete".equals(request.getParameter("action"))) {
            service.delete(request.getParameter("code"));
            response.sendRedirect("/rental");
            return;
        }

        Rental rental = new Rental();
        rental.setCode(request.getParameter("code"));
        rental.setStatus(request.getParameter("status"));
        rental.setArea(Double.parseDouble(request.getParameter("area")));
        rental.setFloor(Integer.parseInt(request.getParameter("floor")));
        rental.setType(request.getParameter("type"));
        rental.setPrice(Long.parseLong(request.getParameter("price")));
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        rental.setStartDate(LocalDate.parse(request.getParameter("startDate"), df));
        rental.setEndDate(LocalDate.parse(request.getParameter("endDate"), df));

        String result = service.addRental(rental);
        if ("success".equals(result)) {
            response.sendRedirect("/rental");
        } else {
            request.setAttribute("error", result);
            request.getRequestDispatcher("/WEB-INF/views/addRental.jsp").forward(request, response);
        }
    }
}
