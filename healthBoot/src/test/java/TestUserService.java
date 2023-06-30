import com.example.health.HealthBootApplication;
import com.example.health.service.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Map;

@SpringBootTest(classes = {HealthBootApplication.class})
public class TestUserService {

    @Autowired
    UserService userService;

    @Test
    public void testGetAllUser(){
        Map<String, Long> map = userService.getUserAddressByTown();
        System.out.println("统计结果是");
        System.out.println(map);
    }

}
