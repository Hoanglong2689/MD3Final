package service;

import model.Rental;
import repository.RentalRepository;

import java.time.temporal.ChronoUnit;

public class RentalService {
    private final RentalRepository repo = new RentalRepository();

    public String addRental(Rental rental) {
        if (repo.existsByCode(rental.getCode())) {
            return "Mã mặt bằng vừa thêm đã tồn tại";
        }
        if (ChronoUnit.MONTHS.between(rental.getStartDate(), rental.getEndDate()) < 6) {
            return "Ngày bắt đầu phải nhỏ hơn ngày kết thúc ít nhất 6 tháng";
        }
        repo.save(rental);
        return "success";
    }

    public java.util.List<Rental> findAll(String type, String floor, String price) {
        return repo.findAll(type, floor, price);
    }

    public void delete(String code) {
        repo.deleteByCode(code);
    }
}